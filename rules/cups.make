# -*-makefile-*-
#
# Copyright (C) 2012 by fabricega
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CUPS) += cups

#
# Paths and names
#
CUPS_VERSION	:= 2.1.0
CUPS_MD5	:= c4e57a66298bfdba66bb3d5bedd317a4
CUPS		:= cups-$(CUPS_VERSION)-source
CUPS_SUFFIX	:= tar.bz2
CUPS_URL	:= http://www.cups.org/software/$(CUPS_VERSION)/$(CUPS).$(CUPS_SUFFIX)
CUPS_SOURCE	:= $(SRCDIR)/$(CUPS).$(CUPS_SUFFIX)
CUPS_DIR	:= $(BUILDDIR)/$(CUPS)
CUPS_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CUPS_PATH	:= PATH=$(CROSS_PATH)
CUPS_ENV	:= $(CROSS_ENV) \
	CFLAGS="-I$(SYSROOT)/usr/include -I$(SYSROOT)/usr/include/libusb-1.0 -I$(SYSROOT)/usr/include/dbus-1.0 -I$(SYSROOT)/usr/lib/dbus-1.0/include -I$(SYSROOT)/usr/include/gssglue" \
	CXXFLAGS="-I$(SYSROOT)/usr/include" \
	LDFLAGS="-L$(SYSROOT)/usr/lib"

CUPS_CONF_TOOL	:= autoconf
CUPS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR)	\
	--libdir=/usr/lib	\
	--disable-gssapi	\
	--with-rcdir=/tmp/cupsinit	\
	--with-system-groups=lpadmin	\
	--with-docdir=/usr/share/cups/doc-2.1.0 

CUPS_INSTALL_OPT	:= \
	BUILDROOT=$(CUPS_PKGDIR) install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cups.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cups)
	@$(call install_fixup, cups,PRIORITY,optional)
	@$(call install_fixup, cups,SECTION,base)
	@$(call install_fixup, cups,AUTHOR,"fabricega")
	@$(call install_fixup, cups,DESCRIPTION,missing)

	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/cancel)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/cups-config)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/ipptool)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/lpq)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/lpr)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/lprm)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/lpstat)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/ppdc)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/ppdhtml)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/ppdi)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/ppdmerge)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/bin/ppdpo)

	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/cupsaccept)
	@$(call install_link, cups, cupsaccept, /usr/sbin/accept)
	@$(call install_link, cups, cupsaccept, /usr/sbin/cupsdisable)
	@$(call install_link, cups, cupsaccept, /usr/sbin/cupsenable)
	@$(call install_link, cups, cupsaccept, /usr/sbin/cupsreject)
	@$(call install_link, cups, cupsaccept, /usr/sbin/reject)

	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/cupsaddsmb)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/cupsctl)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/cupsd)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/cupsfilter)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/lpadmin)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/lpc)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/lpinfo)
	@$(call install_copy, cups, 0, 0, 0755, -, /usr/sbin/lpmove)

	@$(call install_lib, cups, 0, 0, 0644, libcupscgi)
	@$(call install_lib, cups, 0, 0, 0644, libcupsimage)
	@$(call install_lib, cups, 0, 0, 0644, libcupsmime)
	@$(call install_lib, cups, 0, 0, 0644, libcupsppdc)
	@$(call install_lib, cups, 0, 0, 0644, libcups)

	@cd $(CUPS_PKGDIR)/etc && \
	find . -type f | while read file; do \
		$(call install_copy, cups, 0, 0, 644, \
			$(CUPS_PKGDIR)/etc/$$file, \
			/etc/$$file); \
	done

	@cd $(CUPS_PKGDIR)/tmp/cupsinit && \
	find . -type f | while read file; do \
		$(call install_copy, cups, 0, 0, 644, \
			$(CUPS_PKGDIR)/tmp/cupsinit/$$file, \
			/etc/$$file); \
	done    

	@$(call install_finish, cups)

	@$(call touch)

# vim: syntax=make
