export default Ember.Route.extend({
  model: function() {
    return this.store.find('<%= file_name.singularize -%>');
  }
});
