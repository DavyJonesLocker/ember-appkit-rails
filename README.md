# EmberAppkitRails

Ember Appkit for the Asset Pipeline

**This gem is still pre-1.0 and as such its public API will likely change over the course of heading towards 1.0**

[![Build Status](https://secure.travis-ci.org/dockyard/ember-appkit-rails.png?branch=master)](http://travis-ci.org/dockyard/ember-appkit-rails)
[![Dependency Status](https://gemnasium.com/dockyard/ember-appkit-rails.png?travis)](https://gemnasium.com/dockyard/ember-appkit-rails)
[![Code Climate](https://codeclimate.com/github/dockyard/ember-appkit-rails.png)](https://codeclimate.com/github/dockyard/ember-appkit-rails)

## Prerequisites

[Node.js](http://nodejs.org) is required. You can either download the
package from the website or run `brew install node` (for Mac users
only).

## Installation ##

Include the gem in your `Gemfile`

```ruby
gem 'ember-appkit-rails'
```

You should not need to specify any additional core Ember dependencies.
`EmberAppkitRails` includes all you need to get going.

Run the bootstrap generator to prepare your application:

```
rails g ember:bootstrap
```

Then run your Rails server and visit `http://localhost:3000`. If you see `Welcome to Ember!` then you are good to go!

### What do you get? ###

`ember-appkit-rails` will add the `app/` and `config/` directories in
your Rails application to the asset pipeline. We want you to
think of your Ember application files with as much precedence as your
Rails application files.

`ember-appkit-rails` **completely removes `app/assets/javascripts` from
the asset loadpath.** Any files put into this directory will be ignored
during asset compilation. All business logic
you need should be added to `app/`. If you need to add a 3rd party
library these should go into `vendor/assets/javascripts/`.

#### Resolving ####

In order for the resolver to work properly Ember application files need to go into
the correct directories. For example, models **must** go into
`app/models`, controllers **must** go into `app/controllers`, routes
**must** go into `app/routes`, etc... The transpiler makes use of the
logical path for those files when creating the AMD namespace. The Ember
Appkit Resolver relies upon this namespacing for the lookups.

`jquery-ujs` and `turbolinks` will be removed from your application.

Any files in the `app/` directory that compile to JavaScript will be
automatically required.

You **must** use `es6` modules in your application files.
`ember-appkit-rails` handles the transpiling for you via the
`es6_module_transpiler-rails` gem as long as you add the `.es6`
extension to the end of the file. The [generators](#generators) will create these
files for you.

#### Directory Structure ####

The following is added to your `app/` directory:

* `app/components` your component files
* `app/mixins` names Ember mixins
* `app/routes` route files go here
* `app/templates` your `.hbs` files go here
* `app/templates/components` any component templates go here

The following is added to your `config/` directory:

* `config/application.js` the main loader referenced in your Rails layout view. (replaces `app/assets/javascripts/application.js`)
* `config/adapter.js.erb` configure the ember-data adapter. Pre-set for
  `ActiveModelAdapter` and will set the API version to
`Rails.application.config.ember.api_version`
* `config/router.js` your Ember Router. The actual routes will go in
  `app/routes`
* `config/initializers` any files that compile to JavaScript in this directory will be
  automatically required.
* `config/initializers/csrf.js` sets up the `CSRF` token for doing
  `POST` requests back to the Rails backend via AJAX.
* `config/environment.js` the general environment settings object. You
  should put settings in here that will be common across all environments.
* `config/environments/` hold environment specific settings. The correct
  environment file will be loaded. Name matches value of `Rails.env`.
  Settings added to these files will overwrite settings in
  `config/environment.js`
* `config/environments/development.js` development environment settings
* `config/environments/production.js` production environment settings
* `config/environments/test.js` test environment settings

The `lib/` directory is also mounted into the asset load path. You
should use `lib/` to write any custom code that does not belong in
`app/` or `config/` but is not 3rd part software.

Any 3rd party software should be put into `vendor/assets/javascripts`
(this may change)

## Usage ##

### Generators ###

Ember Appkit Rails provides the following generators:

* `ember:bootstrap`

  Initializes Ember Appkit Rails into your project by creating the required files
  (`router.js.es6`, `ember-app.js.es6`, and the directory structure). Also, removes
  `turbolinks` from `Gemfile` and `app/views/layouts/application.html.erb`.
  The `app/assets/javascripts/` directory from your app is removed.

  The following options are supported:

  * `--app-path` - This is the root path to be used for your Ember application. Default value: `app/`.
  * `--config-path` - This is the root path for your configuration files
    used by your Ember Application. Default value: `config/`
  * `--app-name` - This will be used to name the global variable referencing your application. Default value: `App`.

* `ember:route NAME`

  Creates a route using the provided name in `app/routes/`.

* `ember:controller NAME`

  Creates a controller using the provided name in `app/controllers/`.

  The following options are supported:

  * `--array` - Used to generate an `Ember.ArrayController`.
  * `--object` - Used to generate an `Ember.ObjectController`.

* `ember:view NAME`

  Creates a view using the provided name in `app/views/`.

  The following options are supported:

  * `--without-template` - Used to prevent creating a template for the generated view.

* `ember:component NAME`

  Creates a component in `app/components/` and a template in `app/templates/components/`.

* `ember:template NAME`

  Creates a template using the provided name in `app/templates/`.

* `ember:model NAME [ATTRIBUTES]`

  Creates a model using the provided name in `app/models/`.

  Accepts a list of a attributes to setup on the generated model.

* `ember:resource NAME`

  Creates a route, controller, and template for the provided name.

  The following options are supported:

  * `--array` - Used to generate an `Ember.ArrayController`.
  * `--object` - Used to generate an `Ember.ObjectController`.
  * `--skip-route` - When present a route will not be generated.

* `ember:scaffold NAME [ATTRIBUTES]`

  Creates the following:

  * Model of type name with the attributes provided
  * `edit`, `index`, `new`, `show` routes and templates
  * Injected the named resource into `router.js.es6` along with the
    correct nested routes.

* `ember:helper NAME`

  Creates a helper using the provided name in `app/helpers/`.

#### Rails Generators ####

The regular Rails generators `resource` and `scaffold` can also generate
the matching ember templates if you provide the `--ember` switch to the
command:

```
rails g resource post title:string --ember
```

The default behavior of the following Rails generators have been
modified:

* `scaffold NAME [ATTRIBUTES]`

   * Will generate a controller with only `json` response types.
   * Controller and route are namespaced under `api/vX` where `X` = the
     values of `::Rails.application.config.ember.api_version`

### Configuration ###

#### Environments ####

The bootstrap will add environment specific files to
`config/environemnts` that are only loaded in those environments. In
these files the correct versions of Ember, Ember Data, and Handlebars
are required. Any configuration settings you want passed into the
creation of your Ember app should be added to the `config` object:

```js
config.LOG_TRANSITIONS = true
```

The `window.config` option is mixed into your application. Likewise, any
other environment specific settings should be made in these files.

#### API Versioning ####

Ember Data expect to work with a namespace of `api/vX` where `X` is the
current version of the backend API. To update this value you can
override the the value of `config.ember.api_version` in 
`config/application.rb`. 

The routing to the API endpoints in your application need to match
`api/vX`. For example, you can do the following in `config/routes.rb`

```ruby
namespace :api do
  namespace :v1 do
    resources :users
    resources :documents
  end
end
```

Then the controller files need to be under `app/controllers/api/v1` and
the classes should be namespaced properly:

```ruby
class Api::V1::UsersController < ApplicationController
  ...
end
```

Using the rails `scaffold` generator will automatically inject resource
route into the correct versioned api namespace.

#### Asset Path ####

The default file asset path for `eak-rails` files is `app/`. The
generators will write files to that directory by default instead of
`app/assets/javascripts`. To change this you'll have to modify the
configuration:

```ruby
config.ember.paths.app = 'app/assets/javascripts'
``` 

Adding this to your `config/application.rb` file will generate your
assets into `app/assets/javascripts` instead of `app/`

#### AMD Module Namespacing ####

The default AMD namespace is `app`. Modify this in your
`config/application.rb`

```ruby
config.ember.namespaces.app = 'ember'
``` 

The AMD namespace for the router is `config/` you can change this in
your `config/application.rb` file as well:

```ruby
config.ember.namespaces.config = 'ember_config'
```

## Custom Ember Builds ##

By default Ember Appkit Rails will serve up the proper builds of Ember,
Ember Data, and Handlebars depending upon the environment from their
gems. However, you can add custom builds of each library to your project
to override the default builds. The files you add **must** match a
particular file name to override properly:

<table>
<tr><td>Environment<th>Ember</th><th>Ember Data</th><th>Handlebars</th></tr>
<tr><th>development</th><td>ember.js</td><td>ember-data.js</td><td>handlebars.js</td></tr>
<tr><th>test</th><td>ember.js</td><td>ember-data.js</td><td>handlebars.js</td></tr>
<tr><th>production</th><td>ember.prod.js</td><td>ember-data.prod.js</td><td>handlebars.runtime.js</td></tr>
</table>

For example, if you wanted to build a new copy of Ember.js you should
add the files `ember.js` and `ember.prod.js` to
`vendor/assets/javascripts`. The file of the same name will override the
copy in the gem.

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
