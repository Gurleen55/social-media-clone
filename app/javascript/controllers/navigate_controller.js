import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navigate"
export default class extends Controller {
  static values = { url: String }
  go(e) {
    console.log("go")
    if (e.target.closest("a, button")) return
    window.location = this.urlValue
  }
}
