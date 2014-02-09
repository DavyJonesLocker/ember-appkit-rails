import <%= file_name.camelize -%> from '<%= app_path -%>/models/<%= require_name.dasherize -%>';

module('Unit - <%= file_name.camelize -%>');

test('exists', function(){
  ok( <%= file_name.camelize -%>, 'Expected <%= file_name.camelize -%> to exist.');
});
