# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root
  attr_accessor :parent
  def initialize
    @root = nil
  end


  def insert(value)
    inserted = false

    if @root.nil?
      @root = BSTNode.new(value)
      inserted = true
    end
    target_node = @root
    until inserted
      if value <= target_node.value && !target_node.left
        target_node.left = BSTNode.new(value)
        inserted = true
      elsif value <= target_node.value
        target_node = target_node.left
        next
      elsif value > target_node.value && !target_node.right
        target_node.right = BSTNode.new(value)
        inserted = true
      elsif value > target_node.value
        target_node = target_node.right
        next
      end
    end
  end


  def find(value, tree_node = @root)
    target_node = tree_node

    while target_node.left || target_node.right || value == target_node.value
      return target_node if value == target_node.value
      if value <= target_node.value
        @parent = target_node
        target_node = target_node.left
      elsif value > target_node.value
        @parent = target_node
        target_node = target_node.right
      end
    end
    nil
  end

  def delete(value)
    if @root.value == value && !@root.left && !@root.right
      @root = nil
      return nil
    end
    target_node = find(value, @root)

    if !target_node
      return nil
    elsif !target_node.left && !target_node.right
      delete_child(target_node)
    elsif (!target_node.left && target_node.right) || (!target_node.right && target_node.left)
      child_node = target_node.left || target_node.right
      delete_child(target_node)
      if(child_node.value <= @parent.value)
        @parent.left = child_node
      else
        @parent.right = child_node
      end
    else
      max = maximum(target_node.left)
      target_node.value = max.value
      @parent.right = max.left
    end


  end

  def delete_child(target_node)
    if target_node == @parent.left
      @parent.left = nil
    else
      @parent.right = nil
    end
  end


  def maximum(tree_node = @root)
    target_node = tree_node
    until !target_node.right
      @parent = target_node
      target_node = target_node.right
    end

    target_node
  end

  def minimum(tree_node = @root)
    target_node = tree_node
    until !target_node.left
      @parent = target_node
      target_node = target_node.left
    end

    target_node
  end

  def depth(tree_node = @root)
    if tree_node.nil?
      return 0
    end

    if tree_node.left.nil? && tree_node.right.nil?
      return 0
    end
    sum = 0
    if tree_node.left || tree_node.right
      sum += 1
    end
    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)
    actual_depth = 0

    if left_depth >= right_depth
      actual_depth = left_depth
    else
      actual_depth = right_depth
    end

    return sum + actual_depth
  end

  def is_balanced?(tree_node = @root)
    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)

    return left_depth == right_depth

  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] if tree_node.nil?
    return [tree_node.value] if tree_node.left.nil? && tree_node.right.nil?

    in_order_traversal(tree_node.left, arr) + [tree_node.value] + in_order_traversal(tree_node.right, arr)

  end

end
