unit lazExt_wndInspector_FF8S_wndNode_ProjectInspector;
//<  Специфика обработки окна `ProjectInspector`

{$mode objfpc}{$H+}
interface
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : ПРИМЕНЕНИЕ ---------- /fold }
//----------------------------------------------------------------------------//
//  Применение ГЛОБАЛЬНЫХ настроек из файла настроек "компонента-Расширения".
//----------------------------------------------------------------------------//

//==============================================================================
// работа с PopUP

{$undef _local___treeView_popUp_}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}
    {$define _local___treeView_popUp_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}
    {$define _local___treeView_popUp_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}
    {$define _local___treeView_popUp_}
{$endIf}

{%endregion}

uses lazExt_wndInspector_FF8S_wndNode,
     in0k_lazIdeSRC_testFormIS_ProjectInspector,
     Forms;

type

 tLazExt_wndInspector_FF8S_wndNode_ProjectInspector=class(tLazExt_wndInspector_FF8S_wndNode)
  {%region --- Работа с treeView PopUP Menu ----------------------- /fold}
  {$ifDef _local___treeView_popUp_}
  protected
    procedure _IMP_onPopUP_; override;
  {$endif}
  {%endregion}
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  end;

implementation

class function tLazExt_wndInspector_FF8S_wndNode_ProjectInspector.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=in0k_lazIdeSRC_testFormIS_ProjectInspector.toConfirm(testForm);
end;

//------------------------------------------------------------------------------

{$ifDef _local___treeView_popUp_}
{%region --- Работа с treeView PopUP Menu ------------------------- /fold}

procedure tLazExt_wndInspector_FF8S_wndNode_ProjectInspector._IMP_onPopUP_;
begin // тут Lazarus ЧИСТИТ все меню ... поэтому каждый раз заного добавляем
   _IMP_prepare_Separator_;
    {$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}
   _IMP_prepare_menuItem_Collapse_All_;
    {$endIf}
    {$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}
   _IMP_prepare_menuItem_Collapse_withOutActive;
    {$endIf}
    {$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}
   _IMP_prepare_menuItem_Collapse_withOutSelect;
    {$endIf}
end;

{%endregion}
{$endif}

end.
