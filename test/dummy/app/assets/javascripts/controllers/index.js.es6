export default = Ember.ObjectController.extend({
  actions: {
    sayHi: function() {
      alert(this.get('name') + ' says hi!');
    }
  }
});
