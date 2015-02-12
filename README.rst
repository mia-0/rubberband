
Rubber Band
===========

An audio time-stretching and pitch-shifting library.

Written by Chris Cannam, chris.cannam@breakfastquay.com.

Copyright 2007-2014 Particular Programs Ltd.

Rubber Band is a library that permits changing the tempo and pitch of an audio
recording independently of one another.

See http://breakfastquay.com/rubberband/ for more information.

--------------------------------------------------------------------------------

Using the Rubber Band library
-----------------------------

The Rubber Band library has a public API that consists of one C++ class,
called `RubberBandStretcher` in the `RubberBand` namespace.  You should
`#include <rubberband/RubberBandStretcher.h>` to use this class.
There is extensive documentation in the class header.

A header with C language bindings is also provided in
`<rubberband/rubberband-c.h>`.  This is a wrapper around the C++
implementation, and as the implementation is the same, it also requires
linkage against the C++ standard libraries.  It is not yet documented
separately from the C++ header.  You should include only one of the two
headers, not both.


Compiling Rubber Band
---------------------

Just run GNU make. Works with GCC and compatible compilers.

The Make variables PREFIX, LIBDIR, INCLUDEDIR can be used to set the install
locations for 'make install'.

The default 'all' target builds both a static and a dynamic library.
Use the 'static' and 'dynamic' targets if you wish to build only one of them.
