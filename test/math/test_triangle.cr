require "../minitest_helper"

class TestTriangle < Minitest::Test
  def test_constructor
    a = Tres::Triangle.new
    assert_equal(zero3, a.a)
    assert_equal(zero3, a.b)
    assert_equal(zero3, a.c)

    a = Tres::Triangle.new(one3.clone.negate, one3.clone, two3.clone)
    assert_equal(one3.clone.negate, a.a)
    assert_equal(one3, a.b)
    assert_equal(two3, a.c)
  end

  def test_copy
    a = Tres::Triangle.new(one3.clone.negate, one3.clone, two3.clone)
    b = Tres::Triangle.new.copy(a)
    assert_equal(one3.clone.negate, b.a)
    assert_equal(one3, b.b)
    assert_equal(two3, b.c)

    # ensure that it is a true copy
    a.a = one3
    a.b = zero3
    a.c = zero3
    assert_equal(one3.clone.negate, b.a)
    assert_equal(one3, b.b)
    assert_equal(two3, b.c)
  end

  def test_set_from_points_and_indices
    a = Tres::Triangle.new

    points = [ one3, one3.clone.negate, two3 ]
    a.set_from_points_and_indices(points, 1, 0, 2)
    assert_equal(one3.clone.negate, a.a)
    assert_equal(one3, a.b)
    assert_equal(two3, a.c)
  end

  def test_set
    a = Tres::Triangle.new

    a.set(one3.clone.negate, one3, two3)
    assert_equal(one3.clone.negate, a.a)
    assert_equal(one3, a.b)
    assert_equal(two3, a.c)

  end

  def test_area
    a = Tres::Triangle.new

    assert_equal(0, a.area)

    a = Tres::Triangle.new(Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(1, 0, 0), Tres::Vector3.new(0, 1, 0))
    assert_equal(0.5, a.area)

    a = Tres::Triangle.new(Tres::Vector3.new(2, 0, 0), Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(0, 0, 2))
    assert_equal(2, a.area)

    # colinear triangle.
    a = Tres::Triangle.new(Tres::Vector3.new(2, 0, 0), Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(3, 0, 0))
    assert_equal(0, a.area)
  end

  def test_midpoint
    a = Tres::Triangle.new

    assert_equal(Tres::Vector3.new(0, 0, 0), a.midpoint)

    a = Tres::Triangle.new(Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(1, 0, 0), Tres::Vector3.new(0, 1, 0))
    assert_equal(Tres::Vector3.new(1.0/3.0, 1.0/3.0, 0), a.midpoint)

    a = Tres::Triangle.new(Tres::Vector3.new(2, 0, 0), Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(0, 0, 2))
    assert_equal(Tres::Vector3.new(2.0/3.0, 0, 2.0/3.0), a.midpoint)
  end

  def test_normal
    a = Tres::Triangle.new

    assert_equal(Tres::Vector3.new(0, 0, 0), a.normal)

    a = Tres::Triangle.new(Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(1, 0, 0), Tres::Vector3.new(0, 1, 0))
    assert_equal(Tres::Vector3.new(0, 0, 1), a.normal)

    a = Tres::Triangle.new(Tres::Vector3.new(2, 0, 0), Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(0, 0, 2))
    assert_equal(Tres::Vector3.new(0, 1, 0), a.normal)
  end

  def test_plane
    a = Tres::Triangle.new

    # artificial normal is created in this case.
    assert_equal(0, a.plane.distance_to_point(a.a))
    assert_equal(0, a.plane.distance_to_point(a.b))
    assert_equal(0, a.plane.distance_to_point(a.c))
    assert_equal(a.normal, a.plane.normal)

    a = Tres::Triangle.new(Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(1, 0, 0), Tres::Vector3.new(0, 1, 0))
    assert_equal(0, a.plane.distance_to_point(a.a))
    assert_equal(0, a.plane.distance_to_point(a.b))
    assert_equal(0, a.plane.distance_to_point(a.c))
    assert_equal(a.normal, a.plane.normal)

    a = Tres::Triangle.new(Tres::Vector3.new(2, 0, 0), Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(0, 0, 2))
    assert_equal(0, a.plane.distance_to_point(a.a))
    assert_equal(0, a.plane.distance_to_point(a.b))
    assert_equal(0, a.plane.distance_to_point(a.c))
    assert_equal(a.normal, a.plane.normal.clone.normalize)
  end

  def test_barycoord_from_point
    a = Tres::Triangle.new

    bad = Tres::Vector3.new(-2, -1, -1)

    assert_equal(bad, a.barycoord_from_point(a.a))
    assert_equal(bad, a.barycoord_from_point(a.b))
    assert_equal(bad, a.barycoord_from_point(a.c))

    a = Tres::Triangle.new(Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(1, 0, 0), Tres::Vector3.new(0, 1, 0))
    assert_equal(Tres::Vector3.new(1, 0, 0), a.barycoord_from_point(a.a))
    assert_equal(Tres::Vector3.new(0, 1, 0), a.barycoord_from_point(a.b))
    assert_equal(Tres::Vector3.new(0, 0, 1), a.barycoord_from_point(a.c))
    assert_in_delta(0, a.barycoord_from_point(a.midpoint).distance_to(Tres::Vector3.new(1.0/3.0, 1.0/3.0, 1.0/3.0)), 0.0001)

    a = Tres::Triangle.new(Tres::Vector3.new(2, 0, 0), Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(0, 0, 2))
    assert_equal(Tres::Vector3.new(1, 0, 0), a.barycoord_from_point(a.a))
    assert_equal(Tres::Vector3.new(0, 1, 0), a.barycoord_from_point(a.b))
    assert_equal(Tres::Vector3.new(0, 0, 1), a.barycoord_from_point(a.c))
    assert_in_delta(0, a.barycoord_from_point(a.midpoint).distance_to(Tres::Vector3.new(1.0/3.0, 1.0/3.0, 1.0/3.0)), 0.0001, "Passed!")
  end

  def test_contains_point
    a = Tres::Triangle.new

    refute(a.contains_point?(a.a))
    refute(a.contains_point?(a.b))
    refute(a.contains_point?(a.c))

    a = Tres::Triangle.new(Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(1, 0, 0), Tres::Vector3.new(0, 1, 0))
    assert(a.contains_point?(a.a))
    assert(a.contains_point?(a.b))
    assert(a.contains_point?(a.c))
    assert(a.contains_point?(a.midpoint))
    refute(a.contains_point?(Tres::Vector3.new(-1, -1, -1)))

    a = Tres::Triangle.new(Tres::Vector3.new(2, 0, 0), Tres::Vector3.new(0, 0, 0), Tres::Vector3.new(0, 0, 2))
    assert(a.contains_point?(a.a))
    assert(a.contains_point?(a.b))
    assert(a.contains_point?(a.c))
    assert(a.contains_point?(a.midpoint))
    refute(a.contains_point?(Tres::Vector3.new(-1, -1, -1)))
  end
end
