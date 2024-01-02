import {Controller} from "@hotwired/stimulus"
import PerfectScrollbar from 'perfect-scrollbar';
import Cookies from "js-cookies/src/cookies";

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["main", "refresh"]
  static classes = ['systolic', 'normal']

  initialize() {
  }

  connect() {
    this.psb = new PerfectScrollbar(this.mainTarget, {
      heelSpeed: 2,
      wheelPropagation: true,
      minScrollbarLength: 20,
      suppressScrollX: true
    });
    this.tooltipers = document.querySelectorAll('.tooltipster')

    if ($(this.element).hasClass(this.systolicClass)) {
      Cookies.setItem('menu-systolic', 'true');
      // 收起时显示
      [...this.tooltipers].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
    }
  }

  // 1. 定位
  scroll() {
    let ele = $(this.mainTarget).find('ul').dom();
    const menuMainController = this.application.getControllerForElementAndIdentifier(ele, 'menu-main')
    menuMainController.scroll({params: {active: true}});
  }

  // 菜单刷新
  refresh() {
    this.refreshTarget.click()
  }

  // 菜单收起
  toggle() {
    const $body = $('body')
    if ($body.hasClass('open-menu')) {
      setTimeout(() => this.element.classList.add('d-none'), 160)
      return $body.removeClass('open-menu')
    }

    this.element.classList.toggle(this.systolicClass)
    if ($(this.element).hasClass(this.systolicClass)) {
      Cookies.setItem('menu-systolic', 'true');
      // 收起时显示
      [...this.tooltipers].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
    } else {
      Cookies.setItem('menu-systolic', 'false');
      // 展开时注销
      [...this.tooltipers].map(tooltipTriggerEl => bootstrap.Tooltip.getInstance(tooltipTriggerEl).dispose())
    }
  }
}
