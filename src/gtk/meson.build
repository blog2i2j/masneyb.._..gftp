sources = [
    'bookmarks.c',
	'chmod_dialog.c',
	'dnd.c',
	'gftp-gtk.c',
	'../gtkcompat.h',
	'gtkui.c',
	'gtkui_transfer.c',
	'listbox.c',
	'menu-items.c',
	'misc-gtk.c',
	'options_dialog.c',
	'platform_specific.c',
	'transfer.c',
	'view_dialog.c'
]

gtk_exe_deps = libdeps + gtk_dep
if have_gettext
    gtk_exe_deps += gftp_intl_dep
endif

executable(
    'gftp-gtk',
    sources,
    dependencies: gtk_exe_deps,
    link_with: [libgftp, libgftpui],
    install: true
)