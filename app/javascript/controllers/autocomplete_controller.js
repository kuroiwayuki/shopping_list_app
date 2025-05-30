// controllers/autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hidden"]

  connect() {
    console.log("✅ autocomplete connected")
  }

  setItemId(event) {
    console.log(event)
    const selectedId = event.detail.id
    if (this.hasHiddenTarget) {
      this.hiddenTarget.value = selectedId
    }
  }
}
