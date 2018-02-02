#!/usr/bin/env ruby

require_relative './ranker.rb'

filename = ARGV[0]

if filename
  input = File.read(filename)
else
  input = ARGF.read
end

ranker = Ranker.new(input)

puts ranker.rank()