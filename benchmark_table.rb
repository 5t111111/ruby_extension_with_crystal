require 'benchmark'
require_relative 'ruby_example'
require_relative 'extension_with_crystal'

Benchmark.bm 16 do |r|
  r.report "table (ruby)" do
    Table.new.generate("woot", 100, 500)
  end
  r.report "table (crystal)" do
    TableCr.new.generate("woot", 100, 500)
  end
end
