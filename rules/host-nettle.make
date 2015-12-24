# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NETTLE) += host-nettle

#
# Paths and names
#
HOST_NETTLE_DIR	= $(HOST_BUILDDIR)/$(NETTLE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NETTLE_PATH	:= PATH=$(HOST_PATH)
HOST_NETTLE_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_NETTLE_CONF_TOOL	:= autoconf
HOST_NETTLE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-static \
	--enable-public-key \
	--enable-assembler \
	--enable-mini-gmp \
	--disable-openssl \
	--disable-gcov \
	--disable-documentation \

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-nettle.install:
	@$(call targetinfo)
	@$(call world/install, HOST_NETTLE)
	cp $(HOST_NETTLE_DIR)/nettle.pc $(PTXDIST_SYSROOT_HOST)/lib/pkgconfig
	cp $(HOST_NETTLE_DIR)/hogweed.pc $(PTXDIST_SYSROOT_HOST)/lib/pkgconfig
	cp $(HOST_NETTLE_DIR)/.lib/libhogweed.so* $(PTXDIST_SYSROOT_HOST)/lib
	@$(call touch)

# vim: syntax=make
