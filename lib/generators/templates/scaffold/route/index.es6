export default Ember.Route.extend({
  model: function() {
    return this.store.find('<%= require_name.singularize -%>');
  }
});
