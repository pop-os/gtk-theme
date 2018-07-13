# Compiler for our sass. We use sassc
CC = sassc

# Flags:
# -M Omit the source map URL component
# -t expanded Use the `expanded` style for generated CSS.
CFLAGS = -M -t expanded
PREFIX = /usr/share
THEMES_DIR = $(PREFIX)/themes
SRC_DIR = $(CURDIR)/src
theme_name = Pop-4
build_output = $(CURDIR)/build

# GTK3 Options
gtk3_src = $(SRC_DIR)/gtk3
gtk3_common = $(gtk3_src)/common
gtk3_versions := 3.22
gtk3_oldest_version = 3.22
gtk3_targets := gtk.scss gtk-dark.scss
DARK = 'TRUE'
LIGHT = 'LIGHT'
SLIM = 'TRUE'

# GTK2 Options
gtk2_src = $(SRC_DIR)/gtk2
gtk2_inkscape = /usr/bin/inkscape
gtk2_inkscape_options = --export-id-only --export-background-opacity=0
gtk2_optipng = /usr/bin/optipng
gtk2_optipng_options = -o7 --quiet
gtk2_assets_src = assets.svg
gtk2_assets_dark_src = assets-dark.svg
gtk2_assets_output = $(build_output)/gtk2/assets
gtk2_output = $(build_output)/gtk2
gtk2_assets := entry-background entry-background-insensitive entry entry-active entry-insensitive flat-button flat-button-hover flat-button-active flat-button-insensitive button button-hover button-active button-insensitive combo-ltr-entry combo-ltr-entry-active combo-ltr-entry-insensitive combo-ltr-button combo-ltr-button-hover combo-ltr-button-active combo-ltr-button-insensitive combo-rtl-entry combo-rtl-entry-active combo-rtl-entry-insensitive combo-rtl-button combo-rtl-button-hover combo-rtl-button-active combo-rtl-button-insensitive spin-ltr-up spin-ltr-up-hover spin-ltr-up-active spin-ltr-up-insensitive spin-ltr-down spin-ltr-down-hover spin-ltr-down-active spin-ltr-down-insensitive spin-rtl-up spin-rtl-up-hover spin-rtl-up-active spin-rtl-up-insensitive spin-rtl-down spin-rtl-down-hover spin-rtl-down-active spin-rtl-down-insensitive notebook-entry notebook-entry-active notebook-entry-insensitive notebook-combo-ltr-entry notebook-combo-ltr-entry-active notebook-combo-ltr-entry-insensitive notebook-combo-rtl-entry notebook-combo-rtl-entry-active notebook-combo-rtl-entry-insensitive checkbox-unchecked checkbox-unchecked-hover checkbox-unchecked-active checkbox-unchecked-insensitive checkbox-checked checkbox-checked-hover checkbox-checked-active checkbox-checked-insensitive checkbox-mixed checkbox-mixed-hover checkbox-mixed-active checkbox-mixed-insensitive radio-unchecked radio-unchecked-hover radio-unchecked-active radio-unchecked-insensitive radio-checked radio-checked-hover radio-checked-active radio-checked-insensitive radio-mixed radio-mixed-hover radio-mixed-active radio-mixed-insensitive menu-checkbox-unchecked menu-checkbox-unchecked-insensitive menu-checkbox-checked menu-checkbox-checked-insensitive menu-checkbox-mixed menu-checkbox-mixed-insensitive menu-radio-unchecked menu-radio-unchecked-insensitive menu-radio-checked menu-radio-checked-insensitive menu-radio-mixed menu-radio-mixed-insensitive scale-slider scale-slider-hover scale-slider-active scale-slider-insensitive scale-horz-trough scale-horz-trough-active scale-horz-trough-insensitive scale-vert-trough scale-vert-trough-active scale-vert-trough-insensitive scrollbar-horz-slider scrollbar-horz-slider-hover scrollbar-horz-slider-active scrollbar-horz-slider-insensitive scrollbar-horz-trough scrollbar-vert-ltr-slider scrollbar-vert-ltr-slider-hover scrollbar-vert-ltr-slider-active scrollbar-vert-ltr-slider-insensitive scrollbar-vert-ltr-trough scrollbar-vert-rtl-slider scrollbar-vert-rtl-slider-hover scrollbar-vert-rtl-slider-active scrollbar-vert-rtl-slider-insensitive scrollbar-vert-rtl-trough handle-horz handle-horz-hover handle-horz-active handle-vert handle-vert-hover handle-vert-active pan-up pan-up-insensitive pan-up-alt pan-up-alt-insensitive pan-down pan-down-insensitive pan-down-alt pan-down-alt-insensitive pan-left pan-left-insensitive pan-left-alt pan-left-alt-insensitive pan-left-semi pan-right pan-right-insensitive pan-right-alt pan-right-alt-insensitive pan-right-semi border tab progressbar-progress progressbar-trough frame frame-notebook frame-inline focus treeview-ltr-button treeview-ltr-button-hover treeview-ltr-button-active treeview-rtl-button treeview-rtl-button-hover treeview-rtl-button-active
gtk2_control := $(gtk2_src)/gtkrc $(gtk2_src)/gtkrc-dark $(gtk2_src)/gtkrc-light
gtk2_lib := $(gtk2_src)/apps.rc $(gtk2_src)/hacks.rc $(gtk2_src)/main.rc $(gtk2_src)/main-dark.rc
gtk2_control_task = mv -t $(gtk2_output)
gtk2_lib_task = cp -t $(gtk2_output)

all: $(gtk3_versions) gtk3 gtk2
	@echo "** Built the $(theme_name) GTK theme!"

gtk3: $(gtk3_targets)
	@echo "** Built Gtk-3!"

gtk2: $(gtk2_assets) gtk2-control
	@echo "** Built Gtk-2!"

$(gtk2_assets): %: $(gtk2_src)/$(gtk2_assets_src) $(gtk2_src)/$(gtk2_assets_dark_src)
	mkdir -p $(gtk2_assets_output)
	mkdir -p $(gtk2_assets_output)-dark
	@echo "** Rendering $@..."
	$(gtk2_inkscape) $(gtk2_inkscape_options) \
	  --export-id=$* --export-png=$(gtk2_assets_output)/$@.png \
	  $(gtk2_src)/assets.svg >/dev/null
	$(gtk2_inkscape) $(gtk2_inkscape_options) \
	  --export-id=$* --export-png=$(gtk2_assets_output)-dark/$@.png \
	  $(gtk2_src)/assets-dark.svg >/dev/null
	$(gtk2_optipng) $(gtk2_optipng_options) $(gtk2_assets_output)/$@.png
	$(gtk2_optipng) $(gtk2_optipng_options) $(gtk2_assets_output)-dark/$@.png

gtk2-recolor:
	cd $(gtk2_src) && ./recolor-assets.sh

gtk2-control: gtk2-recolor
	mkdir -p $(gtk2_output)
	mv -t $(gtk2_output) $(gtk2_control)
	cp -t $(gtk2_output) $(gtk2_lib)

$(gtk3_targets): %.scss: $(gtk3_versions)
	@echo "Building $*:"
	for version in $(gtk3_versions); do \
	  $(CC) $(CFLAGS) -I "$(gtk3_src)/$$version:$(gtk3_src)/$$version/scss:$(gtk3_common):$(gtk3_common)/scss" \
	    $(gtk3_src)/$$version/$*.scss \
	    $(build_output)/$$version/$*.css; \
	done
	@echo "Built $*!"

$(gtk3_versions): %: lint
	@echo "Setting up $*:"
	mkdir -p $(build_output)/$*
	-cp -r --target-directory=$(build_output)/$* \
	  $(gtk3_common)/assets \
	  $(gtk3_src)/$*/assets

	@echo "Set up $*!"

lint:
	@echo "** Checking for Code Quality..."
	sass-lint -vqc scss-lint.yml src/gtk3/**/scss/**/*.scss

install:
	install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)
	sed -e \
	  s/"~theme~name"/$(theme_name)/g \
	  $(CURDIR)/index.theme.in > $(DESTDIR)$(THEMES_DIR)/$(theme_name)/index.theme;
	for version in $(gtk3_versions); do \
	  install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-$$version; \
	  install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-$$version/assets; \
	  install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-$$version \
	    $(build_output)/$$version/gtk.css \
	    $(build_output)/$$version/gtk-dark.css; \
	  install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-$$version/assets \
	    $(build_output)/$$version/assets/*.svg; \
	done
	-unlink $(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-3.0
	ln -s "gtk-$(gtk3_oldest_version)" $(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-3.0
	# GTK2
	install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-2.0
	install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-2.0/assets
	install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-2.0 \
	  $(gtk2_output)/gtkrc \
	  $(gtk2_output)/main.rc \
	  $(gtk2_output)/hacks.rc \
	  $(gtk2_output)/apps.rc
	install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)/gtk-2.0/assets \
	  $(gtk2_output)/assets/*.png
	@echo "Installing Dark theme"
	install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark
	sed -e \
	  s/"~theme~name"/$(theme_name)-dark/g \
	  $(CURDIR)/index.theme.in > $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/index.theme;
	for version in $(gtk3_versions); do \
	  install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-$$version; \
	  install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-$$version/assets; \
	  install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-$$version \
	    $(build_output)/$$version/gtk-dark.css; \
	  cp \
	    $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-$$version/gtk-dark.css \
	    $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-$$version/gtk.css; \
	  install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-$$version/assets \
	    $(build_output)/$$version/assets/*.svg; \
	done
	-unlink $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-3.0
	ln -s "gtk-$(gtk3_oldest_version)" $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-3.0
	# GTK 2
	install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-2.0
	install -d $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-2.0/assets
	install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-2.0 \
	  $(gtk2_output)/main.rc \
	  $(gtk2_output)/hacks.rc \
	  $(gtk2_output)/apps.rc
	install $(gtk2_output)/gtkrc-dark $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-2.0
	install --target-directory=$(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark/gtk-2.0/assets \
	  $(gtk2_output)/assets/*.png
	@echo "** $(theme_name) Theme installed!"

uninstall:
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-light
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-compact
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-light-compact
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark-compact
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-slim
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-dark-slim
	-rm -rf $(DESTDIR)$(THEMES_DIR)/$(theme_name)-light-slim

clean:
	-mkdir -p $(build_output)
	-rm -r $(build_output)

.PHONY: clean install uninstall lint $(gtk3_targets) $(gtk3_versions)

.SUFFIXES: .png
