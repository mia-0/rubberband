
Rubber Band
===========

An audio time-stretching and pitch-shifting library.

Written by Chris Cannam, chris.cannam@breakfastquay.com.
Copyright 2007-2014 Particular Programs Ltd.

Rubber Band is a library that permits changing the tempo and pitch
of an audio recording independently of one another.

See http://breakfastquay.com/rubberband/ for more information.


Licence
=======

Rubber Band is distributed under the GNU General Public License. See
the file COPYING for more information.

If you wish to distribute code using the Rubber Band Library under
terms other than those of the GNU General Public License, you must
obtain a commercial licence from us before doing so. In particular,
you may not legally distribute through any Apple App Store unless you
have a commercial licence.  See http://breakfastquay.com/rubberband/
for licence terms.

If you have obtained a valid commercial licence, your licence
supersedes this README and the enclosed COPYING file and you may
redistribute and/or modify Rubber Band under the terms described in
that licence. Please refer to your licence agreement for more details.

Note that Rubber Band may link with other GPL libraries or with
proprietary libraries, depending on its build configuration. See the
section "FFT and resampler selection" below. It is your responsibility
to ensure that you redistribute only in accordance with the licence
terms of any other libraries you may build with.


Contents of this README
-----------------------

1. Using the Rubber Band Library
2. Compiling Rubber Band
   a. Other supported #defines
3. Copyright notes for bundled libraries


1. Using the Rubber Band library
--------------------------------

The Rubber Band library has a public API that consists of one C++
class, called RubberBandStretcher in the RubberBand namespace.  You
should #include <rubberband/RubberBandStretcher.h> to use this class.
There is extensive documentation in the class header.

A header with C language bindings is also provided in
<rubberband/rubberband-c.h>.  This is a wrapper around the C++
implementation, and as the implementation is the same, it also
requires linkage against the C++ standard libraries.  It is not yet
documented separately from the C++ header.  You should include only
one of the two headers, not both.

IMPORTANT: Please ensure you have read and understood the licensing
terms for Rubber Band before using it in your application.  This
library is provided under the GNU General Public License, which means
that any application that uses it must also be published under the GPL
or a compatible licence (i.e. with its full source code also available
for modification and redistribution) unless you have separately
acquired a commercial licence from the author.


2. Compiling Rubber Band
------------------------

Just run GNU make. Works with GCC and compatible compilers.

The Make variables PREFIX, LIBDIR, INCLUDEDIR can be used to set the
install locations for 'make install'.

2a. Other supported #defines
----------------------------

Other symbols you may define at compile time are as follows. (Usually
the supplied build files will handle these for you.)

   -DUSE_PTHREADS
   Use the pthreads library (required unless on Windows)

   -DPROCESS_SAMPLE_TYPE=double
   Select double precision for internal calculations. The default is
   single precision.

3. Copyright notes for bundled libraries
========================================

3a. Speex
---------

[files in src/speex]

Copyright 2002-2007 	Xiph.org Foundation
Copyright 2002-2007 	Jean-Marc Valin
Copyright 2005-2007	Analog Devices Inc.
Copyright 2005-2007	Commonwealth Scientific and Industrial Research
                        Organisation (CSIRO)
Copyright 1993, 2002, 2006 David Rowe
Copyright 2003 		EpicGames
Copyright 1992-1994	Jutta Degener, Carsten Bormann

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

- Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

- Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

- Neither the name of the Xiph.org Foundation nor the names of its
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


3b. KissFFT
-----------

[files in src/kissfft]

Copyright (c) 2003-2004 Mark Borgerding

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the author nor the names of any contributors may be used
      to endorse or promote products derived from this software
      without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

