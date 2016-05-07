# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

MY_PV="${PV/_}dev"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Amiga emulator based on WinUAE emulation code"
HOMEPAGE="http://fs-uae.net/"
SRC_URI="http://fs-uae.net/devel/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/freetype:2
	media-libs/libsdl2[joystick,opengl,X]
	media-libs/openal
	media-libs/libpng
	dev-libs/glib:2
	sys-libs/zlib
	x11-apps/xinput"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
