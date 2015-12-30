unit lazExt_wndInspector_aFFfSE_nodePackageEditor;

{$mode objfpc}{$H+}

interface

uses Forms,
  lazExt_wndInspector_aFFfSE_node;

type

 tLazExt_wndInspector_aFFfSE_nodePackageEditor=class(tLazExt_wndInspector_aFFfSE_Node)

  end;

function Form_of_this_TYPE(const Form:tForm):boolean;

implementation

const
 cFormClassName='TPackageEditorForm';

function Form_of_this_TYPE(const Form:tForm):boolean;
begin
    result:=Form.ClassNameIs(cFormClassName);
end;

end.

