require "./minitest_helper"

class TestExtraMath < Minitest::Test
  RANDOM_SAMPLES = 10000

  def test_sign_nan
    sign = Tres::ExtraMath.sign(Float32::NAN)

    assert_predicate sign, :nan?
  end

  def test_sign_negative_zero
    x = -0.0
    sign = Tres::ExtraMath.sign(x)

    assert_equal(x, sign)
  end

  def test_sign_positive_zero
    sign = Tres::ExtraMath.sign(0.0)

    assert_equal(0.0, sign)
  end

  def test_sign_negative_infinity
    sign = Tres::ExtraMath.sign(-Float32::INFINITY)

    assert_equal(-1.0, sign)
  end

  def test_sign_negative_number
    sign = Tres::ExtraMath.sign(-3)

    assert_equal(-1.0, sign)
  end

  def test_sign_negative_small_number
    sign = Tres::ExtraMath.sign(-1e-10)

    assert_equal(-1.0, sign)
  end

  def test_sign_positive_infinity
    sign = Tres::ExtraMath.sign(Float32::INFINITY)

    assert_equal(1.0, sign)
  end

  def test_sign_positive_number
    sign = Tres::ExtraMath.sign(3)

    assert_equal(1.0, sign)
  end

  def test_clamp_less_than_range
    assert_equal 3, Tres::ExtraMath.clamp(2, 3, 7)
  end

  def test_clamp_in_range
    assert_equal 5, Tres::ExtraMath.clamp(5, 3, 7)
  end

  def test_clamp_greater_than_range
    assert_equal 7, Tres::ExtraMath.clamp(8, 3, 7)
  end

  def test_clamp_bottom_less_than_limit
    assert_equal 3, Tres::ExtraMath.clamp_bottom(2, 3)
  end

  def test_clamp_bottom_greater_than_limit
    assert_equal 4, Tres::ExtraMath.clamp_bottom(4, 3)
  end

  def test_map_linear
    inputs = [ -0.1, 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1 ]
    outputs = [ -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1, 1.2 ]
    inputs.zip(outputs).each do |(input, expected)|
      assert_in_delta expected, Tres::ExtraMath.map_linear(input, 0, 1, -1, 1)
    end
  end

  def test_smooth_step
    inputs = [ -0.1, 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1 ]
    outputs = [
      [ 0, 0, 0.028, 0.104, 0.216, 0.352, 0.5, 0.648, 0.784, 0.896, 0.972, 1, 1 ],
      [ 0.42525, 0.5, 0.57475, 0.648, 0.71825, 0.784, 0.84375, 0.896, 0.93925, 0.972, 0.99275, 1, 1 ]
    ]
    inputs.each_with_index do |input, i|
      assert_in_delta outputs[0][i], Tres::ExtraMath.smooth_step(input, 0.0, 1.0)
      assert_in_delta outputs[1][i], Tres::ExtraMath.smooth_step(input, -1.0, 1.0)
    end
  end

  def test_smoother_step
    inputs = [ -0.1, 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1 ]
    outputs = [
      [ 0, 0, 0.00856, 0.05792, 0.16308, 0.31744, 0.5, 0.68256, 0.83692, 0.94208, 0.99144, 1, 1 ],
      [ 0.406873125, 0.5, 0.593126875, 0.68256, 0.764830625, 0.83692, 0.896484375, 0.94208, 0.973388125, 0.99144,
        0.998841875, 1, 1 ]
    ]
    inputs.each_with_index do |input, i|
      assert_in_delta outputs[0][i], Tres::ExtraMath.smoother_step(input, 0.0, 1.0)
      assert_in_delta outputs[1][i], Tres::ExtraMath.smoother_step(input, -1.0, 1.0)
    end
  end

  def test_random16
    RANDOM_SAMPLES.times do
      assert_includes (0..1), Tres::ExtraMath.random16
    end
  end

  def test_rand_int
    RANDOM_SAMPLES.times do
      [[-10, 10], [0, 100]].each do |(low, high)|
        r = Tres::ExtraMath.rand_int(low, high)
        assert_kind_of Int32, r
        assert_includes (low..high), r
      end
    end
  end

  def test_rand_float
    RANDOM_SAMPLES.times do
      [[-1.0f32, 1.0f32], [0.0f32, 1.0f32]].each do |(low, high)|
        r = Tres::ExtraMath.rand_float(low, high)
        assert_kind_of Float32, r
        assert_includes (low..high), r
      end
    end
  end

  def test_rand_float_spread
    RANDOM_SAMPLES.times do
      [1.0, 10.0].each do |limit|
        half_limit = limit/2
        r = Tres::ExtraMath.rand_float_spread(limit)
        assert_kind_of Float, r
        assert_includes (-half_limit..half_limit), r
      end
    end
  end

  def test_deg_to_rad
    inputs = (-360..720).step(30).to_a
    outputs = (-Math::PI*2).step(to: Math::PI*4, by: Math::PI/6).to_a
    inputs.zip(outputs).each do |(input, expected)|
      assert_in_delta expected, Tres::ExtraMath.deg_to_rad(input)
    end
  end

  def test_rad_to_deg
    inputs = (-Math::PI*2).step(to: Math::PI*4, by: Math::PI/6).to_a
    outputs = (-360..720).step(30).to_a
    inputs.zip(outputs).each do |(input, expected)|
      assert_in_delta expected, Tres::ExtraMath.rad_to_deg(input)
    end
  end

  def test_power_of_two?
    assert Tres::ExtraMath.power_of_two?(1), "1 should be a power of two"
    assert Tres::ExtraMath.power_of_two?(4), "4 should be a power of two"
    assert Tres::ExtraMath.power_of_two?(2), "2 should be a power of two"
    assert Tres::ExtraMath.power_of_two?(8192), "8192 should be a power of two"

    refute Tres::ExtraMath.power_of_two?(0), "0 should not be a power of two"
    refute Tres::ExtraMath.power_of_two?(3), "3 should not be a power of two"
    refute Tres::ExtraMath.power_of_two?(12), "12 should not be a power of two"
    refute Tres::ExtraMath.power_of_two?(8191), "8191 should not be a power of two"
  end

  def test_next_power_of_two
    assert_equal 0, Tres::ExtraMath.next_power_of_two(0)
    assert_equal 1, Tres::ExtraMath.next_power_of_two(1)
    assert_equal 2, Tres::ExtraMath.next_power_of_two(2)
    assert_equal 4, Tres::ExtraMath.next_power_of_two(3)
    assert_equal 4096, Tres::ExtraMath.next_power_of_two(4095)
    assert_equal 4096, Tres::ExtraMath.next_power_of_two(4096)
    assert_equal 8192, Tres::ExtraMath.next_power_of_two(4097)
  end
end
