#!/bin/bash
GTK_PACKAGE="gtk+-bundle_3.10.4-20131202_win32.zip"
GLIB_PACKAGE="glib_2.34.3-1_win32.zip"
GLIB_DEV_PACKAGE="glib-dev_2.34.3-1_win32.zip"
THREAD_PACKAGE="pthread.tar.gz"
BUNDLE_GTK="/usr/i586-mingw32msvc"

pkgtar=libaddw32.tar.gz

if [ $(whoami) != "root" ]; then
	echo "Please run with root!"
	exit 1
fi

echo "Install mingw32 ..."
apt-get install mingw32

mkdir -p /usr/i586-mingw32msvc | exit 1
echo "unzip package ..."

unzip -o $GTK_PACKAGE -d $BUNDLE_GTK && \
tar zxvf $THREAD_PACKAGE -C $BUNDLE_GTK && \
cp $pkgtar $BUNDLE_GTK/lib/ && \
cd $BUNDLE_GTK/lib && \
tar xvpf $pkgtar && mv regex.h ../include/regex.h && \
rm $pkgtar && cd -

if [ $? -ne 0 ]; then
	echo "Fail extract $$GTK_PACKAGE"
	exit 1
fi
cd $BUNDLE_GTK

sed -i 's|^prefix=.*$|prefix=/usr/i586-mingw32msvc|g' lib/pkgconfig/*.pc | exit 1
cd ./lib
for f in *.lib;
do
	echo "Current dir: $(pwd)"
	echo "mv $f lib${f%%lib}a"
	mv $f lib${f%%lib}a;
done

PATH_PKG_CONFIG_FILE=$(which i586-mingw32msvc-pkg-config)
echo "PATH_PKG_CONFIG_FILE=${PATH_PKG_CONFIG_FILE}"

if [ -z $PKG_CONFIG_PATH ]; then
	PATH_PKG_CONFIG_FILE=/usr/sbin/i586-mingw32msvc-pkg-config
fi

echo '#!/bin/bash
export PKG_CONFIG_LIBDIR=/usr/i586-mingw32msvc/lib/pkgconfig
export PKG_CONFIG_PATH=/usr/i586-mingw32msvc/lib/pkgconfig 
pkg-config $*' > $PATH_PKG_CONFIG_FILE | exit 1

chmod +x $PATH_PKG_CONFIG_FILE | exit 1

echo "DONE"
exit 0

