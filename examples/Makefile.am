if DEBUG
DEBUG_CFLAGS = -g -ggdb
else
DEBUG_CFLAGS =
endif

bin_PROGRAMS = StylSheelExample

StylSheelExample_SOURCES = cStylSheelExample.c

StylSheelExample_CFLAGS = $(DEBUG_CFLAGS) -std=c99			\
			  $(GLIB_CFLAGS)				\
			  -I$(top_srcdir)/src				\
			  -I$(srcdir)/../package/libxlsxwriter/include

StylSheelExample_LDFLAGS = $(GLIB_LIBS)					\
			   -lstylSheet -L./../src			\
			   -lxlsxwriter -L$(srcdir)/../package/libxlsxwriter/lib -lz
#$(srcdir)/../package/libxlsxwriter/lib/libxlsxwriter.a -z


