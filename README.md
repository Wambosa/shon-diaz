# ShonDiaz.com

## System Requirements
- ubuntu 18
- awscli
- terraform 12.20

## Why Vanilla JS?
When I first learned how to build websites, there were no fancy frameworks to do it.
They were built with html, css, and javascript. 
This simple and plain approach brings a little joy when considering the ole days.


## Deploying to a test s3 bucket
_deploy to a s3 bucket owned by a different aws account with the following command_

```
make install
make build deploy TARGET=website ENV=lab
```

you can then visit https://lab.shondiaz.com  
note: cache may retain old changes for _60-600_ seconds

## Deploy to the real s3 bucket
_simply tag a release on this github repo and circleci will pick up the master branch and deploy the built dist code to the prod bucket_

the prod vanity url will be https://shondiaz.com


## Tech debt
- [ ] stars animation does not traverse very long pages. Near the bottom of the porject page, there are no stars.. Just utter darkness...
- [x] maybe convert to a vue project someday, or just leave this as my only vanilla project.
- [ ] gif sizes could be decreased by dropping the framerate.
- [ ] there are at least a dozen missing projects that are no longer referenced in the new design.
  - [ ] own krillin
  - [ ] lua love letter
  - [ ] loan health
  - [ ] juxstaposition
  - [ ] cyclops
  - [ ] dark solution
  - [ ] db magic
  - [ ] dbzf
  - [ ] vent
  - [ ] pkmn black
  - [ ] PCI compliance
  - [ ] chops (slackbot)
  - [ ] custom tax apps
  - [ ] time management
  - [ ] secret santa
  - [ ] legacy portfolio
