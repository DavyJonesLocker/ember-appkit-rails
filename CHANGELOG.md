## 0.3.0

* Fix issue with asset path ordering. See [#96](https://github.com/dockyard/ember-appkit-rails/issues/96) for details.
* Fix component generator to not add \_component suffix
* Bootstrap generator remove jbuilder
* Don't generate views, helpers, or javascript assets with rails
  resource generator
* Removed ember-rails
* Moved config namespace from config.ember.appkit to config.ember

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
