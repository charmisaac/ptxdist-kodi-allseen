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
PACKAGES-$(PTXCONF_GCONF) += gconf

#
# Paths and names
#
GCONF_VERSION	:= 3.2.6
GCONF_MD5	:= 2b16996d0e4b112856ee5c59130e822c
GCONF		:= GConf-$(GCONF_VERSION)
GCONF_SUFFIX	:= tar.xz
GCONF_URL	:= http://ftp.gnome.org/pub/GNOME/sources/GConf/3.2/$(GCONF).$(GCONF_SUFFIX)
GCONF_SOURCE	:= $(SRCDIR)/$(GCONF).$(GCONF_SUFFIX)
GCONF_DIR	:= $(BUILDDIR)/$(GCONF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GCONF_SOURCE):
	@$(call targetinfo)
	@$(call get, GCONF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GCONF_PATH	:= PATH=$(CROSS_PATH)
GCONF_ENV 	:= $(CROSS_ENV) \
	ORBIT_IDL=$(PTXCONF_SYSROOT_CROSS)/bin/orbit-idl-2

#
# autoconf
#
GCONF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gconf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gconf)
	@$(call install_fixup, gconf,PRIORITY,optional)
	@$(call install_fixup, gconf,SECTION,base)
	@$(call install_fixup, gconf,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gconf,DESCRIPTION,missing)

	@$(call install_lib, gconf, 0, 0, 0644, libgconf-2)

	@$(call install_copy, gconf, 0, 0, 0755, -, /usr/lib/GConf/2/libgconfbackend-oldxml.so)
	@$(call install_copy, gconf, 0, 0, 0755, -, /usr/lib/GConf/2/libgconfbackend-xml.so)
	@$(call install_copy, gconf, 0, 0, 0755, -, /usr/lib/gio/modules/libgsettingsgconfbackend.so)

	@$(call install_copy, gconf, 0, 0, 0755, -, /usr/bin/gconf-merge-tree)
	@$(call install_copy, gconf, 0, 0, 0755, -, /usr/bin/gconftool-2)
	@$(call install_copy, gconf, 0, 0, 0755, -, /usr/bin/gsettings-data-convert)
	@$(call install_copy, gconf, 0, 0, 0755, -, /usr/bin/gsettings-schema-convert)

	@$(call install_copy, gconf, 0, 0, 0755, /etc/gconf/2)
	@$(call install_copy, gconf, 0, 0, 0755, /etc/dbus-1/system.d)
	@$(call install_copy, gconf, 0, 0, 0755, /etc/xdg/autostart)
	@$(call install_copy, gconf, 0, 0, 0644, -, /etc/gconf/2/path)
#	@$(call install_copy, gconf, 0, 0, 0644, -, /etc/dbus-1/system.d/org.gnome.GConf.Defaults.conf)
	@$(call install_copy, gconf, 0, 0, 0644, -, /etc/xdg/autostart/gsettings-data-convert.desktop)

	@$(call install_finish, gconf)

	@$(call touch)

# vim: syntax=make
