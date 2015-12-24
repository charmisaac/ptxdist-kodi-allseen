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
PACKAGES-$(PTXCONF_NETSURF) += netsurf

#
# Paths and names
#
NETSURF_VERSION	:= 3.3
NETSURF_MD5	:= 699b3653056c02fd989189853d07da55
NETSURF		:= netsurf-all-$(NETSURF_VERSION)
NETSURF_SUFFIX	:= tar.gz
NETSURF_URL	:= http://download.netsurf-browser.org/netsurf/releases/source-full/$(NETSURF).$(NETSURF_SUFFIX)
NETSURF_SOURCE	:= $(SRCDIR)/$(NETSURF).$(NETSURF_SUFFIX)
NETSURF_DIR	:= $(BUILDDIR)/$(NETSURF)
NETSURF_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NETSURF_PATH    	:= PATH=$(CROSS_PATH)
NETSURF_ENV		:= $(CROSS_ENV) \
	NETSURF_GTK_MAJOR=3 \
	PKG_CONFIG_LIBDIR="$(SYSROOT)/lib/pkgconfig:$(SYSROOT)/usr/lib/pkgconfig:$(NETSURF_DIR)/inst-gtk/lib/pkgconfig:$(NETSURF_DIR)/inst-framebuffer/lib/pkgconfig"
NETSURF_CFLAGS		:= $(CROSS_CPPFLAGS) -Wno-error=enum-compare -I$(NETSURF_DIR)/inst-framebuffer/include -I$(NETSURF_DIR)/inst-gtk/include

NETSURF_LDFLAGS		:= -L$(NETSURF_DIR)/inst-framebuffer/lib -L$(NETSURF_DIR)/inst-gtk/lib -L$(SYSROOT)/usr/lib
NETSURF_LDFLAGS		+= -lcurl
NETSURF_LDFLAGS		+= -ljpeg
NETSURF_LDFLAGS		+= -lpng
NETSURF_LDFLAGS		+= -lcrypto
NETSURF_LDFLAGS		+= -lssl
NETSURF_LDFLAGS		+= -lSDL
NETSURF_LDFLAGS		+= -liconv
NETSURF_LDFLAGS		+= -lxml2
NETSURF_LDFLAGS		+= -lz
NETSURF_LDFLAGS		+= -lm
NETSURF_LDFLAGS		+= -lcss
NETSURF_LDFLAGS		+= -lutf8proc
NETSURF_LDFLAGS		+= -lparserutils
NETSURF_LDFLAGS		+= -lwapcaplet
NETSURF_LDFLAGS		+= -lnsfb
NETSURF_LDFLAGS		+= -lnsgif
NETSURF_LDFLAGS		+= -lsvgtiny
NETSURF_LDFLAGS		+= -lnsbmp
NETSURF_LDFLAGS		+= -lrosprite
NETSURF_LDFLAGS		+= -lnsutils
NETSURF_LDFLAGS		+= -lrsvg-2
NETSURF_LDFLAGS		+= -ldom -lexpat
NETSURF_LDFLAGS         += -lhubbub

ifdef PTXCONF_NETSURF_FREETYPE
NETSURF_TARGETOPT       += NETSURF_FB_FONTLIB=freetype
NETSURF_LDFLAGS         += -lfreetype
endif

ifdef PTXCONF_LIBHARU
NETSURF_LDFLAGS         += -lhpdf
endif

ifdef PTXCONF_NETSURF_TARGET_FRAMEBUFFER
NETSURF_TARGETOPT	:= TARGET=framebuffer
endif

ifdef PTXCONF_NETSURF_TARGET_GTKDFB
NETSURF_TARGETOPT	:= TARGET=gtk
NETSURF_CFLAGS		+= -I$(SYSROOT)/usr/include/gtk-3.0
NETSURF_CFLAGS		+= -I$(SYSROOT)/usr/lib/gtk-3.0/include
NETSURF_CFLAGS		+= -I$(SYSROOT)/usr/include/cairo
NETSURF_CFLAGS		+= -I$(SYSROOT)/usr/include/glib-2.0
NETSURF_CFLAGS		+= -I$(SYSROOT)/usr/lib/glib-2.0/include
NETSURF_CFLAGS		+= -I$(SYSROOT)/usr/include/pango-1.0
NETSURF_CFLAGS		+= -I$(SYSROOT)/usr/include/atk-1.0/

#NETSURF_LDFLAGS		+= -lgtk-directfb-2.0
NETSURF_LDFLAGS		+= -lgtk-3 -lgdk-3
NETSURF_LDFLAGS		+= -lgdk_pixbuf-2.0
#NETSURF_LDFLAGS		+= -lgdk-directfb-2.0
NETSURF_LDFLAGS		+= -lgobject-2.0
NETSURF_LDFLAGS		+= -lpangocairo-1.0
NETSURF_LDFLAGS		+= -lpango-1.0
NETSURF_LDFLAGS		+= -latk-1.0
NETSURF_LDFLAGS		+= -lglib-2.0
NETSURF_LDFLAGS         += -lcairo
#NETSURF_LDFLAGS		+= -lglade-2.0
endif

NETSURF_LDFLAGS		+= -lgstreamer-1.0

NETSURF_TARGETOPT	+= NETSURF_USE_WEBP=NO
NETSURF_TARGETOPT	+= NETSURF_USE_VIDEO=YES
NETSURF_TARGETOPT	+= NETSURF_USE_RSVG=YES
NETSURF_TARGETOPT	+= NETSURF_USE_NSSVG=YES
NETSURF_TARGETOPT	+= NETSURF_USE_BMP=YES
NETSURF_TARGETOPT	+= NETSURF_USE_GIF=YES
NETSURF_TARGETOPT	+= NETSURF_USE_DOM=YES
NETSURF_TARGETOPT	+= NETSURF_USE_MNG=NO
NETSURF_TARGETOPT	+= NETSURF_USE_MOZJS=AUTO
NETSURF_TARGETOPT	+= NETSURF_USE_ROSPRITE=YES
NETSURF_TARGETOPT	+= NETSURF_USE_HARU_PDF=YES
NETSURF_TARGETOPT	+= NETSURF_USE_UTF8PROC=YES

NETSURF_MAKE_OPT	:= $(NETSURF_ENV) PREFIX=/usr $(NETSURF_TARGETOPT) OPTCFLAGS="$(NETSURF_CFLAGS)" LDFLAGS="$(CROSS_LDFLAGS) $(NETSURF_LDFLAGS) -lcairo -lgobject-2.0 -lstdc++"
NETSURF_INSTALL_OPT	:= $(NETSURF_MAKE_OPT) install

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/netsurf.compile:
	@$(call targetinfo)
	cd $(NETSURF_DIR) && \
		for file in `find . -name "Makefile*" -type f`; do \
			sed -e "s|_BSD_SOURCE|_DEFAULT_SOURCE|g" -i $$file; \
                done;
	cd $(NETSURF_DIR) && \
		$(NETSURF_PATH) $(NETSURF_ENV) \
		$(MAKE) $(NETSURF_MAKE_OPT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/netsurf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, netsurf)
	@$(call install_fixup, netsurf,PRIORITY,optional)
	@$(call install_fixup, netsurf,SECTION,base)
	@$(call install_fixup, netsurf,AUTHOR,"fabricega")
	@$(call install_fixup, netsurf,DESCRIPTION,missing)

	@$(call install_copy, netsurf, 0, 0, 0755, $(NETSURF_PKGDIR)/usr/bin/netsurf, /usr/bin/netsurf.bin)
	@$(call install_alternative, netsurf, 0, 0, 0755, /usr/bin/netsurf)

	@cd $(NETSURF_PKGDIR)/usr/share/netsurf && \
		find . -type f | while read file; do \
		$(call install_copy, netsurf, 0, 0, 644, \
		$(NETSURF_PKGDIR)/usr/share/netsurf/$$file, \
		/usr/share/netsurf/$$file); \
	done

	@$(call install_finish, netsurf)

	@$(call touch)

# vim: syntax=make
