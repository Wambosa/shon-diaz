/** 
 * Class representing a svg drawing of myself
 * there was problems with overlapping animations and lost original state
 * this will always retain the original points and have the ability to go back
 * @param {String} id - the dom attribute id to be used with document.getElementById
 * @param {String} selector - a css selector that determines what paths will be used by Snap.svg and tracked by this class
*/
class Chibi {
  constructor(id, selector='path.part') {
    this.id = id
    this.snap = Snap(`#${id}`)
    this.parts = this.snap.selectAll(selector)
    this.original = {}

    this.parts.forEach(p => {
      this.original[p.id] = {
        d: p.node.getAttribute('d'),
        fill: p.node.getAttribute('fill'),
        fillOpacity: p.node.getAttribute('fill-opacity'),
        transform: p.node.getAttribute('transform'),
      }
    })

    this.stop()
  }

  stop() {
    this.parts.forEach(p => p.stop())
  }

  restore() {
    this.parts.forEach(p => {
      p.node.setAttribute('d', this.original[p.id].d)
      p.node.setAttribute('fill', this.original[p.id].fill)
      p.node.setAttribute('fill-opacity', this.original[p.id].fillOpacity)
    })
  }
}