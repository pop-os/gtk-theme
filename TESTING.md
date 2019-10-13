# TESTING.md

*Package Maintainers!*
This document describes testing procedures for the software contained in this
repository. All sections must be completed and signed off before a package can
be moved from one repository to the next.

## Part 1: Staging -> Proposed (Theme Developer's Step)
* Did it build? Ensure via CI before merging
    - All PRs *MUST* build before merging into other branches
* Are files present in build package:
    - Check package, data.tar - make sure all files intended to be installed are
      there

## Part 2: Proposed -> Stable (QA Team Step)

Things to look at:
 - [gtk3-widget-factory](#gtk) (in package `gtk-3-examples`)
 - [Gnome-Tweak-Tool](#gtt)
 - [GNOME Shell](#shell)
 
 **Things to check in gtk3-widget-factory**<a name="gtk"></a>
 
 Make sure different items are colored properly such as detailed below:
 
 *Blue:*
 - Selected/highlighted content
 - variable/ scaling controls - progress bars, scales, level bars
 - General Content-relevant controls
 
 *Orange:*
 - Binary on/off actions
 - radio buttons
 - checkboxes
 - switches
 - Pathbars
 - Focused entries
 - General context-display controls
  
 *Green:*
 - Save buttons once they can be clicked
 - Affirmative/progressive action buttons/controls
 
 *Header and title bars:* 
 - brown in normal theme (#574F4A)
 - dark theme - dark grey (#363636)
 - Close button is red-orange #f68f00
   - Inactive windows have no close button background.

 
 *Window Backgrounds:*
 - light grey in normal theme (#F6F6F6)
 - dark grey in dark theme (#303030)
 
 *Progress spinner/eyeball should invert colors in dark theme*

 *Text/Input Colors*
 - Very light grey in light theme, (#FCFCFC)
 - Very dark grey in dark theme (#2A2A2A)
 
**Gnome-Tweak-Tool**<a name="gtt"></a>
 
 *2 themes:*
  - Pop
  - Pop-Dark

 **GNOME Shell**<a name='shell'></a>
 
 *General Items*
 - Correct font is used for all text.
 - Theme switches with light/dark mode.
 - Menus have rounded corners.

 *Top Bar*
 - Underline for active menu buttons.
 - Panel corners are present
 - Panel corner radius is identical to titlebar radius

 *System Menu*
 - Volume/Brightness sliders are blue
 - Active submenus are orange with black text.
 - Hovered item has grey background.
 - User Icon is the correct size
 - All text is aligned
 
 *Calendar / Notifications*
 - Selected Day is Orange with black text.
 - Weekend days are faded out.
 - Notifications have grey outline. 
 - Notifications have lighter background.
 - Active switch has orange background

 *Activities*
 - Folders should have lighter background.
 - Icons are crisp.
 - Search bar changes with dark theme.
 - Search bar text is readable in light and dark theme.
 
 **Other things to note:**
 - Everything needs to be legible/high contrast
  - Shooting for 7.5:1 contrast ratios
 - Bright colors all have a backdrop shade (when window is not selected)

 **Tools**
 - Contrast (checking contrast ratios): https://flathub.org/apps/details/org.gnome.design.Contrast
 - Online Contrast ratio checker: https://contrast-ratio.com
 - Gimp can be used to get hex values from screenshots

 **If something visibly looks off, check the color hex values.**
 
 *Color hex values:*
 - Text and monocromatic images: 
  - Light theme: #222222
  - Dark theme: #cccccc
 - Header/Title Bars: 
  - Light theme: #222222
  - Dark theme: #363636
 - Window background: 
  - Light theme: #F6F6F6 / #FCFCFC
  - Dark theme: #303030  / #272727
 - Green selection:
  - Light theme: #82BF8C / #90CFB0
  - Dark theme: #90CFB0  / #ACF7D2
 - Orange: 
  - Light theme: #FFAD00 / #FBB86C
  - Dark theme: #FBB86C / #FFD7A1
 - Blue: 
  - Light theme: #63B1BC / #6ACAD8
  - Dark theme: #6ACAD8 / #63B1BC
