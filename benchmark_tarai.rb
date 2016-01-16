require 'benchmark'
require_relative 'extension_with_crystal'

Benchmark.bm 10 do |r|
  r.report "tarai" do
    Takeuchi.tarai(14, 7, 0)
  end
end
