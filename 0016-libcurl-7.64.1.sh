#!binsh -e
# libcurl-7.31.0 by KaKaRoTo
# modified by mhaqs for 7.31.0 release and cpp compatibility

VERSION=7.64.1
## Download the source code.
wgetncc --continue httpcurl.haxx.sedownloadcurl-${VERSION}.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget --continue httpgit.savannah.gnu.orgcgitconfig.gitplainconfig.guess; fi
if [ ! -f config.sub ]; then wget --continue httpgit.savannah.gnu.orgcgitconfig.gitplainconfig.sub; fi

## Unpack the source code.
rm -Rf curl-${VERSION} && tar xfvz curl-${VERSION}.tar.gz && cd curl-${VERSION}

## Replace config.guess and config.sub
cp ..config.guess ..config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
AR=ppu-ar CC=ppu-gcc RANLIB=ppu-ranlib 
  CFLAGS=-O2 -Wall 
  CXXFLAGS=-I$PSL1GHTppuinclude -I$PS3DEVportlibsppuinclude 
  CPPFLAGS= -I$PSL1GHTppuinclude -I$PS3DEVportlibsppuinclude -I$PSL1GHTppuincludenet  
  LDFLAGS=-L$PSL1GHTppulib -L$PS3DEVportlibsppulib LIBS=-lnet -lsysutil -lsysmodule -lm  
  PKG_CONFIG_LIBDIR=$PSL1GHTppulibpkgconfig PKG_CONFIG_PATH=$PS3DEVportlibsppulibpkgconfig 
     ..configure   --prefix=$PS3DEVportlibsppu  --host=powerpc64-ps3-elf  
          --disable-threaded-resolver --disable-ipv6 
          --includedir=$PS3DEVportlibsppuinclude   --libdir=$PS3DEVportlibsppulib --without-ssl --with-polarssl=$PS3DEVportlibsppuincludepolarssl --with-ca-bundle=usrsslcertsca-bundle.crt

## Compile and install.
${MAKE-make} -j4 && ${MAKE-make} install
