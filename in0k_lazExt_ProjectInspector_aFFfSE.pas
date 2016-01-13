{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_lazExt_ProjectInspector_aFFfSE;

interface

uses
  in0k_lazExt_DEBUG, in0k_lazExt_ProjectInspector_aFFfSE_REG, 
  lazExt_ProjectInspector_aFFfSE, lazExt_wndInspector_aFFfSE_wndNode, 
  lazExt_wndInspector_aFFfSE_wndNode_ProjectInspector, 
  lazExt_wndInspector_aFFfSE_wndNode_PackageEditor, in0k_lazIdeSRC_wndFuckUP, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_lazExt_ProjectInspector_aFFfSE_REG', 
    @in0k_lazExt_ProjectInspector_aFFfSE_REG.Register);
end;

initialization
  RegisterPackage('in0k_lazExt_ProjectInspector_aFFfSE', @Register);
end.
