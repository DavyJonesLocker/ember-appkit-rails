require 'generators/ember/model_generator'

module Ember
  module Generators
    class ScaffoldGenerator < ModelGenerator
      source_root File.expand_path("../../templates", __FILE__)
      desc "Scaffolds a new Ember CRUD"

      class_option :skip_route, :type => :boolean, :default => false, :desc => "Don't create route"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"

      def create_route_files
        create_resource_files_for(:route, 'es6')
        inject_into_router_file(file_name)
      end

      def create_template_files
        create_resource_files_for(:template, 'hbs')
        template "scaffold/template.hbs", File.join(app_path, 'templates', "#{file_name.pluralize}.hbs")
        template "scaffold/template/form.hbs", File.join(app_path, 'templates', file_name.pluralize, 'form.hbs')
      end

      private

      def create_resource_files_for(type, extension)
        dir = type.to_s.pluralize
        resource = file_name.pluralize

        [:edit, :index, :new, :show].each do |action|
          template "scaffold/#{type}/#{action}.#{extension}", File.join(app_path, dir, "#{resource}/#{action}.#{extension}")
        end
      end

      def inject_into_router_file(name)
        router_file = "#{config_path}/router.es6"
        js = <<-JS

  this.resource('#{name.pluralize}', function() {
    this.route('new');
    this.route('show', {path: ':#{file_name.singularize}_id'});
    this.route('edit', {path: ':#{file_name.singularize}_id/edit'});
  });
 JS
        inject_into_file(router_file, :after => /^.*Router.map\(function\(\) \{*$/) do
          js.rstrip
        end
      end
    end
  end
end

