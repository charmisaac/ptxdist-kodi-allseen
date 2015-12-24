# -*-makefile-*-
#
# Copyright (C) 2003-2009 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGO) += pango

#
# Paths and names
#
PANGO_VERSION	:= 1.38.1
PANGO_MD5	:= 7fde35d4a127b55ce8bbcefe109bc80d
PANGO		:= pango-$(PANGO_VERSION)
PANGO_SUFFIX	:= tar.xz
PANGO_URL	:= http://ftp.gnome.org/pub/GNOME/sources/pango/$(basename $(PANGO_VERSION))/$(PANGO).$(PANGO_SUFFIX)
PANGO_SOURCE	:= $(SRCDIR)/$(PANGO).$(PANGO_SUFFIX)
PANGO_DIR	:= $(BUILDDIR)/$(PANGO)
PANGO_LICENSE	:= LGPL-2.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PANGO_PATH	:= PATH=$(CROSS_PATH)
PANGO_ENV 	:= $(CROSS_ENV) \
	CAIRO_CFLAG=-I$(SYSROOT)/usr/include/cairo \
	CAIRO_LIBS=-L$(SYSROOT)/usr/lib \
	FREETYPE_CFLAG=-I$(SYSROOT)/usr/include/freetype2 \
	FREETYPE_LIBS=-L$(SYSROOT)/usr/lib \
	HARFBUZZ_CFLAGS=-I$(SYSROOT)/usr/include/harfbuzz \
	HARFBUZZ_LIBS=-L$(SYSROOT)/usr/lib \
	LIBS="-lstdc++"

#
# autoconf
#
PANGO_MODULES-$(PTXCONF_PANGO_BASIC)	+= basic-fc,basic-win32,basic-x,basic-atsui
PANGO_MODULES-$(PTXCONF_PANGO_ARABIC)	+= arabic-fc
PANGO_MODULES-$(PTXCONF_PANGO_HANGUL)	+= hangul-fc
PANGO_MODULES-$(PTXCONF_PANGO_HEBREW)	+= hebrew-fc
PANGO_MODULES-$(PTXCONF_PANGO_INDIC)	+= indic-fc,indic-lang
PANGO_MODULES-$(PTXCONF_PANGO_KHMER)	+= khmer-fc
PANGO_MODULES-$(PTXCONF_PANGO_SYRIAC)	+= syriac-fc
PANGO_MODULES-$(PTXCONF_PANGO_THAI)	+= thai-fc
PANGO_MODULES-$(PTXCONF_PANGO_TIBETAN)	+= tibetan-fc

PANGO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-xft \
	--x-includes=$(XORG_PREFIX)/include \
	--x-libraries=$(XORG_LIBDIR) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-doc-cross-references \
	--disable-debug

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/pango.compile:
	@$(call targetinfo)
	sed "s|tools tests build|tools build|g" -i $(PANGO_DIR)/Makefile
	cd $(PANGO_DIR) && \
		$(PANGO_PATH) $(PANGO_ENV) \
		$(MAKE) LIBS='-lharfbuzz -lcairo'
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pango.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pango)
	@$(call install_fixup, pango,PRIORITY,optional)
	@$(call install_fixup, pango,SECTION,base)
	@$(call install_fixup, pango,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pango,DESCRIPTION,missing)

	@$(call install_lib, pango, 0, 0, 0644, libpango-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangoft2-1.0)
	@$(call install_lib, pango, 0, 0, 0644, libpangocairo-1.0)

	@$(call install_finish, pango)

	@$(call touch)

# vim: syntax=make
