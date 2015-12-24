# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME, we only need the source tree, do we still need the package ?


#
# We provide this package
#
PACKAGES-$(PTXCONF_ALLJOYN) += alljoyn

#
# Paths and names
#
ALLJOYN_VERSION	:= 15.09.00
ALLJOYN_MD5	:= 49045ea09544ee1d0c264b3ad0c5b89a
ALLJOYN		:= alljoyn-$(ALLJOYN_VERSION)-src
ALLJOYN_SUFFIX	:= tar.gz
ALLJOYN_URL	:= https://allseenalliance.org/releases/alljoyn/$(basename $(ALLJOYN_VERSION))/$(ALLJOYN).$(ALLJOYN_SUFFIX)
ALLJOYN_SOURCE	:= $(SRCDIR)/$(ALLJOYN).$(ALLJOYN_SUFFIX)
ALLJOYN_DIR	:= $(BUILDDIR)/$(ALLJOYN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(STATEDIR)/alljoyn.get:
#	@$(call targetinfo)
#$(ALLJOYN_SOURCE):
#	mkdir -p $(ALLJOYN_DIR)
#	cd $(ALLJOYN_DIR) && \
#		repo init -u $(ALLJOYN_REPO) -b RB15.04 && \
#		repo sync
#	sync
#	cd $(BUILDDIR) && \
#		tar zcvf $(SRCDIR)/$(ALLJOYN).$(ALLJOYN_SUFFIX) $(ALLJOYN)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ALLJOYN_PATH	:= PATH=$(CROSS_PATH)
ALLJOYN_ENV 	:= $(CROSS_ENV) \
	SYSROOT=$(SYSROOT) \
	CROSS_COMPILE=${PTXDIST_WORKSPACE}/selected_toolchain/$(COMPILER_PREFIX) \
	CROSS_PREFIX=$(COMPILER_PREFIX) \
	TARGET_AR=$(COMPILER_PREFIX)ar \
	TARGET_CC=$(COMPILER_PREFIX)gcc \
	TARGET_CXX=$(COMPILER_PREFIX)gxx \
	TARGET_LINK=$(COMPILER_PREFIX)gcc \
	TARGET_RANLIB=$(COMPILER_PREFIX)ranlib \
	TARGET_CFLAGS='-I$(SYSROOT)/usr/include' \
	TARGET_CPPFLAGS='-I$(SYSROOT)/usr/include -D_DEFAULT_SOURCE' \
	TARGET_LDFLAGS='-L$(SYSROOT)/usr/lib -L$(SYSROOT)/lib' \
	STAGING_DIR=$(SYSROOT) \
	CROSS_PATH=${PTXDIST_WORKSPACE}/selected_toolchain \
	CROSS_CFLAGS=-I$(SYSROOT)/usr/include \
	CROSS_LDFLAGS='-L$(SYSROOT)/usr/lib -L$(SYSROOT)/lib' \
	CFLAGS='-I$(SYSROOT)/usr/include' \
	JAVA_HOME=/usr/local/java CLASSPATH=/usr/local/java/junit-4.12.jar \
	GECKO_BASE=$(BUILDDIR)/xulrunner-sdk \
	OPENSSL_ROOT=$(SYSROOT)/usr \
	SSL_LIBS='-L$(SYSROOT)/usr/lib' \
	CAP_LIBS='-L$(SYSROOT)/lib'
# 	TARGET_PATH=${PTXDIST_WORKSPACE}/selected_toolchain:$(CROSS_PATH)
	
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_ABOUT)		+= about,audio
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_C)			+= c
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_CONFIG)		+= config
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_CONFIG_SAMPLES)	+= config-samples
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_CONTROLPANEL)	+= controlpanel
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_CONTROLPANEL_SAMPLES)+= controlpanel-samples
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_NOTIFICATION)	+= notification
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_NOTIFICATION_SAMPLES)+= notification-samples
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_SAMPLE_APPS)		+= sample-apps
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_SERVICE_COMMON)	+= service-common
ALLJOYN_SERVICES-$(PTXCONF_ALLJOYN_ONBORDING)		+= onbording

ALLJOYN_SERVICES := $(shell echo $(ALLJOYN_SERVICES-y) | sed "s| |,|g")

ifdef PTXCONF_ARCH_ARM
ALLJOYN_ENV     += CPPFLAGS="-march=armv7-a -mtune=cortex-a13 -mfloat-abi=hard -mfpu=vfpv3-d16"
endif

ifdef PTXCONF_ARCH_ARM64
ALLJOYN_ENV	+= CPPFLAGS="-march=armv8-a -mtune=cortex-a53"
endif

ALLJOYN_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/alljoyn.compile:
	@$(call targetinfo)
	cd $(ALLJOYN_DIR) && \
		$(ALLJOYN_PATH) $(ALLJOYN_ENV) \
		scons V=1 ICE=off BR=off BT=off WS=off CPU=arm OS=linux BINDINGS="core,cpp,c,objc,unity" SERVICES="$(ALLJOYN_SERVICES)" VARIANT=release
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alljoyn.install:
	@$(call targetinfo)
	cd $(ALLJOYN_DIR)/build/linux/arm/release/dist && \
		for DIST in `ls | grep -v txt`; do \
			cp -a $$DIST/bin $(SYSROOT)/usr; \
			cp -a $$DIST/lib $(SYSROOT)/usr; \
			cp -a $$DIST/inc/* $(SYSROOT)/usr/include; \
		done
	mkdir -p $(ALLJOYN_PKGDIR)/usr
	cd $(ALLJOYN_DIR)/build/linux/arm/release/dist && \
		for DIST in `ls | grep -v txt`; do \
			cp -a $$DIST/bin $$DIST/lib $(ALLJOYN_PKGDIR)/usr; \
		done
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alljoyn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alljoyn)
	@$(call install_fixup, alljoyn,PRIORITY,optional)
	@$(call install_fixup, alljoyn,SECTION,base)
	@$(call install_fixup, alljoyn,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, alljoyn,DESCRIPTION,missing)

	cd $(ALLJOYN_PKGDIR)/usr/bin && \
	for EXE_FILE in `find . -type f | grep -v sample`; do \
		$(call install_copy, alljoyn, 0, 0, 0755, -,\
				/usr/bin/$$(basename $$EXE_FILE)); \
	done

	cd $(ALLJOYN_PKGDIR)/usr/lib && \
	for SO_FILE in `find . -name "lib*.so"`; do \
		$(call install_copy, alljoyn, 0, 0, 0644, -,\
				/usr/lib/$$(basename $$SO_FILE)); \
	done

ifdef PTXCONF_ALLJOYN_SAMPLE_APPS
	cd $(ALLJOYN_PKGDIR)/usr/bin/samples && \
	for EXE_FILE in `find . -type f`; do \
		$(call install_copy, alljoyn, 0, 0, 0755, -,\
			/usr/bin/samples/$$(basename $$EXE_FILE)); \
	done
endif

ifdef PTXCONF_ALLJOYN_BBINIT
ifdef PTXCONF_ALLJOYN_STARTSCRIPT
	@$(call install_alternative, alljoyn, 0, 0, 0755, /etc/init.d/alljoyn)

ifneq ($(call remove_quotes,$(PTXCONF_ALLJOYN_BBINIT_STARTLINK)),)
	@$(call install_link, alljoyn, \
		../init.d/alljoyn, \
		/etc/rc.d/$(PTXCONF_ALLJOYN_BBINIT_STARTLINK))
endif
ifneq ($(call remove_quotes,$(PTXCONF_ALLJOYN_BBINIT_STOPLINK)),)
	@$(call install_link, alljoyn, \
		../init.d/alljoyn, \
		/etc/rc.d/$(PTXCONF_ALLJOYN_BBINIT_STOPLINK))
endif
endif
endif

	@$(call install_finish, alljoyn)

	@$(call touch)


# vim: syntax=make
