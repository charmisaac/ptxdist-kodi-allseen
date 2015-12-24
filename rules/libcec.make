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
PACKAGES-$(PTXCONF_LIBCEC) += libcec

#
# Paths and names
#
LIBCEC_VERSION	:= 3.0.1
LIBCEC_MD5	:= 4908f786cea7d2b866a86c2a47c39fda
LIBCEC		:= libcec
LIBCEC_SUFFIX	:= tar.gz
# LIBCEC_URL	:= https://github.com/Pulse-Eight/libcec/archive/master.$(LIBCEC_SUFFIX)
LIBCEC_GIT	:= git://github.com/Pulse-Eight/libcec.git
LIBCEC_SOURCE	:= $(SRCDIR)/$(LIBCEC).$(LIBCEC_SUFFIX)
LIBCEC_DIR	:= $(BUILDDIR)/$(LIBCEC)
LIBCEC_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# $(STATEDIR)/libcec.get:
$(LIBCEC_SOURCE):
	@$(call targetinfo)
	if [ -d $(LIBCEC_DIR) ]; then rm -rf $(LIBCEC_DIR); fi;
	sync
	cd $(BUILDDIR) && \
		git clone --recursive $(LIBCEC_GIT) && \
		tar zcvf $(SRCDIR)/$(LIBCEC).$(LIBCEC_SUFFIX) $(LIBCEC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libcec.extract:
	@$(call targetinfo)
	cd $(BUILDDIR) && \
		tar zxvf $(SRCDIR)/$(LIBCEC).$(LIBCEC_SUFFIX)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCEC_PATH	:= PATH=$(CROSS_PATH)
LIBCEC_ENV 	:= $(CROSS_ENV) 

ifdef PTXCONF_ARCH_ARM
	LIBCEC_ENV+=LDFLAGS="-march=armv7-a -mtune=cortex-a17 -mfloat-abi=hard -mfpu=vfpv3-d16 -L${SYSROOT}/usr/lib -lc -lgcc_s -lstdc++"
endif

ifdef PTXCONF_ARCH_ARM64
	LIBCEC_ENV+=LDFLAGS="-march=armv8-a -mtune=cortex-a53 -L${SYSROOT}/usr/lib -lstdc++"
endif

#
# cmake 
# 
LIBCEC_CONF_TOOL := cmake
LIBCEC_CONF_OPT	= \
	-DCMAKE_INSTALL_PREFIX=/usr


$(STATEDIR)/libcec.prepare:
	@$(call targetinfo)
	echo "SET(CMAKE_SYSTEM_NAME Linux)" > $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_PROCESSOR arm)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_VERSION 1)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CROSSCOMPILING 1)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "" >> $(LIBCEC_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_C_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CC})" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_C_FLAGS \"-I${SYSROOT}/usr/include -I$(LIBCEC_DIR) -L${SYSROOT}/usr/lib -L$(LIBCEC_DIR)/src/platform\")" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CXX_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CXX})" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CXX_FLAGS \"-I${SYSROOT}/usr/include -I$(LIBCEC_DIR) -L${SYSROOT}/usr/lib -L$(LIBCEC_DIR)/src/platform\")" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "" >> $(LIBCEC_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_FIND_ROOT_PATH ${SYSROOT}/usr)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(BUILD_SHARED_LIBS 1)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(p8-platform_DIR $(LIBCEC_DIR)/src/platform)" >> $(LIBCEC_DIR)/cmake_toolchain.txt

	echo "" >> $(LIBCEC_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_INSTALL_PREFIX /usr)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)" >> $(LIBCEC_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)" >> $(LIBCEC_DIR)/cmake_toolchain.txt

	sync
	sync

	cd $(LIBCEC_DIR)/src/libcec && \
		if [ ! -d p8-platform ]; then ln -s platform p8-platform; fi;
	cd $(LIBCEC_DIR)/src/cec-client && \
		if [ ! -d p8-platform ]; then ln -s ../libcec/platform p8-platform; fi;
	cd $(LIBCEC_DIR)/src/cecc-client && \
		if [ ! -d p8-platform ]; then ln -s ../libcec/platform p8-platform; fi;
	sync
	cd $(LIBCEC_DIR)/src/platform && $(LIBCEC_PATH) $(LIBCEC_ENV) cmake -DCMAKE_TOOLCHAIN_FILE=$(LIBCEC_DIR)/cmake_toolchain.txt .
	sync
	cd $(LIBCEC_DIR) && $(LIBCEC_PATH) $(LIBCEC_ENV) cmake -DCMAKE_TOOLCHAIN_FILE=$(LIBCEC_DIR)/cmake_toolchain.txt -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=1 -DCMAKE_INSTALL_LIBDIR=/usr/lib -DSKIP_PYTHON_WRAPPER:STRING=1 .
	sed -e "s|L/usr/local/lib|L$(LIBCEC_DIR)/src/platform|g" -i $(LIBCEC_DIR)/CMakeCache.txt
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libcec.compile:
	@$(call targetinfo)
	mkdir -p $(LIBCEC_DIR)/src/libcec/platform/threads
	cp $(LIBCEC_DIR)/src/platform/src/os.h $(LIBCEC_DIR)/src/libcec/platform
	cp $(LIBCEC_DIR)/src/platform/src/posix/*.h $(LIBCEC_DIR)/src/libcec/platform/posix
	cp $(LIBCEC_DIR)/src/platform/src/threads/*.h $(LIBCEC_DIR)/src/libcec/platform/threads
	cp $(LIBCEC_DIR)/src/platform/src/util/*.h $(LIBCEC_DIR)/src/libcec/platform/util
	cp $(LIBCEC_DIR)/src/platform/src/sockets/*.h $(LIBCEC_DIR)/src/libcec/platform/sockets
	@cd $(LIBCEC_DIR)/src/platform && $(LIBCEC_PATH) $(LIBCEC_ENV) $(MAKE)
	@cd $(LIBCEC_DIR) && $(LIBCEC_PATH) $(LIBCEC_ENV) $(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcec.install:
	@$(call targetinfo)
	@cd $(LIBCEC_DIR) && DESTDIR=$(SYSROOT)/usr $(MAKE) install
	mkdir -p $(LIBCEC_PKGDIR)
	cd $(LIBCEC_DIR) && DESTDIR=$(LIBCEC_PKGDIR) $(MAKE) install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcec.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcec)
	@$(call install_fixup, libcec,PRIORITY,optional)
	@$(call install_fixup, libcec,SECTION,base)
	@$(call install_fixup, libcec,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libcec,DESCRIPTION,missing)

	@$(call install_copy, libcec, 0, 0, 0755, -, /usr/bin/cecc-client-$(LIBCEC_VERSION))
	@$(call install_copy, libcec, 0, 0, 0755, -, /usr/bin/cec-client-$(LIBCEC_VERSION))
	@$(call install_link, libcec, /usr/bin/cecc-client-$(LIBCEC_VER), /usr/bin/cecc-client)
	@$(call install_link, libcec, /usr/bin/cec-client-$(LIBCEC_VER), /usr/bin/cec-client)

	@$(call install_lib, libcec, 0, 0, 0644, libcec)
	@$(call install_finish, libcec)

	@$(call touch)

# vim: syntax=make
