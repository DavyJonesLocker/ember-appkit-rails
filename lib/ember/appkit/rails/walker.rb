require 'ripper'

class Walker
  def initialize(resource, path, api_version)
    @resource = resource
    @file = File.open(path, 'r+')
    content = @file.read
    @ast = Ripper.sexp(content)
    @lines = content.split("\n")
    @api_version = api_version
  end

  def run
    find_api_namespace(@ast)

    output = nil
    line_number = @lines.index { |line| line =~ /routes\.draw do/ }

    if @write_to
      if @write_to.first == :version
        output = write_resource
      else
        output = write_version_namespace do
          write_resource
        end
      end
      line_number = @write_to.last - 1
    else
      output = write_api_namespace do
        write_version_namespace do
          write_resource
        end
      end
    end

    @lines.insert(line_number + 1, output)
    @file.rewind
    @file.write(@lines.join("\n"))
    @file.close
  end

  def write_api_namespace
    "  namespace :api do\n#{yield}\n  end"
  end

  def write_version_namespace
    "    namespace :v#{@api_version} do\n#{yield}\n    end"
  end

  def write_resource
    "      resources :#{@resource}, except: [:new, :edit]"
  end

  def find_api_namespace(ast)
    find_namespace(ast, 'api') do |ast|
      find_version_namespace(ast, @api_version)

      if @write_to.nil?
        @write_to = [:api, ast[1][1][2][0]]
      end

      # found the first instance of the namespace
      # immediately short-circuit
      return
    end
  end

  def find_version_namespace(ast, version)
    find_namespace(ast, "v#{version}") do |ast|
      @write_to = [:version, ast[1][1][2][0]]

      # found the first instance of the namespace
      # immediately short-circuit
      return
    end

    @write_to
  end

  def find_namespace(ast, name)
    walk(ast) do |ast, node|
      if node == :method_add_block
        flat_ast = ast[1].flatten
        if flat_ast.include?('namespace') && flat_ast.include?(name)
          yield(ast)
        end
      end
    end
  end

  def walk(ast, &block)
    if ast.is_a?(Array)
      ast.each do |node|
        yield(ast, node)
        walk(node, &block)
      end
    end
  end
end
