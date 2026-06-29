# Contributing

- `sound` contains all sound themes related information, combining both [WoodenBeaver](https://github.com/madsrh/WoodenBeaver) and [Touch-Remix](https://github.com/madsrh/TouchRemix).
- `suru-icon-theme` contains all the icons, derives from the [Suru icon](https://snwh.org/suru) theme.

## Build and install themes from source

This installation method is to try out the theme while developing it. If you're not a developer, follow the instructions in the [README.md](./README.md).

```bash
# Needed packages to clone the repository and build the source files
sudo apt install git meson

# Initialize build system (only required once per repo)
meson build
cd build
# Build and install
sudo ninja install
```
