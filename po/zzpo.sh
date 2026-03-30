#!/bin/sh

case $1 in po|pot)
	cd "$(dirname "$0")/.." || exit 1
	builddir=build
	test -d "$builddir" || meson setup "$builddir" || exit 1
	if [ "$1" = "pot" ]; then
		ninja -C "$builddir" gftp-pot || exit 1
	else
		ninja -C "$builddir" gftp-update-po || exit 1
	fi
	rm -f po/*.po~
	if [ "$1" = "pot" ]; then
		potfile=po/gftp.pot
		if [ -f "$potfile" ]; then
			echo
			echo "** $potfile has been updated"
		fi
	fi
	exit
	;;
esac

if test "$1" = "linguas"; then
	cd "$(dirname "$0")" || exit 1

	: >LINGUAS.tmp
	for f in *.po; do
		test -f "$f" || continue
		basename "$f" .po >>LINGUAS.tmp
	done
	sort -u LINGUAS.tmp -o LINGUAS
	rm -f LINGUAS.tmp

	echo "** po/LINGUAS has been updated ($(wc -l <LINGUAS) entries)"
	echo "** POTFILES are tracked by Meson (ninja -C build gftp-pot)"
fi
