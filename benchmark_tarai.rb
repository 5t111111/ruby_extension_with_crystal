require 'benchmark'
require_relative 'ruby_example'
require_relative 'extension_with_crystal'

Benchmark.bm 16 do |r|
  r.report "tarai (ruby)" do
    Takeuchi.tarai(15, 5, 1)
  end
  r.report "tarai (crystal)" do
    TakeuchiCr.tarai(15, 5, 1)
  end
end

# 356,426,301 times function call
