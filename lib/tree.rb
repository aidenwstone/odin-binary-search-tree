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

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
      return
    end

    insert_node(@root, value)
  end

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

  def build_tree(data)
    return nil if data.empty?

    cleaned_data = data.uniq.sort
    mid_index = cleaned_data.length / 2
    root_value = cleaned_data[mid_index]

    left_node = build_tree(cleaned_data.take(mid_index))
    right_node = build_tree(cleaned_data.drop(mid_index + 1))

    Node.new(root_value, left_node, right_node)
  end

  def insert_node(curr_node, value) # rubocop:disable Metrics/MethodLength
    return if value == curr_node.value

    if value < curr_node.value
      if curr_node.left_child.nil?
        curr_node.left_child = Node.new(value)
        return
      end

      insert_node(curr_node.left_child, value)
    else
      if curr_node.right_child.nil?
        curr_node.right_child = Node.new(value)
        return
      end

      insert_node(curr_node.right_child, value)
    end
  end

  def delete_leaf_node(prev_node, curr_node)
    is_left = prev_node.left_child == curr_node
    is_left ? prev_node.left_child = nil : prev_node.right_child = nil
  end

  def delete_single_child_node(prev_node, curr_node)
    is_left = prev_node.left_child == curr_node
    next_node = curr_node.left_child || curr_node.right_child

    is_left ? prev_node.left_child = next_node : prev_node.right_child = next_node
  end
end
