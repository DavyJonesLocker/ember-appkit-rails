var IndexController = Ember.ObjectController.extend({
  actions: {
    sayHi: function() {
      alert(this.get('name') + ' says hi!');
    }
  }
});

export default = IndexController;
