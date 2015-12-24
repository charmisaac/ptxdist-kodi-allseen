# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HARFBUZZ) += harfbuzz

#
# Paths and names
#
HARFBUZZ_VERSION	:= 1.0.6
HARFBUZZ_MD5		:= 2256fd144c936936db9c92e77510a011
HARFBUZZ		:= harfbuzz-$(HARFBUZZ_VERSION)
HARFBUZZ_SUFFIX		:= tar.bz2
HARFBUZZ_URL		:= http://www.freedesktop.org/software/harfbuzz/release/$(HARFBUZZ).$(HARFBUZZ_SUFFIX)
HARFBUZZ_SOURCE		:= $(SRCDIR)/$(HARFBUZZ).$(HARFBUZZ_SUFFIX)
HARFBUZZ_DIR		:= $(BUILDDIR)/$(HARFBUZZ)
HARFBUZZ_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HARFBUZZ_ENV	:= \
	$(CROSS_ENV) \
	CAIRO_CFLAG=-I$(SYSROOT)/usr/include/cairo \
	CAIRO_LIBS=-L$(SYSROOT)/usr/lib \
	FREETYPE_CFLAG=-I$(SYSROOT)/usr/include/freetype2 \
        FREETYPE_LIBS=-L$(SYSROOT)/usr/lib \
	LDFLAGS+='-lfreetype' LIBS="-lstdc++"

#
# autoconf
#
HARFBUZZ_CONF_TOOL	:= autoconf

HARFBUZZ_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-glib=yes


ifdef PTXCONF_CAIRO
HARFBUZZ_CONF_OPT	+=	--with-cairo=yes 
else
HARFBUZZ_CONF_OPT       +=      --with-cairo=no
endif
ifdef PTXCONF_FREETYPE
HARFBUZZ_CONF_OPT       +=      --with-freetype=yes
else
HARFBUZZ_CONF_OPT       +=      --with-freetype=no
endif
ifdef PTXCONF_ICU
HARFBUZZ_CONF_OPT       +=      --with-icu=yes
else
HARFBUZZ_CONF_OPT       +=      --with-icu=no
endif

$(STATEDIR)/harfbuzz.prepare:
	@$(call targetinfo)
	@$(call clean, $(HARFBUZZ_DIR)/config.cache)
	cd $(HARFBUZZ_DIR) && \
		$(HARFBUZZ_PATH) $(HARFBUZZ_ENV) \
		./configure $(HARFBUZZ_CONF_OPT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

#$(STATEDIR)/harfbuzz.install:
#	@$(call targetinfo)
#	@$(call worl/install, HARFBUZZ)
#	cp $(HARFBUZZ_DIR)/src/hb*.h $(SYSROOT)/usr/include
#	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/harfbuzz.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  harfbuzz)
	@$(call install_fixup, harfbuzz,PRIORITY,optional)
	@$(call install_fixup, harfbuzz,SECTION,base)
	@$(call install_fixup, harfbuzz,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, harfbuzz,DESCRIPTION,missing)

#	@$(call install_copy, harfbuzz, 0, 0, 0755, -, /usr/lib/libharfbuzz.so)
	@$(call install_lib, harfbuzz, 0, 0, 0644, libharfbuzz)

	@$(call install_finish, harfbuzz)

	@$(call touch)

# vim: syntax=make
