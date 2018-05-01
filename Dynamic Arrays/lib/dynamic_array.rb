require_relative "static_array"
require "byebug"
class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    if index >= @length
      raise "index out of bounds"
    else
      return @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    if index >= @length
      raise "index out of bounds"
    else
      @store[index] = value
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" unless @length > 0
    res = @store[@length - 1]
    @store[@length - 1] = nil
    @length -= 1

    res
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length + 1 > capacity

    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" unless @length > 0
    res = @store[0]
    tmp = StaticArray.new(capacity)
    (1...@length).each do |i|
      tmp[i - 1] = @store[i]
    end
    @store = tmp
    @length -= 1
    res
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length + 1 > capacity
    tmp = StaticArray.new(capacity)
    tmp[0] = val
    (0...@length).each do |i|
      tmp[i + 1] = @store[i]
    end
    @store = tmp
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    tmp = StaticArray.new(capacity * 2)

    @length.times do |i|
      tmp[i] = @store[i]
    end

    @store = tmp
    @capacity *= 2
  end
end
