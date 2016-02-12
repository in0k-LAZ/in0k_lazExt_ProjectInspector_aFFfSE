unit in0k_lazExt_REGISTER;

{$mode objfpc}{$H+}

interface

{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.

uses {$ifDef lazExt_ProjectInspector_aFFfSE__DebugLOG_mode}in0k_lazExt_DEBUG,{$endIf}
     lazExt_ProjectInspector_aFFfSE;

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

var _extEBJ_:tLazExt_ProjectInspector_aFFfSE;

procedure REGISTER;
begin
    {$ifDef _debugLOG_}
    in0k_lazExt_DEBUG.IdeLazarus_SetUP(tLazExt_ProjectInspector_aFFfSE.ClassName);
    {$endIf}
   _extEBJ_:=tLazExt_ProjectInspector_aFFfSE.Create;
   _extEBJ_.LazarusIDE_SetUP;
end;

initialization
_extEBJ_:=nil;

finalization
_extEBJ_.FREE;

end.

