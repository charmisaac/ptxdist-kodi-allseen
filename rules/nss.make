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
PACKAGES-$(PTXCONF_NSS) += nss

#
# Paths and names
#
NSS_VERSION	:= 3.21
NSS_MD5		:= 3c8b2ed880dd3a8d86c9e0151afe6eba
NSS		:= nss-$(NSS_VERSION)
NSS_SUFFIX	:= tar.gz
NSS_URL		:= http://ftp.mozilla.org/pub/mozilla.org/security/nss/releases/NSS_3_21_RTM/src/$(NSS).$(NSS_SUFFIX)
NSS_SOURCE	:= $(SRCDIR)/$(NSS).$(NSS_SUFFIX)
NSS_DIR		:= $(BUILDDIR)/$(NSS)
NSS_SUBDIR	:= nss
NSS_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NSS_MAKE_ENV	:= \
	NATIVE_CC=gcc \
	OS_TARGET=Linux \
	COMPILER_PREFIX=$(COMPILER_PREFIX) \
	COMPILER_TAG=_$(COMPILER_PREFIX)gcc \
	INCLUDES="-I$(SYSROOT)/kernel-headers/include -I$(SYSROOT)/usr/include/nspr -I$(SYSROOT)/usr/include" \
	LDFLAGS+="-L$(SYSROOT)/usr/lib -lstdc++" LIBS+="-lstdc++" \
 	NSPR_INCLUDE_DIR=$(SYSROOT)/usr/include/nspr \
 	NSPR_LIB_DIR=$(SYSROOT)/usr/lib \
	PKG_BIN_DIR=$(NSS_PKGDIR)/usr/bin \
	PKG_LIB_DIR=$(NSS_PKGDIR)/usr/lib \
	NSS_USE_SYSTEM_SQLITE=1 \
	USE_SYSTEM_ZLIB=1 \
	USE_PTHRESDS=1 \
	ZLIB_LIBS=-lz \
	NSS_DISABLE_DBM=1 \
	NSS_DISABLE_GTESTS=1 \
	PR_BYTES_PER_LONG=4

NSS_INSTALL_OPT	:= install \
	SOURCE_RELEASE_PREFIX=$(NSS_PKGDIR) \
	SOURCE_LIB_DIR=$(SYSROOT)/usr/lib \
	SOURCE_BIN_DIR=$(SYSROOT)/usr/bin \
	PKG_BIN_DIR=$(NSS_PKGDIR)/usr/bin \
	PKG_LIB_DIR=$(NSS_PKGDIR)/usr/lib

ifdef PTXCONF_ARCH_ARM
NSS_MAKE_ENV    += TARGET_ARCH=arm USE_64=1
endif

ifdef PTXCONF_ARCH_ARM64
NSS_MAKE_ENV	+= TARGET_ARCH=aarch64 USE_64=1
endif

NSS_MAKE_ENV	+= CROSS_COMPILE=1 \
        COMPILER_PREFIX=$(COMPILER_PREFIX)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/nss.compile:
	@$(call targetinfo)
	mkdir -p $(NSS_PKGDIR)/usr/bin $(NSS_PKGDIR)/usr/lib
#	$(call world/compile, NSS)
	cd $(NSS_DIR)/nss && \
		$(NSS_PATH) $(NSS_MAKE_ENV) \
		$(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nss.install:
	@$(call targetinfo)
#	 $(call world/install, NSS)
	cd $(NSS_DIR)/nss && \
		$(NSS_PATH) $(NSS_MAKE_ENV) \
		$(MAKE) install
	install -D -m755 $(NSS_DIR)/nss/config/nss-config $(SYSROOT)/usr/bin/nss-config
	install -D -m644 $(NSS_DIR)/nss/config/nss.pc $(SYSROOT)/usr/lib/pkgconfig/nss.pc
	mkdir -p $(SYSROOT)/usr/include/nss
	cd $(NSS_DIR)/nss/lib && \
	for SEC_HEADER in util/secitem.h certdb/cert.h nss/nss.h util/utilrename.h util/base64.h \
			util/seccomon.h util/secport.h util/secdert.h util/secoidt.h \
			cryptohi/keyt.h cryptohi/keythi.h util/pkcs11.h util/pkcs11t.h \
			util/pkcs11p.h util/pkcs11n.h util/pkcs11u.h smime/cmst.h \
			pk11wrap/secmodt.h util/nssrwlk.h util/nssrwlkt.h util/nssilock.h \
			util/nssilckt.h util/secoid.h util/secasn1.h util/secasn1t.h \
			util/utilmodt.h certdb/certt.h util/nssutil.h util/secerr.h cryptohi/key.h \
			util/hasht.h cryptohi/keyhi.h pk11wrap/pk11func.h pk11wrap/pk11pub.h \
			pkcs7/pkcs7t.h smime/cmsreclist.h pk11wrap/pk11priv.h cryptohi/cryptohi.h \
			freebl/blapit.h freebl/ecl/ecl-exp.h cryptohi/cryptoht.h util/secder.h \
			cryptohi/sechash.h pk11wrap/secmod.h certhigh/ocsp.h certhigh/ocspt.h \
			cryptohi/key.h util/base64.h certdb/certdb.h pkcs12/pkcs12.h smime/cms.h \
			pkcs7/secpkcs7.h util/secdig.h util/secdigt.h pkcs12/p12.h pkcs12/p12t.h \
			pkcs12/pkcs12t.h util/pkcs11f.h pkcs12/p12plcy.h util/ciferfam.h; do \
		cp $(NSS_DIR)/nss/lib/$$SEC_HEADER  $(SYSROOT)/usr/include/nss/$$(basename $$SEC_HEADER); \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nss.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nss)
	@$(call install_fixup, nss,PRIORITY,optional)
	@$(call install_fixup, nss,SECTION,base)
	@$(call install_fixup, nss,AUTHOR,"fga")
	@$(call install_fixup, nss,DESCRIPTION,missing)

	cd $(NSS_DIR)/dist/ && \
		find Linux* -name *.so -type f | while read file; do \
			$(call install_copy, nss, 0, 0, 755, \
				$(NSS_DIR)/dist/$$file, \
				/usr/lib/$$(basename $$file)); \
		done

	@$(call install_finish, nss)

	@$(call touch)

# vim: syntax=make
