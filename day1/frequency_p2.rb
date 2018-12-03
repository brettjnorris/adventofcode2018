#!/usr/bin/env ruby

File.open('input.txt', 'r') do |f|
  sum = 0
  i = 0
  deltas = []
  frequencies = []
  match = nil

  f.each do |line|
    deltas << line.to_i
  end

  loop do
    i = 0 if i == deltas.count

    sum += deltas[i]

    if frequencies.include? sum
      match = sum
      break
    end

    frequencies << sum
    i += 1
  end

  puts "Match found: #{match}"

end