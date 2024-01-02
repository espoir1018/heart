import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="menu-main"
export default class extends Controller {
  connect() {
    let $main = $(this.element);
    this.$collapses = $main.find('.collapse');
    this.$activeMenu = $main.find('[aria-current="page"]');
    if (this.$activeMenu.closest('div').hasClass('collapse')) {
      this.$activeCollapse = this.$activeMenu.closest('div');
    }

    // 初始化时，需要定位到滚动位置
    this.scroll({params: {active: true}});

    // 收起后
    this.$collapses.on("hidden.bs.collapse", (_e) => {
      // 判断是否全部关闭
      // 排除当前页面的菜单组
      let length = this.$collapses.filter((_index, ele) => {
        let tmp_ele;
        if (this.$activeCollapse && this.$activeCollapse.dom() === ele) {
          // 如果本次判断的collapse是当前页面的菜单组
          // 则略过
        } else {
          tmp_ele = ele;
        }

        // class 有这个 show 说明是打开的
        // 则记录下来，此时说明没有全部关闭
        if (tmp_ele && $(tmp_ele).hasClass('show')) {
          return ele
        }
      }).length;

      // 全部关闭后
      // scroll 到当前页面的菜单组
      if (length === 0) {
        this.scroll({params: {active: true}});
      }
    })

    // 展开后
    this.$collapses.on("shown.bs.collapse", (e) => {
      // 关闭其他菜单组
      // 排除当前展开的菜单组
      // 排除当前页面的菜单组
      this.$collapses.filter((_index, ele) => {
        let tmp_ele;
        if (e.currentTarget === ele) {
          // 如果本次判断的collapse是当前展开的collapse
          // 则略过
        } else {
          if (this.$activeCollapse && this.$activeCollapse.dom() === ele) {
            // 如果本次判断的collapse是当前页面的菜单组
            // 则略过
          } else {
            tmp_ele = ele;
          }
        }

        // class 有这个 show 说明是打开的
        // 需要进行关闭
        if (tmp_ele && $(tmp_ele).hasClass('show')) {
          return ele
        }
      }).each((_index, ele) => {
        $(ele).collapse('hide'); // 关闭其他菜单组
      })

      // 定位到当前菜单
      this.scroll($(e.target).prev().dom());
    })

  }

  scroll(event) {
    let timeout = 400
    if (event.params) {
      if (this.$activeCollapse) {
        event = this.$activeCollapse.prev().dom();
      } else {
        event = this.$activeMenu.dom();
      }
      timeout = 0;
    }

    setTimeout(() => {
      $(this.element).parent().animate({
        scrollTop: (event.offsetTop > 8 ? event.offsetTop - 8 : 0)
      }, 400);
    }, timeout)
  }

}
