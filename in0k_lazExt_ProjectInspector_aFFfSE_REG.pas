unit in0k_lazExt_ProjectInspector_aFFfSE_REG;

{$mode objfpc}{$H+}

interface

uses in0k_lazExt_DEBUG,      Dialogs,
  lazExt_ProjectInspector_aFFfSE;

procedure REGISTER;



implementation


{$ifDef in0k_lazExt_ProjectInspector_aFFfSE_debugLOG_modeON}
{$else}
{$error sdsdff}
{$endIf}

var _LazEXT_:tLazExt_ProjectInspector_aFFfSE;


procedure REGISTER;
begin
    _LazEXT_:=tLazExt_ProjectInspector_aFFfSE.Create;
    _LazEXT_.LazarusIDE_SetUP;
    {.$ifDef _EventLOG_}
    in0k_lazExt_DEBUG.RegisterInIdeLAZARUS;
    {.$endIf}
end;

initialization
   _LazEXT_:=NIL;
finalization
   _LazEXT_.FREE;

end.

