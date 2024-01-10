import { Controller } from "@hotwired/stimulus"
import toastr from 'toastr'

// Connects to data-controller="toastr"
export default class extends Controller {
  static values = {
    type: String,
    content: String,
    options: Object
  }

  connect() {
    toastr.options = {
      ...this.defaultOptions,
      ...this.optionsValue
    }

    toastr[this.typeValue](this.contentValue)
  }

  disconnect() {

  }

  get defaultOptions() {
    let ele = this.element
    return {
      "closeButton": false,
      "debug": false,
      "newestOnTop": true,
      "progressBar": false,
      "positionClass": "toast-top-center",
      "preventDuplicates": true,
      "onclick": null,
      "showDuration": "300",
      "hideDuration": "1000",
      "timeOut": "500000",
      "extendedTimeOut": "100000",
      "showEasing": "swing",
      "hideEasing": "linear",
      "showMethod": "slideDown",
      "hideMethod": "fadeOut",
      "onHidden": function() {
        $(ele).remove()
      }
    };
  }
}
