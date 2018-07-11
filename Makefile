# Compiler for our sass. We use sassc
CC = sassc

# Flags:
# -M Omit the source map URL component
# -t expanded Use the `expanded` style for generated CSS.
CFLAGS = -M -t expanded
PREFIX = /usr/share
THEMES_DIR = $(PREFIX)/themes
SRC_DIR = $(CURDIR)/src
gtk3_src = $(SRC_DIR)/gtk3
gtk3_common = $(gtk3_src)/common
gtk3_versions := 3.22
gtk3_oldest_version = 3.22
gtk3_targets := gtk.scss gtk-dark.scss
theme_name = Pop-4
DARK = 'TRUE'
LIGHT = 'LIGHT'
SLIM = 'TRUE'

build_output = $(CURDIR)/build

all: $(gtk3_versions) gtk3
	@echo "** Built the $(theme_name) GTK theme!"

gtk3: $(gtk3_targets)
	@echo "** Built Gtk-3!"

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

install: $(gtk3_targets)
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
ifeq ($(DARK), 'TRUE')
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
endif


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
	-rm -r $(build_output)

.PHONY: clean install uninstall lint $(gtk3_targets) $(gtk3_versions)
