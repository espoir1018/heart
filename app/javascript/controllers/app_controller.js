import {Controller} from "@hotwired/stimulus"
import PerfectScrollbar from 'perfect-scrollbar';

// Connects to data-controller="app"
export default class extends Controller {

  static targets = ["main"]

  connect() {
    const mainPsb = new PerfectScrollbar(this.mainTarget, {
      heelSpeed: 2,
      wheelPropagation: true,
      minScrollbarLength: 20,
      suppressScrollX: true
    });
  }
}
