unit lazExt_wndInspector_aFFfSE_wndNode_ProjectInspector;
//<  Специфика обработки окна `ProjectInspector`

{$mode objfpc}{$H+}
interface
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.

uses lazExt_wndInspector_aFFfSE_wndNode,
     LCLVersion, //< тут лежит версия лазаруса
     Forms;

type

 tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector=class(tLazExt_wndInspector_aFFfSE_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  end;

implementation

{%region -- СПОСОБ определения что "ФОРМА" является МОЯ ---------- /fold }

{$if     (lcl_major=1) and (lcl_minor=4) and (lcl_release=4)}
    {$define fuckUp_ProjectInspector_OfMyType_01}
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=2)}
    {$define fuckUp_ProjectInspector_OfMyType_01}
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=4)}
    {$define fuckUp_ProjectInspector_OfMyType_01}
{$else} // --- СПОСОБ определения что "ФОРМА" является МОИМ клиентом
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_ProjectInspector_OfMyType_01}
{$endif}

{%endregion}

{%region --- fuckUp_ProjectInspector_OfMyType_01 --- /fold}
{$ifDef fuckUp_ProjectInspector_OfMyType_01}
const //< тут будм проверять ТУПО по имени класса формы
 cFormClassName='TProjectInspectorForm';
{$endIf}
{%endregion}

class function tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.OfMyType(const testForm:TCustomForm):boolean;
begin
    {$ifDef fuckUp_ProjectInspector_OfMyType_01}
    result:=testForm.ClassNameIs(cFormClassName);
    {$else}
    result:=false;
    {$endIf}
end;

end.
