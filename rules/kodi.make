# -*-makefile-*-
#
# Copyright (C) 2012 by fga
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KODI) += kodi

ifdef PTXCONF_KODI
ifeq ($(shell dpkg -l | grep libsdl-image | grep dev 2>/dev/null),)
     $(warning *** libsdl-image1.2-dev | SDL_image-devel or above is mandatory to build kodi)
     $(warning *** please install libsdl-image1.2-dev on HOST)
#    $(error )
endif
ifdef PTXCONF_KODI_GIT_SOURCE_MASTER
ifeq ($(shell which swig 2>/dev/null),)
    $(warning *** which is mandatory to build kodi)
    $(warning *** please install which)
    $(error )
endif
endif
endif

#
# Paths and names
#
KODI_VERSION	:= 15.2
KODI_MD5	:= c2fc432da92df09ca827d39e32167880
KODI		:= $(KODI_VERSION)-Isengard
KODI_SUFFIX	:= tar.gz
KODI_URL	:= https://github.com/xbmc/xbmc/archive/$(KODI).$(KODI_SUFFIX) \
	http://mirrors.kodi.tv/releases/source/$(KODI).$(KODI_SUFFIX)
KODI_SOURCE	:= $(SRCDIR)/$(KODI).$(KODI_SUFFIX)
KODI_DIR	:= $(BUILDDIR)/$(KODI)
KODI_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(KODI_SOURCE):
	@$(call targetinfo)
	@$(call get, KODI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_ARM
ifdef PTXCONF_RASPBERY_PI
KODI_CFLAGS	+= -Wno-psabi -D__ARM_NEON__ -mcpu=arm1176jzf-s -mtune=arm1176jzf-s -mfloat-abi=hard -mfpu=vfp -mabi=aapcs-linux -Wno-psabi
else
KODI_CFLAGS	+= -march=armv7-a -mtune=cortex-a17 -mfloat-abi=hard -mfpu=vfpv3-d16 -lc -lgcc_s -lstdc++
endif
endif

ifdef PTXCONF_ARCH_ARM64
KODI_CFLAGS	= -march=armv8-a -mtune=cortex-a53 -Wno-attributes -Wno-unused-variable -Wno-int-to-pointer-cast -fpermissive
endif

KODI_ENV	:= $(CROSS_ENV) CFLAGS="$(KODI_CFLAGS) -pipe -O3 -Wno-deprecated-declarations -fomit-frame-pointer -Wno-sign-compare" CPPFLAGS="$(KODI_CFLAGS)" CXXFLAGS="$(KODI_CFLAGS)" PYTHON_VERSION="2.7" \
	LDFLAGS+="-L$(SYSROOT)/usr/lib/python2.7/lib -L$(SYSROOT)/usr/lib -shared -lc -lgcc_s -lstdc++" \
	CEC_CFLAGS="-I$(SYSROOT)/usr/include/libcec" \
	CEC_LIBS="-L$(SYSROOT)/usr/lib"  \
	TINYXML_CFLAGS="-I$(SYSROOT)/usr/include" \
        TINYXML_LIBS="-L$(SYSROOT)/usr/lib" \
	SQUISH_CFLAGS="-I$(SYSROOT)/usr/include" \
        SQUISH_LIBS="-L$(SYSROOT)/usr/lib" \
	ac_cv_search_iconv_open=-L$(SYSROOT)/usr/lib \
	ac_cv_lib_jasper_main=yes \
	ac_cv_lib_microhttpd_main=yes \
	ac_cv_lib_ssh_sftp_tell64=yes
	
KODI_PATH	:= PATH=$(CROSS_PATH):$(SYSROOT)/usr/bin
KODI_TOOLCHAIN	:= $(PTXDIST_WORKSPACE)/selected_toolchain

#
# autoconf
#
KODI_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--with-ffmpeg=shared \
	--disable-joystick \
	--disable-openmax \
	--disable-projectm \
	--disable-pulse \
	--disable-ssh \
	--disable-vdpau \
	--disable-vtbdecoder \
	--enable-optimizations

ifeq ($(MYSQL),y)
KODI_CONF_OPT += --enable-mysql
KODI_CONF_ENV += ac_cv_path_MYSQL_CONFIG="$(SYSROOT)/usr/bin/mysql_config"
else
KODI_CONF_OPT += --disable-mysql
endif

ifeq ($(RPI_USERLAND),y)
KODI_CONF_OPT += --with-platform=raspberry-pi --enable-player=omxplayer
KODI_CONF_ENV += INCLUDES="-I$(SYSROOT)/usr/include/interface/vcos/pthreads \
	-I$(SYSROOT)/usr/include/interface/vmcs_host/linux" \
	LIBS="-lvcos -lvchostif"
endif

ifeq ($(LIBFSLVPUWRAP),y)
KODI_CONF_OPT += --enable-codec=imxvpu
endif

ifeq ($(LIBCAP),y)
KODI_CONF_OPT += --enable-libcap
else
KODI_CONF_OPT += --disable-libcap
endif

ifeq ($(KODI_DBUS),y)
KODI_CONF_OPT += --enable-dbus
else
KODI_CONF_OPT += --disable-dbus
endif

ifeq ($(KODI_ALSA_LIB),y)
KODI_CONF_OPT += --enable-alsa
else
KODI_CONF_OPT += --disable-alsa
endif

KODI_CONF_OPT += --enable-gles

ifeq ($(KODI_GOOM),y)
KODI_CONF_OPT += --enable-goom
else
KODI_CONF_OPT += --disable-goom
endif

ifeq ($(KODI_LIBUSB),y)
KODI_CONF_OPT += --enable-libusb
else
KODI_CONF_OPT += --disable-libusb
endif

ifeq ($(KODI_LIBMICROHTTPD),y)
KODI_CONF_OPT += --enable-webserver
else
KODI_CONF_OPT += --disable-webserver
endif

ifeq ($(KODI_LIBSMBCLIENT),y)
KODI_CONF_OPT += --enable-samba
else
KODI_CONF_OPT += --disable-samba
endif

ifeq ($(KODI_LIBNFS),y)
KODI_CONF_OPT += --enable-nfs
else
KODI_CONF_OPT += --disable-nfs
endif

ifeq ($(KODI_RTMPDUMP),y)
KODI_CONF_OPT += --enable-rtmp
else
KODI_CONF_OPT += --disable-rtmp
endif

ifeq ($(KODI_LIBBLURAY),y)
KODI_CONF_OPT += --enable-libbluray
else
KODI_CONF_OPT += --disable-libbluray
endif

ifeq ($(KODI_LIBSHAIRPLAY),y)
KODI_CONF_OPT += --enable-airplay
else
KODI_CONF_OPT += --disable-airplay
endif

ifeq ($(KODI_AVAHI),y)
KODI_CONF_OPT += --enable-avahi
else
KODI_CONF_OPT += --disable-avahi
endif

ifeq ($(KODI_LIBCEC),y)
KODI_CONF_OPT += --enable-libcec
else
KODI_CONF_OPT += --disable-libcec
endif

# kodi needs libva & libva-glx
ifeq ($(KODI_LIBVA)$(MESA3D_DRI_DRIVER),yy)
KODI_CONF_OPT += --enable-vaapi
else
KODI_CONF_OPT += --disable-vaapi
endif

ifeq ($(KODI_OPTICALDRIVE),y)
KODI_CONF_OPT += --enable-optical-drive --enable-dvdcss
else
KODI_CONF_OPT += --disable-optical-drive --disable-dvdcss
endif


$(STATEDIR)/kodi.prepare:
	@$(call targetinfo)
	@$(call clean, $(KODI_DIR)/config.cache)
	sed -e "s|libcpluff.a|libcpluff.so|g" -i $(KODI_DIR)/Makefile.in
	cd $(KODI_DIR) && ./bootstrap
	cd $(KODI_DIR) && \
		$(KODI_PATH) $(KODI_ENV) \
		./bootstrap
	cd $(KODI_DIR) && \
		$(KODI_PATH) $(KODI_ENV) \
		./configure $(KODI_CONF_OPT)
#	cd $(KODI_DIR) && \
#		sed -i 's/-msse2//' lib/libsquish/Makefile
#	cd $(KODI_DIR) && \
#		sed -i 's/-DSQUISH_USE_SSE=2//' lib/libsquish/Makefile
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kodi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, kodi)
	@$(call install_fixup, kodi,PRIORITY,optional)
	@$(call install_fixup, kodi,SECTION,base)
	@$(call install_fixup, kodi,AUTHOR,"fga")
	@$(call install_fixup, kodi,DESCRIPTION,missing)

	@$(call install_copy, kodi, 0, 0, 0755, -, /usr/bin/kodi)
	@$(call install_copy, kodi, 0, 0, 0755, -, /usr/bin/kodi-standalone)

	@cd $(KODI_PKGDIR)/usr/lib/kodi && \
	find . -type f | while read file; do \
		$(call install_copy, kodi, 0, 0, 755, \
		$(KODI_PKGDIR)/usr/lib/kodi/$$file, \
			/usr/lib/kodi/$$file); \
	done

	@cd $(KODI_PKGDIR)/usr/share/icons && \
	find . -type f | while read file; do \
		$(call install_copy, kodi, 0, 0, 644, \
		$(KODI_PKGDIR)/usr/share/icons/$$file, \
			/usr/share/icons/$$file); \
	done

	@cd $(KODI_PKGDIR)/usr/share/kodi && \
	find . -type f | while read file; do \
		$(call install_copy, kodi, 0, 0, 644, \
		$(KODI_PKGDIR)/usr/share/kodi/$$file, \
			/usr/share/kodi/$$file); \
	done

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_KODI_STARTSCRIPT
	@$(call install_alternative, kodi, 0, 0, 0755, /etc/init.d/kodi)

ifneq ($(call remove_quotes,$(PTXCONF_KODI_BBINIT_STARTLINK)),)
	@$(call install_link, kodi, \
		../init.d/kodi, \
		/etc/rc.d/$(PTXCONF_KODI_BBINIT_STARTLINK))
endif
ifneq ($(call remove_quotes,$(PTXCONF_KODI_BBINIT_STOPLINK)),)
	@$(call install_link, kodi, \
		../init.d/kodi, \
		/etc/rc.d/$(PTXCONF_KODI_BBINIT_STOPLINK))
endif
endif
endif

	@$(call install_finish, kodi)

	@$(call touch)

# vim: syntax=make
