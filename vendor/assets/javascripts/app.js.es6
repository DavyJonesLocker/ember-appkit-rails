import Resolver from 'ember-appkit/resolver';
import registerComponents from 'ember-appkit/register_components';

var App = Ember.Application.extend({
  LOG_ACTIVE_GENERATION: true,
  LOG_MODULE_RESOLVER: true,
  LOG_TRANSITIONS: true,
  LOG_TRANSITIONS_INTERNAL: true,
  LOG_VIEW_LOOKUPS: true,
  modulePrefix: 'appkit', // TODO: loaded via config
  Resolver: Resolver
});

App.initializer({
  name: 'Register Components',
  initialize: function(container, application) {
    registerComponents(container);
  }
});

export default App;
