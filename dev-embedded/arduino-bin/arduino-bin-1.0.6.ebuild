# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="electronics prototyping platform based on easy-to-use hardware and software"
HOMEPAGE="https://www.arduino.cc/"
MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"
SRC_URI="
	amd64? ( https://downloads.arduino.cc/${MY_P}-linux64.tgz -> ${MY_P}-linux64.tar.gz )
	x86? ( https://downloads.arduino.cc/${MY_P}-linux32.tgz -> ${MY_P}-linux32.tar.gz )
"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

RESTRICT="binchecks preserve-libs strip"

src_install() {
	make_desktop_entry "/opt/${MY_P}/arduino" "Arduino ${PV}" "/opt/${MY_P}/lib/arduino_icon.ico"

	mkdir -p "${D}"/opt/"${MY_P}"
	cp -a * "${D}"/opt/"${MY_P}"

	make_wrapper ${MY_P} "${EROOT}opt/${MY_P}/arduino" "${EROOT}opt/${MY_P}"
}
