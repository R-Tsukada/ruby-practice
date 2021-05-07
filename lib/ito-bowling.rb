
#!/usr/bin/env ruby
# frozen_string_literal: true

def calc_score(pinfall_text)
  pinfalls = parse_pinfall_text(pinfall_text)
  frames = []
  pinfalls.each_with_index.sum do |pinfall, index|
    frames << [] if next_frame?(frames)
    rolls = frames.last
    rolls << pinfall
    following_pinfalls = pinfalls[index.succ..]
    last_frame?(frames) ? pinfall : pinfall + add_bonus(rolls, following_pinfalls)
  end
end

def parse_pinfall_text(pinfall_text)
  pinfall_text.split(',').map { |c| c == 'X' ? 10 : c.to_i }
end

def next_frame?(frames)
  rolls = frames.last
  !last_frame?(frames) && (frames.empty? || strike?(rolls) || rolls.size == 2)
end

def add_bonus(rolls, following_pinfalls)
  if strike?(rolls)
    following_pinfalls.first(2).sum
  elsif spare?(rolls)
    following_pinfalls.first
  else
    0
  end
end

def last_frame?(frames)
  frames.size == 10
end

def strike?(rolls)
  rolls[0] == 10
end

def spare?(rolls)
  rolls.sum == 10
end

if __FILE__ == $PROGRAM_NAME # rubocop:disable Style/IfUnlessModifier
  puts calc_score(ARGV[0])
end