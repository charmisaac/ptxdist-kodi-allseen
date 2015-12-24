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
HOST_PACKAGES-$(PTXCONF_HOST_NSS) += host-nss

#
# Paths and names
#
HOST_NSS_DIR	= $(HOST_BUILDDIR)/$(NSS)
HOST_NSS_SUBDIR	= nss

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NSS_MAKE_ENV    := \
	$(HOST_ENV) \
        OS_TARGET=Linux \
        INCLUDES="-I$(PTXDIST_SYSROOT_HOST)/include/nspr -I$(PTXDIST_SYSROOT_HOST)/include" \
	NSPR_INCLUDE_DIR=$(PTXDIST_SYSROOT_HOST)/include/nspr \
	NSPR_LIB_DIR=$(PTXDIST_SYSROOT_HOST)/lib \
	TARGET_ARCH=`uname -m` USE_64=1

#
# autoconf
#
HOST_NSS_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-nss.compile:
	@$(call targetinfo)
#	$(call world/compile, HOST_NSS)
	cd $(HOST_NSS_DIR)/nss && \
		$(HOST_NSS_PATH) $(HOST_NSS_MAKE_ENV) \
		$(MAKE)
	@$(call touch)


# vim: syntax=make
