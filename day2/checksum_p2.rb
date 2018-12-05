#!/usr/bin/env ruby

require 'set'

def levenshtein(first:, second:)
  m, n = first.length, second.length
  return m if n == 0
  return n if m == 0

  # Create our distance matrix
  d = Array.new(m+1) {Array.new(n+1)}
  0.upto(m) { |i| d[i][0] = i }
  0.upto(n) { |j| d[0][j] = j }

  1.upto(n) do |j|
    1.upto(m) do |i|
      d[i][j] = first[i-1] == second[j-1] ? d[i-1][j-1] : [d[i-1][j]+1,d[i][j-1]+1,d[i-1][j-1]+1,].min
    end
  end
  d[m][n]
end

File.open('input.txt', 'r') do |f|
  ids = f.map {|line| line.to_s.strip }

  matches = []

  ids.cycle(1) do |x|
    ids.cycle(1) do |y|
      next if x == y

      diff = levenshtein(first: x, second: y)
      if diff == 1
        matches = [x, y]
      end
    end
  end

  diffs = matches.map {|match| match.split('').to_set }.reduce(:^)
  puts (matches.first.split('') - diffs.to_a).join('')
end
