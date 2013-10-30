module GeneratorTestSupport
  def prepare_destination
    super

    dir = 'app/assets/javascripts'
    dest = Rails.root.join("tmp", "generator_test_output", dir)

    FileUtils.mkdir_p dest
    File.write(dest.join('application.js'), "")

    FileUtils.mkdir_p dest.join('custom')
    File.write(dest.join('custom/application.js'), "")
  end

  private

  def assert_new_dirs(options = {})
    path = options[:in_path] || ember_path

    %W{models controllers views helpers components templates templates/components routes}.each do |dir|
      assert_directory "#{path}/#{dir}"
      assert_file "#{path}/#{dir}/.gitkeep"
    end

  end

  def application_name
    "App"
  end

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end
end
