#!/bin/bash
CXXFLAGS=""
CFLAGS=""
export DEBUG_FLAGS=''
CONF_FLAGS=""

config_stylAutotool()
{
	if [ "$OS_TYPE" = "win" ]; then

		if [ "$DIR_PACKAGE" == "NA" ]; then
			echo "error: non setup package dir for Autotool Demo for win"
			exit 1
		fi
		if [ "$IS_RELEASE" = "NA" ]; then
			FOLDER="$(pwd)/build_win_package_debug"
		else
			FOLDER="$(pwd)/build_win_package_release"
		fi
		if [ "$DIR_INSTALL" = "NA" ]; then
			DIR_INSTALL="$FOLDER/AutotoolDemo"

		else
			DIR_INSTALL="$DIR_INSTALL/AutotoolDemo"
		fi


		CONF_FLAGS="	--prefix=$DIR_INSTALL \
				--host=i586-mingw32msvc \
				--build=i686-linux-gnu"

	else
		if [ "$OS_TYPE" = "NA" ]; then
			OS_TYPE=$(expr substr "$(lsb_release -i)" 17 33)
		fi
		if [ $IS_MAKE -eq $TRUE ]; then
			if [ "$IS_RELEASE" = "NA" ]; then
            	            FOLDER=build_${OS_TYPE}_debug
                	else
                    	    FOLDER=build_${OS_TYPE}_release
                	fi
		else
			if [ "$IS_RELEASE" = "NA" ]; then
				FOLDER=build_${OS_TYPE}_package_debug
			else
				FOLDER=build_${OS_TYPE}_package_release
			fi
		fi
		if [ "$DIR_INSTALL" = "NA" ]; then
			DIR_INSTALL=/usr/local
		fi
		CONF_FLAGS="--prefix=$DIR_INSTALL"
	fi
}


make_stylAutotool()
{

	mkdir -p $FOLDER && cd $FOLDER
	if [ ! -f Makefile ]; then
		echo ../configure $CONF_FLAGS

		if [ "$IS_RELEASE" = "NA" ]; then
			export  CXXFLAGS="$CXXFLAGS"
			export  CFLAGS="$CFLAGS"
		else
			export  CXXFLAGS="$CXXFLAGS $IS_RELEASE"
			export  CFLAGS="$CFLAGS $IS_RELEASE"
		fi
		../configure $CONF_FLAGS
	fi
	make V=s && $SUDO make install
}

create_install_sh()
{
	mkdir -p $FOLDER
	F_INSTALL=$FOLDER"/install.sh"
	rm -rf ${F_INSTALL}
	echo "make install" > "${F_INSTALL}"
	chmod +x ${FOLDER}/install.sh
}

package_stylAutotool()
{
	create_install_sh

	echo mkdir -p $FOLDER
	mkdir -p $FOLDER && cd $FOLDER
	if [ ! -f Makefile ]; then
		echo ../configure $CONF_FLAGS &&
		if [ "$IS_RELEASE" = "NA" ]; then
			export  CFLAGS="$CFLAGS"
			export  CXXFLAGS="$CXXFLAGS"

		else
			export  CXXFLAGS="$CXXFLAGS $IS_RELEASE"
			export  CFLAGS="$CFLAGS $IS_RELEASE"
		fi

		../configure $CONF_FLAGS
	fi

	TYPE_PACK_OP="-D"

	if [ "$OS_TYPE" = "win" ]; then
		which makensis
		if [ $? -ne 0 ]; then
			echo "NSIS not found"
			exit 1
		fi

		make && make install && \
		echo cp -rf $(pwd)/nsis_data/* $DIR_INSTALL && \
		cp -rf $(pwd)/nsis_data/* $DIR_INSTALL && \
		makensis setup.nsi
	else
		if [ "$OS_TYPE" != "Debian" ]; then
			TYPE_PACK_OP="-R"
		fi

		ARCH=$(uname -m)
		if [ "$ARCH" = "i686" ]; then
			ARCH="i386"
		elif [ "$ARCH" = "x86_64" ]; then
			ARCH="amd64"
		elif [ "$ARCH" = "armv7l" ]; then
			ARCH="armhf"
		fi

		make V=s &&

		sudo checkinstall $TYPE_PACK_OP --docdir=../doc-pak/ \
				-y --install=no --fstrans=no \
				--exclude=/selinux \
				--reset-uids=yes \
				--pkgname=$PACKAGE_NAME  \
				--pkgversion=$PACKAGE_VERSION  \
				--pkgrelease=$PACKAGE_RELEASE \
				--pkgarch=$ARCH \
				--maintainer="STYL Solutions" \
				--pakdir=$DIR_PACKAGE --backup=no -D $(pwd)/install.sh \
				--requires="glib-2.0" &&
		cd - || exit 1
	fi
}

_help_()
{
	echo "=========================================================================="
	echo "=========================================================================="
	echo ""
	echo "Usage: $0 [OPTION] [BUILD_OPTION] | $0 [OPTION] [PACKAGE_OPTION]"
	echo ""
	echo "OPTION:"
	echo "  -su                 : build/package Autotool Demo with sudo"
	echo "  -r                  : package Autotool Demo with disable debug"
	echo "BUILD_OPTIONS:"
	echo "  -m                  : make and install Autotool Demo"
	echo "  -d <dir>            : dir install of Autotool Demo"
	echo "  -w32                : build Autotool Demo for windows 32bit"
	echo "PACKAGE_OPTIONS:"
	echo "  -p                  : package Autotool Demo"
	echo "  -pkg_name <name>    : set name of package of Autotool Demo"
	echo ""
	echo "============================================================================"
	echo "============================================================================"
}

FALSE=0
TRUE=1
OS_TYPE="NA"
ENABLE_STATIC=""
DIR_INSTALL="NA"
DIR_PACKAGE=""
PACKAGE_NAME=StylAutotoolDemo
PACKAGE_VERSION="1.0.0"
PACKAGE_RELEASE=$(git log --pretty=format:\'\' | wc -l)
IS_MAKE=$FALSE
IS_PACKAGE=$FALSE
IS_RELEASE="NA"
SUDO=""
for PARAM in $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12}
do
	case $PRE_PAR in
		-d) DIR_INSTALL=$PARAM
			PRE_PAR=""
			continue;;
		-pkg_name)
			PACKAGE_NAME=$PARAM
			PRE_PAR=""
			continue;;
		-pkg_version)
			PACKAGE_VERSION=$PARAM
			echo PACKAGE_VERSION=$PACKAGE_VERSION
			PRE_PAR=""
			continue;;
		-pkg_release)
			PACKAGE_RELEASE=$PARAM
			PRE_PAR=""
			continue;;

		*);;
	esac
	case $PARAM in
		-w32)	OS_TYPE="win";;
		-su) 	SUDO="sudo";;
		-r) 	IS_RELEASE="-D__RELEASE__";;
		-d) 	;;
		-m)     IS_MAKE=$TRUE;;
                -p)     IS_PACKAGE=$TRUE;;
                -push)  IS_PUSH=$TRUE;;
		-pkg_name) ;;
		-pkg_version) ;;
		-pkg_release) ;;
		*) 	help1;;
	esac
	PRE_PAR=$PARAM
done
IS_DO=$FALSE
config_stylAutotool

if [ $IS_MAKE -eq $TRUE ]; then
	IS_DO=$TRUE
	make_stylAutotool
elif [ $IS_PACKAGE -eq $TRUE ]; then
	IS_DO=$TRUE
	package_stylAutotool
fi
if [ $IS_DO -eq $FALSE ]; then
	_help_
	exit 1
fi
