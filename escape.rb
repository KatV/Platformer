require 'gosu'
require 'chipmunk'
require_relative 'boudler'

# class Escape
class Escape < Gosu::Window

  DAMPING = 0.99
  GRAVITY = 400.0
  BOUDLER_FREQUENCY = 0.01

  attr_reader :space

  def initialize
    super(800, 800)
    self.caption = 'Escape'
    @game_over = false
    @space = CP::Space.new
    @dir = File.join(File.dirname(__FILE__), 'images/background.png')
    @background = Gosu::Image.new(@dir, tileable: true)
    @space.damping = DAMPING
    @space.gravity = CP::Vec2.new(0.0, GRAVITY)
    @boulders = []
  end

  def update
    unless @game_over
      10.times do
        @space.step(1.0/600)
      end
      if rand < BOUDLER_FREQUENCY
        @boulders.push Boulder.new(self, 200 + rand(400), -20)
      end
    end
  end

  def draw
    @background.draw(0, 0, 0)
    @background.draw(0, 529, 0)
    @boulders.each(&:draw)
  end

end

window = Escape.new
window.show
