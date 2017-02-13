require "../minitest_helper"

class TestVector4 < Minitest::Test

  def test_constructor
    a = Tres::Vector4.new
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)
    assert_equal(1f32, a.w)

    a = Tres::Vector4.new(x, y, z, w)
    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)
    assert_equal(w, a.w)
  end

  def test_copy
    a = Tres::Vector4.new(x, y, z, w)
    b = Tres::Vector4.new.copy(a)
    assert_equal(x, b.x)
    assert_equal(y, b.y)
    assert_equal(z, b.z)
    assert_equal(w, b.w)

    # ensure that it is a true copy
    a.x = 0f32
    a.y = -1f32
    a.z = -2f32
    a.w = -3f32
    assert_equal(x, b.x)
    assert_equal(y, b.y)
    assert_equal(z, b.z)
    assert_equal(w, b.w)
  end

  def test_set
    a = Tres::Vector4.new
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)
    assert_equal(1f32, a.w)

    a.set(x, y, z, w)
    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)
    assert_equal(w, a.w)
  end

  def test_set_x_set_y_set_z_set_w
    a = Tres::Vector4.new
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)
    assert_equal(1f32, a.w)

    a.x = x
    a.y = y
    a.z = z
    a.w = w

    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)
    assert_equal(w, a.w)
  end

  def test_set_component_get_component
    a = Tres::Vector4.new
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)
    assert_equal(1f32, a.w)

    a[0] = 1f32
    a[1] = 2f32
    a[2] = 3f32
    a[3] = 4f32
    assert_equal(1f32, a[0])
    assert_equal(2f32, a[1])
    assert_equal(3f32, a[2])
    assert_equal(4f32, a[3])
  end

  def test_add
    a = Tres::Vector4.new(x, y, z, w)
    b = Tres::Vector4.new(-x, -y, -z, -w)

    a.add(b)
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)
    assert_equal(0f32, a.w)

    c = Tres::Vector4.new.add_vectors(b, b)
    assert_equal(-2f32*x, c.x)
    assert_equal(-2f32*y, c.y)
    assert_equal(-2f32*z, c.z)
    assert_equal(-2f32*w, c.w)
  end

  def test_sub
    a = Tres::Vector4.new(x, y, z, w)
    b = Tres::Vector4.new(-x, -y, -z, -w)

    a.sub(b)
    assert_equal(2f32*x, a.x)
    assert_equal(2f32*y, a.y)
    assert_equal(2f32*z, a.z)
    assert_equal(2f32*w, a.w)

    c = Tres::Vector4.new.sub_vectors(a, a)
    assert_equal(0f32, c.x)
    assert_equal(0f32, c.y)
    assert_equal(0f32, c.z)
    assert_equal(0f32, c.w)
  end

  def test_multiply_divide
    a = Tres::Vector4.new(x, y, z, w)
    b = Tres::Vector4.new(-x, -y, -z, -w)

    a.multiply_scalar(-2f32)
    assert_equal(x*-2f32, a.x)
    assert_equal(y*-2f32, a.y)
    assert_equal(z*-2f32, a.z)
    assert_equal(w*-2f32, a.w)

    b.multiply_scalar(-2f32)
    assert_equal(2f32*x, b.x)
    assert_equal(2f32*y, b.y)
    assert_equal(2f32*z, b.z)
    assert_equal(2f32*w, b.w)

    a.divide_scalar(-2f32)
    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)
    assert_equal(w, a.w)

    b.divide_scalar(-2f32)
    assert_equal(-x, b.x)
    assert_equal(-y, b.y)
    assert_equal(-z, b.z)
    assert_equal(-w, b.w)
  end

  def test_min_max_clamp
    a = Tres::Vector4.new(x, y, z, w)
    b = Tres::Vector4.new(-x, -y, -z, -w)
    c = Tres::Vector4.new

    c.copy(a).min(b)
    assert_equal(-x, c.x)
    assert_equal(-y, c.y)
    assert_equal(-z, c.z)
    assert_equal(-w, c.w)

    c.copy(a).max(b)
    assert_equal(x, c.x)
    assert_equal(y, c.y)
    assert_equal(z, c.z)
    assert_equal(w, c.w)

    c.set(-2f32*x, 2f32*y, -2f32*z, 2f32*w)
    c.clamp(b, a)
    assert_equal(-x, c.x)
    assert_equal(y, c.y)
    assert_equal(-z, c.z)
    assert_equal(w, c.w)
  end

  def test_negate
    a = Tres::Vector4.new(x, y, z, w)

    a.negate
    assert_equal(-x, a.x)
    assert_equal(-y, a.y)
    assert_equal(-z, a.z)
    assert_equal(-w, a.w)
  end

  def test_dot
    a = Tres::Vector4.new(x, y, z, w)
    b = Tres::Vector4.new(-x, -y, -z, -w)
    c = Tres::Vector4.new(0f32, 0f32, 0f32, 0f32)

    result = a.dot(b)
    assert_equal((-x*x-y*y-z*z-w*w), result)

    result = a.dot(c)
    assert_equal(0f32, result)
  end

  def test_length_length_sq
    a = Tres::Vector4.new(x, 0f32, 0f32, 0f32)
    b = Tres::Vector4.new(0f32, -y, 0f32, 0f32)
    c = Tres::Vector4.new(0f32, 0f32, z, 0f32)
    d = Tres::Vector4.new(0f32, 0f32, 0f32, w)
    e = Tres::Vector4.new(0f32, 0f32, 0f32, 0f32)

    assert_equal(x, a.length)
    assert_equal(x*x, a.length_sq)
    assert_equal(y, b.length)
    assert_equal(y*y, b.length_sq)
    assert_equal(z, c.length)
    assert_equal(z*z, c.length_sq)
    assert_equal(w, d.length)
    assert_equal(w*w, d.length_sq)
    assert_equal(0f32, e.length)
    assert_equal(0f32, e.length_sq)

    a.set(x, y, z, w)
    assert_in_delta(Math.sqrt(x*x + y*y + z*z + w*w), a.length)
    assert_in_delta((x*x + y*y + z*z + w*w), a.length_sq)
  end

  def test_normalize
    a = Tres::Vector4.new(x, 0f32, 0f32, 0f32)
    b = Tres::Vector4.new(0f32, -y, 0f32, 0f32)
    c = Tres::Vector4.new(0f32, 0f32, z, 0f32)
    d = Tres::Vector4.new(0f32, 0f32, 0f32, -w)

    a.normalize
    assert_equal(1f32, a.length)
    assert_equal(1f32, a.x)

    b.normalize
    assert_equal(1f32, b.length)
    assert_equal(-1f32, b.y)

    c.normalize
    assert_equal(1f32, c.length)
    assert_equal(1f32, c.z)

    d.normalize
    assert_equal(1f32, d.length)
    assert_equal(-1f32, d.w)
  end

  def test_distance_to_distance_to_squared
  #  a = Tres::Vector4.new(x, 0f32, 0f32, 0f32)
  #  b = Tres::Vector4.new(0f32, -y, 0f32, 0f32)
  #  c = Tres::Vector4.new(0f32, 0f32, z, 0f32)
  #  d = Tres::Vector4.new(0f32, 0f32, 0f32, -w)
  #  e = Tres::Vector4.new
  #
  #  assert_equal(x, a.distance_to(e))
  #  assert_equal(x*x, a.distance_to_squared(e))
  #
  #  assert_equal(y, b.distance_to(e))
  #  assert_equal(y*y, b.distance_to_squared(e))
  #
  #  assert_equal(z, c.distance_to(e))
  #  assert_equal(z*z, c.distance_to_squared(e))
  #
  #  assert_equal(w, d.distance_to(e))
  #  assert_equal(w*w, d.distance_to_squared(e))
  end


  def test_set_length
    a = Tres::Vector4.new(x, 0f32, 0f32, 0f32)

    assert_equal(x, a.length)
    a.set_length(y)
    assert_equal(y, a.length)

    a = Tres::Vector4.new(0f32, 0f32, 0f32, 0f32)
    assert_equal(0f32, a.length)
    a.set_length(y)
    assert_equal(0f32, a.length)
  end

  def test_lerp_clone
    a = Tres::Vector4.new(x, 0f32, z, 0f32)
    b = Tres::Vector4.new(0f32, -y, 0f32, -w)

    assert_equal(a.lerp(a, 0.5f32), a.lerp(a, 0f32))
    assert_equal(a.lerp(a, 1f32), a.lerp(a, 0f32))

    assert_equal(a, a.clone.lerp(b, 0f32))

    assert_equal(x*0.5f32, a.clone.lerp(b, 0.5f32).x)
    assert_equal(-y*0.5f32, a.clone.lerp(b, 0.5f32).y)
    assert_equal(z*0.5f32, a.clone.lerp(b, 0.5f32).z)
    assert_equal(-w*0.5f32, a.clone.lerp(b, 0.5f32).w)

    assert_equal(b, a.clone.lerp(b, 1f32))
  end

  def test_equals
    a = Tres::Vector4.new(x, 0f32, z, 0f32)
    b = Tres::Vector4.new(0f32, -y, 0f32, -w)

    refute_equal(b.x, a.x)
    refute_equal(b.y, a.y)
    refute_equal(b.z, a.z)
    refute_equal(b.w, a.w)

    refute_equal(b, a)
    refute_equal(a, b)

    a.copy(b)
    assert_equal(b.x, a.x)
    assert_equal(b.y, a.y)
    assert_equal(b.z, a.z)
    assert_equal(b.w, a.w)

    assert_equal(b, a)
    assert_equal(a, b)
  end
end
