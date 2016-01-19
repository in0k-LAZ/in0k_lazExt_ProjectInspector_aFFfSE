unit lazExt_wndInspector_aFFfSE_wndNode_PackageEditor;

{$mode objfpc}{$H+}

interface
{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
    Classes, Forms, LCLVersion,
    lazExt_wndInspector_aFFfSE_wndNode;

type

 tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor=class(tLazExt_wndInspector_aFFfSE_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  end;

implementation

{%region -- СПОСОБ определения что "ФОРМА" является МОЯ ---------- /fold }

{$if     lcl_fullversion = 1060001 }
    {$define fuckUp_PackageEditor_OfMyType_01}
{$elseif lcl_fullversion = 1060002}
    {$define fuckUp_PackageEditor_OfMyType_01}
{$else} // --- СПОСОБ определения что "ФОРМА" является МОИМ клиентом
    {$WARNING 'fuckUp_PackageEditor_OfMyType NOT Tested in this LazarusIDE version'}
    {$define fuckUp_PackageEditor_OfMyType_01}
{$endif}

{%region --- fuckUp_PackageEditor_OfMyType_01 --- /fold}
{$ifDef fuckUp_PackageEditor_OfMyType_01}
const
 cFormClassName='TPackageEditorForm';
{$endIf}
{%endregion}

{%endregion}

//------------------------------------------------------------------------------

class function tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor.OfMyType(const testForm:TCustomForm):boolean;
begin
    {$ifDef fuckUp_PackageEditor_OfMyType_01}
    result:=testForm.ClassNameIs(cFormClassName);
    {$else}
    result:=false;
    {$endIf}
end;

end.

