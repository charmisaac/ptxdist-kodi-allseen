# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
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
PACKAGES-$(PTXCONF_GSTREAMER) += gstreamer

#
# Paths and names
#
GSTREAMER_VERSION	:= 1.6.1
GSTREAMER_MD5		:= e72e2dc2ee06bfc045bb6010c89de520
GSTREAMER		:= gstreamer-$(GSTREAMER_VERSION)
GSTREAMER_SUFFIX	:= tar.xz
GSTREAMER_URL		:= http://gstreamer.freedesktop.org/src/gstreamer/$(GSTREAMER).$(GSTREAMER_SUFFIX)
GSTREAMER_SOURCE	:= $(SRCDIR)/$(GSTREAMER).$(GSTREAMER_SUFFIX)
GSTREAMER_DIR		:= $(BUILDDIR)/$(GSTREAMER)
GSTREAMER_LICENSE	:= LGPL-2.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GSTREAMER_GENERIC_CONF_OPT = \
	--disable-static \
	--disable-nls \
	--disable-rpath \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--disable-gtk-doc \
	--disable-silent-rules \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--disable-gobject-cast-checks

GSTREAMER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--$(call ptx/endis,PTXCONF_GSTREAMER_DEBUG)-gst-debug \
	--$(call ptx/endis,PTXCONF_GSTREAMER_CMDLINEPARSER)-parse \
	--$(call ptx/endis,PTXCONF_GSTREAMER_OPTIONPARSING)-option-parsing \
	--disable-trace \
	--disable-alloc-trace \
	--enable-registry \
	--enable-plugin \
	--disable-tests \
	--disable-failing-tests \
	--disable-poisoning \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-introspection \
	--disable-docbook \
	--disable-check \
	--enable-Bsymbolic

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer)
	@$(call install_fixup, gstreamer,PRIORITY,optional)
	@$(call install_fixup, gstreamer,SECTION,base)
	@$(call install_fixup, gstreamer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gstreamer,DESCRIPTION,missing)

ifdef PTXCONF_GSTREAMER_INSTALL_TYPEFIND
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-typefind-1.0)
endif
ifdef PTXCONF_GSTREAMER_INSTALL_INSPECT
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-inspect-1.0)
endif
ifdef PTXCONF_GSTREAMER_INSTALL_LAUNCH
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-launch-1.0)
endif

	@$(call install_lib, gstreamer, 0, 0, 0644, libgstbase-1.0)
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstcontroller-1.0)
ifdef PTXCONF_GSTREAMER_NETDIST
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstnet-1.0)
endif
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstreamer-1.0)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/gstreamer-1.0/libgstcoreelements.so)

	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/libexec/gstreamer-1.0/gst-plugin-scanner)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer)
endif

	@$(call install_finish, gstreamer)

	@$(call touch)

# vim: syntax=make
