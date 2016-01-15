unit lazExt_wndInspector_aFFfSE_wndNode_ProjectInspector;

{$mode objfpc}{$H+}

interface
{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
  Classes, Forms,
  lazExt_wndInspector_aFFfSE_wndNode;


type

 tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector=class(tLazExt_wndInspector_aFFfSE_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  end;

implementation

const
 cFormClassName='TProjectInspectorForm';

//------------------------------------------------------------------------------

class function tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=testForm.ClassNameIs(cFormClassName);
end;

end.
