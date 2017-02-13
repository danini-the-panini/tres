require "../minitest_helper"

class TestPlane < Minitest::Test

  def compare_plane(a, b, threshold = 0.0001)
    a.normal.distance_to(b.normal) < threshold && (a.constant - b.constant).abs < threshold
  end

  def test_constructor
    a = Tres::Plane.new
    assert_equal(1, a.normal.x)
    assert_equal(0, a.normal.y)
    assert_equal(0, a.normal.z)
    assert_equal(0, a.constant)

    a = Tres::Plane.new(one3.clone, 0)
    assert_equal(1, a.normal.x)
    assert_equal(1, a.normal.y)
    assert_equal(1, a.normal.z)
    assert_equal(0, a.constant)

    a = Tres::Plane.new(one3.clone, 1)
    assert_equal(1, a.normal.x)
    assert_equal(1, a.normal.y)
    assert_equal(1, a.normal.z)
    assert_equal(1, a.constant)
  end

  def test_copy
    a = Tres::Plane.new(Tres::Vector3.new(x, y, z), w)
    b = Tres::Plane.new.copy(a)
    assert_equal(x, b.normal.x)
    assert_equal(y, b.normal.y)
    assert_equal(z, b.normal.z)
    assert_equal(w, b.constant)

    # ensure that it is a true copy
    a.normal.x = 0f32
    a.normal.y = -1f32
    a.normal.z = -2f32
    a.constant = -3f32
    assert_equal(x, b.normal.x)
    assert_equal(y, b.normal.y)
    assert_equal(z, b.normal.z)
    assert_equal(w, b.constant)
  end

  def test_set
    a = Tres::Plane.new
    assert_equal(1, a.normal.x)
    assert_equal(0, a.normal.y)
    assert_equal(0, a.normal.z)
    assert_equal(0, a.constant)

    b = a.clone.set(Tres::Vector3.new(x, y, z), w)
    assert_equal(x, b.normal.x)
    assert_equal(y, b.normal.y)
    assert_equal(z, b.normal.z)
    assert_equal(w, b.constant)
  end

  def test_set_components
    a = Tres::Plane.new
    assert_equal(1, a.normal.x)
    assert_equal(0, a.normal.y)
    assert_equal(0, a.normal.z)
    assert_equal(0, a.constant)

    b = a.clone.set_components(x, y, z , w)
    assert_equal(x, b.normal.x)
    assert_equal(y, b.normal.y)
    assert_equal(z, b.normal.z)
    assert_equal(w, b.constant)
  end

  def test_set_from_normal_and_coplanar_point
    normal = one3.clone.normalize
    a = Tres::Plane.new.set_from_normal_and_coplanar_point(normal, zero3)

    assert_equal(normal, a.normal)
    assert_equal(0, a.constant)
  end

  def test_normalize
    a = Tres::Plane.new(Tres::Vector3.new(2, 0, 0), 2)

    a.normalize
    assert_equal(1, a.normal.length)
    assert_equal(Tres::Vector3.new(1, 0, 0), a.normal)
    assert_equal(1, a.constant)
  end

  def test_negate_distance_to_point
    a = Tres::Plane.new(Tres::Vector3.new(2, 0, 0), -2)

    a.normalize
    assert_equal(3, a.distance_to_point(Tres::Vector3.new(4, 0, 0)))
    assert_equal(0, a.distance_to_point(Tres::Vector3.new(1, 0, 0)))

    a.negate
    assert_equal(-3, a.distance_to_point(Tres::Vector3.new(4, 0, 0)))
    assert_equal(0, a.distance_to_point(Tres::Vector3.new(1, 0, 0)))
  end

  def test_distance_to_point
    a = Tres::Plane.new(Tres::Vector3.new(2, 0, 0), -2)

    a.normalize
    assert_equal(0, a.distance_to_point(a.project_point(zero3.clone)))
    assert_equal(3, a.distance_to_point(Tres::Vector3.new(4, 0, 0)))
  end

  def test_distance_to_sphere
    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), 0)

    b = Tres::Sphere.new(Tres::Vector3.new(2, 0, 0), 1)

    assert_equal(1, a.distance_to_sphere(b))

    a.set(Tres::Vector3.new(1, 0, 0), 2)
    assert_equal(3, a.distance_to_sphere(b))
    a.set(Tres::Vector3.new(1, 0, 0), -2)
    assert_equal(-1, a.distance_to_sphere(b))
  end

  def test_is_interestion_line_intersect_line
    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), 0)

    l1 = Tres::Line3.new(Tres::Vector3.new(-10, 0, 0), Tres::Vector3.new(10, 0, 0))
    assert(a.intersection_line?(l1))
    assert_equal(Tres::Vector3.new(0, 0, 0), a.intersect_line(l1))

    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), -3)

    assert(a.intersection_line?(l1))
    assert_equal(Tres::Vector3.new(3, 0, 0), a.intersect_line(l1))


    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), -11)

    refute(a.intersection_line?(l1))
    assert_equal(nil, a.intersect_line(l1))

    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), 11)

    refute(a.intersection_line?(l1))
    assert_equal(nil, a.intersect_line(l1))

  end

  def test_project_point
    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), 0)

    assert_equal(zero3, a.project_point(Tres::Vector3.new(10, 0, 0)))
    assert_equal(zero3, a.project_point(Tres::Vector3.new(-10, 0, 0)))

    a = Tres::Plane.new(Tres::Vector3.new(0, 1, 0), -1)
    assert_equal(Tres::Vector3.new(0, 1, 0), a.project_point(Tres::Vector3.new(0, 0, 0)))
    assert_equal(Tres::Vector3.new(0, 1, 0), a.project_point(Tres::Vector3.new(0, 1, 0)))

  end

  def test_ortho_point
    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), 0)

    assert_equal(Tres::Vector3.new(10, 0, 0), a.ortho_point(Tres::Vector3.new(10, 0, 0)))
    assert_equal(Tres::Vector3.new(-10, 0, 0), a.ortho_point(Tres::Vector3.new(-10, 0, 0)))
  end

  def test_coplanar_point
    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), 0)
    assert_equal(0, a.distance_to_point(a.coplanar_point))

    a = Tres::Plane.new(Tres::Vector3.new(0, 1, 0), -1)
    assert_equal(0, a.distance_to_point(a.coplanar_point))
  end

  def test_apply_matrix4_translate

    a = Tres::Plane.new(Tres::Vector3.new(1, 0, 0), 0)

    m = Tres::Matrix4.new
    m.make_rotation_z(Math::PI * 0.5)

    assert(compare_plane(a.clone.apply_matrix4(m), Tres::Plane.new(Tres::Vector3.new(0, 1, 0), 0)))

    a = Tres::Plane.new(Tres::Vector3.new(0, 1, 0), -1)
    assert(compare_plane(a.clone.apply_matrix4(m), Tres::Plane.new(Tres::Vector3.new(-1, 0, 0), -1)))

    m.make_translation(1, 1, 1)
    assert(compare_plane(a.clone.apply_matrix4(m), a.clone.translate(Tres::Vector3.new(1, 1, 1))))
  end
end
