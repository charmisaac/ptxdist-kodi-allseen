# -*-makefile-*-
#
# Copyright (C) 2012 by fabricega
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSQUISH) += libsquish

#
# Paths and names
#
LIBSQUISH_VERSION	:= 1.11
LIBSQUISH_MD5		:= 150ba1117d2c1678de12650357787994
LIBSQUISH		:= squish-$(LIBSQUISH_VERSION)
LIBSQUISH_SUFFIX	:= zip
LIBSQUISH_URL		:= https://libsquish.googlecode.com/files/$(LIBSQUISH).$(LIBSQUISH_SUFFIX) \
	http://downloads.sourceforge.net/project/libsquish/$(LIBSQUISH).$(LIBSQUISH_SUFFIX)
LIBSQUISH_SOURCE	:= $(SRCDIR)/$(LIBSQUISH).$(LIBSQUISH_SUFFIX)
LIBSQUISH_DIR		:= $(BUILDDIR)/$(LIBSQUISH)
LIBSQUISH_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSQUISH_PATH	:= PATH=$(CROSS_PATH)
LIBSQUISH_ENV	:= $(CROSS_ENV) \
	CC=${CROSS_CC} CXX=${CROSS_CXX}

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libsquish.compile:
	@$(call targetinfo)
	@cd $(LIBSQUISH_DIR) && $(LIBSQUISH_PATH) $(LIBSQUISH_ENV) $(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsquish.install:
	@$(call targetinfo)
	@cd $(LIBSQUISH_DIR) && $(LIBSQUISH_PATH) INSTALL_DIR=$(SYSROOT)/usr $(MAKE) install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsquish.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsquish)
	@$(call install_fixup, libsquish,PRIORITY,optional)
	@$(call install_fixup, libsquish,SECTION,base)
	@$(call install_fixup, libsquish,AUTHOR,"fabricega")
	@$(call install_fixup, libsquish,DESCRIPTION,missing)

#	@$(call install_lib, libsquish, 0, 0, 0644, libsquish)
	@$(call install_copy, libsquish, 0, 0, 0644, $(LIBSQUISH_DIR)/libsquish.a, /usr/lib/libsquish.a)

	@$(call install_finish, libsquish)

	@$(call touch)

# vim: syntax=make
