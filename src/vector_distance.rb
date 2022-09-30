require 'bundler'
require 'matrix'

Bundler.require

class Vector
  def coordinates
    to_a.map { format('%.2f', _1).to_s.rjust(5) }.join(' ')
  end
end

class VectorDistance
  def initialize(filename)
    @vectors = readfile(filename)
    @distances = []
  end

  def readfile(filename)
    File.read(filename).each_line.map do |line|
      Vector[*line.split(/\s+/).map(&:to_f)] 
    end
  end

  def calculate
    @vectors.map do |v1|
      [v1.coordinates] + @vectors.map { |v2| format('%7.3f', (v1 - v2).magnitude) }
    end
  end

  def header
    [''] + @vectors.map(&:coordinates)
  end

  def print_table
    TTY::Table
      .new(header, calculate)
      .render(:unicode, padding: [0, 1], alignment: :right)
  end
end