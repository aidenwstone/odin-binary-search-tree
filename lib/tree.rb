# frozen_string_literal: true

require_relative 'node'

# The Tree class manages a binary search tree.
# It provides functionality to build a tree; insert, delete, and find nodes; rebalance when neccessary, etc.
# This class is designed to be used with the Node class.
class Tree
  def initialize(data)
    @root = build_tree(data)
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

  def height(value); end

  def depth(value); end

  def balanced?; end

  private

  def build_tree(data); end
end
