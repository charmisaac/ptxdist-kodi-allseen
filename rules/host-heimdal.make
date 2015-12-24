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
HOST_PACKAGES-$(PTXCONF_HOST_HEIMDAL) += host-heimdal

#
# Paths and names
#
HOST_HEIMDAL		= $(HEIMDAL)
HOST_HEIMDAL_DIR	= $(HOST_BUILDDIR)/$(HOST_HEIMDAL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_HEIMDAL_PATH	:= PATH=$(HOST_PATH)
HOST_HEIMDAL_CONF_ENV	:= $(HOST_ENV) \
	LIBS="-lpthread"

#
# autoconf
#
HOST_HEIMDAL_CONF_TOOL	:= autoconf
HOST_HEIMDAL_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--with-x=no --disable-shared --enable-static

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-heimdal.compile:
	@$(call targetinfo)
	sed -e "s| doc||g" -i $(HOST_HEIMDAL_DIR)/Makefile
	cd $(HOST_HEIMDAL_DIR)/lib && \
		$(HOST_HEIMDAL_PATH) $(HOST_HEIMDAL_ENV) \
		$(MAKE) -C com_err
	cd $(HOST_HEIMDAL_DIR)/lib && \
		$(HOST_HEIMDAL_PATH) $(HOST_HEIMDAL_ENV) \
		$(MAKE) -C asn1
	cd $(HOST_HEIMDAL_DIR)/lib && \
		$(HOST_HEIMDAL_PATH) $(HOST_HEIMDAL_ENV) \
		$(MAKE) -C sl
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-heimdal.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_HEIMDAL_DIR)/lib/asn1/asn1_compile $(PTXDIST_SYSROOT_HOST)/bin/asn1_compile
	install -D -m755 $(HOST_HEIMDAL_DIR)/lib/com_err/compile_et $(PTXDIST_SYSROOT_HOST)/bin/compile_et
	install -D -m755 $(HOST_HEIMDAL_DIR)/lib/sl/slc $(PTXDIST_SYSROOT_HOST)/bin/slc
	@$(call touch)

# vim: syntax=make
