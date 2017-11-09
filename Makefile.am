## Process this file with automake to produce Makefile.in

SUBDIRS = src examples

AUTOMAKE_OPTIONS = 1.7

ACLOCAL_AMFLAGS = -I m4

EXTRA_DIST = \
	autogen.sh \
	libstylSheet.pc.in \
	data/env_noinslibary.in

uninstall-local:
	rm -rf $(DESTDIR)$(pkgdatadir);
	rm -rf $(DESTDIR)$(includedir)/libstylSheet

install-data-local: install-data-only
	@$(NORMAL_INSTALL)

install-data-only:
	@$(NORMAL_INSTALL)
	for file in $(builddir)/data/*; do \
          if test -f $$file; then \
            $(INSTALL_DATA) $$file $(bindir)/; \
          fi \
        done

pkgconfig_DATA = libstylSheet.pc
pkgconfigdir = $(libdir)/pkgconfig
