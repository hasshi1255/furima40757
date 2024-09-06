import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
import "@hotwired/turbo-rails"
import "controllers"
import "card"

application.debug = false
window.Stimulus   = application

export { application }
