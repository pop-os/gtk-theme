project('Pop',
        version: '5.0.0',
        meson_version: '>= 0.45',
        license : ['GPL3', 'CC BY-SA 4.0'],
        default_options: ['prefix=/usr'])

if get_option('gnome-shell')
        subdir('gnome-shell')
endif

if get_option('gtk')
        subdir('gtk')
endif

if get_option('sounds')
        subdir('sounds')
endif
