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
PACKAGES-$(PTXCONF_LIBICONV) += libiconv

#
# Paths and names
#
LIBICONV_VERSION	:= 1.14
LIBICONV_MD5		:= e34509b1623cec449dfeb73d7ce9c6c6
LIBICONV		:= libiconv-$(LIBICONV_VERSION)
LIBICONV_SUFFIX		:= tar.gz
LIBICONV_URL		:= http://ftp.gnu.org/gnu/libiconv/$(LIBICONV).$(LIBICONV_SUFFIX)
LIBICONV_SOURCE		:= $(SRCDIR)/$(LIBICONV).$(LIBICONV_SUFFIX)
LIBICONV_DIR		:= $(BUILDDIR)/$(LIBICONV)
LIBICONV_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(LIBICONV_SOURCE):
#	@$(call targetinfo)
#	@$(call get, LIBICONV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#LIBICONV_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBICONV_CONF_TOOL	:= autoconf
#LIBICONV_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

#$(STATEDIR)/libiconv.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(LIBICONV_DIR)/config.cache)
#	cd $(LIBICONV_DIR) && \
#		$(LIBICONV_PATH) $(LIBICONV_ENV) \
#		./configure $(LIBICONV_CONF_OPT)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/libiconv.compile:
#	@$(call targetinfo)
#	@$(call world/compile, LIBICONV)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/libiconv.install:
#	@$(call targetinfo)
#	@$(call world/install, LIBICONV)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libiconv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libiconv)
	@$(call install_fixup, libiconv,PRIORITY,optional)
	@$(call install_fixup, libiconv,SECTION,base)
	@$(call install_fixup, libiconv,AUTHOR,"fga")
	@$(call install_fixup, libiconv,DESCRIPTION,missing)

	@$(call install_lib, libiconv, 0, 0, 0644, libiconv)

	@$(call install_finish, libiconv)

	@$(call touch)

# vim: syntax=make
