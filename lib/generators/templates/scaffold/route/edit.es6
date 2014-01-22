export default Ember.Route.extend({
  model: function(params) {
    return this.store.find('<%= file_name.singularize -%>', params.<%= file_name.singularize -%>_id);
  },
  deactivate: function() {
    var model = this.get('controller.model');
    model.rollback();
  },
  actions: {
    save: function(model) {
      var _this = this;
      model.save().then(function() {
        _this.transitionTo('<%= file_name.pluralize -%>.show', model);
      });
    },
    cancel: function(model) {
      this.transitionTo('<%= file_name.pluralize -%>.show', model);
    }
  }
});
