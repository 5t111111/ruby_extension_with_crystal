lib Ruby
  type VALUE = Void*
  type METHOD_FUNC = VALUE, VALUE -> VALUE # STUB

  $rb_cObject : VALUE

  fun rb_str_to_str(value: VALUE) : VALUE
  fun rb_string_value_cstr(value_ptr: VALUE*) : UInt8*
  fun rb_define_class(name: UInt8*, super: VALUE) : VALUE
  fun rb_define_method(klass: VALUE, name: UInt8*, func: METHOD_FUNC, argc: Int32)
  fun rb_define_module_function(klass: VALUE, name: UInt8*, func: VALUE, VALUE, VALUE, VALUE -> VALUE, argc: Int32)

  fun rb_num2int_inline(value : VALUE) : Int32
  fun rb_num2int(value : VALUE) : Int32
  fun rb_int2inum(value : Int32) : VALUE
end

def salute(self : Ruby::VALUE, name : Ruby::VALUE)
  rb_str = Ruby.rb_str_to_str(name)
  c_str  = Ruby.rb_string_value_cstr(pointerof(rb_str))
  cr_str = String.new(c_str)

  puts "Hello, #{cr_str}!!!"

  name
end

def tarai(self : Ruby::VALUE, x : Ruby::VALUE, y : Ruby::VALUE, z : Ruby::VALUE)
  int_x = Ruby.rb_num2int(x)
  int_y = Ruby.rb_num2int(y)
  int_z = Ruby.rb_num2int(z)
  Ruby.rb_int2inum(tarai2(int_x, int_y, int_z))
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

fun init = Init_crystal_example_ext
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

  greeter = Ruby.rb_define_class("Greeter", Ruby.rb_cObject)
  Ruby.rb_define_method(greeter, "salute", ->salute, 1)

  rb_class_takeuchi = Ruby.rb_define_class("Takeuchi", Ruby.rb_cObject)
  Ruby.rb_define_module_function(rb_class_takeuchi, "tarai", ->tarai, 3);
end
