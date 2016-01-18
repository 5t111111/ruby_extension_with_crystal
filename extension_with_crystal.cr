lib LibRuby
  type VALUE = Void*

  $rb_cObject : VALUE

  fun rb_define_global_function(name : UInt8*, func : VALUE, VALUE -> VALUE, argc : Int32)
  fun rb_define_class(name : UInt8*, super : VALUE) : VALUE
  fun rb_define_method(klass : VALUE, name : UInt8*, func : VALUE, VALUE, VALUE, VALUE -> VALUE, argc : Int32)
  fun rb_define_module_function(klass : VALUE, name : UInt8*, func : VALUE, VALUE, VALUE, VALUE -> VALUE, argc : Int32)
  fun rb_str_to_str(str : VALUE) : VALUE
  fun rb_string_value_cstr(ptr : VALUE*) : UInt8*
  fun rb_str_new(ptr : UInt8*, len : Int32) : VALUE
  fun rb_num2int(value : VALUE) : Int32
  fun rb_int2inum(value : Int32) : VALUE
end

def fibonacci_cr(self : LibRuby::VALUE, value : LibRuby::VALUE)
  int_value = LibRuby.rb_num2int(value)
  LibRuby.rb_int2inum(fibonacci_cr2(int_value))
end

def fibonacci_cr2(n)
  return n if n <= 1
  fibonacci_cr2(n - 1) + fibonacci_cr2(n - 2)
end

def tarai(self : LibRuby::VALUE, x : LibRuby::VALUE, y : LibRuby::VALUE, z : LibRuby::VALUE)
  int_x = LibRuby.rb_num2int(x)
  int_y = LibRuby.rb_num2int(y)
  int_z = LibRuby.rb_num2int(z)
  LibRuby.rb_int2inum(tarai2(int_x, int_y, int_z))
end

def tarai2(x, y, z)
  if y < x
    tarai2(
      tarai2(x - 1, y, z),
      tarai2(y - 1, z, x),
      tarai2(z - 1, x, y)
    )
  else
    y
  end
end

def generate(self : LibRuby::VALUE, value : LibRuby::VALUE, col : LibRuby::VALUE, row : LibRuby::VALUE)
  rb_str = LibRuby.rb_str_to_str(value)
  c_str  = LibRuby.rb_string_value_cstr(pointerof(rb_str))
  cr_str = String.new(c_str)
  int_col = LibRuby.rb_num2int(col)
  int_row = LibRuby.rb_num2int(row)

  table = "<table>"

  int_row.times do |row_i|
    table += "\n  <tr class='row-#{row_i}'>"
    int_col.times { |col_i| table += "\n    <td>(#{col_i}) #{cr_str}</td>" }
    table += "\n  </tr>"
  end

  table += "\n</table>"
  LibRuby.rb_str_new(table.to_unsafe, table.size)
end

fun init = Init_extension_with_crystal
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

  LibRuby.rb_define_global_function("fibonacci_cr", ->fibonacci_cr, 1);

  rb_class_table = LibRuby.rb_define_class("TableCr", LibRuby.rb_cObject)
  LibRuby.rb_define_method(rb_class_table, "generate", ->generate, 3);

  rb_class_takeuchi = LibRuby.rb_define_class("TakeuchiCr", LibRuby.rb_cObject)
  LibRuby.rb_define_module_function(rb_class_takeuchi, "tarai", ->tarai, 3);
end
