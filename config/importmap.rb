# Pin npm packages by running ./bin/importmap

pin "application", preload: true

pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.3/lib/assets/compiled/rails-ujs.js"

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true

pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
