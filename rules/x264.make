# -*-makefile-*-
#
# Copyright (C) 2008 by Daniel Schnell
#		2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_X264) += x264

#
# Paths and names
#
X264_VERSION	:= 20151110-2245
X264_MD5	:= 9b67c3131d5fc3003f29774e263eea95
X264		:= x264-snapshot-$(X264_VERSION)
X264_SUFFIX	:= tar.bz2
X264_URL	:= http://download.videolan.org/pub/x264/snapshots/$(X264).$(X264_SUFFIX)
X264_SOURCE	:= $(SRCDIR)/$(X264).$(X264_SUFFIX)
X264_DIR	:= $(BUILDDIR)/$(X264)
X264_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

X264_PATH	:= PATH=$(CROSS_PATH)
X264_CONF_ENV 	:= $(CROSS_ENV) \
	AS="$(COMPILER_PREFIX)gcc"

#
# autoconf
#
X264_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--enable-strip \
	--disable-pic \
	--enable-shared \
	--disable-ffms \
	--disable-cli

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/x264.targetinstall:
	@$(call targetinfo)

	@$(call install_init, x264)
	@$(call install_fixup, x264,PRIORITY,optional)
	@$(call install_fixup, x264,SECTION,base)
	@$(call install_fixup, x264,AUTHOR,"Daniel Schnell <daniel.schnell@marel.com>")
	@$(call install_fixup, x264,DESCRIPTION,missing)

#	@$(call install_copy, x264, 0, 0, 0755, -, /usr/bin/x264)
	@$(call install_lib, x264, 0, 0, 0644, libx264)

	@$(call install_finish, x264)

	@$(call touch)

# vim: syntax=make
