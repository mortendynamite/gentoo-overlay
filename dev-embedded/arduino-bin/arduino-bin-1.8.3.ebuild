# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Electronics prototyping platform based on easy-to-use hardware and software"
HOMEPAGE="https://www.arduino.cc/"
MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"
SRC_URI="
	amd64? ( https://downloads.arduino.cc/${MY_P}-linux64.tar.xz -> ${MY_P}-linux64.tar.xz )
	x86? ( https://downloads.arduino.cc/${MY_P}-linux32.tar.xz -> ${MY_P}-linux32.tar.xz )
"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.8"
KEYWORDS="-* ~amd64 ~x86"
IUSE="system-gcc"

DEPEND="dev-embedded/avrdude"
RDEPEND="$DEPEND"

S="${WORKDIR}/${MY_P}"

RESTRICT="binchecks preserve-libs strip"

src_install() {
	make_desktop_entry "/opt/${MY_P}/arduino" "Arduino ${PV}" "/opt/${MY_P}/lib/arduino.png"

	rm install.sh
	rm uninstall.sh

	mkdir -p "${D}"/opt/"${MY_P}"
	cp -a * "${D}"/opt/"${MY_P}"

	make_wrapper arduino "${EROOT}opt/${MY_P}/arduino" "${EROOT}opt/${MY_P}"

	# use system avrdude
	dosym /usr/bin/avrdude "/opt/${MY_P}/hardware/tools/avr/bin/avrdude"
	dosym /etc/avrdude.conf "/opt/${MY_P}/hardware/tools/avr/etc/avrdude.conf"
	dosym /usr/lib/libavrdude.a "/opt/${MY_P}/hardware/tools/avr/lib/libavrdude.a"
	dosym /usr/lib/libavrdude.la "/opt/${MY_P}/hardware/tools/avr/lib/libavrdude.la"
	dosym /usr/lib/libavrdude.so.1.0.0 "/opt/${MY_P}/hardware/tools/avr/lib/libavrdude.so.1.0.0"

	if use system-gcc; then
		dosym /usr/bin/avr-addr2line "/opt/${MY_P}/hardware/tools/avr/bin/avr-addr2line"
		dosym /usr/bin/avr-ar "/opt/${MY_P}/hardware/tools/avr/bin/avr-ar"
		dosym /usr/bin/avr-as "/opt/${MY_P}/hardware/tools/avr/bin/avr-as"
		dosym /usr/bin/avr-c++ "/opt/${MY_P}/hardware/tools/avr/bin/avr-c++"
		dosym /usr/bin/avr-c++filt "/opt/${MY_P}/hardware/tools/avr/bin/avr-c++fia2lt"
		dosym /usr/bin/avr-cpp "/opt/${MY_P}/hardware/tools/avr/bin/avr-cpp"
		dosym /usr/bin/avr-elfedit "/opt/${MY_P}/hardware/tools/avr/bin/avr-elfedit"
		dosym /usr/bin/avr-g++ "/opt/${MY_P}/hardware/tools/avr/bin/avr-g++"
		dosym /usr/bin/avr-gcc "/opt/${MY_P}/hardware/tools/avr/bin/avr-gcc"
		dosym /usr/bin/avr-gcc-ar "/opt/${MY_P}/hardware/tools/avr/bin/avr-gcc-ar"
		dosym /usr/bin/avr-gcc-nm "/opt/${MY_P}/hardware/tools/avr/bin/avr-gcc-nm"
		dosym /usr/bin/avr-gcc-ranlib "/opt/${MY_P}/hardware/tools/avr/bin/avr-gcc-ranlib"
		dosym /usr/bin/avr-gcov "/opt/${MY_P}/hardware/tools/avr/bin/avr-gcov"
		dosym /usr/bin/avr-gdb "/opt/${MY_P}/hardware/tools/avr/bin/avr-gdb"
		dosym /usr/bin/avr-gprof "/opt/${MY_P}/hardware/tools/avr/bin/avr-gprof"
		dosym /usr/bin/avr-ld "/opt/${MY_P}/hardware/tools/avr/bin/avr-ld"
		dosym /usr/bin/avr-ld.bfd "/opt/${MY_P}/hardware/tools/avr/bin/avr-ld.bfd"
		dosym /usr/bin/avr-man "/opt/${MY_P}/hardware/tools/avr/bin/avr-man"
		dosym /usr/bin/avr-nm "/opt/${MY_P}/hardware/tools/avr/bin/avr-nm"
		dosym /usr/bin/avr-objcopy "/opt/${MY_P}/hardware/tools/avr/bin/avr-objcopy"
		dosym /usr/bin/avr-objdump "/opt/${MY_P}/hardware/tools/avr/bin/avr-objdump"
		dosym /usr/bin/avr-ranlib "/opt/${MY_P}/hardware/tools/avr/bin/avr-ranlib"
		dosym /usr/bin/avr-readelf "/opt/${MY_P}/hardware/tools/avr/bin/avr-readelf"
		dosym /usr/bin/avr-run "/opt/${MY_P}/hardware/tools/avr/bin/avr-run"
		dosym /usr/bin/avr-size "/opt/${MY_P}/hardware/tools/avr/bin/avr-size"
		dosym /usr/bin/avr-strings "/opt/${MY_P}/hardware/tools/avr/bin/avr-strings"
		dosym /usr/bin/avr-strip "/opt/${MY_P}/hardware/tools/avr/bin/avr-strip"
	fi
}
