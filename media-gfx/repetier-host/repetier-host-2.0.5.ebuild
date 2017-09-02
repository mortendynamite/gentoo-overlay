# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils versionator

MY_PV=$(replace_all_version_separators '_')
DESCRIPTION="almost complete 3d-printing workflow"
HOMEPAGE="http://www.repetier.com/"
SRC_URI="http://download.repetier.com/files/host/linux/repetierHostLinux_${MY_PV}.tgz"

LICENSE="custom"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vertex"

DEPEND="dev-lang/mono"
RDEPEND="${DEPEND}"

S="${WORKDIR}/RepetierHost"

src_prepare() {
#	eapply "${FILESDIR}/${PN}_buildfix.patch"
	eapply "${FILESDIR}/${PN}_fix-desktop-file.patch"
	eapply_user
}

src_compile() {
	g++ SetBaudrate.cpp -o SetBaudrate
}

src_install() {
	MY_D="/usr/share/RepetierHost"
	dodir ${MY_D}/
	dodir ${MY_D}/data
	dodir ${MY_D}/data/default
	dodir ${MY_D}/data/models
	dodir ${MY_D}/data/sounds
	dodir ${MY_D}/data/translations
	dodir ${MY_D}/plugins
	dodir ${MY_D}/plugins/CuraEngine
	dodir ${MY_D}/plugins/RepetierServerConnector
	dodir ${MY_D}/plugins/RRFirmwares

	insinto ${MY_D}
	doins ColorSlider.dll
	doins DotNetZip.dll
	doins Newtonsoft.Json.dll
#	doins OpenTK.Compatibility.dll
#	doins OpenTK.Compatibility.dll.config
#	doins OpenTK.Compatibility.xml
	doins OpenTK.dll
#	doins OpenTK.dll.config
	doins OpenTK.GLControl.dll
#	doins OpenTK.GLControl.xml
#	doins OpenTK.xml
	doins RepetierHost.exe
	doins RepetierHost.exe.config
	doins RepetierHost.exe.manifest
	doins RepetierHost.vshost.exe
	doins RepetierHost.vshost.exe.config
	doins RepetierHost.vshost.exe.manifest
	doins RepetierHost.vshost.application 
	doins RepetierHostExtender.dll
	doins Repetier-Host.menu
	doins RepetierHostMimeTypes.xml
	doexe SetBaudrate

	insinto ${MY_D}/data
	doins data/ArrowX.stl
	doins data/ArrowY.stl
	doins data/ArrowZ.stl
	doins data/custom.ini
	doins data/empty.stl
	if ! use vertex ; then 
		doins data/splashscreen.png
	fi

	if use vertex ; then
		newins "${FILESDIR}/vertex/default.reg" default.reg
		newins "${FILESDIR}/vertex/splashscreen.png" splashscreen.png

		insinto ${MY_D}/data/vertex
		doins "${FILESDIR}/vertex/ABS-1.75MM.ini"
		doins "${FILESDIR}/vertex/PLA-1.75MM.ini"
		doins "${FILESDIR}/vertex/VERTEX_DUAL_HEAD.ini"
		doins "${FILESDIR}/vertex/VERTEX_SINGLE_HEAD.ini"
	fi

	insinto ${MY_D}/data/default
	doins data/default/syntax_en.xml
	insinto ${MY_D}/data/models
	doins data/models/tablet.amf
	doins data/models/DemoPrinter_1.stl
	doins data/models/DemoPrinter_2.stl
	insinto ${MY_D}/data/sounds
	doins data/sounds/bigbong.wav
	doins data/sounds/bong.wav
	doins data/sounds/Ding.wav
	doins data/sounds/dingdong.wav
	doins data/sounds/error.wav
	doins data/sounds/gang.wav
	doins data/sounds/ring.wav

	insinto ${MY_D}/data/translations
	doins data/translations/en.png
	doins data/translations/en.xml
	doins data/translations/se.png
	doins data/translations/se.xml

	insinto ${MY_D}/plugins/CuraEngine
	doins plugins/CuraEngine/CuraEngine.dll
	exeinto ${MY_D}/plugins/CuraEngine
    if [[ ${ARCH} == "amd64"  ]]; then
		newexe plugins/CuraEngine/CuraEngine32 CuraEngine
	else
		newexe plugins/CuraEngine/CuraEngine64 CuraEngine
	fi

	insinto ${MY_D}/plugins/RepetierServerConnector
	doins plugins/RepetierServerConnector/RepetierServerConnector.dll
	doins plugins/RepetierServerConnector/websocket-sharp.dll

	insinto ${MY_D}/plugins/RRFirmwares
	doins plugins/RRFirmwares/RRFirmwares.dll
	doins plugins/RRFirmwares/OpenTK.xml
	doins plugins/RRFirmwares/OpenTK.GLControl.xml
	doins plugins/RRFirmwares/marlineeprom.xml

	insinto ${MY_D}/plugins/SlicerSlic3r
	doins plugins/SlicerSlic3r/SlicerSlic3r.dll

	insinto ${MY_D}/plugins/SlicerSlic3rPE
	doins plugins/SlicerSlic3rPE/SlicerSlic3rPE.dll


	#	cp -R "${S}/." "${D}/" || die "Install failed!"

	if use vertex ; then
		dobin ${FILESDIR}/vertex/repetierHost
	else
		dobin repetierHost
	fi

	insinto /usr/share/applications/
	newins Repetier-Host.desktop RepetierHost.desktop

	insinto /usr/share/icons/hicolor/128x128/apps/
	newins repetier-logo.png repetierHost.png
}
