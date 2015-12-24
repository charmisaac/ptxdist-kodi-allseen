# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSSH) += libssh

#
# Paths and names
#
LIBSSH_VERSION	:= 0.7.2
LIBSSH_MD5	:= 5d7d468937649a6dfc6186edfff083db
LIBSSH		:= libssh-$(LIBSSH_VERSION)
LIBSSH_SUFFIX	:= tar.xz
LIBSSH_URL	:= https://red.libssh.org/attachments/download/177/$(LIBSSH).$(LIBSSH_SUFFIX)
LIBSSH_SOURCE	:= $(SRCDIR)/$(LIBSSH).$(LIBSSH_SUFFIX)
LIBSSH_DIR	:= $(BUILDDIR)/$(LIBSSH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSSH_CONF_TOOL:= cmake
LIBSSH_CONF_OPT	= \
        $(CROSS_CMAKE_USR) \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_RELEASE_TYPE=Release

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libssh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libssh)
	@$(call install_fixup, libssh,PRIORITY,optional)
	@$(call install_fixup, libssh,SECTION,base)
	@$(call install_fixup, libssh,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libssh,DESCRIPTION,missing)

	@$(call install_lib, libssh, 0, 0, 0644, libssh)
	@$(call install_lib, libssh, 0, 0, 0644, libssh_threads)

	@$(call install_finish, libssh)

	@$(call touch)

# vim: syntax=make
