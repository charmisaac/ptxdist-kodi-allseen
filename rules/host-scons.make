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
HOST_PACKAGES-$(PTXCONF_HOST_SCONS) += host-scons

#
# Paths and names
#
HOST_SCONS_VERSION	:= 2.3.5
HOST_SCONS_MD5		:= 8b0d1041266f89b18e47f26d943f8aa5
HOST_SCONS		:= scons-$(HOST_SCONS_VERSION)
HOST_SCONS_SUFFIX	:= tar.gz
HOST_SCONS_URL		:= http://prdownloads.sourceforge.net/scons/$(HOST_SCONS).$(HOST_SCONS_SUFFIX)
HOST_SCONS_SOURCE	:= $(SRCDIR)/$(HOST_SCONS).$(HOST_SCONS_SUFFIX)
HOST_SCONS_DIR		:= $(HOST_BUILDDIR)/$(HOST_SCONS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(HOST_SCONS_SOURCE):
#	@$(call targetinfo)
#	@$(call get, HOST_SCONS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-scons.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-scons.compile:
	@$(call targetinfo)
	@cd $(HOST_SCONS_DIR) && \
		python setup.py install --prefix=$(PTXCONF_SYSROOT_CROSS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-scons.install:
	@$(call targetinfo)
	@cd $(HOST_SCONS_DIR) && \
		python setup.py install --prefix=$(PTXCONF_SYSROOT_CROSS)
	@$(call touch)

# vim: syntax=make
