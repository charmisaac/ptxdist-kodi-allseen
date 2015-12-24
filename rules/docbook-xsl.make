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
PACKAGES-$(PTXCONF_DOCBOOK_XSL) += docbook-xsl

#
# Paths and names
#
DOCBOOK_XSL_VERSION	:= 1.78.1
DOCBOOK_XSL_MD5		:= 6dd0f89131cc35bf4f2ed105a1c17771
DOCBOOK_XSL		:= docbook-xsl-$(DOCBOOK_XSL_VERSION)
DOCBOOK_XSL_SUFFIX	:= tar.bz2
DOCBOOK_XSL_URL		:= http://downloads.sourceforge.net/docbook/$(DOCBOOK_XSL).$(DOCBOOK_XSL_SUFFIX) \
	http://sourceforge.net/projects/docbook/files/docbook-xsl/$(DOCBOOK_XSL_VERSION)/$(DOCBOOK_XSL).$(DOCBOOK_XSL_SUFFIX)
DOCBOOK_XSL_SOURCE	:= $(SRCDIR)/$(DOCBOOK_XSL).$(DOCBOOK_XSL_SUFFIX)
DOCBOOK_XSL_DIR		:= $(BUILDDIR)/$(DOCBOOK_XSL)
DOCBOOK_XSL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(DOCBOOK_XSL_SOURCE):
#	@$(call targetinfo)
#	@$(call get, DOCBOOK_XSL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/docbook-xsl.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/docbook-xsl.compile:
	@$(call targetinfo)
	rm -rf $(SYSROOT)/usr/share/xml/docbook/stylesheet/docbook-xsl
	rm -rf $(DOCBOOK_XSL_PKGDIR)/usr/share/xml/docbook/stylesheet/xsl-stylesheets-$(DOCBOOK_XSL_VERSION)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/docbook-xsl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, docbook-xsl)
	@$(call install_fixup, docbook-xsl,PRIORITY,optional)
	@$(call install_fixup, docbook-xsl,SECTION,base)
	@$(call install_fixup, docbook-xsl,AUTHOR,"fga")
	@$(call install_fixup, docbook-xsl,DESCRIPTION,missing)

#	cd $(DOCBOOK_XSL_PKGDIR) && \
		for XML_FILES in `find . -type f`; do \
			$(call install_copy, docbook-xsl, 0, 0, 0644, -, $$XML_FILES); \
		done

	@$(call install_finish, docbook-xsl)

	@$(call touch)

# vim: syntax=make
