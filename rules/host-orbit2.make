# -*-makefile-*-
#
# Copyright (C) 2012 by fga
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ORBIT2) += host-orbit2

HOST_ORBIT2	= $(ORBIT2)
HOST_ORBIT2_DIR	= $(HOST_BUILDDIR)/$(HOST_ORBIT2)
# HOST_ORBIT2_SUBDIR= src

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# HOST_ORBIT2_CONF_TOOL	:= autoconf
# HOST_ORBIT2_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

HOST_ORBIT2_MAKE_OPT	:= -C src

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-orbit2.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-orbit2.install:
	@$(call targetinfo)
	@$(call touch)
