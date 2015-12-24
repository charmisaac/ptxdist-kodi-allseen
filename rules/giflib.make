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
PACKAGES-$(PTXCONF_GIFLIB) += giflib

#
# Paths and names
#
GIFLIB_VERSION	:= 5.1.1
GIFLIB_MD5	:= 1c39333192712788c6568c78a949f13e
GIFLIB		:= giflib-$(GIFLIB_VERSION)
GIFLIB_SUFFIX	:= tar.bz2
GIFLIB_URL	:= http://downloads.sourceforge.net/giflib/$(GIFLIB).$(GIFLIB_SUFFIX)
GIFLIB_SOURCE	:= $(SRCDIR)/$(GIFLIB).$(GIFLIB_SUFFIX)
GIFLIB_DIR	:= $(BUILDDIR)/$(GIFLIB)
GIFLIB_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(GIFLIB_SOURCE):
#	@$(call targetinfo)
#	@$(call get, GIFLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#GIFLIB_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
GIFLIB_CONF_TOOL	:= autoconf
#GIFLIB_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

#$(STATEDIR)/giflib.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(GIFLIB_DIR)/config.cache)
#	cd $(GIFLIB_DIR) && \
#		$(GIFLIB_PATH) $(GIFLIB_ENV) \
#		./configure $(GIFLIB_CONF_OPT)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/giflib.compile:
#	@$(call targetinfo)
#	@$(call world/compile, GIFLIB)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/giflib.install:
#	@$(call targetinfo)
#	@$(call world/install, GIFLIB)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/giflib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, giflib)
	@$(call install_fixup, giflib,PRIORITY,optional)
	@$(call install_fixup, giflib,SECTION,base)
	@$(call install_fixup, giflib,AUTHOR,"fga")
	@$(call install_fixup, giflib,DESCRIPTION,missing)

	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gif2rgb)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifbuild)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifclrmp)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifecho)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/giffix)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifinto)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/giftext)

	@$(call install_lib, giflib, 0, 0, 0644, libgif)

	@$(call install_finish, giflib)

	@$(call touch)

# vim: syntax=make
