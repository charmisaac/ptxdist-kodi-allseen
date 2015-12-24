# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSODIUM) += libsodium

#
# Paths and names
#
LIBSODIUM_VERSION	:= 1.0.7
LIBSODIUM_MD5		:= 8bdc92cee556526a51612709e976208a
LIBSODIUM		:= libsodium-$(LIBSODIUM_VERSION)
LIBSODIUM_SUFFIX	:= tar.gz
LIBSODIUM_URL		:= https://download.libsodium.org/libsodium/release/$(LIBSODIUM).$(LIBSODIUM_SUFFIX)
LIBSODIUM_SOURCE	:= $(SRCDIR)/$(LIBSODIUM).$(LIBSODIUM_SUFFIX)
LIBSODIUM_DIR		:= $(BUILDDIR)/$(LIBSODIUM)
LIBSODIUM_LICENSE	:= LGPL-3.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSODIUM_CONF_ENV	:= \
	$(CROSS_ENV)

#
# autoconf
#
LIBSODIUM_CONF_TOOL	:= autoconf
LIBSODIUM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsodium.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsodium)
	@$(call install_fixup, libsodium,PRIORITY,optional)
	@$(call install_fixup, libsodium,SECTION,base)
	@$(call install_fixup, libsodium,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libsodium,DESCRIPTION,missing)

	@$(call install_lib, libsodium, 0, 0, 0644, libsodium)

	@$(call install_finish, libsodium)

	@$(call touch)

# vim: syntax=make
