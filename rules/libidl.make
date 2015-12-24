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
PACKAGES-$(PTXCONF_LIBIDL) += libidl

#
# Paths and names
#
LIBIDL_VERSION	:= 0.8.14
LIBIDL_MD5	:= bb8e10a218fac793a52d404d14adedcb
LIBIDL		:= libIDL-$(LIBIDL_VERSION)
LIBIDL_SUFFIX	:= tar.bz2
LIBIDL_URL	:= http://ftp.gnome.org/pub/GNOME/sources/libIDL/0.8/$(LIBIDL).$(LIBIDL_SUFFIX)
LIBIDL_SOURCE	:= $(SRCDIR)/$(LIBIDL).$(LIBIDL_SUFFIX)
LIBIDL_DIR	:= $(BUILDDIR)/$(LIBIDL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBIDL_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBIDL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBIDL_PATH	:= PATH=$(CROSS_PATH)
LIBIDL_ENV 	:= $(CROSS_ENV) \
	libIDL_cv_long_long_format=ll

#
# autoconf
#
LIBIDL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libidl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libidl)
	@$(call install_fixup, libidl,PRIORITY,optional)
	@$(call install_fixup, libidl,SECTION,base)
	@$(call install_fixup, libidl,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libidl,DESCRIPTION,missing)

	@$(call install_lib, libidl, 0, 0, 0644, libIDL-2)

	@$(call install_finish, libidl)

	@$(call touch)

# vim: syntax=make
