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
PACKAGES-$(PTXCONF_LIBVPX) += libvpx

#
# Paths and names
#
LIBVPX_VERSION	:= 1.5.0
LIBVPX_MD5	:= 49e59dd184caa255886683facea56fca
LIBVPX		:= libvpx-$(LIBVPX_VERSION)
LIBVPX_SUFFIX	:= tar.bz2
LIBVPX_URL	:=  http://downloads.webmproject.org/releases/webm/$(LIBVPX).$(LIBVPX_SUFFIX)
LIBVPX_SOURCE	:= $(SRCDIR)/$(LIBVPX).$(LIBVPX_SUFFIX)
LIBVPX_DIR	:= $(BUILDDIR)/$(LIBVPX)
LIBVPX_SUBDIR	:= build-dir
LIBVPX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(LIBVPX_SOURCE):
#	@$(call targetinfo)
#	@$(call get, LIBVPX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBVPX_PATH	:= PATH=$(CROSS_PATH)
LIBVPX_ENV	:= $(CROSS_ENV) \
	CROSS=$(COMPILER_PREFIX) \
	CC_host=gcc CXX_host=g++ \
	CFLAGS+=-fPIC \
	TGT_ISA=$(PTXCONF_ARCH_STRING) \
	SRC_PATH_BARE=$(LIBVPX_DIR)

#
# autoconf
#
LIBVPX_CONF_OPT	:= \
	--prefix=/usr \
	--target=$(COMPILER_PREFIX)gcc \
	--enable-shared \
	--enable-vp8 \
	--enable-vp9 \
	--disable-runtime-cpu-detect \
	--disable-examples --disable-ssse3 --disable-multithread

$(STATEDIR)/libvpx.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBVPX_DIR)/config.cache)
	mkdir -p $(LIBVPX_DIR)/$(LIBVPX_SUBDIR)
	cd $(LIBVPX_DIR)/$(LIBVPX_SUBDIR) && \
		$(LIBVPX_PATH) $(LIBVPX_ENV) \
		../configure $(LIBVPX_CONF_OPT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libvpx.compile:
	@$(call targetinfo)
#	@$(call world/compile, LIBVPX)
	cd $(LIBVPX_DIR)/$(LIBVPX_SUBDIR) && \
		$(LIBVPX_PATH) $(LIBVPX_ENV) \
		$(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/libvpx.install:
#	@$(call targetinfo)
#	@$(call world/install, LIBVPX)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libvpx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libvpx)
	@$(call install_fixup, libvpx,PRIORITY,optional)
	@$(call install_fixup, libvpx,SECTION,base)
	@$(call install_fixup, libvpx,AUTHOR,"fga")
	@$(call install_fixup, libvpx,DESCRIPTION,missing)

	@$(call install_lib, libvpx, 0, 0, 0644, libvpx)

	@$(call install_finish, libvpx)

	@$(call touch)

# vim: syntax=make
