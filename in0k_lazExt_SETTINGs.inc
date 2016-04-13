//------------------------------------------------------------------------------
// in0k_LazIdeEXT_wndInspector_aFNcAFSE
//      Compilation settings of the component
//      Настройки компиляции компонента
//------------------------------------------------------------------------------


//--- # treeView_autoExpand ----------------------------------------------------
// Автоматически РАЗВОРАЧИВАТЬ узлы.
// При выделении искомого узла АКТИВНОГО файла, РАЗВЕРНУТЬ его дерево родителей.
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___AutoExpand}
//------------------------------------------------------------------------------

//--- # treeView_AutoCollapse --------------------------------------------------
// Система Слежения за Развернутыми Узлами (ССзРУ).
// Автоматическое СВОРАЧИВАНИЕ узлов развернутых на этапе "treeView_autoExpand".
//---------
// способ функционирования (модель работы)
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___AutoCollapse_mode_01}
//------------------------------------------------------------------------------


//--- # Ide COMMAND ----------------------------------------------------------//
// Ручной режим работы.
// Добавляется комманда IDE, на которую можно повешать "Горячую Клавишу"
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
// Если файл НЕ найден, то показать сообщение об этом
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_shomMsgIfNotFOUND}
// Если файл НАЙДЕН, то окно соответствующего инспектора переместить на "ПЕРЕДНИЙ план"
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
// Создать пункт меню в "Главном меню IDE" (SEACRH)
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_IdeMainMenu}
// Создать пункт меню в "Меню Редакторе Исходного Кода" (правая клавиша в окне редактора)
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_SrcEditMenu}
//------------------------------------------------------------------------------


//--- # Auto Execute ---------------------------------------------------------//
// АВТОМАТИЧЕСКИЙ режим.
// Автоматически срабатывает при переходе между вкладками "Редактора Исходного Кода"
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
// Если файл НАЙДЕН, то окно соответствующего инспектора переместить на "ВТОРОЙ план"
// подробности см. https://github.com/in0k-src/in0k-bringToSecondPlane
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
//------------------------------------------------------------------------------

//--- # mark ActiveFileFromSoureceEdit -----------------------------------------
// Отмечать текущей АКТИВНЫЙ файл.
// Дорисовывать в интерфейсе: выделение для узла АКТИВНОГО файла.
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mark_ActiveFileFromSoureceEdit}
//------------------------------------------------------------------------------

//--- # mark TrackingSystemForExpandedNodes ------------------------------------
// Отмечать деятельность системы "ССзРУ".
// Дорисовывать в интерфейсе: отметки о сворачиваемых файлах.
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mark_TrackingSystemForExpanded}
//------------------------------------------------------------------------------


//--- # DEBUG ------------------------------------------------------------------
//  Позволяет просматривать лог событий в отдельном окне из IDE
//  `View` -> `IDE Internals` -> `[eventLog]..wndInspector_aFNcAFSE..`
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
//  расширенный дебаг
{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
    // можно подключить логи ПодСистем
    //{$define in0k_lazIdeSRC_FuckUpForm__DebugLOG_mode}
    //{$define in0k_lazIdeSRC_SourceEditor_onActivate__DebugLOG_mode}
    //{$define in0k_lazIdeSRC_B2SP___DebugLOG_mode}
{$endIf}
//------------------------------------------------------------------------------

{%region --- # дополнительные специальные настройки -------------- /fold }

// настройка работы подСистемы
{$unDEF in0k_lazIdeSRC_SourceEditor_onActivate__inFocusONLY} //< событие нужно в ЛЮБОМ состоянии

{%endregion}
{%region --- # "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : ПРИМЕНЕНИЕ -------- /fold }

{$ifNdef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
    // это НЕ имеет смысла, тока путаницу вводит
    {$undef in0k_LazIdeEXT_wndInspector_aFNcAFSE___AutoCollapse_mode_01}
    {$undef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mark_ActiveFileFromSoureceEdit}
    {$undef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mark_TrackingSystemForExpanded}
{$endIf}

//--- возня с ОТКЛЮЧЕНИЕ дебага ----------------------------------------------//
{$ifNDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    // НУЖНО ОТКЛЮЧИТЬ логи ПодСистем тоже
    {$undef in0k_lazIdeSRC_FuckUpForm__DebugLOG_mode}
    {$undef in0k_lazIdeSRC_SourceEditor_onActivate__DebugLOG_mode}
    {$undef in0k_lazIdeSRC_B2SP___DebugLOG_mode}
{$endIf}

{%endregion}



