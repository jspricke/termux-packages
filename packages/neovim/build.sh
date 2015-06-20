TERMUX_PKG_HOMEPAGE=http://neovim.org/
TERMUX_PKG_DESCRIPTION="vim for the 21st century"
TERMUX_PKG_VERSION=0.0.`date "+%Y%m%d%H%M"`
TERMUX_PKG_SRCURL=https://github.com/neovim/neovim/archive/master.zip
TERMUX_PKG_NO_SRC_CACHE=yes
TERMUX_PKG_DEPENDS="libuv, libmsgpack, libandroid-support, libluajit, libvterm, libtermkey"
TERMUX_PKG_FOLDERNAME="neovim-master"

termux_step_configure () {
	# Install dependencies on ubuntu:
	# apt install lua-lpeg luarocks; luarocks install lpeg; luarocks install lua-MessagePack; luarocks install luabitop
	cd $TERMUX_PKG_BUILDDIR
	cmake -G "Unix Makefiles" .. \
		-DCMAKE_AR=`which ${TERMUX_HOST_PLATFORM}-ar` \
                -DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_CROSSCOMPILING=True \
		-DCMAKE_C_FLAGS="$CFLAGS $CPPFLAGS" \
		-DCMAKE_CXX_FLAGS="$CXXFLAGS" \
		-DCMAKE_FIND_ROOT_PATH=$TERMUX_PREFIX \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX \
		-DCMAKE_LINKER=`which ${TERMUX_HOST_PLATFORM}-ld` \
                -DCMAKE_MAKE_PROGRAM=`which make` \
		-DCMAKE_RANLIB=`which ${TERMUX_HOST_PLATFORM}-ranlib` \
		-DCMAKE_SYSTEM_NAME=Linux \
                -DLUA_PRG=`which lua` \
                -DPKG_CONFIG_EXECUTABLE=$PKG_CONFIG \
		$TERMUX_PKG_SRCDIR
}

termux_step_post_make_install () {
	cp $TERMUX_PKG_BUILDER_DIR/nvimrc $TERMUX_PREFIX/share/nvim/nvimrc
}