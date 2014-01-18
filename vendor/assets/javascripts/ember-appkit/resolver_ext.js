(function() {
  var Resolver = require('resolver').default;
  var originalResolveOther = Resolver

  function resolveCustomPrefix(parsedName) {
    /*jshint validthis:true */

    var prefix = this.namespace.modulePrefix,
        type = parsedName.type,
        name = parsedName.fullNameWithoutType,
        tmpModuleName, moduleName, module;

    if (this.namespace[type + 'Prefix']) {
      prefix = this.namespace[type + 'Prefix'];
    }

    tmpModuleName = prefix + '/' + type;
    if (name === 'main' && requirejs._eak_seen[tmpModuleName]) {
      moduleName = tmpModuleName;
    } else {
    }

    if (!moduleName) { moduleName = prefix + '/' + type + 's/' + name; }

    if (requirejs._eak_seen[moduleName]) {
      module = require(moduleName);
      if (module['default']) { module = module['default']; }

      return module;
    } else {
      return this.resolveOther(parsedName);
    }
  }

  Resolver.reopen({
    resolveRouter: resolveCustomPrefix,
    resolveAdapter: resolveCustomPrefix,
    resolveSerializer: resolveCustomPrefix
  });
})();
