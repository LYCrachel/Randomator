# Make file for the Randomator project build. Here we have only six targets
# for now: all, that builds the servrian and maze executables for the 
# correct operating system, clean that clears the object files for a new 
# build, distclean, that clears also the binaries and the Randomator itself.
# Currently we are compiling some object files (.o) from header files (.h),
# which are then linked to create the final binaries.

ifeq ($(OS),Windows_NT)
	KEYGENDIR = bin/Randomator/Windows_NT
	KEYGEN = randomator.exe
else
	KEYGENDIR = bin/Randomator/$(shell uname -s)
	KEYGEN = randomator
endif

# compile randomator
$(KEYGENDIR)/$(KEYGEN): src/*.c
	@if test ! -d $(KEYGENDIR); then mkdir -p $(KEYGENDIR); fi
	$(CC) $^ -o $@
	@echo "Done."

# build projects
all: 
	@echo "Building projects."
	@echo "	Create backups of key.h"
	cp ../Maze/include/key{.h,-old.h}
	cp ../Servrian/include/key{.h,-old.h}
	@echo "	Injecting keys..."
	exec $(KEYGENDIR)/$(KEYGEN)
	@echo "	Making all for Maze"
	cd ../Maze && $(MAKE)
	@echo "	Maze built."
	@echo "	Making all for Servrian"
	cd ../Servrian && $(MAKE)
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
clean:
	@echo "Cleaning up Maze..."
	$(RM) ../Maze/obj/*.o
	@echo "Cleaning up Servrian..."
	$(RM) ../Servrian/obj/*.o

# remove compilation and linking products
distclean:
	@echo "Cleaning up Maze..."
	$(RM) ../Maze/obj/*.o
	$(RM) -rf ../Maze/bin/*
	@echo "Cleaning up Servrian..."
	$(RM) ../Servrian/obj/*.o
	$(RM) -rf ../Servrian/bin/*
	@echo "Cleaning up Randomator..."
	$(RM) ../Randomator/obj/*.o
	$(RM) -rf bin/*
