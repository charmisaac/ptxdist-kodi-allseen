# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTF8PROC) += utf8proc

#
# Paths and names
#
UTF8PROC_VERSION	:= 1.3.1
UTF8PROC_MD5		:= 347cbe5feef3d6714566bad06f1b0135
UTF8PROC		:= utf8proc-$(UTF8PROC_VERSION)
UTF8PROC_SUFFIX		:= tar.gz
UTF8PROC_URL		:= https://github.com/JuliaLang/utf8proc.git;tag=v$(UTF8PROC_VERSION)
UTF8PROC_SOURCE		:= $(SRCDIR)/$(UTF8PROC).$(UTF8PROC_SUFFIX)
UTF8PROC_DIR		:= $(BUILDDIR)/$(UTF8PROC)
UTF8PROC_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
UTF8PROC_CONF_TOOL	:= NO
UTF8PROC_MAKE_ENV	:= \
	CC=$(COMPILER_PREFIX)gcc AR="$(COMPILER_PREFIX)ar rcu"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/utf8proc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, utf8proc)
	@$(call install_fixup, utf8proc,PRIORITY,optional)
	@$(call install_fixup, utf8proc,SECTION,base)
	@$(call install_fixup, utf8proc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, utf8proc,DESCRIPTION,missing)

	@$(call install_lib, utf8proc, 0, 0, 0644, libutf8proc)

	@$(call install_finish, utf8proc)

	@$(call touch)

# vim: syntax=make
