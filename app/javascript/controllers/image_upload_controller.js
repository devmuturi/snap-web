import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-upload"
export default class extends Controller {
  static = [
    "preview",
    "cta",
    "progress",
    "remove"
  ]

  connect() {
    if (this.previewTarget.getAttribute("src")) {
      this.setState("image_set")
    } else {
      this.setState("no_image")
    }
  }

  // private

  setState(state) {
    switch(state) {
      case "no image":
        this.ctaTarget.classList.remove("is-hidden")
        this.removeTarget.classList.add("is-hidden")
        this.progressTarget.classList.add("is-hidden")
        break
      case "uploading":
        this.ctaTarget.classList.remove("is-hidden")
        this.removeTarget.classList.add("is-hidden")
        this.progressTarget.classList.remove("is-hidden")
        break
      case "image_set":
        this.ctaTarget.classList.add("is-hidden")
        this.removeTarget.classList.remove("is-hidden")
        this.progressTarget.classList.add("is-hidden")
        break
    }
  }

  // File upload Delegate
  setFileUploadProgress(progress) {
    this.progressTarget.value = progress
  }
}
