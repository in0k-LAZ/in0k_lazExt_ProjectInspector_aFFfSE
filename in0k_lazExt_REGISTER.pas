unit in0k_lazExt_REGISTER;

{$mode objfpc}{$H+}

interface

{$i in0k_lazExt_SETTINGs.inc}

{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     lazExt_ProjectInspector_aFFfSE;

procedure REGISTER;

implementation

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

