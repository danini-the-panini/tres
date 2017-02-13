require "./vector3"

module Tres
  class Color < Vector3
    def self.elements; { r: 0, g: 1, b: 2 }; end
    def self.dimensions; 3; end

    def initialize()
      @elements = [1.0f32, 1.0f32, 1.0f32]
    end

    def initialize(color : Color)
      @elements = [color.r, color.g, color.b]
    end

    def initialize(hex : Int)
      @elements = [0.0f32, 0.0f32, 0.0f32]
      set_hex(hex)
    end

    def initialize(style : String)
      @elements = [0.0f32, 0.0f32, 0.0f32]
      set_style(style)
    end

    def initialize(red, green, blue)
      @elements = [red.to_f32, green.to_f32, blue.to_f32]
    end

    def r; x; end
    def g; y; end
    def b; z; end

    def r=(v); self.x=v; end
    def g=(v); self.y=v; end
    def b=(v); self.z=v; end

    def set(value : Color)
      copy(value)
      self
    end

    def set(value : Int)
      set_hex(value)
      self
    end

    def set(value : String)
      set_style(value)
      self
    end

    def set_hex(hex)
      hex = hex.floor
      self.r = (hex >> 16 & 255) / 255.0
      self.g = (hex >> 8 & 255) / 255.0
      self.b = (hex & 255) / 255.0
      self
    end

    def set_rgb(r, g, b)
      @elements = [r.to_f32, g.to_f32, b.to_f32]
      self
    end

    def set_hsl(h, s, l)
      # h,s,l ranges are in 0.0 - 1.0
      if s == 0
        self.r = self.g = self.b = l
      else
        p = l <= 0.5 ? l * (1.0 + s) : l + s - (l * s)
        q = (2.0 * l) - p
        self.r = hue2rgb(q, p, h + 1.0 / 3.0)
        self.g = hue2rgb(q, p, h)
        self.b = hue2rgb(q, p, h - 1.0 / 3.0)
      end
      self
    end

    def set_style(style)
      # rgb(255,0,0)
      if /^rgb\((\d+), ?(\d+), ?(\d+)\)$/i =~ style
        self.r = [255.0, $1.to_f32].min / 255.0
        self.g = [255.0, $2.to_f32].min / 255.0
        self.b = [255.0, $3.to_f32].min / 255.0
        return self
      end
      # rgb(100%,0%,0%)
      if /^rgb\((\d+)\%, ?(\d+)\%, ?(\d+)\%\)$/i =~ style
        self.r = [100.0, $1.to_f32].min / 100.0
        self.g = [100.0, $2.to_f32].min / 100.0
        self.b = [100.0, $3.to_f32].min / 100.0
        return self
      end
      # #ff0000
      if /^\#([0-9a-f]{6})$/i =~ style
        self.set_hex($1.to_i(16))
        return self
      end
      # #f00
      if /^\#([0-9a-f])([0-9a-f])([0-9a-f])$/i =~ style
        self.set_hex(($1 + $1 + $2 + $2 + $3 + $3).to_i(16))
        return self
      end
      # red
      if /^(\w+)$/i =~ style
        self.set_hex(Tres::ColorKeywords[style])
        return self
      end
    end

    def copy_gamma_to_linear(color, gamma_factor = 2.0f32)
      self.r = color.r ** gamma_factor
      self.g = color.g ** gamma_factor
      self.b = color.b ** gamma_factor
      self
    end

    def copy_linear_to_gamma(color, gamma_factor = 2.0f32)
      safe_inverse = (gamma_factor > 0) ? (1.0f32 / gamma_factor) : 1.0f32
      self.r = color.r ** safe_inverse
      self.g = color.g ** safe_inverse
      self.b = color.b ** safe_inverse
      self
    end

    def convert_gamma_to_linear
      rr, gg, bb = self.r, self.g, self.b
      self.r = rr * rr
      self.g = gg * gg
      self.b = bb * bb
      self
    end

    def convert_linear_to_gamma
      self.r = Math.sqrt(self.r)
      self.g = Math.sqrt(self.g)
      self.b = Math.sqrt(self.b)
      self
    end

    def hex
      (self.r * 255).to_i << 16 ^ (self.g * 255).to_i << 8 ^ (self.b * 255).to_i << 0
    end

    def hex_string
      ("000000" + self.hex.to_s(16))[-6..-1]
    end

    # h,s,l ranges are in 0.0 - 1.0
    def hsl
      max = [r, g, b].max
      min = [r, g, b].min
      hue, saturation = 0.0, 0.0
      lightness = (min + max) / 2.0
      if min != max
        delta = max - min
        saturation = lightness <= 0.5 ? delta / (max + min) : delta / (2.0 - max - min)
        case max
        when r then hue = (g - b) / delta + (g < b ? 6.0 : 0.0)
        when g then hue = (b - r) / delta + 2.0
        when b then hue = (r - g) / delta + 4.0
        end
        hue /= 6.0
      end
      {h: hue, s: saturation, l: lightness}
    end

    def style
      "rgb(#{ (self.r * 255).to_i },#{ (self.g * 255).to_i },#{ (self.b * 255).to_i })"
    end

    def offset_hsl(h, s, l)
      hsl = self.hsl
      hsl[:h] += h
      hsl[:s] += s
      hsl[:l] += l
      self.set_hsl(hsl[:h], hsl[:s], hsl[:l])
      self
    end

    def add_colors(a, b)
      add_vectors(a, b)
    end

    def clone
      Color.new(r, g, b)
    end

    private def hue2rgb(p, q, t)
      t += 1.0 if t < 0.0
      t -= 1.0 if t > 1.0
      return p + (q - p) * 6.0 * t if t < 1.0 / 6.0
      return q if t < 1.0 / 2.0
      return p + (q - p) * 6.0 * (2.0 / 3.0 - t) if t < 2.0 / 3.0
      p
    end
  end
end
