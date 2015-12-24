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
PACKAGES-$(PTXCONF_LIBBMP) += libbmp

#
# Paths and names
#
LIBBMP_VERSION	:= 0.1.3
LIBBMP_MD5	:= a0b60eb404888111b310ba7c21b35867
LIBBMP		:= libbmp-$(LIBBMP_VERSION)
LIBBMP_SUFFIX	:= tar.bz2
LIBBMP_URL	:= https://libbmp.googlecode.com/files/$(LIBBMP).$(LIBBMP_SUFFIX)
LIBBMP_SOURCE	:= $(SRCDIR)/$(LIBBMP).$(LIBBMP_SUFFIX)
LIBBMP_DIR	:= $(BUILDDIR)/$(LIBBMP)
LIBBMP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(LIBBMP_SOURCE):
#	@$(call targetinfo)
#	@$(call get, LIBBMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#LIBBMP_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBBMP_CONF_TOOL	:= autoconf
#LIBBMP_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

#$(STATEDIR)/libbmp.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(LIBBMP_DIR)/config.cache)
#	cd $(LIBBMP_DIR) && \
#		$(LIBBMP_PATH) $(LIBBMP_ENV) \
#		./configure $(LIBBMP_CONF_OPT)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/libbmp.compile:
#	@$(call targetinfo)
#	@$(call world/compile, LIBBMP)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/libbmp.install:
#	@$(call targetinfo)
#	@$(call world/install, LIBBMP)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libbmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libbmp)
	@$(call install_fixup, libbmp,PRIORITY,optional)
	@$(call install_fixup, libbmp,SECTION,base)
	@$(call install_fixup, libbmp,AUTHOR,"fga")
	@$(call install_fixup, libbmp,DESCRIPTION,missing)

	@$(call install_lib, libbmp, 0, 0, 0644, libbmp)

	@$(call install_finish, libbmp)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/libbmp.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, LIBBMP)

# vim: syntax=make
