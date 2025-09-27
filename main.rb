# frozen_string_literal: true

require_relative 'lib/tree'

data = Array.new(15) { rand(1..100) }
test = Tree.new(data)
puts test.balanced? ? 'Tree is balanced!' : 'Tree is not balanced!'
test.pretty_print

puts "\nPrint level-order:"
test.level_order { |node| puts node.value }

puts "\nPrint pre-order:"
test.preorder { |node| puts node.value }

puts "\nPrint post-order:"
test.postorder { |node| puts node.value }

puts "\nPrint in-order:"
test.inorder { |node| puts node.value }

puts "\nUnbalance the tree:"
test.insert(101)
test.insert(165)
test.insert(134)
puts test.balanced? ? 'Tree is balanced!' : 'Tree is not balanced!'
test.pretty_print

puts "\nRebalance the tree:"
test.rebalance
puts test.balanced? ? 'Tree is balanced!' : 'Tree is not balanced!'
test.pretty_print

puts "\nPrint level-order:"
test.level_order { |node| puts node.value }

puts "\nPrint pre-order:"
test.preorder { |node| puts node.value }

puts "\nPrint post-order:"
test.postorder { |node| puts node.value }

puts "\nPrint in-order:"
test.inorder { |node| puts node.value }
