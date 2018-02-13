require 'gosu'
require 'chipmunk'
require_relative 'boudler'
require_relative 'platform'
require_relative 'wall'

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
    @platforms = make_platforms
    @floor = Wall.new(self, 400, 810, 800, 20)
    @left_wall = Wall.new(self, -10, 400, 20, 800)
    @right_wall = Wall.new(self, 810, 470, 20, 660)
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
    @platforms.each(&:draw)
  end

  def make_platforms
    platforms = []
    platforms.push Platform.new(self, 150, 700)
    platforms.push Platform.new(self, 320, 650)
    platforms.push Platform.new(self, 150, 500)
    platforms.push Platform.new(self, 470, 550)
    platforms
  end

end

window = Escape.new
window.show

