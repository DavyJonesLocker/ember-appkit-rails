require 'parser/current'

class Walker < AST::Processor
  attr_accessor :found_nodes, :namespace_type

  def initialize(resource, path, api_version)
    @resource = resource
    @file = File.open(path, 'r+')
    @content = @file.read
    @ast = Parser::CurrentRuby.parse(@content)
    @api_version = api_version
    @found_nodes = []
  end

  def handler_missing(node)
    walk(node)
  end

  def on_block(node)
    if is_namespace?(node)
      if is_namespace_type?(node, :api)
        found_nodes << node
        self.namespace_type = :api
        walk_namespace(node)
      elsif is_namespace_type?(node, "v#{@api_version}".to_sym)
        found_nodes << node
        self.namespace_type = :version
        walk_namespace(node)
      end
    else
      walk(node)
    end
  end

  def on_send(node)
    if is_resource?(node, @resource.to_sym)
      @found_resource = true
      found_nodes << node
    end
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

  def invoke!
    process(@ast)
    if found_nodes.empty?
      found_nodes << @ast
    end
    node = found_nodes.last
    begin_pos = node.loc.begin.end_pos

    output = ''

    if namespace_type
      if namespace_type == :version
        output = write_resource
      else
        output = write_version_namespace do
          write_resource
        end
      end
    else
      output = write_api_namespace do
        write_version_namespace do
          write_resource
        end
      end
    end

    @file.rewind
    @file.write(@content.insert(begin_pos + 1, output + "\n"))
    @file.close
  end

  def revoke!
    @revoke = true
    process(@ast)
    return if found_nodes.empty? || @found_resource.nil?
    if found_nodes.last.loc.expression
      begin_pos = found_nodes.last.loc.expression.begin_pos
      end_pos = found_nodes.last.loc.expression.end_pos
    else
      begin_pos = found_nodes.last.loc.begin.begin_pos
      end_pos = found_nodes.last.loc.end.end_pos
    end
    begin_pos = begin_pos - @content[0..begin_pos].reverse.index("\n")
    @file.rewind
    @file.write @content.sub(@content[begin_pos...end_pos], '')
    @file.close
  end

  private

  def is_resource?(node, type)
    node.children[1] == :resource && node.children[2].children.first == type.to_sym
  end

  def is_namespace?(node)
    node.children.first.children[1] == :namespace
  end

  def is_namespace_type?(node, type)
    node.children.first.children[2].children.first == type.to_sym
  end

  def walk_namespace(node)
    process(node.children[2])
    if @revoke && node.children[2] && node.children[2].children == found_nodes.last.to_a
      found_nodes << node
    end
  end

  def walk(node)
    node.children.each do |child|
      process(child) if child.respond_to?(:to_ast)
    end
  end
end
