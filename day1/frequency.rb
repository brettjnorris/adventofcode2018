#!/usr/bin/env ruby

File.open('input.txt', 'r') do |f|
  sum = 0
  f.each do |line|
    sum += line.to_i
  end
  puts "Sum: #{sum}"
end