require "./vector"

module Tres
  class Vector2 < Vector
    def self.elements; { x: 0, y: 1 }; end
    def self.dimensions; 2; end

    def initialize(x = 0, y = 0)
      super [x.to_f32, y.to_f32]
    end

    def set(x, y)
      super [x.to_f32, y.to_f32]
    end

    def x; @elements[0]; end
    def y; @elements[1]; end

    def x=(value); @elements[0] = value.to_f32; end
    def y=(value); @elements[1] = value.to_f32; end

    def dot(v)
      x * v.x + y * v.y
    end

    def distance_to_squared(v)
      dx, dy = x - v.x, y - v.y
      dx * dx + dy * dy
    end

    def from_attribute(attribute, index, offset = 0)
      index = index * attribute.item_size + offset
      @elements[0] = attribute.array[index]
      @elements[1] = attribute.array[index + 1]
      self
    end

    def clone
      Vector2.new(x, y)
    end
  end
end
