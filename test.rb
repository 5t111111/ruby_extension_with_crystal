# First, build the extension by running `make`
require './crystal_example_ext'

g = Greeter.new
g.salute('world')
