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
PACKAGES-$(PTXCONF_AT_SPI2_ATK) += at-spi2-atk

#
# Paths and names
#
AT_SPI2_ATK_VERSION	:= 2.18.1
AT_SPI2_ATK_MD5		:= d7040a55df975865ab0d74a4b325afb5
AT_SPI2_ATK		:= at-spi2-atk-$(AT_SPI2_ATK_VERSION)
AT_SPI2_ATK_SUFFIX	:= tar.xz
AT_SPI2_ATK_URL		:= http://ftp.gnome.org/pub/GNOME/sources/at-spi2-atk/$(basename $(AT_SPI2_ATK_VERSION))/$(AT_SPI2_ATK).$(AT_SPI2_ATK_SUFFIX)
AT_SPI2_ATK_SOURCE	:= $(SRCDIR)/$(AT_SPI2_ATK).$(AT_SPI2_ATK_SUFFIX)
AT_SPI2_ATK_DIR		:= $(BUILDDIR)/$(AT_SPI2_ATK)
AT_SPI2_ATK_LICENSE	:= LGPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

AT_SPI2_ATK_PATH	:= PATH=$(CROSS_PATH)
AT_SPI2_ATK_ENV		:= $(CROSS_ENV)

#
# autoconf
#
AT_SPI2_ATK_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static 

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at-spi2-atk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, at-spi2-atk)
	@$(call install_fixup, at-spi2-atk,PRIORITY,optional)
	@$(call install_fixup, at-spi2-atk,SECTION,base)
	@$(call install_fixup, at-spi2-atk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, at-spi2-atk,DESCRIPTION,missing)

	@$(call install_lib, at-spi2-atk, 0, 0, 0644, libatk-bridge-2.0)

	@$(call install_copy, at-spi2-atk, 0, 0, 0644, -, /usr/lib/gtk-2.0/modules/libatk-bridge.so)

	@$(call install_finish, at-spi2-atk)

	@$(call touch)

# vim: syntax=make
