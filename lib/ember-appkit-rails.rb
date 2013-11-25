# This is necessary because the generators live in `lib/generators`
# this path is on the Rubygems load path and the first wins. We need
# to ensure the ember-appkit-rails is always on the load path *before*
# ember-rails

$:.delete(File.expand_path('..', __FILE__))
$:.unshift(File.expand_path('..', __FILE__))

require 'ember/appkit/rails'
