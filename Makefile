# Make file for the Randomator project build. Here we have only six targets
# for now: all, that builds the servrian and maze executables for the 
# correct operating system, clean that clears the object files for a new 
# build, distclean, that clears also the binaries and the Randomator itself.
# Currently we are compiling some object files (.o) from header files (.h),
# which are then linked to create the final binaries.

# check some system's particularyties
ifeq ($(OS),Windows_NT)
	KEYGENDIR = bin/Randomator/Windows_NT
	KEYGEN = randomator.exe
	ARCH = Windows_NT
else 
	ARCH = $(shell uname -s)
	KEYGENDIR = bin/Randomator/$(shell uname -s)
	KEYGEN = randomator
	ifeq ($(ARCH),Darwin)
		CFLAGS = -I ./include -I /usr/local/opt/openssl/include
		LFLAGS = 
	else
		CFLAGS = -I ./include
		LFLAGS = -L lib -lm -lcrypto -lweb
	endif
endif

# set directories for search dependencies
vpath %.h 	./include
vpath %.c 	./src
vpath %.so 	./lib

# compile randomator
$(KEYGEN): randomator.o
	@if test ! -d $(KEYGENDIR); then mkdir -p $(KEYGENDIR); fi
	$(CC) $^ -o $(KEYGENDIR)/$@
	@echo "Done."

%.o: %.c
	@if test ! -d obj; then mkdir obj; fi
	@echo "Compiling $<..."
	$(CC) $(CFLAGS) -c $< -o obj/$@

# create shared libraries
.PHONY: libs

libs: libweb.so

libweb.so: web.o
	$(CC) $(CFLAGS) -shared -fPIC $< -o lib/$@ $(LFLAGS)

%.o: %.c
	@if test ! -d obj; then mkdir obj; fi
	@echo "Compiling $<..."
	$(CC) $(CFLAGS) -fPIC -c $< -o obj/$@

# install shared libs
.PHONY: libs-install

libs-install: libweb.so web.h
	@echo "Instaling $<..."
	cp lib/libweb.so /usr/lib/
	@echo "Instaling $<..."
	cp include/web.h /usr/include/

# build projects
.PHONY: all

all: $(KEYGEN) libweb.so
	@echo "Building projects."
	test ! -d build; then VER = $(cat build); fi
	@echo "	Create backups of key.h"
	cp ../Maze/include/key{.h,-old.h}
	cp ../Servrian/include/key{.h,-old.h}
	@echo "	Injecting keys..."
	exec $(KEYGENDIR)/$(KEYGEN)
	@echo "	Making all for Maze"
	include ../Maze/Makefile
	@echo "	Maze built."
	@echo "	Making all for Servrian"
	include ../Servrian/Makefile
	@echo "	Servrian built."
	@echo "	Delete files with key and restore backups."
	$(RM) ../Maze/include/key.h && mv ../Maze/include/key{-old.h,.h}	
	$(RM) ../Servrian/include/key.h && mv ../Servrian/include/key{-old.h,.h}
	@echo "	Done."
	@echo "Creating symlinks."
	@if test ! -d bin/Maze; then mkdir bin/Maze; fi
	@if test ! -d bin/Servrian; then mkdir bin/Servrian; fi
	ln -sf ../Maze/bin ./bin/Maze
	ln -sf ../Servrian/bin ./bin/Servrian
	@echo "All done."

# remove compilation products
.PHONY: clean

clean:
	@echo "Cleaning up Maze..."
	$(RM) ../Maze/obj/*.o
	@echo "Cleaning up Servrian..."
	$(RM) ../Servrian/obj/*.o
	@echo "Cleaning up Randomator..."
	$(RM) obj/*.o
	$(RM) lib/*.so

# remove compilation and linking products
.PHONY: distclean

distclean:
	@echo "Cleaning up Maze..."
	$(RM) ../Maze/obj/*.o
	$(RM) -rf ../Maze/bin/*
	@echo "Cleaning up Servrian..."
	$(RM) ../Servrian/obj/*.o
	$(RM) -rf ../Servrian/bin/*
	@echo "Cleaning up Randomator..."
	$(RM) obj/*.o
	$(RM) lib/*.so
	$(RM) -rf bin/*

