PREFIX			:= /usr/local
LIBDIR			:= $(PREFIX)/lib
INCLUDEDIR		:= $(PREFIX)/include

OPTFLAGS		:= -fPIC -g -O2 -Wall
override CFLAGS		+= $(OPTFLAGS)
override CXXFLAGS	+= $(OPTFLAGS) -DUSE_PTHREADS -DNDEBUG -I. -Isrc -Irubberband
override LDFLAGS	+= -pthread

MKDIR			:= mkdir
AR			:= ar

INSTALL_INCDIR		:= $(INCLUDEDIR)/rubberband
INSTALL_LIBDIR		:= $(LIBDIR)
INSTALL_PKGDIR		:= $(LIBDIR)/pkgconfig

LIBNAME			:= librubberband

DYNAMIC_EXTENSION	:= .so
DYNAMIC_FULL_VERSION	:= 2.1.0
DYNAMIC_ABI_VERSION	:= 2
DYNAMIC_LDFLAGS		:= -shared -Wl,-Bsymbolic -Wl,-soname=$(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_ABI_VERSION)

STATIC_TARGET  		:= lib/$(LIBNAME).a
DYNAMIC_TARGET 		:= lib/$(LIBNAME)$(DYNAMIC_EXTENSION)

all:		lib $(STATIC_TARGET) $(DYNAMIC_TARGET)

static:		lib $(STATIC_TARGET)
dynamic:	lib $(DYNAMIC_TARGET)

PUBLIC_INCLUDES := \
	rubberband/rubberband-c.h \
	rubberband/RubberBandStretcher.h

LIBRARY_SOURCES := \
	src/RubberBandStretcher.cpp \
	src/StretchCalculator.cpp \
	src/StretcherChannelData.cpp \
	src/StretcherImpl.cpp \
	src/StretcherProcess.cpp \
	src/audiocurves/CompoundAudioCurve.cpp \
	src/audiocurves/ConstantAudioCurve.cpp \
	src/audiocurves/HighFrequencyAudioCurve.cpp \
	src/audiocurves/PercussiveAudioCurve.cpp \
	src/audiocurves/SilentAudioCurve.cpp \
	src/audiocurves/SpectralDifferenceAudioCurve.cpp \
	src/dsp/AudioCurveCalculator.cpp \
	src/dsp/FFT.cpp \
	src/dsp/Resampler.cpp \
	src/kissfft/kiss_fft.c \
	src/kissfft/kiss_fftr.c \
	src/rubberband-c.cpp \
	src/speex/resample.c \
	src/system/Thread.cpp \
	src/system/sysutils.cpp

LIBRARY_OBJECTS := $(LIBRARY_SOURCES:.cpp=.o)
LIBRARY_OBJECTS := $(LIBRARY_OBJECTS:.c=.o)

$(STATIC_TARGET):	$(LIBRARY_OBJECTS)
	$(AR) rsc $@ $^

$(DYNAMIC_TARGET):	$(LIBRARY_OBJECTS)
	$(CXX) $(DYNAMIC_LDFLAGS) $^ -o $@ $(LDFLAGS)

lib:
	$(MKDIR) $@

install:	all
	$(MKDIR) -p $(DESTDIR)$(INSTALL_INCDIR)
	$(MKDIR) -p $(DESTDIR)$(INSTALL_LIBDIR)
	$(MKDIR) -p $(DESTDIR)$(INSTALL_PKGDIR)
	cp $(PUBLIC_INCLUDES) $(DESTDIR)$(INSTALL_INCDIR)
	cp $(STATIC_TARGET) $(DESTDIR)$(INSTALL_LIBDIR)
	rm -f $(DESTDIR)$(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_ABI_VERSION)
	rm -f $(DESTDIR)$(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION)
	cp $(DYNAMIC_TARGET) $(DESTDIR)$(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_FULL_VERSION)
	ln -s $(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_FULL_VERSION) $(DESTDIR)$(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_ABI_VERSION)
	ln -s $(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_FULL_VERSION) $(DESTDIR)$(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION)
	sed "s,%PREFIX%,$(PREFIX)," rubberband.pc.in \
	  > $(DESTDIR)$(INSTALL_PKGDIR)/rubberband.pc

clean:
	rm -f -- $(LIBRARY_OBJECTS)

distclean:	clean
	rm -f -- $(STATIC_TARGET) $(DYNAMIC_TARGET)
	rm -rf lib

depend:
	makedepend -Y $(LIBRARY_SOURCES)
