require 'pathname'
require 'generators/ember/bootstrap_generator'

module IntegrationTestSupport
  def setup
    Dir.chdir 'test/dummy' do
      silence_stream(STDOUT) do
        Ember::Generators::BootstrapGenerator.start
      end
    end
  end
end
