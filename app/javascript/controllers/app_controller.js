import {Controller} from "@hotwired/stimulus"
import PerfectScrollbar from 'perfect-scrollbar';

// Connects to data-controller="app"
export default class extends Controller {

  static targets = ["aside", "main"]

  connect() {
    const mainPsb = new PerfectScrollbar(this.mainTarget, {
      heelSpeed: 2,
      wheelPropagation: true,
      minScrollbarLength: 20,
      suppressScrollX: true
    });
  }

  toggle_aside() {
    this.asideTarget.classList.remove('d-none')
    this.element.classList.add('open-aside')

    const asideController = this.application.getControllerForElementAndIdentifier(this.asideTarget, 'aside')
    asideController.scroll();
  }

}
