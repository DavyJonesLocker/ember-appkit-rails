import Person from 'appkit/models/person';

var IndexRoute = Ember.Route.extend({
  model: function() {
    debugger;
    return Person.create({name: 'Brian Cardarella'});
  }
});

export default = IndexRoute;
