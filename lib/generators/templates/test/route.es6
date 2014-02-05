import <%= config[:route] -%> from '<%= app_path -%>/routes/<%= require_name.dasherize.pluralize -%>/<%= config[:action] -%>';

var route, store;

module('Unit - <%= config[:route] -%>', {
  setup: function(){
    store = {};

    route = <%= config[:route] -%>.create({
      store: store
    });
  },
  teardown: function(){
    Ember.run(route, 'destroy');
  }
});

test('it exist', function(){
  expect(2);

  ok(route);
  ok(route instanceof Ember.Route);
});
