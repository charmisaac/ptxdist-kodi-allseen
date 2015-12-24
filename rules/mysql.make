# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
# Copyright (C) 2009 by Juergen Beisert <j.beisert@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MYSQL) += mysql

#
# Paths and names
#
MYSQL_VERSION	:= 5.5.47
MYSQL_MD5	:= e400d42627f9a955f4cc02cfcaf51725
MYSQL		:= mariadb-$(MYSQL_VERSION)
MYSQL_SUFFIX	:= tar.gz
#MYSQL_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(MYSQL).$(MYSQL_SUFFIX)
MYSQL_URL	:= https://downloads.mariadb.org/interstitial/mariadb-$(MYSQL_VERSION)/source/$(MYSQL).$(MYSQL_SUFFIX)
MYSQL_SOURCE	:= $(SRCDIR)/$(MYSQL).$(MYSQL_SUFFIX)
MYSQL_DIR	:= $(BUILDDIR)/$(MYSQL)
MYSQL_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MYSQL_PATH := PATH=${PTXDIST_SYSROOT_TOOLCHAIN}/../bin:${PATH}
MYSQL_ENV := \
	$(CROSS_ENV) \
	je_cv_static_page_shift=12 \
	ac_cv_path_COMP_ERR=$(PTXCONF_SYSROOT_HOST)/bin/comp_err \
	ac_cv_path_COMP_SQL=$(PTXCONF_SYSROOT_HOST)/bin/comp_sql \
	ac_cv_path_FACTORIAL=$(PTXCONF_SYSROOT_HOST)/bin/factorial \
	ac_cv_path_GEN_LEX_HASH=$(PTXCONF_SYSROOT_HOST)/bin/gen_lex_hash

#
# cmake
#
MYSQL_CONF_TOOL	:= cmake
MYSQL_CONF_OPT	= \
	-DCMAKE_INSTALL_PREFIX=/usr -DMYSQL_TCP_PORT=$(PTXCONF_MYSQL_TCP_PORT) \
	-DCURSES_LIBRARY=${SYSROOT}/lib/libncurses.so -DCURSES_INCLUDE_PATH=${SYSROOT}/usr/include

MYSQL_CONF_OPT += -DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
	-DMYSQL_DATADIR=/data/mariadb \
	-DSYSCONFDIR=/etc \
	-DMYSQL_USER=mysql \
	-DENABLE_DTRACE=OFF \
	-DWITH_DEBUG=0


ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_ARMSCII8
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=armscii8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_ASCII
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=ascii
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_BIG5
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=big5
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1250
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp1250
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1251
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp1251
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1256
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp1256
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP1257
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp1257
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP850
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp850
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP852
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp852
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP866
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp866
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_CP932
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=cp932
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_DEC8
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=dec8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_EUCJPMS
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=eucjpms
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_EUCR
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=eucr
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GB2312
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=gb2312
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GBK
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=gbk
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GEOSTD8
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=geostd8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_GREEK
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=greek
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_HEBREW
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=hebrew
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_HP8
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=hp8
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_KEYBCS2
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=keybcs2
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_KOI8R
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=koi8r
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_KOI8U
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=koi8u
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN1
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=latin1
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN2
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=latin2
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN5
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=latin5
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_LATIN7
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=latin7
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_MACCE
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=macce
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_MACROMAN
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=macroman
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_SJIS
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=sjis
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_UCS2
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=ucs2
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_UJIS
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=ujis
endif
ifdef PTXCONF_MYSQL_DEFAULT_CHARSET_UTF8
MYSQL_CONF_OPT += -DMYSQL_DEFAULT_CHARSET_NAME=utf8
endif

MYSQL_CONF_OPT += -DEXTRA_CHARSETS=all


$(STATEDIR)/mysql.prepare:
	@$(call targetinfo)
	echo "SET(CMAKE_SYSTEM_NAME Linux)" > $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_PROCESSOR $(PTXCONF_ARCH_STRING))" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_SYSTEM_VERSION 1)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CROSSCOMPILING 1)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_C_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CC})" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_C_FLAGS \"-I${MYSQL_DIR}/include -I${SYSROOT}/usr/include -I${SYSROOT}/usr/include/libxml2 -DHAVE_CURSES_H -DHAVE_TERM_H -L${SYSROOT}/usr/lib\")" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_CXX_COMPILER ${PTXDIST_SYSROOT_TOOLCHAIN}/../bin/${CROSS_CXX})" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_CXX_FLAGS \"-I${MYSQL_DIR}/include -I${SYSROOT}/usr/include -I${SYSROOT}/usr/include/libxml2 -DHAVE_CURSES_H -DHAVE_TERM_H -L${SYSROOT}/usr/lib\")" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt

#	echo "SET(CMAKE_AR ${CROSS_AR})" >> $(MYSQL_DIR)/cmake_toolchain.txt
#	echo "SET(CMAKE_RANLIB ${CROSS_RANLIB})" >> $(MYSQL_DIR)/cmake_toolchain.txt
#	echo "SET(CMAKE_STRIP ${CROSS_STRIP})" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(STACK_DIRECTION 1)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_INSTALL_PREFIX /usr)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(WITH_UNIT_TESTS OFF)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(WITH_EMBEDDED_SERVER TRUE)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt


	echo "SET(CMAKE_FIND_ROOT_PATH ${SYSROOT}/usr)" >> $(MYSQL_DIR)/cmake_toolchain.txt

	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt
#	echo "SET(DEFAULT_CHARSET_HOME ${SYSROOT}/usr/local/share/mysql)" >> $(MYSQL_DIR)/cmake_toolchain.txt

#	echo "SET(CURSES_LIBRARY ${SYSROOT}/lib/libncurses.so)" >> $(MYSQL_DIR)/cmake_toolchain.txt	
#	echo "SET(CURSES_INCLUDE_PATH ${SYSROOT}/usr/include)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(WITH_ZLIB bundle)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(ZLIB_LIBRARY ${SYSROOT}/usr/lib/libz.so)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(ZLIB_INCLUDE_DIR ${SYSROOT}/usr/include)" >> $(MYSQL_DIR)/cmake_toolchain.txt

#	echo "SET(LIBXML2_LIBRARIES ${SYSROOT}/usr/lib/libxml2.so)" >> $(MYSQL_DIR)/cmake_toolchain.txt
#	echo "SET(LIBXML2_INCLUDE_DIR ${SYSROOT}/usr/include)" >> $(MYSQL_DIR)/cmake_toolchain.txt

	echo "SET(OPENSSL_ROOT_DIR ${SYSROOT}/usr)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(OPENSSL_LIBRARIES ${SYSROOT}/usr/lib/libssl.so)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(OPENSSL_INCLUDE_DIR ${SYSROOT}/usr/include)" >> $(MYSQL_DIR)/cmake_toolchain.txt
#	echo "SET(LZ4_LIBRARIES ${SYSROOT}/usr/lib/liblz4.so)" >> $(MYSQL_DIR)/cmake_toolchain.txt
#	echo "SET(LZ4_INCLUDE_DIR ${SYSROOT}/usr/include)" >> $(MYSQL_DIR)/cmake_toolchain.txt

#	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt

	echo "" >> $(MYSQL_DIR)/cmake_toolchain.txt

	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)" >> $(MYSQL_DIR)/cmake_toolchain.txt
	echo "SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)" >> $(MYSQL_DIR)/cmake_toolchain.txt

	sync
	@sed -e "s|--enable-cc-silence|--host=arm-linux-gnueabihf|g" -i ${MYSQL_DIR}/cmake/jemalloc.cmake
	@sync
	cd $(MYSQL_DIR) && $(MYSQL_PATH) $(MYSQL_ENV) cmake -DCMAKE_TOOLCHAIN_FILE=$(MYSQL_DIR)/cmake_toolchain.txt ${MYSQL_CONF_OPT} .
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mysql.compile:
	@$(call targetinfo)
	sed -e "s|\.\/factorial |\.\/host-factorial |g" -i ${MYSQL_DIR}/dbug/CMakeLists.txt
	cp ${HOST_MYSQL_PKGDIR}/bin/factorial ${MYSQL_DIR}/dbug/host-factorial
	cp ${HOST_MYSQL_PKGDIR}/bin/factorial ${MYSQL_DIR}/dbug/factorial
	cp ${HOST_MYSQL_PKGDIR}/bin/comp_err ${MYSQL_DIR}/extra
	cp ${HOST_MYSQL_PKGDIR}/bin/comp_sql ${MYSQL_DIR}/scripts
	cp ${HOST_MYSQL_PKGDIR}/bin/gen_lex_hash ${MYSQL_DIR}/sql
	@cd $(MYSQL_DIR) && $(MYSQL_PATH) $(MYSQL_ENV) $(MAKE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mysql.install:
	@$(call targetinfo)
	@cd $(MYSQL_DIR) && $(MYSQL_PATH) $(MAKE) install DESTDIR=${SYSROOT}
	@cd $(MYSQL_DIR) && $(MYSQL_PATH) $(MAKE) install DESTDIR=${MYSQL_PKGDIR}
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mysql.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mysql)
	@$(call install_fixup, mysql,PRIORITY,optional)
	@$(call install_fixup, mysql,SECTION,base)
	@$(call install_fixup, mysql,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, mysql,DESCRIPTION,missing)

#	# install server stuff
#	# --------------------

	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqld)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqld_multi,n)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqld_safe,n)

#	# FIXME: need more languages?
#	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/share/english/errmsg.sys,n)
	@cd $(MYSQL_PKGDIR)/usr/share; \
		for file in `find . -name "errmsg.sys" -type f`; do \
			echo "scanning $$file"; \
			$(call install_copy, mysql, 0, 0, 0755, -, \
					/usr/share/$$file,n); \
		done;


#	# install management scripts
#	# --------------------------
#	# install_db:
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql_secure_installation,n)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/my_print_defaults)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/share/fill_help_tables.sql,n)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/share/mysql_performance_tables.sql,n)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/share/mysql_system_tables_data.sql,n)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/share/mysql_system_tables.sql,n)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/share/mysql_test_data_timezone.sql,n)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/resolveip)
#	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql_create_system_tables)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/innochecksum)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/myisamchk)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/myisamlog)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqlaccess)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqlbinlog)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql_config)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqlhotcopy)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqlimport)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql_plugin)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql_setpermission)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqlshow)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mytop)


#	# install client stuff
#	# --------------------------
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqladmin)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql_upgrade)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqlcheck)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqldump)

	@$(call install_lib, mysql, 0, 0, 0644, libmysqlclient)

#	# libmyodbc3_r-3.51.27.so uses this library:
	@$(call install_link, mysql, libmysqlclient, /usr/lib/libmysqlclient_r)

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_MYSQL_STARTSCRIPT
	@$(call install_alternative, mysql, 0, 0, 0755, /etc/init.d/mysql, n)

ifneq ($(call remove_quotes,$(PTXCONF_MYSQL_BBINIT_LINK)),)
	@$(call install_link, mysql, \
		../init.d/mysql, \
		/etc/rc.d/$(PTXCONF_MYSQL_BBINIT_LINK))
endif
endif
endif

	@$(call install_finish, mysql)

	@$(call touch)

# vim: syntax=make
