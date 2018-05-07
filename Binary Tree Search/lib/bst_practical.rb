
def kth_largest(tree_node, k)
  tree = BinarySearchTree.new
  tree.root = tree_node
  if tree.depth(tree_node.right) == (k - 1)
    return tree_node
  elsif tree.depth(tree_node.right) >= k
    kth_largest(tree_node.right, k)
  else
    kth_largest(tree_node.left, (k - 1 - tree.depth(tree_node.right)))
  end
end
