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
	sed "s,%PREFIX%,$(PREFIX),;s,%LIBDIR%,$(INSTALL_LIBDIR),;s,%INCLUDEDIR%,$(INSTALL_INCDIR)," rubberband.pc.in > rubberband.pc
	install -D -m644 rubberband.pc $(INSTALL_PKGDIR)/rubberband.pc
	install -D -m644 $(PUBLIC_INCLUDES) $(INSTALL_INCDIR)
	install -D -m644 $(STATIC_TARGET) $(INSTALL_LIBDIR)
	install -D -m755 $(DYNAMIC_TARGET) $(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_FULL_VERSION)
	ln -sf $(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_FULL_VERSION) $(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_ABI_VERSION)
	ln -sf $(LIBNAME)$(DYNAMIC_EXTENSION).$(DYNAMIC_FULL_VERSION) $(INSTALL_LIBDIR)/$(LIBNAME)$(DYNAMIC_EXTENSION)

clean:
	rm -f -- $(LIBRARY_OBJECTS)

distclean:	clean
	rm -f -- $(STATIC_TARGET) $(DYNAMIC_TARGET)
	rm -rf lib
