# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBLTDL) += libltdl

#
# Paths and names
#
LIBLTDL_VERSION	:= 2.4.6
LIBLTDL_MD5	:= addf44b646ddb4e3919805aa88fa7c5e
LIBLTDL		:= libtool-$(LIBLTDL_VERSION)
LIBLTDL_SUFFIX	:= tar.gz
LIBLTDL_URL	:= $(call ptx/mirror, GNU, libtool/$(LIBLTDL).$(LIBLTDL_SUFFIX)) \
	https://ftp.gnu.org/gnu/libtool/$(LIBLTDL).$(LIBLTDL_SUFFIX)
LIBLTDL_SOURCE	:= $(SRCDIR)/$(LIBLTDL).$(LIBLTDL_SUFFIX)
LIBLTDL_DIR	:= $(BUILDDIR)/$(LIBLTDL)
# License for libltdl only
LIBLTDL_LICENSE	:= LGPL-2.0+
LIBLTDL_LICENSE_FILES := \
	file://libltdl/COPYING.LIB;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBLTDL_PATH	:= PATH=$(CROSS_PATH)
LIBLTDL_ENV 	:= $(CROSS_ENV) HELP2MAN=:

#
# autoconf
#
LIBLTDL_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libltdl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libltdl)
	@$(call install_fixup, libltdl,PRIORITY,optional)
	@$(call install_fixup, libltdl,SECTION,base)
	@$(call install_fixup, libltdl,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libltdl,DESCRIPTION,missing)

	@$(call install_lib, libltdl, 0, 0, 0644, libltdl)

	@$(call install_finish, libltdl)

	@$(call touch)

# vim: syntax=make
