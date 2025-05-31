import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hamburger"
export default class extends Controller {
  static targets = ["results", "button"]
  connect() {
  }

  open(){
    console.log('開けてるよ💩');
    const hamburger = this.resultsTarget;
    console.log(hamburger);
    console.log(this.buttonTarget,"💩💩");
    this.buttonTarget.classList.add('hidden')
    hamburger.classList.remove("hidden")
  }

  close(){
    const hamburger = this.resultsTarget;
    hamburger.classList.add("hidden")
    this.buttonTarget.classList.remove('hidden')
  }
}
