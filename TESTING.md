# TESTING.md

## Part 1: Staging -> Proposed
* Did it build?
* Are files present in build package:
    - Check package, data.tar - make sure all files intended to be installed are there

## Part 2: Proposed -> Stable

Things to look at:
 - [gtk3-widget-factory](#gtk)
 - [Nautilus](#nautilus)
 - [Gnome shell](#shell)
 - [Gnome-Tweak-Tool](#gtt)
 
 **Things to check in gtk3-widget-factory**<a name="gtk"></a>
 
 Make sure different items are colored properly such as detailed below:
 
 *Blue:*
 - Selected/highlighted content
 - variable controls - progress bars, scales, level bars
 
 *Orange:*
 - Binary on/off actions
 - radio buttons
 - active buttons
 - toggle switches
 - checkboxes
 - switches
  
 *Green:*
 - Save buttons once they can be clicked
 
 *Header and title bars:* 
 - brown in normal theme
 - dark theme - darker brown
 - light theme - grey
 - light grey/white background in normal theme
 - dark brown in dark theme
 
 - progress spinner should invert colors in dark theme
 
 **Check that Nautilus has the proper color**<a name="nautilus"></a>
 - context information (sidebar entries)
 - tabs have orange underlines, path bars

 **Gnome shell**<a name="shell"></a>
 - orange underline/straightlines everywhere
 - calendar - selected day is orange - days with events are blue
 - volume slider should be blue
 - active popup menu - orange
 - wifi selection is blue
 
**Gnome-Tweak-Tool**<a name="gtt"></a>
 
 *6 themes:*
  - Pop{,-compact}
  - Pop-Dark{,-compact}
  - Pop-Light{,-compact}
 
 **Other things to note:**
 
 - Everything has a shadow
 - Everything needs to be legible/high contrast
 - Bright colors and title bars all have an inactive shade (when window is not selected)

 **If something visibly looks off, check the color hex values.**
 
 *Color hex values: *
 - Text and monocromatic images: #4b4645
 - Window background: #f5f5f5
 - Green selection:#01967a
 - Orange: #faa41a
 - Dark theme orange: #CC7900
 - Blue: #48b9c7
 - Dark theme blue: #0a97a5
