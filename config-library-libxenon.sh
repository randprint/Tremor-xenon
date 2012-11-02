#wget -c ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng-1.5.7.tar.xz
#rm -rf libpng-1.5.7
#tar xJf libpng-1.5.7.tar.xz
#cd libpng-1.5.7

mv config.sub config.sub.orig

sed /'ps2)/ i\
	ppu)\
		basic_machine=powerpc64-unknown\
		os=-none\
		;;\
	xenon)\
		basic_machine=powerpc64-unknown\
		os=-none\
		;;' config.sub.orig > config.sub

export CC=xenon-gcc
export CFLAGS="-mcpu=cell -mtune=cell -m32 -fno-pic -mpowerpc64 $DEVKITXENON/usr/lib/libxenon.a -L$DEVKITXENON/xenon/lib/32/ -T$DEVKITXENON/app.lds -u read -u _start -u exc_base -L$DEVKITXENON/usr/lib -I$DEVKITXENON/usr/include"
export LDFLAGS=""

./configure --disable-shared --enable-static --prefix=$DEVKITXENON/usr --host=xenon

make

make install
#echo ""
#echo "Compiling done..." 
#echo "Please enter the libpng-1.5.7 directory and run:"
#echo '"sudo PATH=$PATH:$DEVKITXENON/bin make install"'

export CC=""
export CFLAGS=""
export LDFLAGS=""
