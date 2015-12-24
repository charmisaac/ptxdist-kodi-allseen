# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GDK_PIXBUF) += host-gdk-pixbuf

#
# Paths and names
#
HOST_GDK_PIXBUF		= $(GDK_PIXBUF)
HOST_GDK_PIXBUF_DIR	= $(HOST_BUILDDIR)/$(HOST_GDK_PIXBUF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GDK_PIXBUF_PATH	:= PATH=$(HOST_PATH)
HOST_GDK_PIXBUF_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_GDK_PIXBUF_CONF_TOOL	:= autoconf
HOST_GDK_PIXBUF_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-rebuilds \
	--enable-explicit-deps=no \
	--disable-nls \
	--disable-rpath \
	--disable-glibtest \
	--disable-modules \
	--disable-introspection \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-man \
	--disable-Bsymbolic \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--with-included-loaders=png \
	--without-libtiff \
	--without-libjpeg \
	--without-gdiplus

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gdk-pixbuf.compile:
	@$(call targetinfo)
	cd $(HOST_GDK_PIXBUF_DIR) && \
		$(HOST_GDK_PIXBUF_PATH) $(HOST_GDK_PIXBUF_ENV) \
		$(MAKE) -C gdk-pixbuf
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gdk-pixbuf.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_GDK_PIXBUF_DIR)/gdk-pixbuf/gdk-pixbuf-csource $(PTXDIST_SYSROOT_HOST)/bin/gdk-pixbuf-csource
	@$(call touch)

# vim: syntax=make
