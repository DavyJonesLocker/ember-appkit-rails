import <%= config[:object] -%> from '<%= app_path -%>/controllers/<%= require_name.dasherize.pluralize -%>/<%= config[:action] -%>';

module('Unit - <%= config[:object] -%>');

test('it exist', function(){
  expect(2);

  ok(<%= config[:object] -%>);
  ok(<%= config[:object] -%>.create() instanceof Ember.<%= config[:object] -%>);
});
