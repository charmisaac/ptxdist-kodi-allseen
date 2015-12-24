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
HOST_PACKAGES-$(PTXCONF_HOST_LIBGMP) += host-libgmp

#
# Paths and names
#
HOST_LIBGMP_DIR	= $(HOST_BUILDDIR)/$(LIBGMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBGMP_PATH	:= PATH=$(HOST_PATH)
HOST_LIBGMP_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBGMP_CONF_TOOL	:= autoconf
HOST_LIBGMP_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-static

# vim: syntax=make
