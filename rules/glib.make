# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIB) += glib

#
# Paths and names
#
#ifdef PTXCONF_GLIB_EXPERIMENTAL
#GLIB_VERSION	:= 2.27.93
#GLIB_MD5	:=
#else
GLIB_VERSION	:= 2.47.3
GLIB_MD5	:= 7758ba6fd2b3a4320cdb96b0af1d2fdf
#endif

GLIB		:= glib-$(GLIB_VERSION)
GLIB_SUFFIX	:= tar.xz
GLIB_SOURCE	:= $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR	:= $(BUILDDIR)/$(GLIB)

GLIB_URL	:= http://ftp.gnome.org/pub/GNOME/sources/glib/$(basename $(GLIB_VERSION))/glib-$(GLIB_VERSION).$(GLIB_SUFFIX)

GLIB_LICENSE	:= LGPL-2.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIB_CONF_ENV	:= \
	$(CROSS_ENV) \
	glib_cv_uscore=no \
	glib_cv_stack_grows=no \
	glib_cv_have_qsort_r=yes \
	ac_cv_func_statfs=yes \
	ac_cv_path_MSGFMT=: \
	ac_cv_path_XGETTEXT=no \
	LDFLAGS="-L$(PTXDIST_SYSROOT_TOOLCHAIN)/lib -L$(PTXDIST_SYSROOT_TOOLCHAIN)/usr/lib -L$(SYSROOT)/usr/lib -L$(SYSROOT)/usr/lib64"


#
# autoconf
#
# --with-libiconv=no does also find the libc iconv implementation! So it
# is the right choice for no locales and locales-via-libc
#

GLIB_CONF_TOOL	:= autoconf
GLIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-silent-rules \
	--enable-debug=minimum \
	--disable-gc-friendly \
	--enable-mem-pools \
	--disable-rebuilds \
	--disable-installed-tests \
	--disable-always-build-tests \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--enable-shared \
	--disable-included-printf \
	--disable-selinux \
	--disable-fam \
	--enable-xattr \
	--disable-libelf \
	--disable-gtk-doc \
	--disable-man \
	--disable-dtrace \
	--disable-systemtap \
	--disable-coverage \
	--with-libiconv=gnu \
	--with-threads=posix \
	--with-pcre=internal

# workaround for broken libtool
GLIB_CFLAGS:= -Wl,-rpath-link,$(GLIB_DIR)/gmodule/.libs

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib.install:
	@$(call targetinfo)
	@$(call world/install, GLIB)
	install -D -m755 $(GLIB_DIR)/gobject/glib-mkenums $(PTXDIST_SYSROOT_HOST)/bin/glib-mkenums
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glib)
	@$(call install_fixup, glib,PRIORITY,optional)
	@$(call install_fixup, glib,SECTION,base)
	@$(call install_fixup, glib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, glib,DESCRIPTION,missing)

#	# /usr/bin/gtester-report
#	# /usr/bin/glib-genmarshal
#	# /usr/bin/glib-gettextize
#	# /usr/bin/gobject-query
#	# /usr/bin/glib-mkenums
#	# /usr/bin/gtester

	@$(call install_copy, glib, 0, 0, 0755, /usr/lib/gio/modules)

	@for i in libgio-2.0 libglib-2.0 libgmodule-2.0 libgobject-2.0 libgthread-2.0; do \
		$(call install_lib, glib, 0, 0, 0644, $$i); \
	done

ifdef PTXCONF_GLIB_GDBUS
	@$(call install_copy, glib, 0, 0, 0755, -, /usr/bin/gdbus)
endif
	@$(call install_finish, glib)

	@$(call touch)

# vim: syntax=make
