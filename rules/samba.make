# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SAMBA) += samba

#
# Paths and names
#
SAMBA_VERSION	:= 4.3.1
SAMBA_MD5	:= e63a481cad0603db1a9239d7606cbc9a
SAMBA		:= samba-$(SAMBA_VERSION)
SAMBA_SUFFIX	:= tar.gz
SAMBA_SOURCE	:= $(SRCDIR)/$(SAMBA).$(SAMBA_SUFFIX)
SAMBA_DIR	:= $(BUILDDIR)/$(SAMBA)
SAMBA_LICENSE	:= GPL-2.0

SAMBA_URL	:= \
	http://www.samba.org/samba/ftp/stable/$(SAMBA).$(SAMBA_SUFFIX) \
	http://www.samba.org/samba/ftp/old-versions/$(SAMBA).$(SAMBA_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SAMBA_PATH	:= PATH=$(CROSS_PATH)
SAMBA_ENV	:= \
	$(CROSS_ENV) \
	CFLAGS=-O2 \
	libreplace_cv_READDIR_NEEDED=no \
	samba_cv_HAVE_BROKEN_FCNTL64_LOCKS=no \
	samba_cv_HAVE_BROKEN_GETGROUPS=no \
	samba_cv_HAVE_C99_VSNPRINTF=yes \
	samba_cv_HAVE_DEVICE_MAJOR_FN=yes \
	samba_cv_HAVE_DEVICE_MINOR_FN=yes \
	samba_cv_HAVE_FCNTL_LOCK=yes \
	samba_cv_HAVE_FTRUNCATE_EXTEND=yes \
	samba_cv_HAVE_GETTIMEOFDAY_TZ=yes \
	samba_cv_HAVE_IFACE_AIX=no \
	samba_cv_HAVE_IFACE_IFCONF=yes \
	samba_cv_HAVE_IFACE_IFREQ=yes \
	samba_cv_HAVE_KERNEL_CHANGE_NOTIFY=yes \
	samba_cv_HAVE_KERNEL_OPLOCKS_LINUX=yes \
	samba_cv_HAVE_KERNEL_SHARE_MODES=yes \
	samba_cv_HAVE_MAKEDEV=yes \
	samba_cv_HAVE_MMAP=yes \
	samba_cv_HAVE_NATIVE_ICONV=yes \
	samba_cv_HAVE_SECURE_MKSTEMP=yes \
	samba_cv_HAVE_STRUCT_FLOCK64=yes \
	samba_cv_HAVE_TRUNCATED_SALT=no \
	samba_cv_HAVE_WORKING_AF_LOCAL=yes \
	samba_cv_LINUX_LFS_SUPPORT=yes \
	samba_cv_REALPATH_TAKES_NULL=yes \
	samba_cv_REPLACE_INET_NTOA=no \
	samba_cv_USE_SETRESUID=yes \
	samba_cv_USE_SETREUID=yes \
	samba_cv_have_longlong=yes \
	samba_cv_have_setresgid=yes \
	samba_cv_have_setresuid=yes

#
# autoconf
#
SAMBA_AUTOCONF := \
	--prefix=/usr \
	--localstatedir=/var \
	--libdir=/usr/lib \
	--sysconfdir=/etc \
	--cross-compile \
	--cross-answers=arm-cache.txt \
	--hostcc=gcc \
	--with-configdir=/etc/samba \
	--with-lockdir=/var/lock \
	--with-logfilebase=/var/log \
	--with-piddir=/var/run \
	--with-privatedir=/etc/samba \
	--with-syslog \
	--without-ads \
	--without-automount \
	--without-ldap \
	--without-pam \
	--without-utmp \
	--without-winbind \
	--enable-fhs \
	--disable-rpath \
	--disable-rpath-install \
	--disable-iprint \
	--without-dmapi \
	--disable-glusterfs \
	--with-cluster-support \
	--bundled-libraries='!asn1_compile,!compile_et'

ifdef PTXCONF_SAMBA_CUPS
SAMBA_AUTOCONF += --enable-cups
else
SAMBA_AUTOCONF += --disable-cups
endif

ifdef PTXCONF_SAMBA_SMBFS
SAMBA_AUTOCONF += --with-smbmount
endif

ifdef PTXCONF_ICONV
SAMBA_AUTOCONF += --with-libiconv=$(SYSROOT)/usr
else
SAMBA_AUTOCONF += --without-libiconv
endif

#SAMBA_SUBDIR := source4
SAMBA_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/samba.targetinstall:
	@$(call targetinfo)

	@$(call install_init, samba)
	@$(call install_fixup, samba,PRIORITY,optional)
	@$(call install_fixup, samba,SECTION,base)
	@$(call install_fixup, samba,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, samba,DESCRIPTION,missing)

	@$(call install_copy, samba, 0, 0, 0755, /etc/samba)

ifdef PTXCONF_SAMBA_COMMON
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/nmblookup)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/net)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbpasswd)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/testparm)
#	@$(call install_copy, samba, 0, 0, 0644, -, \
#		/usr/lib/lowcase.dat)
#	@$(call install_copy, samba, 0, 0, 0644, -, \
#		/usr/lib/upcase.dat)
#	@$(call install_copy, samba, 0, 0, 0644, -, \
#		/usr/lib/valid.dat)
endif

ifdef PTXCONF_SAMBA_SERVER
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/sbin/smbd)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/sbin/nmbd)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/pdbedit)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbcontrol)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbstatus)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/tdbbackup)
endif

ifdef PTXCONF_SAMBA_SMB_CONF
	@$(call install_alternative, samba, 0, 0, 0644, \
		/etc/samba/smb.conf)
endif

ifdef PTXCONF_SAMBA_SECRETS_USER
	@$(call install_alternative, samba, 0, 0, 0600, \
		/etc/sudoers.d/ctdb)
endif

#	#
#	# busybox init
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_SAMBA_STARTSCRIPT
	@$(call install_alternative, samba, 0, 0, 0755, /etc/init.d/samba)

ifneq ($(call remove_quotes,$(PTXCONF_SAMBA_BBINIT_LINK)),)
	@$(call install_link, samba, \
		../init.d/samba, \
		/etc/rc.d/$(PTXCONF_SAMBA_BBINIT_LINK))
endif
endif
endif

ifdef PTXCONF_SAMBA_CLIENT
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbcacls)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbcquotas)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbtree)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbclient)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/rpcclient)
endif

	@$(call install_lib, samba, 0, 0, 0644, libdcerpc-atsvc)
	@$(call install_lib, samba, 0, 0, 0644, libdcerpc-binding)
	@$(call install_lib, samba, 0, 0, 0644, libdcerpc-samr)
	@$(call install_lib, samba, 0, 0, 0644, libdcerpc-server)
	@$(call install_lib, samba, 0, 0, 0644, libdcerpc)
	@$(call install_lib, samba, 0, 0, 0644, libgensec)
	@$(call install_lib, samba, 0, 0, 0644, libndr-krb5pac)
	@$(call install_lib, samba, 0, 0, 0644, libndr-nbt)
	@$(call install_lib, samba, 0, 0, 0644, libndr)
	@$(call install_lib, samba, 0, 0, 0644, libndr-standard)
	@$(call install_lib, samba, 0, 0, 0644, libnetapi)
	@$(call install_lib, samba, 0, 0, 0644, libnss_winbind)
	@$(call install_lib, samba, 0, 0, 0644, libnss_wins)
	@$(call install_lib, samba, 0, 0, 0644, libregistry)
	@$(call install_lib, samba, 0, 0, 0644, libsamba-credentials)
	@$(call install_lib, samba, 0, 0, 0644, libsamba-hostconfig)
	@$(call install_lib, samba, 0, 0, 0644, libsamba-passdb)
	@$(call install_lib, samba, 0, 0, 0644, libsamba-policy)
	@$(call install_lib, samba, 0, 0, 0644, libsamba-util)
	@$(call install_lib, samba, 0, 0, 0644, libsamdb)
	@$(call install_lib, samba, 0, 0, 0644, libsmbclient)
	@$(call install_lib, samba, 0, 0, 0644, libsmbconf)
	@$(call install_lib, samba, 0, 0, 0644, libwbclient)

	@$(call install_copy, samba, 0, 0, 0644, -, \
		/usr/lib/winbind_krb5_locator.so)

ifdef PTXCONF_SAMBA_SMBFS
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbmount)
	@$(call install_copy, samba, 0, 0, 0755, -, \
		/usr/bin/smbumount)
endif

	@$(call install_finish, samba)

	@$(call touch)

# vim: syntax=make
