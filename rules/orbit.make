# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
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
PACKAGES-$(PTXCONF_ORBIT2) += orbit2

#
# Paths and names
#
ORBIT2_VERSION	:= 2.14.19
ORBIT2_MD5	:= 7082d317a9573ab338302243082d10d1
ORBIT2		:= ORBit2-$(ORBIT2_VERSION)
ORBIT2_SUFFIX	:= tar.bz2
ORBIT2_URL	:= http://ftp.gnome.org/pub/GNOME/sources/ORBit2/2.14/$(ORBIT2).$(ORBIT2_SUFFIX)
ORBIT2_SOURCE	:= $(SRCDIR)/$(ORBIT2).$(ORBIT2_SUFFIX)
ORBIT2_DIR	:= $(BUILDDIR)/$(ORBIT2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ORBIT2_SOURCE):
	@$(call targetinfo)
	@$(call get, ORBIT2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ORBIT2_PATH	:= PATH=$(CROSS_PATH)
ORBIT2_ENV 	:= $(CROSS_ENV) \
	ac_cv_c_bigendian=no \
	ac_cv_alignof_CORBA_octet=1 \
	ac_cv_alignof_CORBA_boolean=1 \
	ac_cv_alignof_CORBA_char=1 \
	ac_cv_alignof_CORBA_wchar=2 \
	ac_cv_alignof_CORBA_short=2 \
	ac_cv_alignof_CORBA_float=4 \
	ac_cv_alignof_CORBA_long=4 \
	ac_cv_alignof_CORBA_long_long=8 \
	ac_cv_alignof_CORBA_double=8 \
	ac_cv_alignof_CORBA_long_double=8 \
	ac_cv_alignof_CORBA_struct=1 \
	ac_cv_alignof_CORBA_pointer=4

#
# autoconf
#
ORBIT2_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-purify --disable-static

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/orbit2.compile:
	@$(call targetinfo)
	cp $(HOST_ORBIT2_DIR)/src/idl-compiler/Makefile $(ORBIT2_DIR)/src/idl-compiler/
	$(call world/compile, ORBIT2)
	cp $(ORBIT2_DIR)/src/idl-compiler/orbit-idl-2 $(PTXCONF_SYSROOT_CROSS)/bin/
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/orbit2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, orbit2)
	@$(call install_fixup, orbit2,PRIORITY,optional)
	@$(call install_fixup, orbit2,SECTION,base)
	@$(call install_fixup, orbit2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, orbit2,DESCRIPTION,missing)

	@$(call install_copy, orbit2, 0, 0, 0755, -, /usr/bin/ior-decode-2)
	@$(call install_copy, orbit2, 0, 0, 0755, -, /usr/bin/linc-cleanup-sockets)
	@$(call install_copy, orbit2, 0, 0, 0755, -, /usr/bin/orbit2-config)

	@$(call install_lib, orbit2, 0, 0, 0644, libORBit-2)
	@$(call install_lib, orbit2, 0, 0, 0644, libORBitCosNaming-2)
	@$(call install_lib, orbit2, 0, 0, 0644, libORBit-imodule-2)


	@$(call install_finish, orbit2)

	@$(call touch)

# vim: syntax=make
