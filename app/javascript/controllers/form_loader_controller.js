import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-loader"
// Shows loading indicator with a minimum display time for better UX
export default class extends Controller {
  static targets = ["form", "submitButton", "buttonText", "loadingSpinner"]

  connect() {
    // Intercept form submission to add minimum display time
    this.formTarget.addEventListener("submit", this.handleSubmit.bind(this))
  }

  disconnect() {
    this.formTarget.removeEventListener("submit", this.handleSubmit.bind(this))
  }

  handleSubmit(event) {
    // Prevent immediate form submission
    event.preventDefault()
    
    // Show loading spinner and hide button text immediately
    this.buttonTextTarget.classList.add("d-none")
    this.loadingSpinnerTarget.classList.remove("d-none")
    
    // Disable the submit button to prevent double submission
    this.submitButtonTarget.disabled = true
    
    // Minimum display time (600ms) - enough to be visible, not too slow
    // This ensures users see the feedback even for fast operations
    const minDisplayTime = 600
    
    // Wait for minimum time, then submit the form
    setTimeout(() => {
      // Remove the event listener to allow normal submission
      this.formTarget.removeEventListener("submit", this.handleSubmit.bind(this))
      // Submit the form programmatically
      this.formTarget.submit()
    }, minDisplayTime)
  }
}
