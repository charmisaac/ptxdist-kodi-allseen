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
PACKAGES-$(PTXCONF_LIBHARU) += libharu

#
# Paths and names
#
LIBHARU_VERSION	:= 2_3_0
LIBHARU_MD5	:= 4f916aa49c3069b3a10850013c507460
LIBHARU		:= libharu-RELEASE_$(LIBHARU_VERSION)
LIBHARU_SUFFIX	:= tar.gz
LIBHARU_URL	:= https://github.com/libharu/libharu/archive/RELEASE_$(LIBHARU_VERSION).$(LIBHARU_SUFFIX)
LIBHARU_SOURCE	:= $(SRCDIR)/$(LIBHARU).$(LIBHARU_SUFFIX)
LIBHARU_DIR	:= $(BUILDDIR)/$(LIBHARU)
LIBHARU_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBHARU_PATH	:= PATH=$(CROSS_PATH)
LIBHARU_ENV	:= $(CROSS_ENV) \
	CC=${CROSS_CC} CXX=${CROSS_CXX}

LIBHARO_CONF_TOOL	:= cmake
LIBHARU_CONF_OPT	:= \
	$(CROSS_CMAKE_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libharu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libharu)
	@$(call install_fixup, libharu,PRIORITY,optional)
	@$(call install_fixup, libharu,SECTION,base)
	@$(call install_fixup, libharu,AUTHOR,"fabricega")
	@$(call install_fixup, libharu,DESCRIPTION,missing)

	@$(call install_copy, libharu, 0, 0, 0644, -, /usr/lib/libhpdf.so)

	@$(call install_finish, libharu)

	@$(call touch)

# vim: syntax=make
