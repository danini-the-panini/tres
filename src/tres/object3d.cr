module Tres
  class Object3D
    @children : Array(Object3D)
    @parent : Object3D?

    property :parent
    getter :children

    def initialize
      @children = [] of Object3D
      @parent = nil
    end

    def add(object)
      parent = object.parent
      if !parent.is_a?(Nil)
        parent.remove(object)
      end
      object.parent = self
      @children << object
    end

    def remove(object)
      object.parent = nil
      @children.delete(object)
    end
  end
end
