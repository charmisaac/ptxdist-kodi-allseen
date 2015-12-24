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
PACKAGES-$(PTXCONF_BCMWL) += bcmwl

#
# Paths and names
#
BCMWL_VERSION	:= 6_37_14_88
BCMWL		:= aardvark01t_rel_$(BCMWL_VERSION)
BCMWL_SUFFIX	:= tgz
BCMWL_URL	:= https://supports.broadcom.com/bcmwl/$(BCMWL_VERSION)
BCMWL_SOURCE	:= $(SRCDIR)/$(BCMWL).$(BCMWL_SUFFIX)
BCMWL_DIR	:= $(BUILDDIR)/$(BCMWL)
BCMWL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/bcmwl.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BCMWL_ENV 	:= $(CROSS_ENV) \
	EXTRA_CFLAGS="-mabi=aapcs-linux -mfpu=vfp -marm -D__LINUX_ARM_ARCH__=7 -march=armv7-a -Uarm -Wframe-larger-than=1024 " \
	BRAND=linux-external-wl STBLINUX=1 ARCH=arm WET=1 WLLXIW=0 BRCM_WLAN_IFNAME=wln%d RPC_RETURN_WAIT_TIMEOUT_MSEC=30000 WL_DNGL_WD=0 BCMEXTNVM=1 \
	TARGETARCH=arm 
TARGET=arm-apdef-stadef-p2p
KERNELRELEASE=$(shell cat $(KERNEL_DIR)/include/config/kernel.release 2> /dev/null)

$(STATEDIR)/bcmwl.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/bcmwl.compile:
	@$(call targetinfo)
	cd $(BCMWL_DIR)/src && \
		$(BCMWL_ENV) $(BCMWL_PATH) \
		$(MAKE) -C wl/linux LINUXDIR=$(KERNEL_DIR) LINUXVER=$(KERNELRELEASE) $(TARGET)
	cd $(BCMWL_DIR)/src && \
		$(MAKE) -C wl/exe $(BCMWL_ENV) ASD=0 TARGETARCH=arm_le
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bcmwl.install:
	@$(call targetinfo)
#	@cd $(BCMWL_DIR) && \
#		make LINUXDIR=$(KERNEL_DIR) SYSROOT=$(SYSROOT) install
	@mkdir -p $(BCMWL_PKGDIR)/lib/module/$(KERNELRELEASE)/kernel/drivers/net/wireless
	@mkdir -p $(BCMWL_PKGDIR)/usr/bin
	@cp -ar $(BCMWL_DIR)/src/wl/linux/obj-$(TARGET)-$(KERNELRELEASE)/wl.ko $(BCMWL_PKGDIR)/lib/modules/$(KERNELRELEASE)/kernel/drivers/net/wireless/wl.ko
	@cp -ar $(BCMWL_DIR)/src/wl/exe/wlarm_le $(BCMWL_PKGDIR)/usr/bin/wl
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bcmwl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bcmwl)
	@$(call install_fixup, bcmwl,PRIORITY,optional)
	@$(call install_fixup, bcmwl,SECTION,base)
	@$(call install_fixup, bcmwl,AUTHOR,"fabricega")
	@$(call install_fixup, bcmwl,DESCRIPTION,missing)

	@$(call install_copy, bcmwl, 0, 0, 0644, -, /lib/modules/$(KERNELRELEASE)/kernel/drivers/net/wireless/wl.ko, n)
	@$(call install_copy, bcmwl, 0, 0, 0755, -, /usr/bin/wl)

	@$(call install_finish, bcmwl)

	@$(call touch)
