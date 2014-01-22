export default Ember.Route.extend({
  model: function(params) {
    return this.store.find('<%= file_name.singularize -%>', params.<%= file_name.singularize -%>_id);
  },
  actions: {
    destroyRecord: function(model) {
      var _this = this;
      model.destroyRecord().then(function() {
        _this.transitionTo('<%= file_name.pluralize -%>.index');
      });
    }
  }
});
