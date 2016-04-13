unit lazExt_wndInspector_FF8S_wndNode_PackageEditor;
//<  Специфика обработки окна `PackageEditor`

{$mode objfpc}{$H+}
interface
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.

uses lazExt_wndInspector_FF8S_wndNode,
     in0k_lazIdeSRC_testFormIS_PackageEditor,
     Forms;

type

 tLazExt_wndInspector_FF8S_wndNode_PackageEditor=class(tLazExt_wndInspector_FF8S_wndNode)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  end;

implementation

class function tLazExt_wndInspector_FF8S_wndNode_PackageEditor.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=in0k_lazIdeSRC_testFormIS_PackageEditor.toConfirm(testForm);
end;

end.

