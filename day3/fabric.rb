#!/usr/bin/env ruby

ROWS = 1000
COLS = 1000

fabric = Array.new(ROWS * COLS, 0)

def coordinate_index(x, y)
  (COLS * (x - 1)) + (y - 1)
end

def output(fabric)
  fabric.each_slice(COLS).map {|a| p a.join(' ') }
end

def squares(claim)
  indices = []

  start = coordinate_index(claim[:x], claim[:y])

  claim[:l].times do |i|
    row_start = start + ((i + 1) * COLS)

    claim[:w].times do |j|
      index = row_start + j + 1

      indices << index
    end
  end

  indices
end

claims = nil

File.open('input.txt', 'r') do |f|
  claims = f.map do |line|
    parts = line.to_s.split(' ')

    y, x = parts[2].gsub(':', '').split(',').map(&:to_i)
    w, l = parts[3].split('x').map(&:to_i)

    { id: parts[0], y: y, x: x, w: w, l: l }
  end
end

claims.each do |claim|
  squares(claim).each do |square|
    fabric[square] = (fabric[square] || 0) + 1
  end
end

claims.each do |claim|
  counts = squares(claim).map {|i| fabric[i] }.uniq

  if counts.max == 1
    puts "Exclusive claim found: #{claim[:id]}"
  end
end

puts "Duplicate squares: #{fabric.select {|a| a && a > 1}.count}"


