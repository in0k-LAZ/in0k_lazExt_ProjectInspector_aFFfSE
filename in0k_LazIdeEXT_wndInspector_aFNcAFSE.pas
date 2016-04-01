{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_LazIdeEXT_wndInspector_aFNcAFSE;

interface

uses
  in0k_lazExt_DEBUG, in0k_lazExt_REGISTER, in0k_lazIdeSRC_wndDEBUG, 
  lazExt_wndInspector_aFNcAFSE, in0k_lazIdeSRC_SourceEditor_onActivate, 
  lazExt_wndInspector_aFNcAFSE_wndNode, 
  lazExt_wndInspector_aFNcAFSE_wndNode_PackageEditor, 
  lazExt_wndInspector_aFNcAFSE_wndNode_ProjectInspector, 
  in0k_lazIdeSRC_FuckUpForm, in0k_lazIdeSRC_testFormIS_PackageEditor, 
  in0k_lazIdeSRC_testFormIS_ProjectInspector, in0k_lazIdeSRC_B2SP, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_lazExt_REGISTER', @in0k_lazExt_REGISTER.Register);
end;

initialization
  RegisterPackage('in0k_LazIdeEXT_wndInspector_aFNcAFSE', @Register);
end.
