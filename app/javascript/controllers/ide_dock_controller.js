import ApplicationController from "controllers/application_controller"

export default class extends ApplicationController {
  static values = {
    selected: { type: String, default: 'code' },
  }

  connect() {
    this.layout_elements = {
      "code": document.getElementById("ide-code"),
      "navbar": document.getElementById("nav-bar"),
      "gutter": document.getElementById("ide-gutter"),
      "panelL": document.getElementById("ide-panel-l"),
    }

    this.watch()
    // addEventListener("resize", this.watch)
  }

  disconnect() {
    // removeEventListener("resize", this.watch)
  }

  watch(e) {
    var element = document.getElementById("ide-dock")
    var style = window.getComputedStyle(element)

    if(style.display != 'none'){
      this.set_layout()
    } else {
      this.reset_layout()
    }
  }

  set_layout() {
    Object.values(this.layout_elements).forEach((element) => {
      element.classList.add("hidden")
    })

    this.layout_elements[this.selectedValue].classList.remove("hidden")
  }

  reset_layout() {
    Object.values(this.layout_elements).forEach((element) => {
      element.classList.remove("hidden")
    })
  }
}
