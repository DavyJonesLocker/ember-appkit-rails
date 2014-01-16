require 'parser/current'
require 'byebug'

file = File.read('routes_with_api_version_namespaces_and_route.rb')

ast = Parser::CurrentRuby.parse(file)

class RouteProcessor < AST::Processor
  attr_accessor :delete_nodes

  def initialize(*)
    @delete_nodes = []
    super
  end

  def handler_missing(node)
    walk(node)
  end

  def on_block(node)
    if is_namespace?(node)
      if is_namespace_type?(node, :api)
        walk_namespace(node)
      elsif is_namespace_type?(node, :v1)
        walk_namespace(node)
      end
    else
      walk(node)
    end
  end

  def on_send(node)
    if is_resource?(node, :dogs)
      delete_nodes << node
    end
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
    if node.children[2].children == delete_nodes.last.to_a
      delete_nodes << node
    end
  end

  def walk(node)
    node.children.each do |child|
      process(child) if child.respond_to?(:to_ast)
    end
  end
end

processor = RouteProcessor.new
processor.process(ast)
if processor.delete_nodes.last.loc.expression
  begin_pos = processor.delete_nodes.last.loc.expression.begin_pos
  end_pos = processor.delete_nodes.last.loc.expression.end_pos
else
  begin_pos = processor.delete_nodes.last.loc.begin.begin_pos
  end_pos = processor.delete_nodes.last.loc.end.end_pos
end
begin_pos = begin_pos - file[0..begin_pos].reverse.index("\n")
puts file.sub(file[begin_pos...end_pos], '')
