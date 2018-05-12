
class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {1 => [[1]], 2 => [[2],[1,1]], 3 => [[1,2],[2,1],[1,1,1],[3]]}
    @super_cache = {0 => [[]], 1 => [[1]]}
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    answer = blair_nums(n-1) + blair_nums(n-2) + (2 * (n - 1) - 1)
    @blair_cache[n] = answer
    answer
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    return cache[n]
  end

  def frog_cache_builder(n)
    ways = @frog_cache
    return ways if ways[n]
    (4..n).each do |i|
      ways[i] = []
      (1...i).each do |j|
        ways[j].each do |x|
          (1..3).each do |z|
            ways[i].concat([x + [z]]) if [x + [z]][0].reduce(:+) == i
          end
        end
      end
    end
    ways
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    answer = []
    (1..3).each do |i|
      answer.concat(frog_hops_top_down_helper(n - i).map {|j| j + [i]})
    end
    @frog_cache[n] = answer
    answer
  end

  def super_frog_hops(num_stairs, max_stairs)
    cache = super_frog_hops_helper(num_stairs, max_stairs)
    cache[num_stairs]
  end

  def super_frog_hops_helper(n, k)
    return @super_cache if n < 2
    (2..n).each do |i|
      @super_cache[i] = []
      (1..k).each do |j|
        @super_cache[i] += @super_cache[i - j].map { |z| z + [j] } if i >= j
      end
    end
    @super_cache
  end


  def knapsack(weights, values, capacity)
    array = knapsack_table(weights, values, capacity)
    array.last.last
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    n = weights.length
    array = Array.new(capacity + 1) { Array.new(n, 0) }
    (1..capacity).each do |j|
      (0...n).each do |i|
        if weights[i] > j
          array[j][i] = array[j][i - 1]
        elsif i == 0
          array[j][i] = values[i]
        else
          previous = array[j][i - 1]
          array[j][i] = [previous, array[j - weights[i]][i - 1] + values[i]].max
        end
      end
    end
    array
  end

  def maze_solver(maze, start_pos, end_pos)

  end
end
