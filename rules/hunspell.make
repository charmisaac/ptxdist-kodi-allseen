# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HUNSPELL) += hunspell

#
# Paths and names
#
HUNSPELL_VERSION	:= 1.3.3
HUNSPELL_MD5		:= 4967da60b23413604c9e563beacc63b4
HUNSPELL		:= hunspell-$(HUNSPELL_VERSION)
HUNSPELL_SUFFIX		:= tar.gz
HUNSPELL_URL		:= http://downloads.sourceforge.net/hunspell/$(HUNSPELL).$(HUNSPELL_SUFFIX)
HUNSPELL_SOURCE		:= $(SRCDIR)/$(HUNSPELL).$(HUNSPELL_SUFFIX)
HUNSPELL_DIR		:= $(BUILDDIR)/$(HUNSPELL)
HUNSPELL_LICENSE	:= BSD, GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hunspell.install:
	@$(call targetinfo)
	@$(call world/install, HUNSPELL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hunspell.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  hunspell)
	@$(call install_fixup, hunspell,PRIORITY,optional)
	@$(call install_fixup, hunspell,SECTION,base)
	@$(call install_fixup, hunspell,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, hunspell,DESCRIPTION,missing)

	@$(call install_lib,  hunspell, 0, 0, 0644, libhunspell-$(basename $(HUNSPELL_VERSION)))

	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/affixcompress)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/analyze)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/chmorph)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/hunspell)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/hunzip)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/hzip)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/ispellaff2myspell)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/makealias)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/munch)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/unmunch)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/wordforms)
	@$(call install_copy,  hunspell, 0, 0, 0755, -, /usr/bin/wordlist2hunspell)

	@$(call install_finish, hunspell)

	@$(call touch)

# vim: syntax=make
