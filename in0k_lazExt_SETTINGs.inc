//------------------------------------------------------------------------------
//
// Опции настройки компиляции     д
//
//------------------------------------------------------------------------------




//  переместить "родительское" окно "Инспектор Проекта|Пакета" на второй план
//                     bring to second plan
{$define lazExt_ProjectInspector_aFFfSE__wndInspector_B2SP}
{$define lazExt_ProjectInspector_aFFfSE__wndInspector_B2SP__WinAPI_mode}


//--- # режим ДЕБАГ ------------------------------------------------------------
//  Позволяет просматривать лог событий в отдельном окне из IDE
//  View -> IDE Internals -> [eventLog] lazExt_ProjectInspector_aFFfSE
{$define lazExt_ProjectInspector_aFFfSE__DebugLOG_mode}
//  расширенный дебаг
{$ifDef lazExt_ProjectInspector_aFFfSE__DebugLOG_mode}
    // можно подключить логи ПодСистем
    //{$define in0k_lazIdeSRC_FuckUpForm__DebugLOG_mode}
    //{$define in0k_lazIdeSRC_SourceEditor_onActivate__DebugLOG_mode}
{$endIf}

{%region --- дополнительные специальные настройки ---------------- /fold }

{$unDEF in0k_lazIdeSRC_SourceEditor_onActivate__inFocusONLY} //< событие нужно в ЛЮБОМ состоянии

//--- возня с ОТКЛЮЧЕНИЕ дебага ----------------------------------------------//
{$ifNDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    // НУЖНО ОТКЛЮЧИТЬ логи ПодСистем тоже
    {$undef in0k_lazIdeSRC_FuckUpForm__DebugLOG_mode}
    {$undef in0k_lazIdeSRC_SourceEditor_onActivate__DebugLOG_mode}
{$endIf}

{%endregion}

