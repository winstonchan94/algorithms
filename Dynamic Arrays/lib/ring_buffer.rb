require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[tru_idx(index)]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[tru_idx(index)] = val
    @length += 1
  end

  # O(1)
  def pop
    check_emptiness
    result = @store[tru_idx(@length - 1)]
    @length -= 1
    result
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[tru_idx(@length)] = val
    @length += 1
  end

  # O(1)
  def shift
    check_emptiness
    shifted = @store[@start_idx]
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    @start_idx -= 1
    @store[@start_idx] = val # start_idx is a real index
  end

  def tru_idx(idx)
    (idx + @start_idx) % @capacity
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length


  def check_emptiness
    raise "index out of bounds" if @length == 0
  end

  def check_index(index)
    raise "index out of bounds" if index > @length - 1
  end

  def resize!
    new_cap = @capacity * 2
    new_store = StaticArray.new(new_cap)
    @length.times do |idx|
      new_store[idx] = @store[tru_idx(idx)]
    end
    @start_idx = 0
    @capacity = new_cap
    @store = new_store
  end
end
