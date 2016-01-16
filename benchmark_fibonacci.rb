require 'benchmark'
require_relative 'ruby_example'
require_relative 'extension_with_crystal'

Benchmark.bm 18 do |r|
  r.report "fibonacci (ruby)" do
    fibonacci(40)
  end
  r.report "fibonacci (crystal)" do
    fibonacci_cr(40)
  end
end
