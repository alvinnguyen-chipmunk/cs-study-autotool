######################### STYL SHEET COMMON VARIABLE ###########################
if DEBUG
DEBUG_CFLAGS = -g -ggdb
else
DEBUG_CFLAGS =
endif
   
STYLSHEET_includedir = $(includedir)/libstylSheet

STYLSHEET_SOURCES = cStylSheet.h cStylSheet.c

STYLSHEET_include_HEADERS = cStylSheet.h

STYLSHEET_CFLAGS = $(DEBUG_CFLAGS) -std=c99				\
		   $(GLIB_CFLAGS)					\
		   -I$(srcdir)/../package/libxlsxwriter/include

STYLSHEET_LDFLAGS = $(GLIB_LIBS) 						\
		    #-lxlsxwriter -L$(srcdir)/../package/libxlsxwriter/lib -lz   \
		    $(srcdir)/../package/libxlsxwriter/lib/libxlsxwriter.a -lz

######################### STYL SHEET LIBTOOL LIBRARY ############################

lib_LTLIBRARIES = libstylSheet.la

libstylSheet_la_includedir = $(STYLSHEET_includedir)

libstylSheet_la_SOURCES = $(STYLSHEET_SOURCES)

libstylSheet_la_include_HEADERS = $(STYLSHEET_include_HEADERS)

libstylSheet_la_CFLAGS = $(STYLSHEET_CFLAGS)

libstylSheet_la_LDFLAGS = $(STYLSHEET_LDFLAGS)

######################### STYL SHEET STATIC LIBRARY #############################

lib_LIBRARIES = libstylSheet.a

libstylSheet_a_includedir = $(STYLSHEET_includedir)

libstylSheet_a_SOURCES = $(STYLSHEET_SOURCES)

libstylSheet_a_include_HEADERS = $(STYLSHEET_include_HEADERS)

libstylSheet_a_CFLAGS = $(STYLSHEET_CFLAGS)

libstylSheet_a_LIBADD = 
