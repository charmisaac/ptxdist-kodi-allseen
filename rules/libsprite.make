# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
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
PACKAGES-$(PTXCONF_LIBSPRITE) += libsprite

#
# Paths and names
#
LIBSPRITE_VERSION	:= 1.0
LIBSPRITE_MD5		:= 473e27f76e1708b3ec70af0519f1c73d
LIBSPRITE		:= libSPRITE-$(LIBSPRITE_VERSION)
LIBSPRITE_SUFFIX	:= zip
LIBSPRITE_URL		:= https://github.com/nasa/libSPRITE/archive/master.$(LIBSPRITE_SUFFIX)
LIBSPRITE_SOURCE	:= $(SRCDIR)/$(LIBSPRITE).$(LIBSPRITE_SUFFIX)
LIBSPRITE_DIR		:= $(BUILDDIR)/$(LIBSPRITE)
LIBSPRITE_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

#$(STATEDIR)/libsprite.get:
#	@$(call targetinfo)
#	cd $(BUILDDIR) && \
#		git clone --recursive $(LIBSPRITE_GIT) && \
#		tar zcvf $(SRCDIR)/$(LIBSPRITE).$(LIBSPRITE_SUFFIX) $(LIBSPRITE)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

#$(STATEDIR)/libsprite.extract:
#	@$(call targetinfo)
#	cd $(BUILDDIR) && \
#		tar zxvf $(SRCDIR)/$(LIBSPRITE).$(LIBSPRITE_SUFFIX)
#	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSPRITE_PATH	:= PATH=$(CROSS_PATH)
LIBSPRITE_ENV 	:= $(CROSS_ENV) \
	LIBS+="-lstdc++"

#
# cmake 
# 
LIBSPRITE_CONF_TOOL := cmake
LIBSPRITE_CONF_OPT	= \
	-DCMAKE_INSTALL_PREFIX=/usr


$(STATEDIR)/libsprite.prepare:
	@$(call targetinfo)
	echo "SET(CMAKE_SYSTEM_NAME Linux)" > $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_PROCESSOR arm)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_VERSION 1)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CROSSCOMPILING 1)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_C_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CC})" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_C_FLAGS \"-I${SYSROOT}/usr/include -I$(LIBSPRITE_DIR) -L${SYSROOT}/usr/lib -L$(LIBSPRITE_DIR)/src/platform\")" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CXX_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CXX})" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CXX_FLAGS \"-I${SYSROOT}/usr/include -I$(LIBSPRITE_DIR) -L${SYSROOT}/usr/lib -L$(LIBSPRITE_DIR)/src/platform -lstdc++\")" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_FIND_ROOT_PATH ${SYSROOT}/usr)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(BUILD_SHARED_LIBS 1)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(platform_DIR $(LIBSPRITE_DIR)/src/platform)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt

	echo "" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_INSTALL_PREFIX /usr)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(LUA_INCLUDE_DIR ${SYSROOT}/usr/include)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(LUA_LIBRARIES ${SYSROOT}/usr/lib)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(LUA_LIB ${SYSROOT}/usr/lib)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)" >> $(LIBSPRITE_DIR)/cmake_toolchain.txt

	sync
	sync
	cd $(LIBSPRITE_DIR) && $(LIBSPRITE_PATH) $(LIBSPRITE_ENV) cmake -DCMAKE_TOOLCHAIN_FILE=$(LIBSPRITE_DIR)/cmake_toolchain.txt -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=1 -DCMAKE_INSTALL_LIBDIR=/usr/lib -DSKIP_PYTHON_WRAPPER:STRING=1 .
	@$(call touch)


# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libsprite.compile:
	@$(call targetinfo)
	@cd $(LIBSPRITE_DIR) && $(LIBSPRITE_PATH) $(LIBSPRITE_ENV) $(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsprite.install:
	@$(call targetinfo)
	@cd $(LIBSPRITE_DIR) && DESTDIR=$(SYSROOT)/usr $(MAKE) install
	mkdir -p $(LIBSPRITE_PKGDIR)
	cd $(LIBSPRITE_DIR) && DESTDIR=$(LIBSPRITE_PKGDIR) $(MAKE) install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsprite.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsprite)
	@$(call install_fixup, libsprite,PRIORITY,optional)
	@$(call install_fixup, libsprite,SECTION,base)
	@$(call install_fixup, libsprite,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libsprite,DESCRIPTION,missing)

	@$(call install_copy, libsprite, 0, 0, 0644, -, /usr/lib/SPRITE/libSPRITE_math.so)
	@$(call install_copy, libsprite, 0, 0, 0644, -, /usr/lib/SPRITE/libSPRITE_net.so)
	@$(call install_copy, libsprite, 0, 0, 0644, -, /usr/lib/SPRITE/libSPRITE_SCALE.so)
	@$(call install_copy, libsprite, 0, 0, 0644, -, /usr/lib/SPRITE/libSPRITE_SRTX.so)
	@$(call install_copy, libsprite, 0, 0, 0644, -, /usr/lib/SPRITE/libSPRITE_units.so)
	@$(call install_copy, libsprite, 0, 0, 0644, -, /usr/lib/SPRITE/libSPRITE_util.so)

	@$(call install_finish, libsprite)

	@$(call touch)

# vim: syntax=make
