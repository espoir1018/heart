import {Controller} from "@hotwired/stimulus"
import PerfectScrollbar from 'perfect-scrollbar';

// Connects to data-controller="app"
export default class extends Controller {

  static targets = ["menu", "main"]

  connect() {
    const mainPsb = new PerfectScrollbar(this.mainTarget, {
      heelSpeed: 2,
      wheelPropagation: true,
      minScrollbarLength: 20,
      suppressScrollX: true
    });
  }

  toggle_menu() {
    this.menuTarget.classList.remove('d-none')
    this.element.classList.add('open-menu')

    const menuController = this.application.getControllerForElementAndIdentifier(this.menuTarget, 'menu')
    menuController.scroll();
  }

}
