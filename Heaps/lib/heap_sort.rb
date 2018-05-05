require_relative "heap"

class Array
  def heap_sort!
    (2..count).each do |donger|
      BinaryMinHeap.heapify_up(self, donger - 1, donger)
    end
    count.downto(2).each do |donger|
      self[donger - 1], self[0] = self[0], self[donger - 1]
      BinaryMinHeap.heapify_down(self, 0, donger - 1)
    end
    self.reverse!
  end
end
