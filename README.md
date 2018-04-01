# Randomator
> A builder and pseudo random string generator for Servrian and Maze (two projects of the maintainer). The Randomator is planned to be transparent and safe to generate a key. By inserting it in the code and build the project, no one could see the key used.

##  How to use this

This project will automatically build of Servrian and Maze by generating pseudo random strings, a shared library *libweb.so*, and running the built scripts.

### Build Randomator

Run command `make` under project's directory.

### Build to shared libraries

Run `make libs` to build *libweb.so*. If you wish to install it to your system, run `make libs-install` instead.

### Build Servrian and Maze

* To build both projects, *libweb.so* must have been installed (see the previous section). 
* Servrian and Maze must be built together, otherwise they will not share the same key and not work correctly, to buid issue `make all`  under the _Randomator_ folder.

## Requirements

This project must be placed under the same folder with Servrian and Maze. To build Randomator and the shared libraries the requirements are the following:

- Make; 
- A C compiler.

For Servrian and Maze please visit their pages.

## Current work

- Creating version information; 
- Automating the creation of encryption keys.

## To-do

There are lots of things to do, the ones in my mind now are listed below.

- Prepare for upcoming projects.

## Meta

Created by: Brian Mayer - bleemayer@gmail.com	
Inital commit: Mar, 24, 2018
Distributed under the GNU GPL v2. See ``LICENSE`` for more information.

## Contributing

Check the *contributing* file for details, but, in advance, it is pretty intuitive and straightforward.
