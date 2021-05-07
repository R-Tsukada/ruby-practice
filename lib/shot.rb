#!/usr/bin/env ruby
# frozen_string_literal: true


#1投ごとの計算方法
class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark == 'X'

    mark.to_i
  end
end
