module Tres
  class Triangle
    property :a, :b, :c

    def initialize(a = Tres::Vector3.new, b = Tres::Vector3.new, c = Tres::Vector3.new)
      @a, @b, @c = a, b, c
    end

    def set(a, b, c)
      @a.copy(a)
      @b.copy(b)
      @c.copy(c)
      self
    end

    def set_from_points_and_indices(points, i0, i1, i2)
      @a.copy(points[i0])
      @b.copy(points[i1])
      @c.copy(points[i2])
      self
    end

    def copy(triangle)
      @a.copy(triangle.a)
      @b.copy(triangle.b)
      @c.copy(triangle.c)
      self
    end

    def area
      v0 = Tres::Vector3.new
      v1 = Tres::Vector3.new
      v0.sub_vectors(@c, @b)
      v1.sub_vectors(@a, @b)
      v0.cross(v1).length * 0.5
    end

    def midpoint(target = Tres::Vector3.new)
      target.add_vectors(@a, @b).add(@c).multiply_scalar(1.0 / 3.0)
    end

    def normal(target = Tres::Vector3.new)
      Tres::Triangle.normal(@a, @b, @c, target)
    end

    def plane(target = Tres::Plane.new)
      target.set_from_coplanar_points(@a, @b, @c)
    end

    def barycoord_from_point(point, target = Tres::Vector3.new)
      Tres::Triangle.barycoord_from_point(point, @a, @b, @c, target)
    end

    def contains_point?(point)
      Tres::Triangle.contains_point?(point, @a, @b, @c)
    end

    def equals(triangle)
      triangle.a.equals(@a) && triangle.b.equals(@b) && triangle.c.equals(@c)
    end

    def clone
      Tres::Triangle.new.copy(self)
    end

    def self.normal(a, b, c, target = Tres::Vector3.new)
      v0 = Tres::Vector3.new
      target.sub_vectors(c, b)
      v0.sub_vectors(a, b)
      target.cross(v0)

      result_length_sq = target.length_sq
      if (result_length_sq > 0)
        target.multiply_scalar(1.0 / Math.sqrt(result_length_sq))
      else
        target.set(0.0, 0.0, 0.0)
      end
    end

    # static/instance method to calculate barycoordinates
    # based on: http://www.blackpawn.com/texts/pointinpoly/default.html
    def self.barycoord_from_point(point, a, b, c, target = Tres::Vector3.new)
      v0 = Tres::Vector3.new
      v1 = Tres::Vector3.new
      v2 = Tres::Vector3.new

      v0.sub_vectors(c, a)
      v1.sub_vectors(b, a)
      v2.sub_vectors(point, a)

      dot00 = v0.dot(v0)
      dot01 = v0.dot(v1)
      dot02 = v0.dot(v2)
      dot11 = v1.dot(v1)
      dot12 = v1.dot(v2)

      denom = dot00 * dot11 - dot01 * dot01

      # colinear or singular triangle
      if denom == 0
        # arbitrary location outside of triangle?
        # not sure if this is the best idea, maybe should be returning undefined
        return target.set(-2.0, -1.0, -1.0)
      end

      inv_denom = 1.0 / denom
      u = (dot11 * dot02 - dot01 * dot12) * inv_denom
      v = (dot00 * dot12 - dot01 * dot02) * inv_denom

      target.set(1.0 - u - v, v, u)
    end

    def self.contains_point?(point, a, b, c)
      v1 = Tres::Vector3.new
      result = Tres::Triangle.barycoord_from_point(point, a, b, c, v1)
      result.x >= 0 && result.y >= 0 && result.x + result.y <= 1
    end
  end
end
