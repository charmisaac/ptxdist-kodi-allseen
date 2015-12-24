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
PACKAGES-$(PTXCONF_NSPR) += nspr

#
# Paths and names
#
NSPR_VERSION	:= 4.11
NSPR_MD5	:= 4f24b2fb88ca03b5d6d6931d6a67ef9a
NSPR		:= nspr-$(NSPR_VERSION)
NSPR_SUFFIX	:= tar.gz
NSPR_URL	:= https://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v$(NSPR_VERSION)/src/$(NSPR).$(NSPR_SUFFIX)
NSPR_SOURCE	:= $(SRCDIR)/$(NSPR).$(NSPR_SUFFIX)
NSPR_DIR	:= $(BUILDDIR)/$(NSPR)
NSPR_SUBDIR	:= nspr
NSPR_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NSPR_CONF_ENV	:= $(CROSS_ENV) \
	HOST_CC=gcc

#
# autoconf
#
NSPR_CONF_TOOL	:= autoconf
NSPR_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--with-mozilla \
	--with-pthreads \
	--disable-debug --enable-optimize \
	--enable-64bit

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nspr.install:
	@$(call targetinfo)
	@$(call world/install, NSPR)
	cp $(NSPR_DIR)/nspr/config/nspr-config $(PTXCONF_SYSROOT_HOST)/bin
	cp $(NSPR_DIR)/nspr/config/nspr-config $(PTXCONF_SYSROOT_TARGET)/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nspr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nspr)
	@$(call install_fixup, nspr,PRIORITY,optional)
	@$(call install_fixup, nspr,SECTION,base)
	@$(call install_fixup, nspr,AUTHOR,"fga")
	@$(call install_fixup, nspr,DESCRIPTION,missing)

	@$(call install_copy, nspr, 0, 0, 0644, -, /usr/lib/libnspr4.so)
	@$(call install_copy, nspr, 0, 0, 0644, -, /usr/lib/libplds4.so)
	@$(call install_copy, nspr, 0, 0, 0644, -, /usr/lib/libplc4.so)

	@$(call install_finish, nspr)

	@$(call touch)

# vim: syntax=make
