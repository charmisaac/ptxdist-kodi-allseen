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
HOST_PACKAGES-$(PTXCONF_HOST_LIBTASN1) += host-libtasn1

#
# Paths and names
#
HOST_LIBTASN1_DIR	= $(HOST_BUILDDIR)/$(LIBTASN1)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBTASN1_PATH	:= PATH=$(HOST_PATH)
HOST_LIBTASN1_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBTASN1_CONF_TOOL	:= autoconf

# vim: syntax=make
