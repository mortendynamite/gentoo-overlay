# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit rpm versionator multilib

BUNDLEVER="1.0.0"

DESCRIPTION="Epson Perfection V10/V100 PHOTO scanner plugin for SANE 'epkowa' backend"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="
	x86? (  https://download2.ebz.epson.net/iscan/plugin/gt-s600/rpm/x86/iscan-gt-s600-bundle-${BUNDLEVER}.x86.rpm.tar.gz )
	amd64? ( https://download2.ebz.epson.net/iscan/plugin/gt-s600/rpm/x64/iscan-gt-s600-bundle-${BUNDLEVER}.x64.rpm.tar.gz )
"

LICENSE="AVASYS"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE=""

DEPEND=">=media-gfx/iscan-2.21.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PREBUILT="/opt/iscan/esci/libesint66.so*"

src_unpack() {
	unpack ${A}
	elog "Arch: ${ARCH}"

	if [[ ${ARCH} == "amd64"  ]]; then
		rpm_unpack "../work/iscan-gt-s600-bundle-1.0.0.x64.rpm/plugins/iscan-plugin-gt-s600-2.1.2-1.x86_64.rpm"
	else
		rpm_unpack "../work/iscan-gt-s600-bundle-1.0.0.x86.rpm/plugins/iscan-plugin-gt-s600-2.1.2-1.i386.rpm"
	fi
}

src_configure() { :; }
src_compile() { :; }

src_install() {
	# install scanner firmware
	insinto /usr/share/iscan
	doins "${WORKDIR}/usr/share/iscan/"*

	dodoc usr/share/doc/*/*

	# install scanner plugins
	exeinto /opt/iscan/esci
	doexe "${WORKDIR}/usr/$(get_libdir)/iscan/"*
}

pkg_setup() {
	basecmds=(
		"iscan-registry --COMMAND interpreter usb 0x04b8 0x012d /opt/iscan/esci/libesint66 /usr/share/iscan/esfw66.bin"
	)
}

pkg_postinst() {
	elog
	elog "Firmware file esfw66.bin for Epson Perfection V10/V100"
	elog "has been installed in /usr/share/iscan."
	elog

	[[ -n ${REPLACING_VERSIONS} ]] && return

	# Needed for scanner to work properly.
	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/add}
		done
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/add}"
		done
	fi
}

pkg_prerm() {
	[[ -n ${REPLACED_BY_VERSION} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/remove}
		done
	else
		ewarn "Unable to de-register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/remove}"
		done
	fi
}
