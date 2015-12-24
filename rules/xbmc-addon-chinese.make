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
PACKAGES-$(PTXCONF_XBMC_ADDON_CHINESE) += xbmc-addon-chinese

#
# Paths and names
#
XBMC_ADDON_CHINESE_VERSION	:= master
XBMC_ADDON_CHINESE_MD5		:= bf64eb1ab300ee1a550162a41de61d98
XBMC_ADDON_CHINESE		:= xbmc-addon-chinese-$(XBMC_ADDON_CHINESE_VERSION)
XBMC_ADDON_CHINESE_SUFFIX	:= zip
XBMC_ADDON_CHINESE_URL		:= https://github.com/taxigps/xbmc-addons-chinese/archive/$(XBMC_ADDON_CHINESE_VERSION).$(XBMC_ADDON_CHINESE_SUFFIX) \
		https://xbmc-addons-chinese.googlecode.com/files/repository.googlecode.xbmc-addons-chinese-eden.zip
XBMC_ADDON_CHINESE_SOURCE	:= $(SRCDIR)/$(XBMC_ADDON_CHINESE).$(XBMC_ADDON_CHINESE_SUFFIX)
XBMC_ADDON_CHINESE_DIR		:= $(BUILDDIR)/$(XBMC_ADDON_CHINESE)
XBMC_ADDON_CHINESE_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XBMC_ADDON_CHINESE_ENV		:= $(CROSS_ENV)

#
# autoconf
#
XBMC_ADDON_CHINESE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--prefix=/usr/share/xbmc \
	--disable-static \
	--enable-shared

$(STATEDIR)/xbmc-addon-chinese.prepare:
	@$(call targetinfo)
	@$(call clean, $(XBMC_ADDON_CHINESE_DIR)/config.cache)
	cd $(XBMC_ADDON_CHINESE_DIR) && \
		sh autogen.sh
	cd $(XBMC_ADDON_CHINESE_DIR) && \
		$(XBMC_ADDON_CHINESE_PATH) $(XBMC_ADDON_CHINESE_ENV) \
		./configure $(XBMC_ADDON_CHINESE_CONF_OPT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xbmc-addon-chinese.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xbmc-addon-chinese)
	@$(call install_fixup, xbmc-addon-chinese,PRIORITY,optional)
	@$(call install_fixup, xbmc-addon-chinese,SECTION,base)
	@$(call install_fixup, xbmc-addon-chinese,AUTHOR,"fabricega")
	@$(call install_fixup, xbmc-addon-chinese,DESCRIPTION,missing)

	@cd $(XBMC_ADDON_CHINESE_PKGDIR) && \
	find . -type f | while read file; do \
		$(call install_copy, xbmc-addon-chinese, 0, 0, 644, \
		$(XBMC_ADDON_CHINESE_PKGDIR)/$$file, \
			/$$file); \
	done

	@$(call install_finish, xbmc-addon-chinese)

	@$(call touch)

# vim: syntax=make
