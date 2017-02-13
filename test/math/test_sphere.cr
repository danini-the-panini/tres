require "../minitest_helper"

class TestSphere < Minitest::Test

  def test_constructor
    a = Tres::Sphere.new
    assert_equal(zero3, a.center)
    assert_equal(0.0, a.radius)

    a = Tres::Sphere.new(one3.clone, 1)
    assert_equal(one3, a.center)
    assert_equal(1.0, a.radius)
  end

  def test_copy
    a = Tres::Sphere.new(one3.clone, 1)
    b = Tres::Sphere.new.copy(a)

    assert_equal(one3, b.center)
    assert_equal(1, b.radius)

    # ensure that it is a true copy
    a.center = zero3
    a.radius = 0f32
    assert_equal(one3, b.center)
    assert_equal(1, b.radius)
  end

  def test_set
    a = Tres::Sphere.new
    assert_equal(zero3, a.center)
    assert_equal(0, a.radius)

    a.set(one3, 1)
    assert_equal(one3, a.center)
    assert_equal(1, a.radius)
  end

  def test_empty
    a = Tres::Sphere.new
    assert(a.empty)

    a.set(one3, 1)
    assert(! a.empty)
  end

  def test_contains_point
    a = Tres::Sphere.new(one3.clone, 1)

    refute(a.contains_point?(zero3))
    assert(a.contains_point?(one3))
  end

  def test_distance_to_point
    a = Tres::Sphere.new(one3.clone, 1)

    assert((a.distance_to_point(zero3) - 0.7320) < 0.001)
    assert_equal(-1, a.distance_to_point(one3))
  end

  def test_intersects_sphere
    a = Tres::Sphere.new(one3.clone, 1)
    b = Tres::Sphere.new(zero3.clone, 1)
    c = Tres::Sphere.new(zero3.clone, 0.25)

    assert(a.intersects_sphere?(b))
    refute(a.intersects_sphere?(c))
  end

  def test_clamp_point
    a = Tres::Sphere.new(one3.clone, 1)

    assert_equal(Tres::Vector3.new(1, 1, 2), a.clamp_point(Tres::Vector3.new(1, 1, 3)))
    assert_equal(Tres::Vector3.new(1, 1, 0), a.clamp_point(Tres::Vector3.new(1, 1, -3)))
  end

  def test_get_bounding_box
    a = Tres::Sphere.new(one3.clone, 1)

    assert_equal(Tres::Box3.new(zero3, two3), a.bounding_box)

    a.set(zero3, 0)
    assert_equal(Tres::Box3.new(zero3, zero3), a.bounding_box)
  end

  def test_apply_matrix4
    a = Tres::Sphere.new(one3.clone, 1)

    m = Tres::Matrix4.new.make_translation(1, -2, 1)

    assert_equal(a.bounding_box.apply_matrix4(m), a.clone.apply_matrix4(m).bounding_box)
  end

  def test_translate
    a = Tres::Sphere.new(one3.clone, 1)

    a.translate(one3.clone.negate)
    assert_equal(zero3, a.center)
  end
end
