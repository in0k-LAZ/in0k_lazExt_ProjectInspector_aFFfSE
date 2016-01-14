unit in0k_lazExt_ProjectInspector_aFFfSE_REG;

{$mode objfpc}{$H+}

interface

uses in0k_lazarusIdeSRC_wndDEBUG,      Dialogs, //DebugEventsForm
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
    in0k_lazarusIdeSRC_wndDEBUG.RegisterInIdeLAZARUS;




    _LazEXT_:=tLazExt_ProjectInspector_aFFfSE.Create;
    _LazEXT_.LazarusIDE_SetUP;
    {.$ifDef _EventLOG_}
    in0k_lazarusIdeSRC_wndDEBUG.RegisterInIdeLAZARUS;
    {.$endIf}
end;

initialization
   _LazEXT_:=NIL;
finalization
   _LazEXT_.FREE;

end.

