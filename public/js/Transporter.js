/** 
 * This manages a complex dynamic animation where my avatar
 * appears to 'beams in' and out of the canvas
 * 
 * @param {Object} opt - an object containing the following configurations
 * @param {String} opt.chibi - the entity to be animated
 * @param {String} opt.direction - used to alter the direction from which the chibi 'beams in' from
*/
class Transporter {
  constructor(opt) {
    this.chibi = opt.chibi
    this.snap = opt.chibi.snap
    this.direction = opt.direction
    this.energyColor = "#0088FE"
    this.teleportTime = 750
    this.materializeTime = 500
    this.pattern = {}
  }

  beamMeUpScotty() {
    return new Promise(resolve => {
      let done = Transporter.isDone(this.chibi.parts.length, resolve)
      this.chibi.parts.forEach(p => {
        this.energize(p)
        this.scramble(p)
        this.move(p, `t0,${this.direction==='down'? '-': ''}300s`)
        this.materialize({
          part: p,
          callback: () => {
            this.chibi.restore()
            this.pattern[p.id].remove()
            done()
          },
        })
      })
    })
  }

  intoTheVoid() {
    return new Promise(resolve => {
      let done = Transporter.isDone(this.chibi.parts.length, resolve)
        this.chibi.parts.forEach(p => {
          this.energize(p)
          this.deMaterialize({
            part: p,
            callback: () => {
              this.chibi.restore()
              this.pattern[p.id].remove()
              done()
            },
          })
        })
    })
  }

  energize(part) {
    this.pattern[part.id] = this.snap.path("M10 10 h 80 v 80 h -80 Z").attr({
      fill: "none",
      stroke: this.energyColor,
      strokeWidth: 5
    })
    this.pattern[part.id] = this.pattern[part.id].pattern(0, 0, 10, 10)
    part.attr({fill: this.pattern[part.id]})
  }

  scramble(part) {
    let points = this.chibi.original[part.id].d
    let randomized = points.slice(1, -1).split(' ')
      .map(i => Number(i) && Number(i) * -Math.random() || i)
      .join(' ')
    part.attr({d: `M${randomized}Z`})
  }

  move(actor, to) {
    actor.attr({transform: to})
  }

  materialize(opt) {
    let part = opt.part
    let callback = opt.callback
    let { d, fill } = this.chibi.original[part.id]

    let teleport = {d: d, opacity: 1.0, transform: "t0,0s"}
    let materialize = {fill: fill}

    part.animate(teleport, this.teleportTime, mina.linear, () => {
      part.animate(materialize, this.materializeTime, mina.linear, callback)
    })
  }

  deMaterialize(opt) {
    let part = opt.part
    let callback = opt.callback
    let vanish = {opacity: 0.0, transform: "t0,300s"}
    part.animate(vanish, this.materializeTime, mina.linear, callback)
  }

  static isDone(limit, resolve) {
    let progress = 0
    return () => {
      if(++progress === limit)
        return resolve(true)
    }
  }
}