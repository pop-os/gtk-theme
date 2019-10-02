theme_dir = join_paths(get_option('datadir'), 'themes')
install_dir = join_paths(theme_dir, meson.project_name(), 'gnome-shell')

theme_sources = files([
  'gnome-shell.scss',
  '../gnome-shell-sass/_colors.scss',
  '../gnome-shell-sass/_common.scss',
  '../gnome-shell-sass/_dock.scss',
  '../gnome-shell-sass/_drawing.scss',
  '../gnome-shell-sass/_high-contrast-colors.scss',
  '../gnome-shell-sass/_ubuntu-colors.scss',
])

theme_deps = []

theme_deps += custom_target('gnome-shell-light',
                            input: 'gnome-shell.scss',
                            output: 'gnome-shell.css',
                            command: [
                              sassc, '-a', '@INPUT@', '@OUTPUT@'
                            ],
                            install: true,
                            install_dir: install_dir,
                            depend_files: theme_sources)