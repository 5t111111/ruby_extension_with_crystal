require 'benchmark'
require './crystal_example_ext'

Benchmark.bm 10 do |r|
  r.report "tarai" do
    Takeuchi.tarai(14, 7, 0)
  end
end
