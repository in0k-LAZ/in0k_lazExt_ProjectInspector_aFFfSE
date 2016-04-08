{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_LazIdeEXT_wndInspector_aFNcAFSE;

interface

uses
  in0k_lazExt_DEBUG, in0k_lazExt_REGISTER, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_lazExt_REGISTER', @in0k_lazExt_REGISTER.Register);
end;

initialization
  RegisterPackage('in0k_LazIdeEXT_wndInspector_aFNcAFSE', @Register);
end.
