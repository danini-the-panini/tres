module Tres
  module ExtraMath
    def self.sign(x : Number)
      return Float32::NAN if x.to_f32.nan?
      return x.to_f if x == 0
      return (x < 0) ? -1.0 : (x > 0) ? 1.0 : +x
    end

    def self.clamp(x, a, b)
      ( x < a ) ? a : ( ( x > b ) ? b : x )
    end

    def self.clamp_bottom(x, a)
      x < a ? a : x
    end

    def self.map_linear(x, a1, a2, b1, b2)
      b1 + ( x - a1 ) * ( b2 - b1 ) / ( a2 - a1 )
    end

    def self.smooth_step(x, min, max)
  		return 0.0 if x <= min
  		return 1.0 if x >= max

  		x = ( x - min ) / ( max - min )

  	   x * x * ( 3.0 - 2.0 * x )
    end

    def self.smoother_step(x, min, max)
  		return 0.0 if x <= min
  		return 1.0 if x >= max

  		x = ( x - min ) / ( max - min )

  		x * x * x * ( x * ( x * 6.0 - 15.0 ) + 10.0 )
    end

    def self.random16
      ( 65280 * rand + 255 * rand ) / 65535
    end

    def self.rand_int(low, high)
      self.rand_float( low, high ).floor.to_i32
    end

    def self.rand_float(low, high)
      low + rand.to_f32 * ( high - low )
    end

    def self.rand_float_spread(range)
      range * (0.5 - rand.to_f32)
    end

    DEGREE_TO_RADIANS_FACTOR = ::Math::PI / 180
    def self.deg_to_rad(degrees)
      degrees * DEGREE_TO_RADIANS_FACTOR
    end

    RADIANS_TO_DEGREES_FACTOR = 180 / ::Math::PI
    def self.rad_to_deg(radians)
      radians * RADIANS_TO_DEGREES_FACTOR
    end

    def self.power_of_two?(value)
      ( value & ( value - 1 ) ) == 0 && value != 0
    end

    def self.next_power_of_two(value)
  		value -= 1
  		value |= value >> 1
  		value |= value >> 2
  		value |= value >> 4
  		value |= value >> 8
  		value |= value >> 16
  		value += 1
    end
  end
end
