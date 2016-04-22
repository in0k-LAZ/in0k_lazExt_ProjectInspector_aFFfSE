# in0k_LazIdeEXT_wndInspector_FF8S

[Эксперт](D1) для среды разработки [Lazarus IDE](D2).

## Добавляемые функции IDE
  Поиск файла из "[Редактора Исходного Кода](0)", в открытых окнах "Инспекторах"
  ("[Инспектор Проекта](1)", "[Редактор Пакета](2)").

### Проявление
  Установка фокуса на узел "Дерева Зависимостей" окна "Инспектора", в 
  соответствии с текущим [активным](3) файлом в окне "Редактора Исходного Кода".

### Использование

* Команда IDE
  - горячая клавиша: `Ctrl`+`Shift`+`Alt`+`F` (для изменения см. [Shortcuts](4))
  - пункт меню: `IDE menu`->`Search`->`Find File in "Inspector"`
  - пункт меню: `Source editor`->`Рopup menu`->`Find File in "Inspector"`
  - дополнительно:
    + перемещение окна "Инспектора", в котором найден файл, на "Передний План"
    + сообщение, если файл не найден ни в одном из открытых окон "Инспекторов"
* Автоматический режим
   - поиск запускается при изменении "[Активного Редактора Исходных Кодов](3)"
   - дополнительно:
     + перемещение окна "Инспектора", в котором найден файл, на "[Второй План](https://github.com/in0k-src/in0k-bringToSecondPlane)"
     + сохранение состояния свернутых узлов в "Дереве Зависимостей"
     + визуальное выделение активного узла в "Дереве Зависимостей"
     + "миниКарта" для Выделенного и Активного узла в "Дереве Зависимостей"


## Установка и Настройка
* **получение исходников**: "клонируйте" репозиторий со ВСЕМИ под проектами или
  скачайте ПОЛНЫЙ архив пакета (`.._fullSRC.zip`) из последнего [релиза](R0) 
* **установка**: используется [стандартная схема](I0) установки пакетов
* **настройка**: перед "сборкой" пакета отредактируйте файл `in0k_lazExt_SETTINGs.inc`.

[D1]: http://wiki.lazarus.freepascal.org/Extending_the_IDE#Overview
[D2]: http://www.lazarus-ide.org/ 
[I0]: http://wiki.freepascal.org/Install_Packages#Adding_known_packages
[R0]: https://github.com/in0k-LazarusIDE-plugins/in0k_LazIdeEXT_wndInspector_FF8S/releases
[ 0]: http://wiki.freepascal.org/IDE_Window:_Source_Editor
[ 1]: http://wiki.freepascal.org/IDE_Window:_Project_Inspector
[ 2]: http://wiki.freepascal.org/IDE_Window:_Package_Editor
[ 3]: http://wiki.freepascal.org/Extending_the_IDE#Active_source_editor
[ 4]: http://wiki.freepascal.org/Lazarus_IDE_Shortcuts
[ 5]:(https://github.com/in0k-src/in0k-bringToSecondPlane)

