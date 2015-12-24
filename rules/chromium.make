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
PACKAGES-$(PTXCONF_CHROMIUM) += chromium

#
# Paths and names
#
CHROMIUM_VERSION	:= 49.0.2588.7
CHROMIUM_MD5		:= 5a53ab1bb782bd3b88c976f8075ffd20
CHROMIUM		:= chromium-$(CHROMIUM_VERSION)
CHROMIUM_SUFFIX		:= tar.gz
CHROMIUM_SOURCE		:= $(SRCDIR)/$(CHROMIUM).$(CHROMIUM_SUFFIX)
CHROMIUM_DIR		:= $(BUILDDIR)/$(CHROMIUM)
CHROMIUM_LICENSE	:= MIT
CHROMIUM_URL            := https://chromium.googlesource.com/chromium/src.git/+archive/$(CHROMIUM_VERSION).$(CHROMIUM_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(CHROMIUM_SOURCE):
#	@$(call targetinfo)
#	mkdir -p $(CHROMIUM_DIR)
#	cd $(CHROMIUM_DIR) && \
#		gclient config https://src.chromium.org/chrome/releases/$(CHROMIUM_VERSION) && \
#		gclient sync --nohooks
#	sync
#	cd $(BUILDDIR) && \
#		tar zcvf $(SRCDIR)/$(CHROMIUM).$(CHROMIUM_SUFFIX) $(CHROMIUM)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/chromium.extract:
	@$(call targetinfo)
	mkdir -p $(CHROMIUM_DIR)/src
	tar zxvf $(CHROMIUM_SOURCE) -C $(CHROMIUM_DIR)/src
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CHROMIUM_PATH	:= PATH=$(CHROMIUM_DIR)/depot_tools:$(CROSS_PATH):${PTXDIST_SYSROOT_TOOLCHAIN}/../bin:${PTXDIST_SYSROOT_TOOLCHAIN}/usr/lib
	
CHROMIUM_ENV	:= $(CROSS_ENV) \
	CROSSTOOL=${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CC} \
	GYP_CROSSCOMPILE=1 \
	GYP_GENERATORS="ninja" \
	GYP_DEFINES="target_arch=arm arm_float_abi=hard arm_neon=1 OS=linux sysroot=$(SYSROOT) component=shared_library chromeos=0 clang=0 disable_fatal_linker_warnings=1 hoat_arch=ia32 use_system_bzip2=1 use_system_flac=1 use_system_harfbuzz=1 use_system_jsoncpp=1 use_system_libevent=1 use_system_libexif=1 use_system_libjpeg=1 use_system_libpng=1 use_system_libusb=1 use_system_libwebp=1 use_system_libxml=1 use_system_libxslt=1 use_system_nspr=1 use_system_protobuf=0 use_system_ffmpeg=1 use_system_re2=1 use_system_snappy=1 use_system_speex=1 use_system_xdg_utils=1" \
	LIBRARY_PATH=$(PTXDIST_SYSROOT_TOOLCHAIN)/lib:$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib:$(SYSROOT)/usr/lib:$(LIBRARY_PATH) \
	SYSROOT="${SYSROOT}" \
	cc_host=gcc cxx_host=g++ \
	CFLAGS="-I$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/include -I$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/include/asm-generic -I$(SYSROOT)/usr/include -I$(CHROMIUM_DIR)/src/arm-sysroot/usr/include -L$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib -L$(PTXDIST_SYSROOT_TOOLCHAIN)/lib" \
	CXXFLAGS="-I$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/include -I$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/include/asm-generic -I$(SYSROOT)/usr/include -I$(CHROMIUM_DIR)/src/arm-sysroot/usr/include -L$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib -L$(PTXDIST_SYSROOT_TOOLCHAIN)/lib" \
	LDFLAGS="-L$(PTXDIST_SYSROOT_TOOLCHAIN)/lib -L$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib -L$(SYSROOT)/usr/lib"

$(STATEDIR)/chromium.prepare:
	@$(call targetinfo)
	@$(call clean, $(CHROMIUM_DIR)/config.cache)
	[ -d /usr/local/share/fonts ] || sudo mkdir -p /usr/local/share/fonts
	if [ $(shell lsb_release --i --short) == Fedora ]; then \
	sed -e "s|apt-get|dnf|g" -e "s|precise|TwentyThree|g" \
		-e "s|apt-cache pkgnames|dnf list available|g" \
		-e "s|apt-cache show|dnf dnf repoquery --requires|g" \
		-e "s|apt-cache depends|dnf repoquery --requires|g" \
		-e "s|--important||g" -e "s|libgl1-mesa-glx-lts-|mesa-lib|g" \
		-e "s|libc6-dev-armhf-cross|arm-linux-gnueabihf|g" \
		-i $(CHROMIUM_DIR)/src/build/install-build-deps.sh; \
	fi
	sed -e "s|gdk-2|gdk-3|g" -e "s|gtk+-2|gtk+-3|g" \
		-e "s|gtk+-unix-print-2|gtk+-unix-print-3|g" \
		-e "s|gtk+-x11-2|gtk+-x11-3|g" \
		-i $(CHROMIUM_DIR)/src/build/linux/system.gyp
	cd $(CHROMIUM_DIR)/src && \
		$(CHROMIUM_PATH) $(CHROMIUM_ENV) \
		./build/install-build-deps.sh --no-nacl
#	cd $(CHROMIUM_DIR) && \
		$(CHROMIUM_PATH) $(CHROMIUM_ENV) \
		gclient runhooks
#	cd $(CHROMIUM_DIR)/src && \
		$(CHROMIUM_PATH) $(CHROMIUM_ENV) \
		./build/gyp_chromium --depth=. -G out
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/chromium.compile:
	@$(call targetinfo)
	cd $(CHROMIUM_DIR)/src/out/Release && \
	for NINJA in `find . -name "*.ninja" -type f`; do \
		sed "s|BSD_SOURCE|DEFAULT_SOURCE|g" -i $(CHROMIUM_DIR)/src/out/Release/$$NINJA; \
	done
	cd $(CHROMIUM_DIR)/src && \
		$(CHROMIUM_PATH) $(CHROMIUM_ENV) \
		ninja -C out/Release chrome -j1
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/chromium.install:
	@$(call targetinfo)
#	@$(call world/install, CHROMIUM)
	cp $(CHROMIUM_DIR)/src/out/Relese/bin/chrome $(CHROMIUM_PKGDIR)/usr/local/bin/chrome
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/chromium.targetinstall:
	@$(call targetinfo)

	@$(call install_init, chromium)
	@$(call install_fixup, chromium,PRIORITY,optional)
	@$(call install_fixup, chromium,SECTION,base)
	@$(call install_fixup, chromium,AUTHOR,"fga")
	@$(call install_fixup, chromium,DESCRIPTION,missing)

	@$(call install_copy, chromium, 0, 0, 0755, -, /usr/local/bin/chrome)

	@$(call install_finish, chromium)

	@$(call touch)

# vim: syntax=make
