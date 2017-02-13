require "../minitest_helper"

class TestVector3 < Minitest::Test

  def test_initialize
    a = Tres::Vector3.new
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)

    a = Tres::Vector3.new(x, y, z)
    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)
  end

  def test_copy
    a = Tres::Vector3.new(x, y, z)
    b = Tres::Vector3.new.copy(a)
    assert_equal(x, b.x)
    assert_equal(y, b.y)
    assert_equal(z, b.z)

    # ensure that it is a true copy
    a.x = 0f32
    a.y = -1f32
    a.z = -2f32
    assert_equal(x, b.x)
    assert_equal(y, b.y)
    assert_equal(z, b.z)
  end

  def test_set
    a = Tres::Vector3.new
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)

    a.set(x, y, z)
    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)
  end

  def test_setters
    a = Tres::Vector3.new
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)

    a.x = x
    a.y = y
    a.z = z

    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)
  end

  def test_subscript
    a = Tres::Vector3.new
    assert_equal(0f32, a[0])
    assert_equal(0f32, a[1])
    assert_equal(0f32, a[2])
    assert_raises(IndexError) { a[-1] }
    assert_raises(IndexError) { a[3] }

    a[0] = 1f32
    a[1] = 2f32
    a[2] = 3f32
    assert_raises(IndexError) { a[-1] = 0f32}
    assert_raises(IndexError) { a[3] = 4f32}

    assert_equal(1f32, a[0])
    assert_equal(2f32, a[1])
    assert_equal(3f32, a[2])
    assert_raises(IndexError) { a[-1]}
    assert_raises(IndexError) { a[3]}
  end

  def test_add
    a = Tres::Vector3.new(x, y, z)
    b = Tres::Vector3.new(-x, -y, -z)

    a.add(b)
    assert_equal(0f32, a.x)
    assert_equal(0f32, a.y)
    assert_equal(0f32, a.z)

    c = Tres::Vector3.new.add_vectors(b, b)
    assert_equal(-2f32*x, c.x)
    assert_equal(-2f32*y, c.y)
    assert_equal(-2f32*z, c.z)
  end

  def test_sub
    a = Tres::Vector3.new(x, y, z)
    b = Tres::Vector3.new(-x, -y, -z)

    a.sub(b)
    assert_equal(2f32*x, a.x)
    assert_equal(2f32*y, a.y)
    assert_equal(2f32*z, a.z)

    c = Tres::Vector3.new.sub_vectors(a, a)
    assert_equal(0f32, c.x)
    assert_equal(0f32, c.y)
    assert_equal(0f32, c.z)
  end

  def test_multiply_divide
    a = Tres::Vector3.new(x, y, z)
    b = Tres::Vector3.new(-x, -y, -z)

    a.multiply_scalar(-2f32)
    assert_equal(x*-2f32, a.x)
    assert_equal(y*-2f32, a.y)
    assert_equal(z*-2f32, a.z)

    b.multiply_scalar(-2f32)
    assert_equal(2f32*x, b.x)
    assert_equal(2f32*y, b.y)
    assert_equal(2f32*z, b.z)

    a.divide_scalar(-2f32)
    assert_equal(x, a.x)
    assert_equal(y, a.y)
    assert_equal(z, a.z)

    b.divide_scalar(-2f32)
    assert_equal(-x, b.x)
    assert_equal(-y, b.y)
    assert_equal(-z, b.z)
  end

  def test_min_max_clamp
    a = Tres::Vector3.new(x, y, z)
    b = Tres::Vector3.new(-x, -y, -z)
    c = Tres::Vector3.new

    c.copy(a).min(b)
    assert_equal(-x, c.x)
    assert_equal(-y, c.y)
    assert_equal(-z, c.z)

    c.copy(a).max(b)
    assert_equal(x, c.x)
    assert_equal(y, c.y)
    assert_equal(z, c.z)

    c.set(-2f32*x, 2f32*y, -2f32*z)
    c.clamp(b, a)
    assert_equal(-x, c.x)
    assert_equal(y, c.y)
    assert_equal(-z, c.z)
  end

  def test_negate
    a = Tres::Vector3.new(x, y, z)

    a.negate
    assert_equal(-x, a.x)
    assert_equal(-y, a.y)
    assert_equal(-z, a.z)
  end

  def test_dot
    a = Tres::Vector3.new(x, y, z)
    b = Tres::Vector3.new(-x, -y, -z)
    c = Tres::Vector3.new

    result = a.dot(b)
    assert_equal((-x*x-y*y-z*z), result)

    result = a.dot(c)
    assert_equal(0f32, result)
  end

  def test_length_length_sq
    a = Tres::Vector3.new(x, 0f32, 0f32)
    b = Tres::Vector3.new(0f32, -y, 0f32)
    c = Tres::Vector3.new(0f32, 0f32, z)
    d = Tres::Vector3.new

    assert_equal(x, a.length)
    assert_equal(x*x, a.length_sq)
    assert_equal(y, b.length)
    assert_equal(y*y, b.length_sq)
    assert_equal(z, c.length)
    assert_equal(z*z, c.length_sq)
    assert_equal(0f32, d.length)
    assert_equal(0f32, d.length_sq)

    a.set(x, y, z)
    assert_in_delta(Math.sqrt(x*x + y*y + z*z), a.length)
    assert_in_delta((x*x + y*y + z*z), a.length_sq)
  end

  def test_normalize
    a = Tres::Vector3.new(x, 0f32, 0f32)
    b = Tres::Vector3.new(0f32, -y, 0f32)
    c = Tres::Vector3.new(0f32, 0f32, z)

    a.normalize
    assert_in_delta(1f32, a.length)
    assert_in_delta(1f32, a.x)

    b.normalize
    assert_in_delta(1f32, b.length)
    assert_in_delta(-1f32, b.y)

    c.normalize
    assert_in_delta(1f32, c.length)
    assert_in_delta(1f32, c.z)
  end

  def test_distance_to_distance_to_squared
    a = Tres::Vector3.new(x, 0f32, 0f32)
    b = Tres::Vector3.new(0f32, -y, 0f32)
    c = Tres::Vector3.new(0f32, 0f32, z)
    d = Tres::Vector3.new

    assert_equal(x, a.distance_to(d))
    assert_equal(x*x, a.distance_to_squared(d))

    assert_equal(y, b.distance_to(d))
    assert_equal(y*y, b.distance_to_squared(d))

    assert_equal(z, c.distance_to(d))
    assert_equal(z*z, c.distance_to_squared(d))
  end

  def test_set_length
    a = Tres::Vector3.new(x, 0f32, 0f32)

    assert_in_delta(x, a.length)
    a.set_length(y)
    assert_in_delta(y, a.length)

    a = Tres::Vector3.new(0f32, 0f32, 0f32)
    assert_equal(0f32, a.length)
    a.set_length(y)
    assert_equal(0f32, a.length)

  end

  def test_project_on_vector
    a = Tres::Vector3.new(1f32, 0f32, 0f32)
    b = Tres::Vector3.new
    normal = Tres::Vector3.new(10f32, 0f32, 0f32)

    assert_equal(Tres::Vector3.new(1f32, 0f32, 0f32), b.copy(a).project_on_vector(normal))

    a.set(0f32, 1f32, 0f32)
    assert_equal(Tres::Vector3.new(0f32, 0f32, 0f32), b.copy(a).project_on_vector(normal))

    a.set(0f32, 0f32, -1f32)
    assert_equal(Tres::Vector3.new(0f32, 0f32, 0f32), b.copy(a).project_on_vector(normal))

    a.set(-1f32, 0f32, 0f32)
    assert_equal(Tres::Vector3.new(-1f32, 0f32, 0f32), b.copy(a).project_on_vector(normal))
  end

  def test_project_on_plane
    a = Tres::Vector3.new(1f32, 0f32, 0f32)
    b = Tres::Vector3.new
    normal = Tres::Vector3.new(1f32, 0f32, 0f32)

    assert_equal(Tres::Vector3.new(0f32, 0f32, 0f32), b.copy(a).project_on_plane(normal))

    a.set(0f32, 1f32, 0f32)
    assert_equal(Tres::Vector3.new(0f32, 1f32, 0f32), b.copy(a).project_on_plane(normal))

    a.set(0f32, 0f32, -1f32)
    assert_equal(Tres::Vector3.new(0f32, 0f32, -1f32), b.copy(a).project_on_plane(normal))

    a.set(-1f32, 0f32, 0f32)
    assert_equal(Tres::Vector3.new(0f32, 0f32, 0f32), b.copy(a).project_on_plane(normal))

  end

  def test_reflect
    a = Tres::Vector3.new
    normal = Tres::Vector3.new(0f32, 1f32, 0f32)
    b = Tres::Vector3.new

    a.set(0f32, -1f32, 0f32)
    assert_equal(Tres::Vector3.new(0f32, 1f32, 0f32), b.copy(a).reflect(normal))

    a.set(1f32, -1f32, 0f32)
    assert_equal(Tres::Vector3.new(1f32, 1f32, 0f32), b.copy(a).reflect(normal))

    a.set(1f32, -1f32, 0f32)
    normal.set(0f32, -1f32, 0f32)
    assert_equal(Tres::Vector3.new(1f32, 1f32, 0f32), b.copy(a).reflect(normal))
  end

  def test_angle_to
    a = Tres::Vector3.new(0f32, -0.18851655680720186f32, 0.9820700116639124f32)
    b = Tres::Vector3.new(0f32, 0.18851655680720186f32, -0.9820700116639124f32)

    assert_in_delta(a.angle_to(a), 0f32)
    assert_in_delta(a.angle_to(b), Math::PI)

    x = Tres::Vector3.new(1f32, 0f32, 0f32)
    y = Tres::Vector3.new(0f32, 1f32, 0f32)
    z = Tres::Vector3.new(0f32, 0f32, 1f32)

    assert_in_delta(x.angle_to(y), Math::PI / 2f32)
    assert_in_delta(x.angle_to(z), Math::PI / 2f32)
    assert_in_delta(z.angle_to(x), Math::PI / 2f32)

    assert_in_delta(Math::PI / 4f32, x.angle_to(Tres::Vector3.new(1f32, 1f32, 0f32)))
  end

  def test_lerp_clone
    a = Tres::Vector3.new(x, 0f32, z)
    b = Tres::Vector3.new(0f32, -y, 0f32)

    assert_equal(a.lerp(a, 0.5f32), a.lerp(a, 0f32))
    assert_equal(a.lerp(a, 1f32), a.lerp(a, 0f32))

    assert_equal(a, a.clone.lerp(b, 0f32))

    assert_equal(x*0.5f32, a.clone.lerp(b, 0.5f32).x)
    assert_equal(-y*0.5f32, a.clone.lerp(b, 0.5f32).y)
    assert_equal(z*0.5f32, a.clone.lerp(b, 0.5f32).z)

    assert_equal(b, a.clone.lerp(b, 1f32))
  end

  def test_equals
    a = Tres::Vector3.new(x, 0f32, z)
    b = Tres::Vector3.new(0f32, -y, 0f32)

    refute_equal(b.x, a.x)
    refute_equal(b.y, a.y)
    refute_equal(b.z, a.z)

    refute_equal(b, a)
    refute_equal(a, b)

    a.copy(b)
    assert_equal(b.x, a.x)
    assert_equal(b.y, a.y)
    assert_equal(b.z, a.z)

    assert_equal(b, a)
    assert_equal(a, b)
  end
end
