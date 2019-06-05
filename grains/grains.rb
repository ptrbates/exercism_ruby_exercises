require "benchmark"

module GrainsRecursive
  # optimized for readability
  def self.square(square) 
    raise ArgumentError unless square.positive? && square <= 64
    return 1 if square == 1

    2 * GrainsRecursive.square(square - 1)
  end

  def self.total(square = 64, total = 0)
    return total if square.zero?

    new_total = total + GrainsRecursive.square(square)
    new_square = square - 1

    GrainsRecursive.total(new_square, new_total)
  end
end

module Grains
  # optimized for performance
  def self.square(square)
    raise ArgumentError unless square.positive? && square <= 64

    2**(square - 1)
  end

  def self.total
    2**64 - 1
  end
end

square_speed_recursive = Benchmark.measure { 5000.times { GrainsRecursive.square(64) } }
square_speed_direct = Benchmark.measure { 5000.times { Grains.square(64) } }
total_speed_recursive = Benchmark.measure { 5000.times { GrainsRecursive.total } }
total_speed_direct = Benchmark.measure { 5000.times { Grains.total } }
puts "The two versions have the same `total` output: #{GrainsRecursive.total == Grains.total}"
puts "Recursive version (square): #{square_speed_recursive}"
puts "Direct version (square): #{square_speed_direct}"
puts "Recursive version (total): #{total_speed_recursive}"
puts "Direct version (total): #{total_speed_direct}"
puts "Recursive to direct ratio (square): #{square_speed_recursive.total / square_speed_direct.total}"
puts "Recursive to direct ratio (total): #{total_speed_recursive.total / total_speed_direct.total}"
