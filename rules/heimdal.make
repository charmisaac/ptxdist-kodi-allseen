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
PACKAGES-$(PTXCONF_HEIMDAL) += heimdal

#
# Paths and names
#
HEIMDAL_VERSION	:= 1.5.3
HEIMDAL_MD5	:= 30b379e3de12f332fbd201131f02ffca
HEIMDAL		:= heimdal-$(HEIMDAL_VERSION)
HEIMDAL_SUFFIX	:= tar.gz
HEIMDAL_URL	:= http://www.h5l.org/dist/src/$(HEIMDAL).$(HEIMDAL_SUFFIX)
HEIMDAL_SOURCE	:= $(SRCDIR)/$(HEIMDAL).$(HEIMDAL_SUFFIX)
HEIMDAL_DIR	:= $(BUILDDIR)/$(HEIMDAL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HEIMDAL_ENV	:= \
	$(CROSS_ENV) \
	LIBS="-lstdc++ -lpthread" \
	COMPILE_ET=$(PTXDIST_SYSROOT_HOST)/bin/compile_et

#
# autoconf
#
HEIMDAL_CONF_TOOL	:= autoconf
HEIMDAL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-cross-tools=$(PTXDIST_SYSROOT_HOST)/bin/

#$(STATEDIR)/heimdal.prepare:
#	@$(call targetinfo)
#	@$(call world/prepare, HEIMDAL)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/heimdal.compile:
	@$(call targetinfo)
	sed -e "s| doc||g" -i $(HEIMDAL_DIR)/Makefile
	$(call world/compile, HEIMDAL)
	@$(call touch)

# ----------------------------------------------------------------------------
# TargetInstall
# ----------------------------------------------------------------------------

$(STATEDIR)/heimdal.targetinstall:
	@$(call targetinfo)

	@$(call install_init, heimdal)
	@$(call install_fixup, heimdal,PRIORITY,optional)
	@$(call install_fixup, heimdal,SECTION,base)
	@$(call install_fixup, heimdal,AUTHOR,"fga")
	@$(call install_fixup, heimdal,DESCRIPTION,missing)

	@$(call install_lib, heimdal, 0, 0, 0644, libasn1)
	@$(call install_lib, heimdal, 0, 0, 0644, libcom_err)
	@$(call install_lib, heimdal, 0, 0, 0644, libgssapi)
#	@$(call install_lib, heimdal, 0, 0, 0644, libhcrypto)
	@$(call install_lib, heimdal, 0, 0, 0644, libhdb)
	@$(call install_lib, heimdal, 0, 0, 0644, libheimbase)
	@$(call install_lib, heimdal, 0, 0, 0644, libheimedit)
	@$(call install_lib, heimdal, 0, 0, 0644, libheimntlm)
	@$(call install_lib, heimdal, 0, 0, 0644, libheimsqlite)
	@$(call install_lib, heimdal, 0, 0, 0644, libhx509)
	@$(call install_lib, heimdal, 0, 0, 0644, libkadm5clnt)
	@$(call install_lib, heimdal, 0, 0, 0644, libkadm5srv)
	@$(call install_lib, heimdal, 0, 0, 0644, libkafs)
	@$(call install_lib, heimdal, 0, 0, 0644, libkdc)
	@$(call install_lib, heimdal, 0, 0, 0644, libkrb5)
	@$(call install_lib, heimdal, 0, 0, 0644, libroken)
	@$(call install_lib, heimdal, 0, 0, 0644, libsl)
	@$(call install_lib, heimdal, 0, 0, 0644, libwind)
	@$(call install_lib, heimdal, 0, 0, 0644, windc)

	@$(call install_copy, heimdal, 0, 0, 1755, -, /usr/bin/su)
	@$(call install_copy, heimdal, 0, 0, 1755, -, /usr/bin/otp)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/afslog)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/ftp)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/gsstool)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/hxtool)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/idn-lookup)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/kcc)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/kdestroy)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/kf)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/kgetcred)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/kinit)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/kpasswd)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/kx)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/login)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/otpprint)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/rcp)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/rsh)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/rxtelnet)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/string2key)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/telnet)
#	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/telnetrx)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/bin/xnlock)

#	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/sbin/iprog-log)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/sbin/kadmin)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/sbin/kstash)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/sbin/ktutil)

	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/digest-service)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/ftpd)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/hprop)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/hpropd)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/ipropd-master)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/ipropd-slave)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kadmind)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kcm)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kdc)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kdigest)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kfd)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kimpersonate)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kpasswdd)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/kxd)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/popper)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/push)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/rshd)
	@$(call install_copy, heimdal, 0, 0, 0755, -, /usr/libexec/telnetd)

	@$(call install_finish, heimdal)

	@$(call touch)

# vim: syntax=make
