// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
// import * as Turbo from "@hotwired/turbo"
// window.Turbo = Turbo
import { Turbo } from "@hotwired/turbo-rails"

import "controllers"
import "config"
import "channels"

import "trix"
import "@rails/actiontext"

import "chartkick"
import "Chart.bundle"

// Turbo.setProgressBarDelay(delayInMilliseconds)
window.Turbo = Turbo
