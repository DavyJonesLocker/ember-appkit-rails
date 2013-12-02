## 0.2.1

* Force camelcased es6 module names to dasherized

## 0.2.0

* Ember-Data setting up - Brian Cardarella
* Rails resource generator only overrides if --ember option is given - Brian Cardarella
* Resource is injected into router during resource generator - Brian Cardarella
* Updated es6\_module\_transpiler-rails gem - Wouter Willaert
* Corrected Title in in Welcome Page - Lin Reid
* Remove jquery\_ujs from application.js on bootstrap - Brian Cardarella
* Bootstrap into top-level `appkit/` directory - Brian Cardarella
* Replaced Rails::WelcomeController with LandingController. Now uses
  the application layout with an empty template. - Brian Cardarella
* Added utils/csrf.js to autoset csrf token in $.ajaxPrefilter - Brian Cardarella
* Added cache buster for in-gem application.hbs for Sprockets - Brian Cardarella & Lin Reid
* Added Scaffold Generator - Brian Cardarella
* Application generates into `app/` and `config/` - Brian Cardarella
