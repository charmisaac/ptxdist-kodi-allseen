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
PACKAGES-$(PTXCONF_X265) += x265

#
# Paths and names
#
X265_VERSION	:= 1.8
X265_MD5	:= 72005f2c0acda56913c0eae4562dc5ad
X265		:= x265_$(X265_VERSION)
X265_SUFFIX	:= tar.gz
X265_URL	:= http://ftp.videolan.org/pub/videolan/x265/$(X265).$(X265_SUFFIX)
X265_SOURCE	:= $(SRCDIR)/$(X265).$(X265_SUFFIX)
X265_DIR	:= $(BUILDDIR)/$(X265)
X265_SUBDIR	:= source
X265_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

X265_PATH := PATH=${PTXDIST_SYSROOT_TOOLCHAIN}/../bin:${PATH}
X265_ENV := \
	$(CROSS_ENV)

X265_CONF_TOOL	:= cmake
X265_CONF_OPT	= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_SYSTEM_PROCESSOR=armv7l \
	-DCMAKE_RELEASE_TYPE=Release \
	-DBUILD_SHARED_LIBS=ON \
	-DENABLE_PIC=ON

$(STATEDIR)/x265.prepare:
	@$(call targetinfo)
	echo "SET(CMAKE_SYSTEM_NAME Linux)" > $(X265_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_PROCESSOR arm)" >> $(X265_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_VERSION 1)" >> $(X265_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CROSSCOMPILING 1)" >> $(X265_DIR)/cmake_toolchain.txt
	echo "" >> $(X265_DIR)/cmake_toolchain.txt
	echo "" >> $(X265_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_C_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CC})" >> $(X265_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_C_FLAGS \"-I${SYSROOT}/usr/include -L${SYSROOT}/usr/lib\")" >> $(X265_DIR)/cmake_toolchain.txt
	echo "" >> $(X265_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_CXX_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CXX} \"-Wl,rpath=${PTXDIST_SYSROOT_TOOLCHAIN}/usr/lib \")" >> $(X265_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CXX_FLAGS \"-I${SYSROOT}/usr/include -DHAVE_STRTOK_R=1 -fPIC -L${SYSROOT}/usr/lib\")" >> $(X265_DIR)/cmake_toolchain.txt
	echo "" >> $(X265_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_SYSROOT $(SYSROOT))" >> $(X265_DIR)/cmake_toolchain.txt

	echo "SET(NUMA_ROOT_DIR $(SYSROOT)/usr)" >> $(X265_DIR)/cmake_toolchain.txt
	echo "SET(NUMA_INCLUDE_DIR $(SYSROOT)/usr/include)" >> $(X265_DIR)/cmake_toolchain.txt
	echo "SET(NUMA_LIBRARY $(SYSROOT)/usr/lib)" >> $(X265_DIR)/cmake_toolchain.txt

	@sync
	cd $(X265_DIR)/source && $(X265_PATH) $(X265_ENV) cmake -DCMAKE_TOOLCHAIN_FILE=$(X265_DIR)/cmake_toolchain.txt ${X265_CONF_OPT} .

	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/x265.compile:
	@$(call targetinfo)
	cd $(X265_DIR)/source && \
		$(X265_PATH) $(X265_ENV) \
		$(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/x265.install:
	@$(call targetinfo)
	cd $(X265_DIR)/source && \
		$(X265_PATH) $(X265_ENV) \
		$(MAKE) install DESTDIR=$(SYSROOT)
	cd $(X265_DIR)/source && \
		$(X265_PATH) $(X265_ENV) \
		$(MAKE) install DESTDIR=$(X265_PKGDIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/x265.targetinstall:
	@$(call targetinfo)

	@$(call install_init, x265)
	@$(call install_fixup, x265,PRIORITY,optional)
	@$(call install_fixup, x265,SECTION,base)
	@$(call install_fixup, x265,AUTHOR,"fabricega")
	@$(call install_fixup, x265,DESCRIPTION,missing)

	@$(call install_copy, x265, 0, 0, 0755, -, /usr/bin/x265)

	@$(call install_lib, x265, 0, 0, 0644, libx265)

	@$(call install_finish, x265)

	@$(call touch)

# vim: syntax=make
