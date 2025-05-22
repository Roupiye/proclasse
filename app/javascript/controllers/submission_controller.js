import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: String
  }

  connect() {
  }

  switchCode() {
    const code_el = document.getElementById(`code_submission_${this.idValue}`);
    const code = code_el.innerHTML

    const element = document.getElementById('submission_code');
    element.dispatchEvent(
      new CustomEvent("code", {
        detail: { code: code },
      })
    )
  }
}
