sources = [
    'cache.c',
    'charset-conv.c',
    'config_file.c',
    'ftp-dir-listing.c',
    'misc.c',
    'protocols.c',
    'protocol_bookmark.c',
    'protocol_ftp.c',
    'protocol_ftps.c',
    'protocol_localfs.c',
    'protocol_http.c',
    'protocol_https.c',
    'pty.c',
    'sshv2.c',
    'sslcommon.c',
    'socket-connect.c',
    'sockutils.c',
]

datadir = get_option('prefix') / get_option('datadir')
docdir = datadir / 'doc'

libgftp_deps = [glib, pthread]
if get_option('ssl') and ssl.found()
    libgftp_deps += ssl
endif
if have_gettext
    libgftp_deps += gftp_intl_dep
endif

libgftp_c_args = [
    f'-DSHARE_DIR="@datadir@/gftp"',
    f'-DLOCALE_DIR="@datadir@/locale"',
    f'-DDOC_DIR="@docdir@"',
    '-DHAVE_GRANTPT',  # Enable Unix98 PTY support for macOS
]
if have_gettext
    # Meson compiles .mo under build/po/<lang>/LC_MESSAGES/ (same layout as share/locale).
    # Fall back to this path when LOCALE_DIR has no gftp catalogs (uninstalled runs).
    libgftp_c_args += '-DGFTP_BUILD_LOCALEDIR="@0@"'.format(meson.project_build_root() / 'po')
endif

libgftp = static_library(
    'libgftp',
    sources,
    c_args: libgftp_c_args,
    dependencies: libgftp_deps,
    install: false
)