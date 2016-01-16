require 'benchmark'
require_relative 'extension_with_crystal'

Benchmark.bm 10 do |r|
  r.report "table" do
    Table.new.generate("woot", 100, 100)
  end
end
