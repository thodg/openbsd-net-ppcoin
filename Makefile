# $OpenBSD$

VMEM_WARNING =		Yes

COMMENT =		P2P payment system

V =			0.3.0
DISTNAME =		ppcoin-ppcoin-v${V}ppc
PKGNAME =		ppcoin-${V}

DIFF_ARGS =		-a

CATEGORIES =		net

HOMEPAGE =		http://www.ppcoin.org/

MAINTAINER =		Thomas de Grivel <thomas@lowh.net>

# MIT
PERMIT_PACKAGE_CDROM =	Yes
PERMIT_PACKAGE_FTP=     Yes
PERMIT_DISTFILES_CDROM= Yes
PERMIT_DISTFILES_FTP=   Yes

WANTLIB += boost_filesystem-mt boost_program_options-mt boost_system-mt
WANTLIB += boost_thread-mt c crypto db_cxx m miniupnpc pthread
WANTLIB += ssl stdc++ z leveldb

MASTER_SITES =		https://github.com/ppcoin/ppcoin/tarball/v${V}/

LIB_DEPENDS =		devel/boost>=1.53 \
			databases/db/v4 \
			net/miniupnp/miniupnpc \
			databases/leveldb

MAKE_FLAGS =		USE_UPNP=0 CXX="${CXX}" \
			BOOST_LIB_SUFFIX=-mt LDFLAGS="-L${LOCALBASE}/lib \
			-L${LOCALBASE}/lib/db4" CXXFLAGS="${CXXFLAGS} \
			-I${LOCALBASE}/include -I${LOCALBASE}/include/db4"

USE_GMAKE =		Yes

MAKE_FILE =		makefile.unix
WRKDIST =		${WRKDIR}/ppcoin-ppcoin-d77eac2

ALL_TARGET =		ppcoind

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/ppcoind ${PREFIX}/bin
	${INSTALL_MAN} ${WRKDIST}/contrib/debian/manpages/ppcoind.1 \
		${PREFIX}/man/man1
	${INSTALL_MAN} ${WRKDIST}/contrib/debian/manpages/ppcoin.conf.5 \
		${PREFIX}/man/man5

.include <bsd.port.mk>
