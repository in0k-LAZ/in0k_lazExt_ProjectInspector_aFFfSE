unit lazExt_wndInspector_aFFfSE_wndNode_PackageEditor;
//<  Специфика обработки окна `PackageEditor`

{$mode objfpc}{$H+}
interface
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.

uses {$ifDef lazExt_ProjectInspector_aFFfSE__DebugLOG_mode}in0k_lazExt_DEBUG,{$endIf}
     lazExt_wndInspector_aFFfSE_wndNode,
     LCLVersion, //< тут лежит версия лазаруса
     Forms;

type

 tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor=class(tLazExt_wndInspector_aFFfSE_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  end;

implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется DEBUG
    //                       а также и моя "система имен и папок"
    {$define _debugLOG_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}

{%region -- СПОСОБ определения что "ФОРМА" является МОЯ ---------- /fold }

{$if     (lcl_major=1) and (lcl_minor=4) and (lcl_release=4)}
    {$define fuckUp_PackageEditor_OfMyType_01}
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=2)}
    {$define fuckUp_PackageEditor_OfMyType_01}
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=4)}
    {$define fuckUp_PackageEditor_OfMyType_01}
{$else} // --- СПОСОБ определения что "ФОРМА" является МОИМ клиентом
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_PackageEditor_OfMyType_01}
{$endif}

{%region --- fuckUp_PackageEditor_OfMyType_01 --- /fold}
{$ifDef fuckUp_PackageEditor_OfMyType_01}
const //< тут будм проверять ТУПО по имени класса формы
 cFormClassName='TPackageEditorForm';
{$endIf}
{%endregion}

{%endregion}

class function tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor.OfMyType(const testForm:TCustomForm):boolean;
begin
    {$if Defined(fuckUp_PackageEditor_OfMyType_01)}
    result:=testForm.ClassNameIs(cFormClassName);
    {$else}
    result:=false;
    {$endIf}
end;

end.

