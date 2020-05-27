.PHONY: install lint build deploy push_assets fetch_assets circleci clean terraform

# example: make build TARGET=website ENV=lab
# ENV := lab, prod

PROJECT            := shon-diaz
PREFIX             := sd
TF_VER             := 0.12.20
TF_STATE           := diaz-tfstate-${ENV}
TF_REGION          := us-east-1
BUILD_LOCAL_DIR    := .build

install:
	@make -s terraform \
	make -s clean

lint:
	@${BUILD_LOCAL_DIR}/terraform fmt -recursive \
	&& ${BUILD_LOCAL_DIR}/terraform validate

build:
	@rm -f ./infra/${TARGET}/.terraform/terraform.tfstate ;\
	cd ./infra/${TARGET} \
	&& . ../../config/secrets-${ENV}.env \
	&& ../../${BUILD_LOCAL_DIR}/terraform init -backend-config="bucket=${TF_STATE}" \
	&& ../../${BUILD_LOCAL_DIR}/terraform get

deploy:
	@cd ./infra/${TARGET} \
	&& . ../../config/secrets-${ENV}.env \
	&& ../../${BUILD_LOCAL_DIR}/terraform apply ${AUTO_APPROVE} \
		-var="environment=${ENV}"

push_assets:
	@. ./config/secrets-${ENV}.env \
	aws s3 rm s3://shon-diaz-assets-${ENV}/ --recursive \
	&& aws s3 cp public/assets/ s3://shon-diaz-assets-${ENV}/ \
	--recursive \
	--exclude "*" \
	--include "*.png" \
	--include "*.jpg" \
	--include "*.gif" \
	--include "*.pdf" \

fetch_assets:
	@mkdir -p ./public/assets/ \
	&& find public/assets/ -type f -iname \*.jpg -delete \
	&& find public/assets/ -type f -iname \*.gif -delete \
	&& find public/assets/ -type f -iname \*.png -delete \
	&& find public/assets/ -type f -iname \*.pdf -delete \
	&& . ./config/secrets-${ENV}.env \
	&& aws s3 cp s3://shon-diaz-assets-${ENV}/ public/assets/ --recursive 

circleci:
	@mkdir -p  ./config/ \
	&& touch ./config/secrets-${ENV}.env \
	&& sudo chmod -R 777 /usr/local/share \
	&& sudo chmod -R 777 /usr/local/bin/ \
	&& make install \
	&& aws --version \
	&& aws s3api create-bucket --bucket ${TF_STATE} --region ${TF_REGION} || true

clean:
	@find . -name '__pycache__' -exec rm -rf "{}" \; > /dev/null 2>&1 ;\
	rm -rf ./.pytest_cache ;\
	find ${BUILD_LOCAL_DIR}/* \! -name 'terraform' -delete ;\

terraform:
	@echo "installing terraform ${TF_VER}"
	wget https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip > /dev/null 2>&1 \
	&& unzip ./terraform_${TF_VER}_linux_amd64.zip -d . \
	&& rm -f ./terraform_${TF_VER}_linux_amd64.zip \
	&& chmod +x ./terraform \
	&& mkdir -p ${BUILD_LOCAL_DIR} \
	&& mv ./terraform ${BUILD_LOCAL_DIR}/terraform
