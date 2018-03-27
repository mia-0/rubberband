PREFIX			:= /usr/local
LIBDIR			:= $(PREFIX)/lib
INCLUDEDIR		:= $(PREFIX)/include

OPTFLAGS		:= -fPIC -g -O3 -Wall
override CFLAGS		:= $(OPTFLAGS) $(CFLAGS)
override CXXFLAGS	:= $(OPTFLAGS) -DUSE_PTHREADS -DNDEBUG -I. -Isrc -Irubberband $(CXXFLAGS)
override LDFLAGS	:= -pthread $(LDFLAGS)

MKDIR			:= mkdir
AR			:= ar

INSTALL_INCDIR		:= $(INCLUDEDIR)/rubberband
INSTALL_LIBDIR		:= $(LIBDIR)
INSTALL_PKGDIR		:= $(LIBDIR)/pkgconfig

LIBNAME			:= librubberband

DYNAMIC_EXTENSION	:= .so
DYNAMIC_FULL_VERSION	:= 2.1.0
DYNAMIC_ABI_VERSION	:= 2
DYNAMIC_NAME		:= $(LIBNAME)$(DYNAMIC_EXTENSION)
DYNAMIC_FULL_NAME	:= $(DYNAMIC_NAME).$(DYNAMIC_FULL_VERSION)
DYNAMIC_LDFLAGS		:= -shared -Wl,-Bsymbolic -Wl,-soname=$(DYNAMIC_NAME).$(DYNAMIC_ABI_VERSION)

STATIC_NAME		:= $(LIBNAME).a
STATIC_TARGET		:= lib/$(STATIC_NAME)
DYNAMIC_TARGET		:= lib/$(DYNAMIC_NAME)

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

all: static dynamic

$(STATIC_TARGET): $(LIBRARY_OBJECTS)
	$(AR) rsc $@ $^

$(DYNAMIC_TARGET): $(LIBRARY_OBJECTS)
	$(CXX) $(DYNAMIC_LDFLAGS) $^ -o $@ $(LDFLAGS)

lib:
	$(MKDIR) $@

static: lib $(STATIC_TARGET)
dynamic:lib $(DYNAMIC_TARGET)

install-headers:
	sed "s,%PREFIX%,$(PREFIX),;s,%LIBDIR%,$(INSTALL_LIBDIR),;s,%INCLUDEDIR%,$(INSTALL_INCDIR)," rubberband.pc.in > rubberband.pc
	install -d $(DESTDIR)$(INSTALL_PKGDIR)
	install -d $(DESTDIR)$(INSTALL_INCDIR)
	install -m 644 rubberband.pc $(DESTDIR)$(INSTALL_PKGDIR)/rubberband.pc
	install -m 644 $(PUBLIC_INCLUDES) $(DESTDIR)$(INSTALL_INCDIR)

install-static: static install-headers
	install -d $(DESTDIR)$(INSTALL_LIBDIR)
	install -m644 $(STATIC_TARGET) $(DESTDIR)$(INSTALL_LIBDIR)

install-dynamic: dynamic install-headers
	install -d $(DESTDIR)$(INSTALL_LIBDIR)
	install -m 755 $(DYNAMIC_TARGET) $(DESTDIR)$(INSTALL_LIBDIR)/$(DYNAMIC_FULL_NAME)
	ln -sf $(DYNAMIC_FULL_NAME) $(DESTDIR)$(INSTALL_LIBDIR)/$(DYNAMIC_NAME).$(DYNAMIC_ABI_VERSION)
	ln -sf $(DYNAMIC_FULL_NAME) $(DESTDIR)$(INSTALL_LIBDIR)/$(DYNAMIC_NAME)

install: all install-static install-dynamic

uninstall:
	rm -f -- $(DESTDIR)$(INSTALL_PKGDIR)/rubberband.pc
	rm -f -- $(DESTDIR)$(INSTALL_LIBDIR)/$(STATIC_NAME)
	rm -f -- $(DESTDIR)$(INSTALL_LIBDIR)/$(DYNAMIC_FULL_NAME) $(DESTDIR)$(INSTALL_LIBDIR)/$(DYNAMIC_NAME).$(DYNAMIC_ABI_VERSION) $(DYNAMIC_FULL_NAME) $(DESTDIR)$(INSTALL_LIBDIR)/$(DYNAMIC_NAME)
	rm -rf -- $(DESTDIR)$(INSTALL_INCDIR)

clean:
	rm -f -- $(LIBRARY_OBJECTS)

distclean:	clean
	rm -f -- $(STATIC_TARGET) $(DYNAMIC_TARGET)
	rm -rf lib

.PHONY: clean install-headers
