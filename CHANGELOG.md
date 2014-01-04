## 0.4.0

* Changed Rails controller to use respond\_with instead of render
* Add commented out history location Router details

## 0.3.0

* Fix issue with asset path ordering. See [#96](https://github.com/dockyard/ember-appkit-rails/issues/96) for details.
* Fix component generator to not add \_component suffix
* Bootstrap generator remove jbuilder
* Don't generate views, helpers, or javascript assets with rails
  resource generator
* Removed ember-rails
* Moved config namespace from config.ember.appkit to config.ember
* Don't auto-create modules in app/ for directories that don't contain
  \*.rb files
* Remove local variant `vendor/assets/ember`. It should just go into
  `vendor/assets/javascripts`
* Force model generator to singularize file name
* Ensure correct ember-data is loaded
* Force ember-source, ember-data-source, and handlebars-source to end of
  assets load path
* Replaced default `application.hbs` with Rails-like default page
* Don't remove `app/assets/javascripts` in bootstrap but ignore the path
  in the asset loadpath

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
