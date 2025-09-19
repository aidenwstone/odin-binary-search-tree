# frozen_string_literal: true

# The Node class manages instances of binary search tree nodes.
# It provides functionality to store a value and the children of the node, as well as to compare Nodes.
# This class is designed to be used with the Tree class.
class Node
  include Comparable

  attr_accessor :value, :left_child, :right_child

  def initialize(value, left_child, right_child)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end

  def <=>(other)
    @value <=> other.value
  end
end
