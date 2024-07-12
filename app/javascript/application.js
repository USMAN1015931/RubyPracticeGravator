// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"


// app/javascript/packs/application.js
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "./channels" 

Rails.start()
ActiveStorage.start()
