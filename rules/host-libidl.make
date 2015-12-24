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
HOST_PACKAGES-$(PTXCONF_HOST_LIBIDL) += host-libidl

HOST_LIBIDL	= $(LIBIDL)
HOST_LIBIDL_DIR	= $(HOST_BUILDDIR)/$(HOST_LIBIDL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBIDL_CONF_TOOL	:= autoconf
HOST_LIBIDL_CONF_OPT	:= $(HOST_AUTOCONF_USR)

