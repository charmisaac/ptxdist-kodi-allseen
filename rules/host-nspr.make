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
HOST_PACKAGES-$(PTXCONF_HOST_NSPR) += host-nspr

#
# Paths and names
#
HOST_NSPR_DIR	= $(HOST_BUILDDIR)/$(NSPR)
HOST_NSPR_SUBDIR= nspr

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_NSPR_CONF_TOOL	:= autoconf
HOST_NSPR_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-debug --enable-optimize \
	--enable-64bit

# vim: syntax=make
