import Person from 'appkit/models/person';

var IndexRoute = Ember.Route.extend({
  model: function() {
    return Person.create({name: 'Brian Cardarella'});
  }
});

export default = IndexRoute;
