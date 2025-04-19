// resizer_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"];
  static values = { isResizing: { type: Boolean, default: false } };

  connect() {
    console.log("dwadwa2");
  }

  start() {
    this.isResizingValue = true;
  }

  stop() {
    this.isResizingValue = false;
  }

  set(event) {
    if (!this.isResizingValue) { return; }

    this.panelTarget.style.width = `${this.panelTarget.offsetWidth + event.movementX}px`;
  }
}
