# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/channels", under: "channels"
pin_all_from "app/javascript/config", under: "config"
pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.2.200
pin "morphdom" # @2.6.1
pin "cable_ready" # @5.0.5
pin "stimulus_reflex", to: "stimulus_reflex.js", preload: true
pin "fireworks-js", to: "https://ga.jspm.io/npm:fireworks-js@2.10.0/dist/index.es.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@stimulus-components/rails-nested-form", to: "@stimulus-components--rails-nested-form.js" # @5.0.0

pin 'monaco-editor', to: 'https://cdn.jsdelivr.net/npm/monaco-editor@0.45.0/+esm'
pin "tailwindcss-stimulus-components" # @6.1.3
pin "@stimulus-components/reveal", to: "@stimulus-components--reveal.js" # @5.0.0
