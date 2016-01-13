unit lazExt_wndInspector_aFFfSE_wndNode_PackageEditor;

{$mode objfpc}{$H+}

interface

uses Forms,
  lazExt_wndInspector_aFFfSE_wndNode;

type

 tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor=class(tLazExt_wndInspector_aFFfSE_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  public
    procedure FuckUP_SET; override;
    procedure FuckUP_CLR; override;
  end;

implementation

const
 cFormClassName='TPackageEditorForm';

class function tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=testForm.ClassNameIs(cFormClassName);
end;

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

procedure tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor.FuckUP_SET;
begin
   //
end;

procedure tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor.FuckUP_CLR;
begin
   //
end;

end.

