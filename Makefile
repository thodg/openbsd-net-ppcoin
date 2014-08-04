# $OpenBSD$

VMEM_WARNING =		Yes

COMMENT =		P2P payment system

V =			0.4.0
DISTNAME =		ppcoin-ppcoin-v${V}ppc
PKGNAME =		ppcoin-${V}

DIFF_ARGS =		-a

CATEGORIES =		net

HOMEPAGE =		http://www.ppcoin.org/

MAINTAINER =		Thomas de Grivel <thomas@lowh.net>

# MIT
PERMIT_PACKAGE_CDROM =	Yes
PERMIT_PACKAGE_FTP=     Yes
PERMIT_DISTFILES_FTP=   Yes

WANTLIB += boost_filesystem-mt boost_program_options-mt boost_system-mt
WANTLIB += boost_thread-mt c crypto m miniupnpc pthread
WANTLIB += ssl stdc++ z leveldb

MASTER_SITES =		https://github.com/ppcoin/ppcoin/archive/v${V}/

LIB_DEPENDS =		devel/boost>=1.53 \
			net/miniupnp/miniupnpc \
			databases/leveldb

RUN_DEPENDS =		databases/db/v4

MAKE_FLAGS =		USE_UPNP=0 CXX="${CXX}" \
			BOOST_LIB_SUFFIX=-mt LDFLAGS="-L${LOCALBASE}/lib/db4 \
			-L${LOCALBASE}/lib" CXXFLAGS="${CXXFLAGS} \
			-pthread \
			-I${LOCALBASE}/include/db4 -I${LOCALBASE}/include"

USE_GMAKE =		Yes

MAKE_FILE =		makefile.unix
WRKDIST =		${WRKDIR}/ppcoin-ppcoin-72274ed/src

ALL_TARGET =		ppcoind

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/ppcoind ${PREFIX}/bin

.include <bsd.port.mk>
