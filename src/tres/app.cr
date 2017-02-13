module Tres
  class App
    @window : GLFW::Window
    @scene : Scene

    getter :scene, :window

    def initialize
      @window = GLFW::Window.new(800, 600, "Tres")
      @window.make_current
      GLFW.swap_interval = 1
      @scene = Scene.new
    end

    def start
      until @window.should_close?
        fb_size = @window.framebuffer_size
        ratio = fb_size[:width].to_f32 / fb_size[:height].to_f32

        LibGL.viewport(0, 0, fb_size[:width], fb_size[:height])
        LibGL.clear(LibGL::COLOR_BUFFER_BIT)

        @window.swap_buffers
        GLFW.poll_for_events
      end
    end
  end
end
