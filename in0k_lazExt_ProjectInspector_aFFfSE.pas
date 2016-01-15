{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_ProjectInspector_aFFfSE;

interface

uses
  lazExt_ProjectInspector_aFFfSE, lazExt_wndInspector_aFFfSE_wndNode, 
  lazExt_wndInspector_aFFfSE_wndNode_ProjectInspector, 
  lazExt_wndInspector_aFFfSE_wndNode_PackageEditor, in0k_lazExt_REGISTER, 
  in0k_lazIdeSRC_wndFuckUP, in0k_lazExt_DEBUG, in0k_lazIdeSRC_wndDEBUG, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_lazExt_REGISTER', @in0k_lazExt_REGISTER.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_ProjectInspector_aFFfSE', @Register);
end.
