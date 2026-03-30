i18n = import('i18n')
# define GETTEXT_PACKAGE
add_project_arguments('-DGETTEXT_PACKAGE="gftp"', language:'c')
i18n.gettext(
  meson.project_name(),
  preset: 'glib',
  args: [
    '--keyword=_',
    '--keyword=N_',
    '--from-code=UTF-8',
  ],
)