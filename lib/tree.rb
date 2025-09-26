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

  def delete(value) # rubocop:disable Metrics/MethodLength
    prev_node = nil
    curr_node = @root
    until value == curr_node.value
      prev_node = curr_node
      curr_node = value < curr_node.value ? curr_node.left_child : curr_node.right_child
    end

    if curr_node.left_child.nil? && curr_node.right_child.nil?
      delete_leaf_node(prev_node, curr_node)
    elsif curr_node.left_child && curr_node.right_child
      delete_multi_child_node(curr_node)
    else
      delete_single_child_node(prev_node, curr_node)
    end
  end

  def find(value)
    curr_node = @root
    until value == curr_node.value
      return if curr_node.left_child.nil? && curr_node.right_child.nil?

      curr_node = value < curr_node.value ? curr_node.left_child : curr_node.right_child
    end
    curr_node
  end

  def level_order # rubocop:disable Metrics/MethodLength
    return [] if @root.nil?

    nodes_to_visit = [@root]
    found_values = []

    until nodes_to_visit.empty?
      curr_node = nodes_to_visit.shift

      children = [curr_node.left_child, curr_node.right_child].compact
      nodes_to_visit.push(*children)

      found_values.push(curr_node.value)
      yield curr_node if block_given?
    end

    found_values
  end

  def inorder(curr_node = @root, &block)
    return [] if curr_node.nil?

    left_values = inorder(curr_node.left_child, &block)
    yield curr_node if block_given?
    right_values = inorder(curr_node.right_child, &block)

    left_values + [curr_node.value] + right_values
  end

  def preorder(curr_node = @root, &block)
    return [] if curr_node.nil?

    yield curr_node if block_given?
    left_values = preorder(curr_node.left_child, &block)
    right_values = preorder(curr_node.right_child, &block)

    [curr_node.value] + left_values + right_values
  end

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

  def get_successor(node)
    curr_node = node.right_child

    curr_node = curr_node.left_child until curr_node.left_child.nil?
    curr_node
  end

  def delete_multi_child_node(curr_node)
    next_node = get_successor(curr_node)

    delete(next_node.value)
    curr_node.value = next_node.value
  end
end
