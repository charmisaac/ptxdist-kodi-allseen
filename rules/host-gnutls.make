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
HOST_PACKAGES-$(PTXCONF_HOST_GNUTLS) += host-gnutls

#
# Paths and names
#
HOST_GNUTLS_DIR	= $(HOST_BUILDDIR)/$(GNUTLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GNUTLS_PATH	:= PATH=$(HOST_PATH)
HOST_GNUTLS_CONF_ENV	:= $(HOST_ENV) \
	LDFLAGS="-L$(PTXDIST_SYSROOT_HOST)/lib -L$(PTXDIST_SYSROOT_HOST)/lib64"

#
# autoconf
#
HOST_GNUTLS_CONF_TOOL	:= autoconf
HOST_GNUTLS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-doc \
	--disable-tests \
	--disable-gtk-doc \
	--disable-nls \
	--disable-rpath \
	--disable-valgrind-tests \
	--disable-gcc-warnings \
	--enable-shared \
	--disable-static \
	--disable-self-checks \
	--disable-fips140-mode \
	--enable-non-suiteb-curves \
	--disable-libdane \
	--enable-local-libopts \
	--disable-libopts-install \
	--disable-guile \
	--disable-crywrap \
	--without-p11-kit \
	--without-tpm \
	--without-librt-prefix \
	--without-libregex \
	--with-zlib \
	--without-libz-prefix

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gnutls.compile:
	@$(call targetinfo)
	$(call world/compile, HOST_GNUTLS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# vim: syntax=make
