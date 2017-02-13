require "../minitest_helper"

class TestVector2 < Minitest::Test

  def test_initialize
    a = Tres::Vector2.new(1.5f32, 2.3f32)
    assert_equal 1.5f32, a.x
    assert_equal 2.3f32, a.y

    a = Tres::Vector2.new(1.5f32)
    assert_equal 1.5f32, a.x
    assert_equal 0f32, a.y

    a = Tres::Vector2.new
    assert_equal 0f32, a.x
    assert_equal 0f32, a.y
  end

  def test_set
    a = Tres::Vector2.new

    result = a.set(1.5f32, 2.3f32)
    assert_equal 1.5f32, a.x
    assert_equal 2.3f32, a.y

    assert_equal a, result
  end

  def test_set_x
    a = Tres::Vector2.new

    a.x = 4.2f32
    assert_equal 4.2f32, a.x
    assert_equal 0f32, a.y
  end

  def test_set_y
    a = Tres::Vector2.new

    a.y = 4.2f32
    assert_equal 0f32, a.x
    assert_equal 4.2f32, a.y
  end

  def test_set_component
    a = Tres::Vector2.new

    a[0] = 4.2f32
    assert_equal 4.2f32, a.x
    assert_equal 0f32, a.y

    a[1] = 2.1f32
    assert_equal 4.2f32, a.x
    assert_equal 2.1f32, a.y

    assert_raises(IndexError) { a[-1] = 1.0f32 }
    assert_raises(IndexError) { a[2] = 1.0f32 }
  end

  def test_get_component
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    assert_equal 1.5f32, a[0]
    assert_equal 2.3f32, a[1]

    assert_raises(IndexError) { a[-1] }
    assert_raises(IndexError) { a[2] }
  end

  def test_copy
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.copy(Tres::Vector2.new(3.4f32, 1.2f32))

    assert_equal 3.4f32, a.x
    assert_equal 1.2f32, a.y

    assert_equal a, result
  end

  def test_add
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.add(Tres::Vector2.new(3.4f32, 1.2f32))

    assert_equal 1.5f32 + 3.4f32, a.x
    assert_equal 2.3f32 + 1.2f32, a.y

    assert_equal a, result
  end

  def test_add_scalar
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.add_scalar(4.1f32)

    assert_equal 1.5f32 + 4.1f32, a.x
    assert_equal 2.3f32 + 4.1f32, a.y

    assert_equal a, result
  end

  def test_add_vectors
    a = Tres::Vector2.new

    result = a.add_vectors(Tres::Vector2.new(1.5f32, 2.3f32), Tres::Vector2.new(3.4f32, 1.2f32))

    assert_equal 1.5f32 + 3.4f32, a.x
    assert_equal 2.3f32 + 1.2f32, a.y

    assert_equal a, result
  end

  def test_sub
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.sub(Tres::Vector2.new(3.4f32, 1.2f32))

    assert_equal 1.5f32 - 3.4f32, a.x
    assert_equal 2.3f32 - 1.2f32, a.y

    assert_equal a, result
  end

  def test_sub_scalar
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.sub_scalar(4.1f32)

    assert_equal 1.5f32 - 4.1f32, a.x
    assert_equal 2.3f32 - 4.1f32, a.y

    assert_equal a, result
  end

  def test_sub_vectors
    a = Tres::Vector2.new

    result = a.sub_vectors(Tres::Vector2.new(1.5f32, 2.3f32), Tres::Vector2.new(3.4f32, 1.2f32))

    assert_equal 1.5f32 - 3.4f32, a.x
    assert_equal 2.3f32 - 1.2f32, a.y

    assert_equal a, result
  end

  def test_multiply
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.multiply(Tres::Vector2.new(3.4f32, 1.2f32))

    assert_equal 1.5f32 * 3.4f32, a.x
    assert_equal 2.3f32 * 1.2f32, a.y

    assert_equal a, result
  end

  def test_multiply_scalar
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.multiply_scalar(4.1f32)

    assert_equal 1.5f32 * 4.1f32, a.x
    assert_equal 2.3f32 * 4.1f32, a.y

    assert_equal a, result
  end

  def test_divide
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.divide(Tres::Vector2.new(3.4f32, 1.2f32))

    assert_equal 1.5f32 / 3.4f32, a.x
    assert_equal 2.3f32 / 1.2f32, a.y

    assert_equal a, result
  end

  def test_divide_scalar
    a = Tres::Vector2.new(1.5f32, 2.3f32)

    result = a.divide_scalar(4.1f32)

    assert_in_delta 1.5f32 / 4.1f32, a.x
    assert_in_delta 2.3f32 / 4.1f32, a.y

    assert_equal a, result
  end

  def test_min
    a = Tres::Vector2.new(1.5f32, 2.3f32)
    result = a.min(Tres::Vector2.new(0.3f32, 0.5f32))
    assert_equal 0.3f32, a.x
    assert_equal 0.5f32, a.y
    assert_equal a, result

    a = Tres::Vector2.new(1.5f32, 2.3f32)
    a.min(Tres::Vector2.new(0.3f32, 3.5f32))
    assert_equal 0.3f32, a.x
    assert_equal 2.3f32, a.y

    a = Tres::Vector2.new(1.5f32, 2.3f32)
    a.min(Tres::Vector2.new(2.3f32, 0.5f32))
    assert_equal 1.5f32, a.x
    assert_equal 0.5f32, a.y

    a = Tres::Vector2.new(1.5f32, 2.3f32)
    a.min(Tres::Vector2.new(2.3f32, 3.5f32))
    assert_equal 1.5f32, a.x
    assert_equal 2.3f32, a.y
  end

  def test_max
    a = Tres::Vector2.new(1.5f32, 2.3f32)
    result = a.max(Tres::Vector2.new(0.3f32, 0.5f32))
    assert_equal 1.5f32, a.x
    assert_equal 2.3f32, a.y
    assert_equal a, result

    a = Tres::Vector2.new(1.5f32, 2.3f32)
    a.max(Tres::Vector2.new(0.3f32, 3.5f32))
    assert_equal 1.5f32, a.x
    assert_equal 3.5f32, a.y

    a = Tres::Vector2.new(1.5f32, 2.3f32)
    a.max(Tres::Vector2.new(2.3f32, 0.5f32))
    assert_equal 2.3f32, a.x
    assert_equal 2.3f32, a.y

    a = Tres::Vector2.new(1.5f32, 2.3f32)
    a.max(Tres::Vector2.new(2.3f32, 3.5f32))
    assert_equal 2.3f32, a.x
    assert_equal 3.5f32, a.y
  end

  def test_clamp
    a = Tres::Vector2.new(1.5f32, -3.4f32)
    result = a.clamp(Tres::Vector2.new(0.0f32, -1.0f32), Tres::Vector2.new(1.0f32, 1.0f32))
    assert_equal(1.0f32, a.x)
    assert_equal(-1.0f32, a.y)
    assert_equal a, result

    a = Tres::Vector2.new(0.5f32, -0.3f32)
    a.clamp(Tres::Vector2.new(0.0f32, -1.0f32), Tres::Vector2.new(1.0f32, 1.0f32))
    assert_equal(0.5f32, a.x)
    assert_equal(-0.3f32, a.y)

    a = Tres::Vector2.new(-1.2f32, 1.7f32)
    a.clamp(Tres::Vector2.new(0.0f32, -1.0f32), Tres::Vector2.new(1.0f32, 1.0f32))
    assert_equal(0.0f32, a.x)
    assert_equal(1.0f32, a.y)
  end

  def test_clamp_scalar
    a = Tres::Vector2.new(1.5f32, -3.4f32)
    result = a.clamp_scalar(0.0f32, 1.0f32)
    assert_equal 1.0f32, a.x
    assert_equal 0.0f32, a.y
    assert_equal a, result

    a = Tres::Vector2.new(0.5f32, 0.3f32)
    a.clamp_scalar(0.0f32, 1.0f32)
    assert_equal 0.5f32, a.x
    assert_equal 0.3f32, a.y
  end

  def test_floor
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    result = a.floor
    assert_equal(1f32, a.x)
    assert_equal(-4f32, a.y)
    assert_equal a, result

    a = Tres::Vector2.new(1.5f32, -3.5f32)
    a.floor
    assert_equal(1f32, a.x)
    assert_equal(-4f32, a.y)
  end

  def test_ceil
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    result = a.ceil
    assert_equal(2f32, a.x)
    assert_equal(-3f32, a.y)
    assert_equal a, result

    a = Tres::Vector2.new(1.5f32, -3.5f32)
    a.ceil
    assert_equal(2f32, a.x)
    assert_equal(-3f32, a.y)
  end

  def test_round
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    result = a.round
    assert_equal(1f32, a.x)
    assert_equal(-3f32, a.y)
    assert_equal a, result

    a = Tres::Vector2.new(1.5f32, -3.5f32)
    a.round
    assert_equal(2f32, a.x)
    assert_equal(-4f32, a.y)
  end

  def test_round_to_zero
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    result = a.round_to_zero
    assert_equal(1f32, a.x)
    assert_equal(-3f32, a.y)
    assert_equal a, result

    a = Tres::Vector2.new(1.5f32, -3.5f32)
    a.round_to_zero
    assert_equal(1f32, a.x)
    assert_equal(-3f32, a.y)
  end

  def test_negate
    a = Tres::Vector2.new(1.4f32, -3.4f32)

    result = a.negate

    assert_equal(-1.4f32, a.x)
    assert_equal(3.4f32, a.y)

    assert_equal a, result
  end

  def test_dot
    a = Tres::Vector2.new(1.4f32, -3.4f32)

    d = a.dot(Tres::Vector2.new(-2.3f32, 4.2f32))

    assert_in_delta(-17.5f32, d)
  end

  def test_length_sq
    a = Tres::Vector2.new(1.4f32, -3.4f32)

    assert_in_delta(13.52f32, a.length_sq)
  end

  def test_length
    a = Tres::Vector2.new(1.4f32, -3.4f32)

    assert_in_delta(3.676955262170047f32, a.length)
  end

  def test_normalize
    a = Tres::Vector2.new(1.4f32, -3.4f32)

    result = a.normalize

    assert_in_delta(0.38074980525429f32, a.x)
    assert_in_delta(-0.92467809847472f32, a.y)

    assert_equal(a, result)
  end

  def test_distance_to
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    b = Tres::Vector2.new(3.7f32, 4.2f32)

    assert_in_delta(7.940403012442126f32, a.distance_to(b))
  end

  def test_distance_to_squared
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    b = Tres::Vector2.new(3.7f32, 4.2f32)

    assert_in_delta(63.05f32, a.distance_to_squared(b))
  end

  def test_set_length
    a = Tres::Vector2.new(1.4f32, -3.4f32)

    result = a.set_length 2.3f32

    assert_in_delta(0.87572455208487f32, a.x)
    assert_in_delta(-2.12675962649186f32, a.y)
    assert_equal(result, a)
  end

  def test_lerp
    alphas = [-0.1f32, 0f32, 0.1f32, 0.2f32, 0.3f32, 0.4f32, 0.5f32, 0.6f32, 0.7f32, 0.8f32, 0.9f32, 1f32, 1.1f32]
    expected = [[1.17f32, -4.16f32], [1.4f32, -3.4f32], [1.63f32, -2.64f32], [1.86f32, -1.88f32], [2.09f32, -1.12f32], [2.32f32, -0.36f32],
      [2.55f32, 0.4f32], [2.78f32, 1.16f32], [3.01f32, 1.92f32], [3.24f32, 2.68f32], [3.47f32, 3.44f32], [3.7f32, 4.2f32], [3.93f32, 4.96f32]]
    alphas.zip(expected).each do |alpha, (exx, exy)|
      a = Tres::Vector2.new(1.4f32, -3.4f32)
      b = Tres::Vector2.new(3.7f32, 4.2f32)

      result = a.lerp(b, alpha)

      assert_in_delta(exx, a.x)
      assert_in_delta(exy, a.y)
      assert_equal a, result
    end
  end

  def test_lerp_vectors
    alphas = [-0.1f32, 0f32, 0.1f32, 0.2f32, 0.3f32, 0.4f32, 0.5f32, 0.6f32, 0.7f32, 0.8f32, 0.9f32, 1f32, 1.1f32]
    expected = [[1.17f32, -4.16f32], [1.4f32, -3.4f32], [1.63f32, -2.64f32], [1.86f32, -1.88f32], [2.09f32, -1.12f32], [2.32f32, -0.36f32],
      [2.55f32, 0.4f32], [2.78f32, 1.16f32], [3.01f32, 1.92f32], [3.24f32, 2.68f32], [3.47f32, 3.44f32], [3.7f32, 4.2f32], [3.93f32, 4.96f32]]
    alphas.zip(expected).each do |alpha, (exx, exy)|
      a = Tres::Vector2.new(1.4f32, -3.4f32)
      b = Tres::Vector2.new(3.7f32, 4.2f32)
      c = Tres::Vector2.new

      result = c.lerp_vectors(a, b, alpha)

      assert_in_delta(exx, c.x)
      assert_in_delta(exy, c.y)
      assert_equal c, result
    end
  end

  def test_equality
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    a2 = Tres::Vector2.new(1.4f32, -3.4f32)
    b = Tres::Vector2.new(3.7f32, 4.2f32)

    assert_equal a, a2
    refute_equal a, b
  end

  def test_from_array
    a = Tres::Vector2.new

    result = a.from_array([1.2f32, 2.4f32])

    assert_equal 1.2f32, a.x
    assert_equal 2.4f32, a.y
    assert_equal a, result

    a.from_array([1.2f32, 2.4f32, 4.8f32, 8.16f32, 16.32f32], 2)

    assert_equal 4.8f32, a.x
    assert_equal 8.16f32, a.y
  end

  def test_to_array
    a = Tres::Vector2.new(1.4f32, -3.4f32)
    assert_equal [1.4f32, -3.4f32], a.to_array

    ary = [0f32,0f32]
    a.to_array(ary)
    assert_equal [1.4f32, -3.4f32], ary

    ary = [0f32,0f32,0f32,0f32,0f32]
    a.to_array(ary, 2)
    assert_equal [0f32, 0f32, 1.4f32, -3.4f32, 0f32], ary

    assert_equal [1.4f32, -3.4f32], a.to_a
  end

  # def test_from_attribute
  #   a = Tres::Vector2.new
  #   att = Tres::BufferAttribute.new([1.0, 2.0, 4.0, 8.0, 16.0], 2)
  #
  #   result = a.from_attribute(att, 0)
  #   assert_equal 1.0, a.x
  #   assert_equal 2.0, a.y
  #   assert_equal a, result
  #
  #   a.from_attribute(att, 1)
  #   assert_equal 4.0, a.x
  #   assert_equal 8.0, a.y
  #
  #   att = Tres::BufferAttribute.new([1.0, 2.0, 4.0, 8.0, 16.0, 32.0, 64.0, 128.0], 4)
  #
  #   a.from_attribute(att, 1)
  #   assert_equal 16.0, a.x
  #   assert_equal 32.0, a.y
  #
  #   a.from_attribute(att, 1, 2)
  #   assert_equal 64.0, a.x
  #   assert_equal 128.0, a.y
  # end

  def test_clone
    a = Tres::Vector2.new(1.4f32, -3.4f32)

    b = a.clone

    assert_kind_of Tres::Vector2, b
    assert_equal(1.4f32, b.x)
    assert_equal(-3.4f32, b.y)
  end
end
