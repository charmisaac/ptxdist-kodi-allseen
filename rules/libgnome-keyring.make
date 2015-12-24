# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGNOME_KEYRING) += libgnome-keyring

#
# Paths and names
#
LIBGNOME_KEYRING_VERSION	:= 3.12.0
LIBGNOME_KEYRING_MD5		:= 6696e4f2e9aed4625cdc3af30bd8c238
LIBGNOME_KEYRING		:= libgnome-keyring-$(LIBGNOME_KEYRING_VERSION)
LIBGNOME_KEYRING_SUFFIX		:= tar.xz
LIBGNOME_KEYRING_URL		:= http://ftp.gnome.org/pub/GNOME/sources/libgnome-keyring/$(basename $(LIBGNOME_KEYRING_VERSION))/$(LIBGNOME_KEYRING).$(LIBGNOME_KEYRING_SUFFIX)
LIBGNOME_KEYRING_SOURCE		:= $(SRCDIR)/$(LIBGNOME_KEYRING).$(LIBGNOME_KEYRING_SUFFIX)
LIBGNOME_KEYRING_DIR		:= $(BUILDDIR)/$(LIBGNOME_KEYRING)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGNOME_KEYRING_PATH	:= PATH=$(CROSS_PATH)
LIBGNOME_KEYRING_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGNOME_KEYRING_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgnome-keyring.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgnome-keyring)
	@$(call install_fixup, libgnome-keyring,PRIORITY,optional)
	@$(call install_fixup, libgnome-keyring,SECTION,base)
	@$(call install_fixup, libgnome-keyring,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libgnome-keyring,DESCRIPTION,missing)

	@$(call install_lib, libgnome-keyring, 0, 0, 0644, libgnome-keyring)

	@$(call install_finish, libgnome-keyring)

	@$(call touch)

# vim: syntax=make
