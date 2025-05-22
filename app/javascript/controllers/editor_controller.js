import { Controller } from "@hotwired/stimulus"
import * as monaco from 'monaco-editor'

export default class extends Controller {
  connect() {
    this.element.editor = monaco.editor.create(this.element, {
      language: 'python',
      theme: 'vs-dark',
      // value: document.getElementById('submission_code').value,
      automaticLayout: true,
      minimap: { enabled: false },
    })

    let newValue = this.element.editor.getValue()
    const element = document.getElementById('submission_code')
    element.value = newValue

    this.element.editor.onDidChangeModelContent((event) => {
      let newValue = this.element.editor.getValue()
      const element = document.getElementById('submission_code')
      element.value = newValue
    });


    element.addEventListener('code',(event) => {
      // console.log(event.detail.code)
      this.element.editor.setValue(event.detail.code)
    })
  }
}
