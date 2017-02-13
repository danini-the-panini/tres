require "minitest/autorun"

require "../src/tres"
require "./support/*"

class Minitest::Test
  def assert_color_equal(expected, actual)
    assert_in_delta expected.r, actual.r
    assert_in_delta expected.g, actual.g
    assert_in_delta expected.b, actual.b
  end

  macro assert_predicate(obj, pred)
    assert {{obj}}.{{pred.id}}, "{{ obj }} is not {{ pred.id }}"
  end

  macro refute_predicate(obj, pred)
    refute {{obj}}.{{pred.id}}, "{{ obj }} is {{ pred.id }}"
  end

  macro assert_kind_of(klass, obj)
    assert {{obj}}.is_a?({{klass.id}}), "{{ obj }} is is a kind of #{{{ obj }}.class}, expected {{ klass }}"
  end

  macro refute_kind_of(klass, obj)
    refute {{obj}}.is_a?({{klass.id}}), "{{ obj }} is a kind of {{ klass }}"
  end

  def assert_raises
    begin
      yield
      assert false, "Did not raise exception"
    rescue
      assert true
    end
  end
end
