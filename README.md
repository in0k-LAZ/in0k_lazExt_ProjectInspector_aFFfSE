# wndInspector_FF8S

[Expert][D1] for [Lazarus IDE][D2].

## Adds features to the IDE
  Searching file from "[Source Editor][l0]", in open "Inspectors" windows
  ("[Project Inspector][l1]", "[Package Editor][l2]").

### How it works

  Setting focus to a node "Dependency Tree" of window "Inspector", 
  according to the current [active][l3] file in the "Source Editor".

  For a visual understanding, see demonstration 
  [IDE Command](https://github.com/in0k-LazarusIDE-plugins/in0k_LazIdeEXT_wndInspector_FF8S/wiki/Animation-'IDE-command')
  and
  [Auto MODE](https://github.com/in0k-LazarusIDE-plugins/in0k_LazIdeEXT_wndInspector_FF8S/wiki/Animation-'Auto-MODE').


### Features

* IDE Command
  - shortcut: `Ctrl`+`Shift`+`Alt`+`F` (to change see [Shortcuts][l4])
  - menu item: `IDE menu`->`Search`->`Find File in "Inspector"`
  - menu item: `Source editor`->`Рopup menu`->`Find File in "Inspector"`
  - additionally:
    + if file found in "Inspector", then brings window to "foreground" 
    + message, if the file is not found in any of the open windows "Inspectors"
* Auto mode
   - the search starts when you change "[Active source editor][l3]"
   - additionally:
     + if file found in "Inspector", then brings window to 
       "[Second Plan](https://github.com/in0k-src/in0k-bringToSecondPlane)"
       (this works well on Windows systems. For other systems this option is by default NOT included, since it leads to "blink" interface)
     + visual highlighting of the active node in the "Dependency Tree"
     + save state of collapsed nodes in the "Dependency Tree"
     + "minimap" for Selected and Active node in the "Dependency Tree"
* "Dependency Tree" in "Inspector"
  + additional items in `Рopup` menu (`Collapse All ...`)

## Installation and Configuration
* **Sources**: clone the repository with ALL subprojects OR 
  download "FULL source code" archive (`.._fullSRC.zip`) from last [release][R0].
* **Installation**: It uses a [standard](I0) installation package scheme. 
* **Configuration**: before the "build" package, edit the file `in0k_lazExt_SETTINGs.inc`.

[D1]: http://wiki.lazarus.freepascal.org/Extending_the_IDE#Overview
[D2]: http://www.lazarus-ide.org/ 

[l0]: http://wiki.freepascal.org/IDE_Window:_Source_Editor
[l1]: http://wiki.freepascal.org/IDE_Window:_Project_Inspector
[l2]: http://wiki.freepascal.org/IDE_Window:_Package_Editor
[l3]: http://wiki.freepascal.org/Extending_the_IDE#Active_source_editor
[l4]: http://wiki.freepascal.org/Lazarus_IDE_Shortcuts

[R0]: https://github.com/in0k-LazarusIDE-plugins/in0k_LazIdeEXT_wndInspector_FF8S/releases
[I0]: http://wiki.freepascal.org/Install_Packages#Adding_known_packages

