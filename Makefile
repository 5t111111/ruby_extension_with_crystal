CRYSTAL = crystal
UNAME = "$(shell uname -ms)"
LIBS = -levent -lpcl -lpcre -lgc -lpthread
LDFLAGS = -Wl,-undefined,dynamic_lookup

TARGET = crystal_example_ext.bundle

$(TARGET): crystal_example_ext.o
	$(CC) -bundle -o $@ $^ $(LIBS) $(LDFLAGS)

crystal_example_ext.o: crystal_example_ext.cr
	$(CRYSTAL) build --cross-compile $(UNAME) $<

.PHONY: clean
clean:
	rm -f bc_flags
	rm -f crystal_example_ext.o
	rm -f $(TARGET)
