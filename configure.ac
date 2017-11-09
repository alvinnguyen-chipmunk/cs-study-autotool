# Program name is "Autotool Sample" and version is 0.0.1"
AC_INIT([Autotool Sample], [0.0.1], [khuong.linux@gmail.com])
AC_CONFIG_SRCDIR([configure.ac])

dnl Must come before AM_INIT_AUTOMAKE.

# Auxiliary files go "build-aux" directory
AC_CONFIG_AUX_DIR([build-aux])

# Init recursive automake
AM_INIT_AUTOMAKE([-Wall])

AC_CONFIG_MACRO_DIR([m4])

# Find & probe C compiler
AC_PROG_CC
AM_PROG_AR
AC_PROG_LIBTOOL
AC_PROG_INSTALL

# Init libtool to compile a libtool library
LT_INIT

# Configure for libtool
AM_PROG_LIBTOOL
LIBTOOL="$LIBTOOL --silent"


# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_OFF_T
AC_TYPE_SIZE_T
AC_STRUCT_TM

dnl ================================================================

glib_modules="glib-2.0"
PKG_CHECK_MODULES([GLIB], [$glib_modules])
AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)
GLIB_VERSION=`$PKG_CONFIG --modversion ${glib_modules}`

dnl ================================================================

#stylSheet_modules="libstylSheet"
#PKG_CHECK_MODULES([LIBSTYLSHEET], [$stylSheet_modules])
#AC_SUBST(LIBSTYLSHEET_CFLAGS)
#AC_SUBST(LIBSTYLSHEET_LIBS)

dnl ================================================================

AC_CONFIG_FILES([ Makefile src/Makefile examples/Makefile])
AC_OUTPUT([ libstylSheet.pc data/env_noinslibary])

AC_ARG_ENABLE([debug],
[  --enable-debug    Turn on debugging],
[case "${enableval}" in
  yes) debug=true ;;
  no)  debug=false ;;
  *) AC_MSG_ERROR([bad value ${enableval} for --enable-debug]) ;;
esac],[debug=false])

AM_CONDITIONAL([DEBUG], [test x$debug = xtrue])

dnl ================================================================

echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo ""
echo "Install STYL SHEET and Example in           : ${prefix}"
echo "Using GLIB version                          : ${GLIB_VERSION}"

echo ""
echo "Configuration is done OK."
echo ""
