window.onload = () => main()
window.onbeforeunload = () => {
  hideChibi(ID.chibi.intro)
  hideChibi(ID.chibi.bio)
  hideChibi(ID.chibi.hats)
  window.scrollTo(0, 0)
}

const ID = {
  chibi: {
    intro: 'intro-chibi-svg',
    bio: 'bio-chibi-svg',
    hats: 'hats-chibi-svg',
  }
}

const TEXT = {
  intro: [
    'Hi. I livee',
    'Hi. I live insde',
    'Hi. I live inside thwt',
    'Hi. I live inside the terminal.'
  ],
  bio: '^250\n`I am an engineer.<br>`^1000\n`I like to build cool things.<br>`^5500\n`Or break other things.`',
  hats: 'I can perform many other roles^750\n``in a pinch\,^750\n``and enjoy the learning all the while^3000.',
  call: 'What could we create together?'
}

function main() {

  drawLetters('#intro-name').then(() => {
    //maybe pulse letter slowly
    showChibi(ID.chibi.intro, 'path.part', 'down')
      .then(say('intro-hi-typed', TEXT.intro))
  })

  let bio = new Waypoint({
    element: document.getElementById('bio'),
    offset: 'bottom-in-view',
    handler: direction => {
      showChibi(ID.chibi.bio, 'path.part', direction)
        .then(say('bio-typed', TEXT.bio))
        .then(() => Snap('#voyager-svg').select('g').animate({opacity: 1}, 1500, mina.linear))
      bio.destroy()
    }
  })

  let hats = new Waypoint({
    element: document.getElementById('hats'),
    offset: 'bottom-in-view',
    handler: direction => {
      showChibi(ID.chibi.hats, 'path.part', direction)
        .then(say('hats-typed', TEXT.hats))
        .then(() => document.getElementById('hats-actor-uniform').classList.add('color-rotate'))
      hats.destroy()
    }
  })

  let call = new Waypoint({
    element: document.getElementById('call'),
    offset: 'bottom-in-view',
    handler: direction => {
      say('call-typed', TEXT.call)()
      call.destroy()
    }
  })
}



function drawLetters(id, letterCount=8, timePerLetter=150) {
  Snap(id).selectAll('g').attr({opacity: 1.0})
  return anime({
    targets: `${id} .letter-path`,
    strokeDashoffset: [anime.setDashoffset, 0],
    easing: 'easeInOutSine',
    duration: letterCount * timePerLetter,
    delay: (_, i) => i * timePerLetter,
    direction: 'alternate',
    loop: false
  }).finished
}

function showChibi(id, selector, direction='down') {
  let chibi = new Chibi(id, selector)
  return new Transporter({chibi, direction})
    .beamMeUpScotty()
    //try deleting the chibi after this
}

function hideChibi(id, selector, direction='up') {
  let chibi = new Chibi(id, selector)
  return new Transporter({chibi, direction})
    .intoTheVoid()
}

function say(id, things, opt) {
  if(things.constructor.name === "String")
    things = [things]

  return () => {
    let typed = new Typed(`#${id}`, {
      strings: things,
      typeSpeed: 45,
      backSpeed: 25,
      smartBackspace: true,
      loop: false,
      onComplete: () => typed.stop()
    })
    return typed
  }
}
