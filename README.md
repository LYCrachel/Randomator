# Randomator
> A builder and pseudo random string generator for Servrian and Maze. I plan to make it transparent and safe to generate a key, insert it in the code and build the project, so no one can ever see the key used.

##  How to use this

This piece of code is meant to automate the build of Servrian and Maze, two projects of mine, by generating pseudo random strings, a shared library, libweb.so, and running build scripts.

### Build Randomator

To buid this project is enough to enter its folder and issue `make`.

### Build to shared libraries

This will build libweb.so, just run `make libs`. If you with to install it to your system, so you don't need to mess with search paths run `make libs-install`.

### Build Servrian and Maze

To build both projects libweb.so must exist in the system, if you didn't build it see the previous section. Servrian and Maze must be built together, otherwise they won't share the same key and won't work correctly, to buid enter the _Randomator_ folder and issue `make all`.

## Requirements

This project must be placed together with Servrian and Maze, under the same folder. To build Randomator and the shared libraries the requirements are the following:

- Make; &
- A C compiler.

For Servrian and Maze please visit their pages.

## Current work

- Creating version information; &
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
