import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    collapsableid: String
  }

  connect() {
  }

  toggle() {
    document.getElementById(this.collapsableidValue).classList.toggle('hidden');
  }
}
