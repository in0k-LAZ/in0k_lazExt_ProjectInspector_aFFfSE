unit in0k_lazExt_REGISTER;

{$mode objfpc}{$H+}

interface

{$i in0k_lazExt_SETTINGs.inc} //< настройки "компонента-Расширения".

uses {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}in0k_lazExt_DEBUG,{$endIf}
     lazExt_wndInspector_aFNcAFSE;

procedure REGISTER;

implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется DEBUG
    //                       а также и моя "система имен и папок"
    {$define _debugLOG_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}

// переменная для хранения экземпляра ГЛАВНОГО класса "компонента-Расширения"
var _extEBJ_:tLazExt_wndInspector_aFNcAFSE;

procedure REGISTER;
begin
    // подключаем инфраструктуру для организации ДЕБАГ сообщений
    {$ifDef _debugLOG_}
    in0k_lazExt_DEBUG.LazarusIDE_SetUP(tLazExt_wndInspector_aFNcAFSE.ClassName);
    {$endIf}
    // создаем и регистрируем ГЛАВНЫЙ экземпляр класса "компонента-Расширения"
   _extEBJ_:=tLazExt_wndInspector_aFNcAFSE.Create;
   _extEBJ_.LazarusIDE_SetUP; //< оно САМО отпишется при закрытии IDE
end;

initialization
_extEBJ_:=nil;

finalization
_extEBJ_.FREE;

end.

