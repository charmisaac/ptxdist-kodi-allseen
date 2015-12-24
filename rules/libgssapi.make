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
PACKAGES-$(PTXCONF_LIBGSSAPI) += libgssapi

#
# Paths and names
#
LIBGSSAPI_VERSION	:= 0.11
LIBGSSAPI_MD5		:= 0e5b4c7267724f8ddf64bc35514c272e
LIBGSSAPI		:= libgssapi-$(LIBGSSAPI_VERSION)
LIBGSSAPI_SUFFIX	:= tar.gz
LIBGSSAPI_URL		:= http://www.citi.umich.edu/projects/nfsv4/linux/libgssapi/$(LIBGSSAPI).$(LIBGSSAPI_SUFFIX)
LIBGSSAPI_SOURCE	:= $(SRCDIR)/$(LIBGSSAPI).$(LIBGSSAPI_SUFFIX)
LIBGSSAPI_DIR		:= $(BUILDDIR)/$(LIBGSSAPI)
LIBGSSAPI_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#LIBGSSAPI_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBGSSAPI_CONF_TOOL	:= autoconf
#LIBGSSAPI_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgssapi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgssapi)
	@$(call install_fixup, libgssapi,PRIORITY,optional)
	@$(call install_fixup, libgssapi,SECTION,base)
	@$(call install_fixup, libgssapi,AUTHOR,"fga")
	@$(call install_fixup, libgssapi,DESCRIPTION,missing)

	@$(call install_lib, libgssapi, 0, 0, 0644, libgssapi)

	@$(call install_finish, libgssapi)

	@$(call touch)

# vim: syntax=make
