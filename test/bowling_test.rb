require 'minitest/autorun'
require './lib/game'

class BowlingTest < MiniTest::Test
  def test_score1
    game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, game.frames
  end
end
