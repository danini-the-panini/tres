class Minitest::Test
  def x; 2; end
  def y; 3; end
  def z; 4; end
  def w; 5; end

  def negInf2
    @_negInf2 ||= Tres::Vector2.new(-Float32::INFINITY, -Float32::INFINITY)
  end
  def posInf2
    @_posInf2 ||= Tres::Vector2.new(Float32::INFINITY, Float32::INFINITY)
  end

  def zero2
    @_zero2 ||= Tres::Vector2.new
  end
  def one2
    @_one2 ||= Tres::Vector2.new(1, 1)
  end
  def two2
    @_two2 ||= Tres::Vector2.new(2, 2)
  end

  def negInf3
    @_negInf3 ||= Tres::Vector3.new(-Float32::INFINITY, -Float32::INFINITY, -Float32::INFINITY)
  end
  def posInf3
    @_posInf3 ||= Tres::Vector3.new(Float32::INFINITY, Float32::INFINITY, Float32::INFINITY)
  end

  def zero3
    @_zero3 ||= Tres::Vector3.new()
  end
  def one3
    @_one3 ||= Tres::Vector3.new(1, 1, 1)
  end
  def two3
    @_two3 ||= Tres::Vector3.new(2, 2, 2)
  end
end
