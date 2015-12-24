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
PACKAGES-$(PTXCONF_LIBPLIST) += libplist

#
# Paths and names
#
LIBPLIST_VERSION	:= 1.12
LIBPLIST_MD5		:= 8b04b0f09f2398022dcd4fba75012997
LIBPLIST		:= libplist-$(LIBPLIST_VERSION)
LIBPLIST_SUFFIX		:= tar.bz2
LIBPLIST_URL		:= http://www.libimobiledevice.org/downloads/$(LIBPLIST).$(LIBPLIST_SUFFIX)
LIBPLIST_SOURCE		:= $(SRCDIR)/$(LIBPLIST).$(LIBPLIST_SUFFIX)
LIBPLIST_DIR		:= $(BUILDDIR)/$(LIBPLIST)
#LIBPLIST_SUBDIR		:= build
LIBPLIST_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPLIST_PATH	:= PATH=$(CROSS_PATH)
LIBPLIST_ENV    := $(CROSS_ENV)

LIBPLIST_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--without-cython

$(STATEDIR)/libplist.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBPLIST_DIR)/config.cache)
	cd $(LIBPLIST_DIR) && \
		$(LIBPLIST_PATH) $(LIBPLIST_ENV) \
		./configure $(LIBPLIST_CONF_OPT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libplist.install:
	@$(call targetinfo)
	cd $(LIBPLIST_DIR) && \
		$(LIBPLIST_PATH) $(LIBPLIST_ENV) \
		$(MAKE) install DESTDIR=$(LIBPLIST_PKGDIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libplist.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libplist)
	@$(call install_fixup, libplist,PRIORITY,optional)
	@$(call install_fixup, libplist,SECTION,base)
	@$(call install_fixup, libplist,AUTHOR,"fga")
	@$(call install_fixup, libplist,DESCRIPTION,missing)

	@$(call install_lib, libplist, 0, 0, 0644, libplist)
	@$(call install_lib, libplist, 0, 0, 0644, libplist++)
	@$(call install_finish, libplist)

	@$(call touch)

# vim: syntax=make
