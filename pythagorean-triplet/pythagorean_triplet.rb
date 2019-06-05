class Triplet
  def initialize(*sides) 
    @sides = sides
  end

  def sum # rubocop:disable Rails/Delegate
    sides.sum
  end

  def product
    sides.reduce(:*)
  end

  def pythagorean?
    sides[0]**2 + sides[1]**2 == sides[2]**2
  end

  def self.where(options = {})
    min_factor = options[:min_factor] || 0
    max_factor = options[:max_factor]
    sum = options[:sum]
    triplets = TripletFinder.new(min_factor, max_factor, sum).triplets
    triplets.map! { |triplet| Triplet.new(*triplet) }
  end

  private

  attr_reader :sides
end

class TripletFinder
  attr_reader :triplets

  def initialize(min_factor, max_factor = 0, sum = nil)
    @triplets = generate_triplets(min_factor, max_factor, sum)
  end
  
  private

  def generate_triplets(min, max, sum)
    triplets = []
    (2..max).step(2).each do |seed|
      dicksons_method(seed).each do |triplet| 
        if triplet.all? { |value| value.between?(min, max) }
          if sum
            triplets.push(triplet) if triplet.sum == sum
          else
            triplets.push(triplet)
          end
        end
      end
    end
    triplets
  end

  def dicksons_method(seed) 
    # as described at https://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_triplets
    find_factors(seed**2 / 2).map { |factor_a, factor_b| [seed + factor_a, seed + factor_b, seed + factor_a + factor_b] } 
  end

  def find_factors(natural) 
    (1..Math.sqrt(natural)).map { |integer| [integer, natural / integer] if (natural % integer).zero? }.compact
  end
end
