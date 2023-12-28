import jquery from 'jquery'

window.jQuery = jquery
window.$ = jquery

$.fn.dom = function () {
  return this[0]
}
