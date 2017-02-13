module Tres
  class Line3
    property :start_point, :end_point

    def initialize(start_point = Tres::Vector3.new, end_point = Tres::Vector3.new)
      @start_point, @end_point = start_point, end_point
    end

    def set(start_point, end_point)
      @start_point.copy(start_point)
      @end_point.copy(end_point)
      self
    end

    def copy(line)
      @start_point.copy(line.start_point)
      @end_point.copy(line.end_point)
      self
    end

    def center(target = Tres::Vector3.new)
      target.add_vectors(@start_point, @end_point).multiply_scalar(0.5)
    end

    def delta(target = Tres::Vector3.new)
      target.sub_vectors(@end_point, @start_point)
    end

    def distance_sq
      @start_point.distance_to_squared(@end_point)
    end

    def distance
      @start_point.distance_to(@end_point)
    end

    def at(t, target = Tres::Vector3.new)
      self.delta(target).multiply_scalar(t).add(self.start_point)
    end

    def closest_point_to_point_parameter(point, clamp_to_line)
      start_p = Tres::Vector3.new
      start_end = Tres::Vector3.new
      start_p.sub_vectors(point, @start_point)
      start_end.sub_vectors(@end_point, @start_point)
      start_end2 = start_end.dot(start_end)
      start_end_start_p = start_end.dot(start_p)
      t = start_end_start_p / start_end2
      if clamp_to_line
        t = ExtraMath.clamp(t, 0.0f32, 1.0f32)
      end
      t
    end

    def closest_point_to_point(point, clamp_to_line, target = Tres::Vector3.new)
      t = self.closest_point_to_point_parameter(point, clamp_to_line)
      self.delta(target).multiply_scalar(t).add(self.start_point)
    end

    def apply_matrix4(matrix)
      @start_point.apply_matrix4(matrix)
      @end_point.apply_matrix4(matrix)
      self
    end

    def equals(line)
      line.start_point.equals(@start_point) && line.end_point.equals(@end_point)
    end

    def clone
      Tres::Line3.new.copy(self)
    end
  end
end
