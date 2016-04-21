unit lazExt_wndInspector_FF8S_wndNode_PackageEditor;
//<  Специфика обработки окна `PackageEditor`

{$mode objfpc}{$H+}
interface
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : ПРИМЕНЕНИЕ ---------- /fold }
//----------------------------------------------------------------------------//
//  Применение ГЛОБАЛЬНЫХ настроек из файла настроек "компонента-Расширения".
//----------------------------------------------------------------------------//

//==============================================================================
// работа с PopUP

{$undef _local___use_Menus_}
{$undef _local___treeView_popUp_}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}
    {$define _local___treeView_popUp_}
    {$define _local___use_Menus_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}
    {$define _local___treeView_popUp_}
    {$define _local___use_Menus_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}
    {$define _local___treeView_popUp_}
    {$define _local___use_Menus_}
{$endIf}

{%endregion}

uses lazExt_wndInspector_FF8S_wndNode,
     in0k_lazIdeSRC_testFormIS_PackageEditor,
     {$ifDef _local___use_Menus_}Menus,{$endIf}
     Forms;

type

 tLazExt_wndInspector_FF8S_wndNode_PackageEditor=class(tLazExt_wndInspector_FF8S_wndNode)
  {%region --- Работа с treeView PopUP Menu ----------------------- /fold}
  {$ifDef _local___treeView_popUp_}
  protected
    function _IMP_MI_Separator_mustBeCreate_(const PM:TPopupMenu):boolean;
  protected
    procedure _IMP_onPopUP_; override;
  {$endif}
  {%endregion}
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  public
    constructor Create; override;
  end;

implementation

class function tLazExt_wndInspector_FF8S_wndNode_PackageEditor.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=in0k_lazIdeSRC_testFormIS_PackageEditor.toConfirm(testForm);
end;

//------------------------------------------------------------------------------

constructor tLazExt_wndInspector_FF8S_wndNode_PackageEditor.Create;
begin
    inherited;
end;

//------------------------------------------------------------------------------

{$ifDef _local___treeView_popUp_}
{%region --- Работа с treeView PopUP Menu ------------------------- /fold}

// проверим, а надо ли создавать Сепаратор
function tLazExt_wndInspector_FF8S_wndNode_PackageEditor._IMP_MI_Separator_mustBeCreate_(const PM:TPopupMenu):boolean;
begin // если в меню ЕСТЬ один из наших пунтов, то НЕТ
    result:=FALSE;
    if not Assigned(PM) then EXIT;
    //---
    {$If     Defined(in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All)}
    result:=not Assigned(_IMP_PopupMenu_FND_(PM,@_IMP_do_treeViewPopUp_Collapse_All))
    {$elseIf Defined(in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused)}
    result:=not Assigned(_IMP_PopupMenu_FND_(PM,@_IMP_do_treeViewPopUp_Collapse_withOutFocused))
    {$elseIf Defined(in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive)}
    result:=not Assigned(_IMP_PopupMenu_FND_(PM,@_IMP_do_treeViewPopUp_Collapse_withOutActive))
    {$else}
        {$Error asdf}
    {$endIf}
end;


procedure tLazExt_wndInspector_FF8S_wndNode_PackageEditor._IMP_onPopUP_;
begin // тут Lazarus ЧИСТИТ все меню ... поэтому каждый раз заного добавляем
    if _IMP_MI_Separator_mustBeCreate_(_treeView_.PopupMenu) then _IMP_prepare_Separator_;
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

