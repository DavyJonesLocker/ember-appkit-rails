import Person from 'dummy/models/person';

var IndexRoute = Ember.Route.extend({
  model: function() {
    return Person.create({
      name: 'Joe Doe',
      company: 'B&W',
      job: 'Sound Engineer'
    });
  }
});

export default = IndexRoute;
