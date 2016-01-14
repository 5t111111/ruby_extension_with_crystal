lib Ruby
  type VALUE = Void*
  type METHOD_FUNC = VALUE, VALUE -> VALUE # STUB

  $rb_cObject : VALUE

  fun rb_str_to_str(value: VALUE) : VALUE
  fun rb_string_value_cstr(value_ptr: VALUE*) : UInt8*
  fun rb_define_class(name: UInt8*, super: VALUE) : VALUE
  fun rb_define_method(klass: VALUE, name: UInt8*, func: METHOD_FUNC, argc: Int32)
end

def salute(self : Ruby::VALUE, name : Ruby::VALUE)
  rb_str = Ruby.rb_str_to_str(name)
  c_str  = Ruby.rb_string_value_cstr(pointerof(rb_str))
  cr_str = String.new(c_str)

  puts "Hello, #{cr_str}!!!"

  name
end

fun init = Init_crystal_example_ext
  GC.init
  LibCrystalMain.__crystal_main(0, Pointer(Pointer(UInt8)).null)

  greeter = Ruby.rb_define_class("Greeter", Ruby.rb_cObject)
  Ruby.rb_define_method(greeter, "salute", ->salute, 1)
end
