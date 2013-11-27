export default Ember.Route.extend({
  model: function() {
    return this.store.createRecord('<%= file_name.singularize -%>');
  },
  deactivate: function() {
    var model = this.get('controller.model');
    if (model.get('isNew')) {
      model.deleteRecord();
    }
  },
  actions: {
    save: function() {
      var model = this.get('controller.model');
      var _this = this;
      model.save().then(function() {
        _this.transitionTo('<%= file_name.pluralize -%>.show', model);
      });
    },
    cancel: function() {
      this.transitionTo('<%= file_name.pluralize -%>.index');
    }
  }
});
