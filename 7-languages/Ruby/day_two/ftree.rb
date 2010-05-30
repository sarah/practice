class Tree
  attr_accessor :children, :node_name

  def initialize(tree)
    if tree.is_a?(Hash)
      @node_name = tree.keys.first
      @children  = []
      child_nodes  = tree[@node_name]
      child_nodes.each do |child_node|
        @children << Tree.new(child_node) 
      end
    else
p tree
      @node_name = tree
      @children = []
    end
  end

  def visit_all(&block)
    visit &block
    children.each{|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end
end

family = {'grandpa' => [{'dad'=>['kid1', 'kid2']},{'uncle'=>['kid3','kid4']}]}
family_tree = Tree.new(family)

puts family_tree.inspect

puts "Visiting a node"
puts family_tree.visit{|node| puts node.node_name}
puts "Visiting entire tree"
family_tree.visit_all{|node| puts node.node_name}
