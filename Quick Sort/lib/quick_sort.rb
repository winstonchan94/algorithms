class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.empty?
    pivot = array[0]
    left = array.select { |el| pivot > el }
    middle = array.select { |el| pivot == el }
    right = array.select { |el| pivot < el }
    sort1(left) + middle + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }
    return array if length < 2
    pivy = partition(array, start, length, &prc)
    left = pivy - start
    right = length - (left + 1)
    sort2!(array, start, left, &prc)
    sort2!(array, pivy + 1, right, &prc)
    arrays
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }
    pivy = start
    pivot = array[start]
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivy + 1] = array[pivy + 1], array[idx]
        pivy += 1
      end
    end
    array[start], array[pivy] = array[pivy], array[start]
    pivy
  end
end
