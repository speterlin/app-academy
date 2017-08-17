class PolyTreeNode
#   attr_reader :parent, :children, :value
#
#   def initialize(value)
#     @value = value
#     @parent = nil
#     @children = []
#   end
#
#   def parent=(new_parent)
#     old_parent = @parent
#     @parent = new_parent
#     old_parent.children.delete(self) if old_parent
#     new_parent.children << self if new_parent
#   end
#
#   def add_child(child_node)
#     child_node.parent = self
#   end
#
#   def remove_child(child_node)
#     raise "Not a child" if child_node.parent != self
#     @children.delete(child_node)
#     child_node.parent = nil
#   end
#
#   def dfs(target_value)
#     return self if self.value == target_value
#
#     @children.each do |child|
#       child_node = child.dfs(target_value)
#       return child_node if child_node
#     end
#
#     nil
#   end
#
#   def bfs(target_value)
#     queue = [self]
#
#     until queue.empty?
#       check_node = queue.shift
#       if check_node.value == target_value
#         return check_node
#       else
#         queue += check_node.children
#       end
#     end
#
#     nil
#   end
end
