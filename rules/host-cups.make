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
HOST_PACKAGES-$(PTXCONF_HOST_CUPS) += host-cups

#
# Paths and names
#
HOST_CUPS_DIR	= $(HOST_BUILDDIR)/$(CUPS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CUPS_PATH       := PATH=$(HOST_PATH):$(HOST_CUPS_DIR)/ppdc:$(HOST_CUPS_DIR)/man
HOST_CUPS_ENV        := $(HOST_ENV)

#
# autoconf
#
HOST_CUPS_CONF_TOOL	:= autoconf
HOST_CUPS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-gssapi \
	--enable-static

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-cups.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_CUPS_DIR)/ppdc/genstrings $(PTXDIST_SYSROOT_HOST)/bin/genstrings
	install -D -m755 $(HOST_CUPS_DIR)/man/mantohtml $(PTXDIST_SYSROOT_HOST)/bin/mantohtml
	@$(call touch)

# vim: syntax=make
