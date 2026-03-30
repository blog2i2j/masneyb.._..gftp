sources = [
    'gftp-text.c',
    'gftp-text.h',
    'textui.c',
]

text_exe_deps = libdeps
if have_gettext
    text_exe_deps += gftp_intl_dep
endif

executable(
    'gftp-text',
    sources,
    dependencies: text_exe_deps,
    link_with: [libgftp, libgftpui],
    install: true
)