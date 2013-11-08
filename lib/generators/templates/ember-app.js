//= require ember-appkit
//= require_self
//= require router
//= require_tree ./mixins
//= require_tree ./models
//= require_tree ./templates
//= require_tree ./controllers
//= require_tree ./components
//= require_tree ./routes
//= require_tree ./views
//= require_tree ./helpers

window.<%= application_name.camelize %> = require('app').default.create();
