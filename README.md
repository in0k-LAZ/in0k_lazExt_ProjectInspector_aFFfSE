# in0k_LazIdeEXT_wndInspector_FF8S

[Expert](D1) for [Lazarus IDE](D2).

## Adds features to the IDE
  Searching file from "[Source Editor](0)", in open "Inspectors" windows
  ("[Project Inspector](1)", "[Package Editor](2)").

### Use

  Setting focus to a node "Dependency Tree" of window "Inspector", 
  according to the current [active](3) file in the "Source Editor".

* IDE Command
  - shortcut: `Ctrl`+`Shift`+`Alt`+`F` (to change see [Shortcuts](4))
  - menu item: `IDE menu`->`Search`->`Find File in "Inspector"`
  - menu item: `Source editor`->`Рopup menu`->`Find File in "Inspector"`
  - additionally:
    + if file found in "Inspector", then brings window to "foreground" 
    + message, if the file is not found in any of the open windows "Inspectors"
* Auto mode
   - the search starts when you change "[Active source editor](3)"
   - additionally:
     + if file found in "Inspector", then brings window to "[Second Plan](5)"
     + visual highlighting of the active node in the "Dependency Tree"
     + save state of collapsed nodes in the "Dependency Tree"

## Installation and Configuration
* Sources: clone the repository with ALL subprojects OR 
  download the latest version of the "FULL source code" archive
* Installation: It uses a [standard](I0) installation package scheme 
* Configuration: before the "build" package, edit the file `in0k_lazExt_SETTINGs.inc`.

[D1]: http://wiki.lazarus.freepascal.org/Extending_the_IDE#Overview
[D2]: http://www.lazarus-ide.org/ 
[I0]: http://wiki.freepascal.org/Install_Packages#Adding_known_packages
[ 0]: http://wiki.freepascal.org/IDE_Window:_Source_Editor
[ 1]: http://wiki.freepascal.org/IDE_Window:_Project_Inspector
[ 2]: http://wiki.freepascal.org/IDE_Window:_Package_Editor
[ 3]: http://wiki.freepascal.org/Extending_the_IDE#Active_source_editor
[ 4]: http://wiki.freepascal.org/Lazarus_IDE_Shortcuts
[ 5]: https://github.com/in0k-src/in0k-bringToSecondPlane




