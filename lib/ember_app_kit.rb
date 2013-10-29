require 'ember_app_kit/engine'
require 'es6_module_transpiler/rails'

ES6ModuleTranspiler.prefix_pattern = [/^(controllers|models|views|helpers|routes|router|store)/, 'appkit']
