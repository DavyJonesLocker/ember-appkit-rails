module ActiveSupport::Dependencies
  def autoloadable_module?(path_suffix)
    autoload_paths.each do |load_path|
      path = File.join(load_path, path_suffix)
      return load_path if File.directory?(path) && Dir.glob(File.join(path, '**/*.rb')).present?
    end

    return false
  end
end
