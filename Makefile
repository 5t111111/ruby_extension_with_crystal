CRYSTAL = crystal
UNAME = "$(shell uname -ms)"
LIBS = -levent -lpcl -lpcre -lgc -lpthread
LDFLAGS = -Wl,-undefined,dynamic_lookup

TARGET = extension_with_crystal.bundle

$(TARGET): extension_with_crystal.o
	$(CC) -bundle -o $@ $^ $(LIBS) $(LDFLAGS)

extension_with_crystal.o: extension_with_crystal.cr
	$(CRYSTAL) build --release --cross-compile $(UNAME) $<

.PHONY: clean
clean:
	rm -f bc_flags
	rm -f extension_with_crystal.o
	rm -f $(TARGET)
