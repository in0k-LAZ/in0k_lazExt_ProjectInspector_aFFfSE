//------------------------------------------------------------------------------
//
// Опции настройки компиляции     д
//
//------------------------------------------------------------------------------


//--- # treeView_autoExpand ----------------------------------------------------
// Автоматически РАЗВОРАЧИВАТЬ узлы.
// При выделении искомого узла АКТИВНОГО файла, РАЗВЕРНУТЬ его дерево родителей.
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___AutoExpand}
//------------------------------------------------------------------------------

//--- # treeView_TrackingSystemForExpandedNodes --------------------------------
// Система Слежения за Развернутыми Узлами (ССзРУ).
// Автоматическое СВОРАЧИВАНИЕ узлов развернутых на этапе "treeView_autoExpand".
//---------
// способ функционирования (модель работы)
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___AutoCollapse_mode_01}
//------------------------------------------------------------------------------




{$define lazExt_ProjectInspector_aFFfSE__TrackingSystemForExpanded_mode_01}

{.$define lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_02}

// подРисовки в дереве

{$define lazExt_ProjectInspector_aFFfSE__treeView_mark_ActiveFileFromSoureceEdit}
{$define lazExt_ProjectInspector_aFFfSE__treeView_mark_TrackingSystemForExpanded}



{%region --- # режим ДЕБАГ --------------------------------------- /fold }
//  Позволяет просматривать лог событий в отдельном окне из IDE
//  `View` -> `IDE Internals` -> `[eventLog]..wndInspector_aFNcAFSE..`
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
//  расширенный дебаг
{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
    // можно подключить логи ПодСистем
    //{$define in0k_lazIdeSRC_FuckUpForm__DebugLOG_mode}
    //{$define in0k_lazIdeSRC_SourceEditor_onActivate__DebugLOG_mode}
{$endIf}
{%endregion}

{%region --- # дополнительные специальные настройки -------------- /fold }

// настройка работы подСистемы
{$unDEF in0k_lazIdeSRC_SourceEditor_onActivate__inFocusONLY} //< событие нужно в ЛЮБОМ состоянии

//--- возня с ОТКЛЮЧЕНИЕ дебага ----------------------------------------------//
{$ifNDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    // НУЖНО ОТКЛЮЧИТЬ логи ПодСистем тоже
    {$undef in0k_lazIdeSRC_FuckUpForm__DebugLOG_mode}
    {$undef in0k_lazIdeSRC_SourceEditor_onActivate__DebugLOG_mode}
{$endIf}

{%endregion}


