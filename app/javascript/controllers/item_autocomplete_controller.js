// controllers/item_autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "hidden", "results"]
  timeout = null

  search() {
    clearTimeout(this.timeout)

    const query = this.inputTarget.value.trim()
    if (query.length < 1) {
      this.resultsTarget.innerHTML = ""
      return
    }

    this.timeout = setTimeout(() => {
      fetch(`/items/autocomplete?q=${encodeURIComponent(query)}`, {
        headers: { "Accept": "application/json" }
      })
        .then(res => res.json())
        .then(data => {
          this.resultsTarget.innerHTML = ""
          data.forEach(item => {
            const li = document.createElement("li")
            li.textContent = item.name
            li.classList.add("cursor-pointer", "hover:bg-gray-200", "p-2")
            li.addEventListener("click", () => this.select(item))
            this.resultsTarget.appendChild(li)
          })
        })
    }, 300)
  }

  select(item) {
    this.inputTarget.value = item.name
    this.hiddenTarget.value = item.id
    this.resultsTarget.innerHTML = ""
  }
}
