require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Khan's
def topological_sort(vertices)
  in_edge_counts = {}
  no_ins = []

  vertices.each do |vertex|
    in_edge_counts[vertex] = vertex.in_edges.length
    no_ins << vertex if vertex.in_edges.empty?
  end

  result = []
  while !no_ins.empty?
    ding_la = no_ins.shift
    result << ding_la

    ding_la.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      in_edge_counts[to_vertex] -= 1
      no_ins << to_vertex if in_edge_counts[to_vertex] == 0
    end
  end
  if result.length != vertices.length
    return []
  end
  result
end

# Tarjan's
def topological_sort_t(vertices)
  result = []
  visited = Set.new
  vertices.each do |vertex|
    if !visited.include?(vertex)
      dfs_visit(vertex, visited, result)
    end
  end
  result
end

def dfs_visit(vertex, visited, result)
  visited << vertex
  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    if !visited.include?(to_vertex)
      dfs_visit(to_vertex, visited, result)
    end
  end

  result.unshift(vertex)
end
