# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBRSVG) += librsvg

#
# Paths and names
#
LIBRSVG_VERSION	:= 2.40.11
LIBRSVG_MD5	:= 6b9cd1a048210a8e95bdc04c85fe997f
LIBRSVG		:= librsvg-$(LIBRSVG_VERSION)
LIBRSVG_SUFFIX	:= tar.xz
LIBRSVG_URL	:= http://ftp.gnome.org/pub/GNOME/sources/librsvg/$(basename $(LIBRSVG_VERSION))/$(LIBRSVG).$(LIBRSVG_SUFFIX)
LIBRSVG_SOURCE	:= $(SRCDIR)/$(LIBRSVG).$(LIBRSVG_SUFFIX)
LIBRSVG_DIR	:= $(BUILDDIR)/$(LIBRSVG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBRSVG_PATH	:= PATH=$(CROSS_PATH)
LIBRSVG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBRSVG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-tools \
	--disable-introspection \
	--$(call ptx/endis, PTXCONF_LIBRSVG_PIXBUF_LOADER)-pixbuf-loader

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/librsvg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, librsvg)
	@$(call install_fixup, librsvg,PRIORITY,optional)
	@$(call install_fixup, librsvg,SECTION,base)
	@$(call install_fixup, librsvg,AUTHOR,"Erwin Rol")
	@$(call install_fixup, librsvg,DESCRIPTION,missing)

	@$(call install_lib, librsvg, 0, 0, 0644, librsvg-2)

	@$(call install_finish, librsvg)

	@$(call touch)

# vim: syntax=make
