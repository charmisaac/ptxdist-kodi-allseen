# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MYSQL) += host-mysql

#
# Paths and names
#
HOST_MYSQL		= $(MYSQL)
HOST_MYSQL_DIR		= $(HOST_BUILDDIR)/$(HOST_MYSQL)-build

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MYSQL_CONF_TOOL	:= cmake
HOST_MYSQL_CONF_OPT	= \
	$(HOST_CMAKE_OPT) \
	-DDEFAULT_CHARSET_HOME=$(HOST_MYSQL_DIR) \
	-DDEFAULT_MYSQL_HOME=$(HOST_MYSQL_DIR)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mysql.compile:
	@$(call targetinfo)

	cd $(HOST_MYSQL_DIR) && $(HOST_MYSQL_PATH) cmake .

	# we need a comp_err tool
#	cd $(HOST_MYSQL_DIR)/include && $(HOST_MYSQL_PATH) $(MAKE)
#	cd $(HOST_MYSQL_DIR)/mysys && $(HOST_MYSQL_PATH) $(MAKE) libmysys.a
#	cd $(HOST_MYSQL_DIR)/dbug && $(HOST_MYSQL_PATH) $(MAKE) libdbug.a
#	cd $(HOST_MYSQL_DIR)/strings && $(HOST_MYSQL_PATH) $(MAKE) libmystrings.a
	cd $(HOST_MYSQL_DIR)/extra && $(HOST_MYSQL_PATH) $(MAKE) comp_err
	cd $(HOST_MYSQL_DIR)/scripts && $(HOST_MYSQL_PATH) $(MAKE) comp_sql

	# we need sql/gen_lex_hash
#	cd $(HOST_MYSQL_DIR)/storage/myisam && $(HOST_MYSQL_PATH) $(MAKE) libmyisam.a
#	cd $(HOST_MYSQL_DIR)/storage/myisammrg && $(HOST_MYSQL_PATH) $(MAKE) libmyisammrg.a
#	cd $(HOST_MYSQL_DIR)/storage/heap && $(HOST_MYSQL_PATH) $(MAKE) libheap.a
#	cd $(HOST_MYSQL_DIR)/vio && $(HOST_MYSQL_PATH) $(MAKE) libvio.a
#	cd $(HOST_MYSQL_DIR)/regex && $(HOST_MYSQL_PATH) $(MAKE) libregex.a
	cd $(HOST_MYSQL_DIR)/sql && $(HOST_MYSQL_PATH) $(MAKE) gen_lex_hash

	# we need dbug/factorial
	cd $(HOST_MYSQL_DIR)/dbug && $(HOST_MYSQL_PATH) $(MAKE) factorial

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mysql.install:
	@$(call targetinfo)
	@install -m 755 -D $(HOST_MYSQL_DIR)/extra/comp_err $(HOST_MYSQL_PKGDIR)/bin/comp_err
	@install -m 755 -D $(HOST_MYSQL_DIR)/scripts/comp_sql $(HOST_MYSQL_PKGDIR)/bin/comp_sql
	@install -m 755 -D $(HOST_MYSQL_DIR)/sql/gen_lex_hash $(HOST_MYSQL_PKGDIR)/bin/gen_lex_hash
#	@install -m 755 -D $(HOST_MYSQL_DIR)/sql/gen_lex_token $(HOST_MYSQL_PKGDIR)/bin/gen_lex_token
	@install -m 755 -D $(HOST_MYSQL_DIR)/dbug/factorial $(HOST_MYSQL_PKGDIR)/bin/factorial
	@$(call touch)

# vim: syntax=make
