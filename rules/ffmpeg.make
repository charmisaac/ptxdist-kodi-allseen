# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
#
#
# We provide this package
#
PACKAGES-$(PTXCONF_FFMPEG) += ffmpeg

#
# Paths and names
#
FFMPEG_VERSION	:= 2.8.3
FFMPEG_MD5	:= 2af2723dd53364ac0635efd20cf6e34e
FFMPEG		:= ffmpeg-$(FFMPEG_VERSION)
FFMPEG_SUFFIX	:= tar.xz
FFMPEG_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FFMPEG).$(FFMPEG_SUFFIX) \
	https://www.ffmpeg.org/releases/$(FFMPEG).$(FFMPEG_SUFFIX)
FFMPEG_SOURCE	:= $(SRCDIR)/$(FFMPEG).$(FFMPEG_SUFFIX)
FFMPEG_DIR	:= $(BUILDDIR)/$(FFMPEG)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FFMPEG_PATH	:= PATH=$(CROSS_PATH)
FFMPEG_CONF_ENV	:= $(CROSS_ENV) \
	CFLAGS="-isystem $(PTXDIST_SYSROOT_TOOLCHAIN)/usr/include" \
	ASFLAGS="-isystem $(PTXDIST_SYSROOT_TOOLCHAIN)/usr/include"

#
# autoconf
# Carefull, ffmpeg has a home grown configure, and not all autoconf options work!!! :-/
# for example it enables things by default and than only has a --disable-BLA option and no
# --enable-BLA option.
#
FFMPEG_CONF_OPT	:= \
	--prefix=/usr \
	--enable-cross-compile \
	--cross-prefix=$(COMPILE_PREFIX) \
	--host-cc=gcc \
	--arch=$(PTXCONF_ARCH_STRING) \
	--cpu="cortex-a53" \
	--target-os=linux \
	--cc=$(PTXDIST_SYSROOT_TOOLCHAIN)/../bin/$(COMPILER_PREFIX)gcc \
	--cxx=$(PTXDIST_SYSROOT_TOOLCHAIN)/../bin/$(COMPILER_PREFIX)g++ \
	--as=$(PTXDIST_SYSROOT_TOOLCHAIN)/../bin/$(COMPILER_PREFIX)as \
	--ld=$(PTXDIST_SYSROOT_TOOLCHAIN)/../bin/$(COMPILER_PREFIX)gcc \
	--ar=$(PTXDIST_SYSROOT_TOOLCHAIN)/../bin/$(COMPILER_PREFIX)ar \
	--nm=$(PTXDIST_SYSROOT_TOOLCHAIN)/../bin/$(COMPILER_PREFIX)nm \
	--ranlib=$(PTXDIST_SYSROOT_TOOLCHAIN)/../bin/$(COMPILER_PREFIX)ranlib \
	--extra-cflags="-I$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/include $(PTXDIST_CROSS_CPPFLAGS)" \
	--extra-ldflags="-L$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib $(PTXDIST_CROSS_LDFLAGS)" \
	--extra-libs="-L$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib -lgcc -ldl -lz -lm -lc -lstdc++" \
	--pkgconfigdir=$(PKG_CONFIG_LIBDIR) \
	--enable-pthreads \
	--enable-shared \
	--disable-stripping \
	--disable-yasm \
	--disable-asm \
	--disable-doc

ifdef PTXCONF_FFMPEG_GPL
FFMPEG_CONF_OPT += --enable-gpl
else
FFMPEG_CONF_OPT += --disable-gpl
endif

ifdef PTXCONF_FFMPEG_NONFREE
FFMPEG_CONF_OPT += --enable-nonfree
else
FFMPEG_CONF_OPT += --disable-nonfree
endif

ifdef PTXCONF_FFMPEG_FFMPEG
FFMPEG_CONF_OPT += --enable-ffmpeg
else
FFMPEG_CONF_OPT += --disable-ffmpeg
endif

ifdef PTXCONF_FFMPEG_FFPLAY
FFMPEG_CONF_OPT += --enable-ffplay
FFMPEG_CONF_ENV += SDL_CONFIG=$(SYSROOT)/usr/bin/sdl-config
else
FFMPEG_CONF_OPT += --disable-ffplay
endif

ifdef PTXCONF_FFMPEG_FFSERVER
FFMPEG_CONF_OPT += --enable-ffserver
else
FFMPEG_CONF_OPT += --disable-ffserver
endif

ifdef PTXCONF_FFMPEG_AVRESAMPLE
FFMPEG_CONF_OPT += --enable-avresample
else
FFMPEG_CONF_OPT += --disable-avresample
endif

ifdef PTXCONF_FFMPEG_FFPROBE
FFMPEG_CONF_OPT += --enable-ffprobe
else
FFMPEG_CONF_OPT += --disable-ffprobe
endif

ifdef PTXCONF_FFMPEG_POSTPROC
FFMPEG_CONF_OPT += --enable-postproc
else
FFMPEG_CONF_OPT += --disable-postproc
endif

ifdef PTXCONF_FFMPEG_SWSCALE
FFMPEG_CONF_OPT += --enable-swscale
else
FFMPEG_CONF_OPT += --disable-swscale
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_ENCODERS)),all)
FFMPEG_CONF_OPT += --disable-encoders \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_DECODERS)),all)
FFMPEG_CONF_OPT += --disable-decoders \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_MUXERS)),all)
FFMPEG_CONF_OPT += --disable-muxers \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_DEMUXERS)),all)
FFMPEG_CONF_OPT += --disable-demuxers \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_PARSERS)),all)
FFMPEG_CONF_OPT += --disable-parsers \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_BSFS)),all)
FFMPEG_CONF_OPT += --disable-bsfs \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_BSFS)),--enable-bsfs=$(x))
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_PROTOCOLS)),all)
FFMPEG_CONF_OPT += --disable-protocols \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(PTXCONF_FFMPEG_FILTERS)),all)
FFMPEG_CONF_OPT += --disable-filters \
	$(foreach x,$(call qstrip,$(PTXCONF_FFMPEG_FILTERS)),--enable-filter=$(x))
endif

ifdef PTXCONF_FFMPEG_INDEVS
FFMPEG_CONF_OPT += --enable-indevs
else
FFMPEG_CONF_OPT += --disable-indevs
endif

ifdef PTXCONF_FFMPEG_OUTDEVS
FFMPEG_CONF_OPT += --enable-outdevs
else
FFMPEG_CONF_OPT += --disable-outdevs
endif

ifdef PTXCONF_GLIBC_PTHREAD
FFMPEG_CONF_OPT += --enable-pthreads
else
FFMPEG_CONF_OPT += --disable-pthreads
endif

ifdef PTXCONF_ZLIB
FFMPEG_CONF_OPT += --enable-zlib
else
FFMPEG_CONF_OPT += --disable-zlib
endif

ifdef PTXCONF_BZIP2
FFMPEG_CONF_OPT += --enable-bzlib
else
FFMPEG_CONF_OPT += --disable-bzlib
endif

ifdef PTXCONF_OPENSSL
# openssl isn't license compatible with GPL
ifdef PTXCONF_FFMPEG_GPL
FFMPEG_CONF_OPT += --disable-openssl
else
FFMPEG_CONF_OPT += --enable-openssl
endif
else
FFMPEG_CONF_OPT += --disable-openssl
endif

ifdef PTXCONF_LIBVORBIS
FFMPEG_CONF_OPT += \
	--enable-libvorbis \
	--enable-muxer=ogg \
	--enable-encoder=libvorbis
endif

ifdef PTXCONF_LIBVA
FFMPEG_CONF_OPT += --enable-vaapi
else
FFMPEG_CONF_OPT += --disable-vaapi
endif

ifdef PTXCONF_OPUS
FFMPEG_CONF_OPT += --enable-libopus
else
FFMPEG_CONF_OPT += --disable-libopus
endif

ifdef PTXCONF_LIBVPX
FFMPEG_CONF_OPT += --enable-libvpx
else
FFMPEG_CONF_OPT += --disable-libvpx
endif

# ffmpeg freetype support require fenv.h which is only
# available/working on glibc.
# The microblaze variant doesn't provide the needed exceptions
ifdef PTXCONF_FREETYPE
FFMPEG_CONF_OPT += --enable-libfreetype
endif

ifdef PTXCONF_FONTCONFIG
FFMPEG_CONF_OPT += --enable-fontconfig
endif

ifdef PTXCONF_POWERPC_CPU_HAS_ALTIVEC
FFMPEG_CONF_OPT += --enable-altivec
else
FFMPEG_CONF_OPT += --disable-altivec
endif

ifeq ($(PTXCONF_X264)$(PTXCONF_FFMPEG_GPL),yy)
FFMPEG_CONF_OPT += --enable-libx264
else
FFMPEG_CONF_OPT += --disable-libx264
endif

ifeq ($(PTXCONF_X265)$(PTXCONF_FFMPEG_GPL),yy)
FFMPEG_CONF_OPT += --enable-libx265
else
FFMPEG_CONF_OPT += --disable-libx265
endif

FFMPEG_CONF_OPT += --enable-pic

FFMPEG_CONF_OPT += $(call qstrip,$(PTXCONF_FFMPEG_EXTRACONF))


$(STATEDIR)/ffmpeg.prepare:
	@$(call targetinfo)
	cd $(FFMPEG_DIR) && \
		$(FFMPEG_PATH) $(FFMPEG_CONF_ENV) \
		./configure $(FFMPEG_CONF_OPT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ffmpeg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ffmpeg)
	@$(call install_fixup, ffmpeg,PRIORITY,optional)
	@$(call install_fixup, ffmpeg,SECTION,base)
	@$(call install_fixup, ffmpeg,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, ffmpeg,DESCRIPTION,missing)

ifdef PTXCONF_FFMPEG_FFMPEG
	@$(call install_copy, ffmpeg, 0, 0, 0755, -, /usr/bin/ffmpeg)
endif
ifdef PTXCONF_FFMPEG_FFPROBE
	@$(call install_copy, ffmpeg, 0, 0, 0755, -, /usr/bin/ffprobe)
endif
ifdef PTXCONF_FFMPEG_FFPLAY
	@$(call install_copy, ffmpeg, 0, 0, 0755, -, /usr/bin/ffplay)
endif
ifdef PTXCONF_FFMPEG_FFSERVER
	@$(call install_copy, ffmpeg, 0, 0, 0755, -, /usr/bin/ffserver)
endif

	@$(call install_lib, ffmpeg, 0, 0, 0644, libavcodec)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavdevice)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavformat)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavfilter)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavresample)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libavutil)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libpostproc)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libswresample)
	@$(call install_lib, ffmpeg, 0, 0, 0644, libswscale)

	@$(call install_finish, ffmpeg)

	@$(call touch)

# vim: syntax=make
