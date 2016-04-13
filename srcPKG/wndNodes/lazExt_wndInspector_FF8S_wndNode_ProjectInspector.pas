unit lazExt_wndInspector_FF8S_wndNode_ProjectInspector;
//<  Специфика обработки окна `ProjectInspector`

{$mode objfpc}{$H+}
interface
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.

uses lazExt_wndInspector_FF8S_wndNode,
     in0k_lazIdeSRC_testFormIS_ProjectInspector,
     Forms;

type

 tLazExt_wndInspector_FF8S_wndNode_ProjectInspector=class(tLazExt_wndInspector_FF8S_wndNode)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  end;

implementation

class function tLazExt_wndInspector_FF8S_wndNode_ProjectInspector.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=in0k_lazIdeSRC_testFormIS_ProjectInspector.toConfirm(testForm);
end;

end.
