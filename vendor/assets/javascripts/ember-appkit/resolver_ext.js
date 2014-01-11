(function() {
  var Resolver = require('resolver').default;

  function resolveRouter(parsedName) {
    /*jshint validthis:true */

    var prefix = this.namespace.configPrefix,
        routerModule;

    if (parsedName.fullName === 'router:main') {
      // for now, lets keep the router at app/router.js
      if (requirejs._eak_seen[prefix + '/router']) {
        routerModule = require(prefix + '/router');
        if (routerModule['default']) { routerModule = routerModule['default']; }

        return routerModule;
      }
    }
  }

  function resolveAdapter(parsedName) {
    /*jshint validthis:true */

    var prefix = this.namespace.configPrefix,
        adapterModule, adapterName;

    if (parsedName.fullName.match(/adapter:/)) {
      adapterName = parsedName.fullName.split(/adapter:/)[1];
      if (requirejs._eak_seen[prefix + '/adapters/' + adapterName]) {
        adapterModule = require(prefix + '/adapters/' + adapterName);
        if (adapterModule['default']) { adapterModule = adapterModule['default']; }

        return adapterModule;
      }
    }
  }

  Resolver.reopen({
    resolveRouter: resolveRouter,
    resolveAdapter: resolveAdapter
  });
})();
