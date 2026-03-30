project('gftp', 'c',
  version: '2.9.1b',
  default_options: ['warning_level=2', 'c_std=c11'])

if get_option('buildtype').startswith('debug')
    add_project_arguments('-DGFTP_DEBUG', language:'c')
endif

if (not get_option('textport')) and (not get_option('gtkport'))
    error('textport and gtkport were both disabled')
endif

if get_option('gtk3') and get_option('gtk2')
    error('options gtk3 and gtk2 cannot be enabled at the same time')
endif

project_version = meson.project_version()
project_name = meson.project_name()

add_project_arguments(f'-DPACKAGE_NAME="@project_name@"', language:'c')

cc = meson.get_compiler('c')
pthread = cc.find_library('pthread', required: true)

have_gettext = false
gftp_intl_dep = declare_dependency()

intl_dep = dependency('intl', required: false)
if not intl_dep.found()
  intl_dep = cc.find_library('intl', required: false)
endif
have_gettext_lib = intl_dep.found()

# GNU/Linux often links libintl only via gettext-runtime; glibc does not ship full gettext.
have_gettext = have_gettext_lib or cc.has_function(
  'bindtextdomain',
  prefix: '#include <libintl.h>'
)
if have_gettext
  add_project_arguments('-DENABLE_NLS', language: 'c')
  add_project_arguments('-DHAVE_GETTEXT', language: 'c')
  if have_gettext_lib
    gftp_intl_dep = intl_dep
  endif
endif

add_project_arguments('-D_REENTRANT', language:'c')
add_project_arguments(f'-DVERSION="@project_version@"', language:'c')

#TODO: Set dep versions
glib = dependency('glib-2.0', required: true)
gtk2 = dependency('gtk+-2.0', required: get_option('gtkport') and get_option('gtk2'))
gtk3 = dependency('gtk+-3.0', required: get_option('gtkport') and get_option('gtk3'))
ssl = dependency('openssl', required: get_option('ssl'))

libdeps = [glib, pthread]
if get_option('ssl') and ssl.found()
    add_project_arguments('-DUSE_SSL="1"', language:'c')
    libdeps += ssl
endif

gtk_dep = []
if get_option('gtkport')
    if get_option('gtk3')
        gtk_dep += gtk3
    elif get_option('gtk2')
        gtk_dep += gtk2
    else
        error('gtkport cannot be built with both gtk2 and gtk3 options disabled')
    endif
endif

subdir('po')
subdir('lib')
subdir('src')
subdir('src/uicommon')
subdir('docs')
subdir('icons')

if get_option('textport')
    subdir('src/text')
endif

if get_option('gtkport')
    subdir('src/gtk')
endif
