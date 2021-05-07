
score = ARGV[0]
scores = score.split(',')
shots = scores.map { |s| s == 'X' ? 10 : s.to_i }

frames = []
frame = []
shots.each do |s|
  frame << s

  if frames.size < 10
    if frame.size >= 2 || s == 10
      frames << frame.dup
      frame.clear
    end
  else # last frame
    frames.last << s
  end
end

point = 0
(0..9).each do |n|
  frame, next_frame, after_next_frame = frames.slice(n, 3)
  #next_frameがnil, または　falseだったら[]を代入する
  next_frame ||= []
  after_next_frame ||= []
  left_shots = next_frame + after_next_frame

  if frame[0] == 10 # strike
    point += frame.sum + left_shots.slice(0, 2).sum
  elsif frame.sum == 10 # spare
    point += frame.sum + left_shots.fetch(0)
  else
    point += frame.sum
  end
end
puts point