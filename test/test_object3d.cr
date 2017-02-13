require "./minitest_helper"

describe Tres::Object3D do
  it "allows children to be added" do
    obj = Tres::Object3D.new
    child = Tres::Object3D.new

    obj.add(child)

    assert_includes obj.children, child
    assert_equal obj, child.parent
  end

  it "allows children to be removed" do
    obj = Tres::Object3D.new
    child = Tres::Object3D.new
    obj.add(child)

    obj.remove(child)

    refute_includes obj.children, child
    assert_nil child.parent
  end

  it "removes object from previous parent if any" do
    parent = Tres::Object3D.new
    child = Tres::Object3D.new
    parent.add(child)
    obj = Tres::Object3D.new

    obj.add(child)

    refute_includes parent.children, child
    assert_equal obj, child.parent
  end
end
