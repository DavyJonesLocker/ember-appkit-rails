# EmberAppkitRails

Ember Appkit for the Asset Pipeline

[![Build Status](https://secure.travis-ci.org/dockyard/ember-appkit-rails.png?branch=master)](http://travis-ci.org/dockyard/ember-appkit-rails)
[![Dependency Status](https://gemnasium.com/dockyard/ember-appkit-rails.png?travis)](https://gemnasium.com/dockyard/ember-appkit-rails)
[![Code Climate](https://codeclimate.com/github/dockyard/ember-appkit-rails.png)](https://codeclimate.com/github/dockyard/ember-appkit-rails)

## Installation ##

Include the gem in your `Gemfile`

```ruby
gem 'ember-appkit-rails'
```

You should not need to specify any additional core Ember depdendencies.
`EmberAppkitRails` includes all you need to get going.

## Prerequisites

[Node.js](http://nodejs.org) is required. You can either download the
package from the website or run `brew install node` (for Mac users
only).

## Usage ##

### Generators ###

Ember Appkit Rails provides the following generators:

* `ember:bootstrap`

  Initializes Ember Appkit Rails into your project by creating the required files
  (`router.js.es6`, `ember-app.js.es6`, and the directory structure). Also, removes
  `turbolinks` from `Gemfile`, `app/assets/javascripts/application.js`, and `app/views/layouts/application.html.erb`
  and `jquery_js` from `app/assets/javascripts/application.js`.

  The following options are supported:

  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `app/assets/javascripts/`.
  * `--app-name` - This will be used to name the global variable referencing your application. Default value: `App`.
  * `--leave-turbolinks` - This will prevent the removal of `turbolinks`.
  * `--leave-jqueryujs` - This will prevent the removal of `jquery_ujs`.

* `ember:route NAME`

  Creates a route using the provided name in `app/assets/javascripts/routes/`.

  The following options are supported:

  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `app/assets/javascripts/`.

* `ember:controller NAME`

  Creates a controller using the provided name in `app/assets/javascripts/controllers/`.

  The following options are supported:

  * `--array` - Used to generate an `Ember.ArrayController`.
  * `--object` - Used to generate an `Ember.ObjectController`.
  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `app/assets/javascripts/`.

* `ember:view NAME`

  Creates a view using the provided name in `app/assets/javascripts/views/`.

  The following options are supported:

  * `--without-template` - Used to prevent creating a template for the generated view.
  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `app/assets/javascripts/`.

* `ember:component NAME`

  Creates a component in `app/assets/javascripts/components/` and a template in `app/assets/javascripts/templates/components/`.

  The following options are supported:

  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `app/assets/javascripts/`.

* `ember:template NAME`

  Creates a template using the provided name in `app/assets/javascripts/templates/`.

  The following options are supported:

  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `/app/assets/javascripts`.

* `ember:model NAME [ATTRIBUTES]`

  Creates a model using the provided name in `app/assets/javascripts/models/`.

  Accepts a list of a attributes to setup on the generated model.

  The following options are supported:

  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `app/assets/javascripts/`.

* `ember:resource NAME`

  Creates a route, controller, and template for the provided name.

  The following options are supported:

  * `--array` - Used to generate an `Ember.ArrayController`.
  * `--object` - Used to generate an `Ember.ObjectController`.
  * `--skip-route` - When present a route will not be generated.
  * `--ember-path` - This is the root path to be used for your Ember application. Default value: `app/assets/javascripts/`.

* `ember:helper NAME`

  Creates a helper using the provided name in `app/assets/javascripts/helpers/`.

#### Rails Generators ####

The regular Rails generators `resource` and `scaffold` can also generate
the match ember templates if you profile the `--ember` switch to the
command:

```
rails g resource post title:string --ember
```

TODO: Add details about writing es6 modules

## Authors ##

* [Brian Cardarella](http://twitter.com/bcardarella)
* [Alex Navasardyan](http://twitter.com/twokul)
* [Robert Jackson](http://twitter.com/rwjblue)

A lot of the "real work" was done by [Stefan Penner](http://twitter.com/stefanpenner) with the original [Ember Appkit](https://github.com/stefanpenner/ember-app-kit) project.

[We are very thankful for the many contributors](https://github.com/dockyard/ember-appkit-rails/graphs/contributors)

## Versioning ##

This gem follows [Semantic Versioning](http://semver.org)

## Want to help? ##

Please do! We are always looking to improve this gem.

## Legal ##

[DockYard](http://dockyard.com), LLC &copy; 2013

[@dockyard](http://twitter.com/dockyard)

[Licensed under the MIT license](http://www.opensource.org/licenses/mit-license.php)
