# -*-makefile-*-
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
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
PACKAGES-$(PTXCONF_AT_SPI2_CORE) += at-spi2-core

#
# Paths and names
#
AT_SPI2_CORE_VERSION	:= 2.18.3
AT_SPI2_CORE_MD5	:= fc18801e56f6ce6914126f837d42f556
AT_SPI2_CORE		:= at-spi2-core-$(AT_SPI2_CORE_VERSION)
AT_SPI2_CORE_SUFFIX	:= tar.xz
AT_SPI2_CORE_URL	:= http://ftp.gnome.org/pub/GNOME/sources/at-spi2-core/$(basename $(AT_SPI2_CORE_VERSION))/$(AT_SPI2_CORE).$(AT_SPI2_CORE_SUFFIX)
AT_SPI2_CORE_SOURCE	:= $(SRCDIR)/$(AT_SPI2_CORE).$(AT_SPI2_CORE_SUFFIX)
AT_SPI2_CORE_DIR	:= $(BUILDDIR)/$(AT_SPI2_CORE)
AT_SPI2_CORE_LICENSE	:= LGPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

AT_SPI2_CORE_PATH	:= PATH=$(CROSS_PATH)
AT_SPI2_CORE_ENV	:= $(CROSS_ENV) \
	LDFLAGS="-L$(PTXDIST_SYSROOT_TOOLCHAIN)/lib -L$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib -L$(SYSROOT)/usr/lib -L$(SYSROOT)/usr/lib64"

#
# autoconf
#
AT_SPI2_CORE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static 

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at-spi2-core.targetinstall:
	@$(call targetinfo)

	@$(call install_init, at-spi2-core)
	@$(call install_fixup, at-spi2-core,PRIORITY,optional)
	@$(call install_fixup, at-spi2-core,SECTION,base)
	@$(call install_fixup, at-spi2-core,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, at-spi2-core,DESCRIPTION,missing)

	@$(call install_lib, at-spi2-core, 0, 0, 0644, libatspi)

	@$(call install_copy, at-spi2-core, 0, 0, 0755, -, /usr/libexec/at-spi2-registryd)
	@$(call install_copy, at-spi2-core, 0, 0, 0755, -, /usr/libexec/at-spi-bus-launcher)

	@$(call install_copy, at-spi2-core, 0, 0, 0644, -, /etc/at-spi2/accessibility.conf)
	@$(call install_copy, at-spi2-core, 0, 0, 0644, -, /etc/xdg/autostart/at-spi-dbus-bus.desktop)

	@$(call install_finish, at-spi2-core)

	@$(call touch)

# vim: syntax=make
