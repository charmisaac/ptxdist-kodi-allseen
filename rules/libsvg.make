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
PACKAGES-$(PTXCONF_LIBSVG) += libsvg

#
# Paths and names
#
LIBSVG_VERSION	:= 0.1.4
LIBSVG_MD5	:= ce0715e3013f78506795fba16e8455d3
LIBSVG		:= libsvg-$(LIBSVG_VERSION)
LIBSVG_SUFFIX	:= tar.gz
LIBSVG_URL	:= http://cairographics.org/snapshots/$(LIBSVG).$(LIBSVG_SUFFIX)
LIBSVG_SOURCE	:= $(SRCDIR)/$(LIBSVG).$(LIBSVG_SUFFIX)
LIBSVG_DIR	:= $(BUILDDIR)/$(LIBSVG)
LIBSVG_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(LIBSVG_SOURCE):
#	@$(call targetinfo)
#	@$(call get, LIBSVG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#LIBSVG_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBSVG_CONF_TOOL	:= autoconf
#LIBSVG_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

#$(STATEDIR)/libsvg.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(LIBSVG_DIR)/config.cache)
#	cd $(LIBSVG_DIR) && \
#		$(LIBSVG_PATH) $(LIBSVG_ENV) \
#		./configure $(LIBSVG_CONF_OPT)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/libsvg.compile:
#	@$(call targetinfo)
#	@$(call world/compile, LIBSVG)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/libsvg.install:
#	@$(call targetinfo)
#	@$(call world/install, LIBSVG)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsvg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsvg)
	@$(call install_fixup, libsvg,PRIORITY,optional)
	@$(call install_fixup, libsvg,SECTION,base)
	@$(call install_fixup, libsvg,AUTHOR,"fga")
	@$(call install_fixup, libsvg,DESCRIPTION,missing)

	@$(call install_lib, libsvg, 0, 0, 0644, libsvg)

	@$(call install_finish, libsvg)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/libsvg.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, LIBSVG)

# vim: syntax=make
