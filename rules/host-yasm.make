# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_YASM) += host-yasm

#
# Paths and names
#
HOST_YASM_VERSION	:= 1.3.0
HOST_YASM_MD5		:= fc9e586751ff789b34b1f21d572d96af
HOST_YASM		:= yasm-$(HOST_YASM_VERSION)
HOST_YASM_SUFFIX	:= tar.gz
HOST_YASM_URL		:= http://www.tortall.net/projects/yasm/releases/$(HOST_YASM).$(HOST_YASM_SUFFIX)
HOST_YASM_SOURCE	:= $(SRCDIR)/$(HOST_YASM).$(HOST_YASM_SUFFIX)
HOST_YASM_DIR		:= $(HOST_BUILDDIR)/$(HOST_YASM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_YASM_CONF_TOOL	:= autoconf

# vim: syntax=make
