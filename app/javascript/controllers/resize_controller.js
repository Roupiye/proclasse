// resizer_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panelL", "panelR", "gutter"];

  connect() {
  }

  resize(e) {
    let prevX = e.x;
    const leftPanel = this.panelLTarget.getBoundingClientRect();
    const leftPane = this.panelLTarget;

    window.addEventListener('mousemove', mousemove);
    window.addEventListener('mouseup', mouseup);

    document.body.style.userSelect = 'none';

    function mousemove(e) {
      let newX = prevX - e.x;
      leftPane.style.width = leftPanel.width - newX + "px";
    }

    function mouseup() {
      window.removeEventListener('mousemove', mousemove);
      window.removeEventListener('mouseup', mouseup);
      document.body.style.userSelect = '';
    }
  }
}
