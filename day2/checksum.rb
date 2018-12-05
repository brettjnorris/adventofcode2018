#!/usr/bin/env ruby

File.open('input.txt', 'r') do |f|
  counts = {}

  f.each do |line|
    line.split('').group_by(&:to_s).map do |_, v| 
      v.count if v.count > 1
    end.compact.uniq.each do |n|
      if counts[n]
        counts[n] += 1 
      else
        counts[n] = 1
      end
    end
  end

  p counts.values.reduce(:*)
end