import { Controller } from "@hotwired/stimulus"
import { FileUpload } from "../helpers/file_upload"

// Connects to data-controller="image-upload"
export default class extends Controller {
  static targets = [
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

  upload(event) {
    let file = event.target.files[0]
    new FileUpload(
      event.target.files[0],
      event.target.dataset.directUploadUrl,
      this
    ).start()
  }

  // private

  setState(state) {
    switch(state) {
      case "no_image":
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

  fileUploadDidStart(upload) {
    this.setState("uploading")
  }

  fileUploadDidComplete(error, attributes) {
    if(error) {
      this.setState("no_image")
      return
    }

    this.setState("image_set")
  }
}
