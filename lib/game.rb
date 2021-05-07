require './lib/frame'
require './lib/shot'

class Game
  def initialize(mark)
    @frames = frames(mark.split(','))
  end

  def score(frames)
    point = 0
    frames.each do |f|
      p f
      point += frames[f].score
    end
  end

  def frames(marks)
    #1フレーム
    #すべてのフレーム
    frames = []
    frame_shots = []
    #marks = 1投ごとのスコア
    marks.each do |mark|
      frame_shots << mark
      if next_frame?(frames)
        frames << Frame.new(frame_shots[0], frame_shots[1], frame_shots[2]=nil)
        frame_shots.clear
      elsif frame_shots[0] == 'X'
        frames << Frame.new(frame_shots[0], frame_shots[1]=nil, frame_shots[2]=nil)
        frame_shots.clear
      elsif last_frame?(frames)
        frames << Frame.new(frame_shots[0], frame_shots[1], frame_shots[2])
      end
      #p frames
    end

  end

  def next_frame?(frames)
    p frames.last
    rolls = frames.last
    !last_frame?(frames) && (frames.empty? || rolls.size == 2)
  end

  def last_frame?(frames)
    frames.size == 10
  end

  def add_bonus(frame_shots, following_pinfalls)
    if frame_shots[0] == 10
      following_pinfalls.first[2].sum
    elsif frame_shots[0][1] == 10
      following_pinfalls.first
    end
  end
end
