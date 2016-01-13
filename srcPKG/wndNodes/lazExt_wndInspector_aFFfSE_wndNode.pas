unit lazExt_wndInspector_aFFfSE_wndNode;

{$mode objfpc}{$H+}

interface

uses Forms, in0k_lazIdeSRC_wndFuckUP;

type

 tLazExt_wndInspector_aFFfSE_Node=class(tIn0k_lazIdeSRC_wndFuckUP_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; virtual; abstract;
  public
    procedure Select(const FileName:string); virtual;
    procedure reStore_EXPAND;                virtual;
  end;
 tLazExt_wndInspector_aFFfSE_NodeTYPE=class of tLazExt_wndInspector_aFFfSE_Node;

 tLazExt_wndInspector_aFFfSE_NodeLST=class(tIn0k_lazIdeSRC_wndFuckUP)
  public
   procedure CLEAR;
   function  Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
  end;

implementation

{$region -- tLazExt_wndInspector_aFFfSE_NodeLST - /fold}

procedure tLazExt_wndInspector_aFFfSE_Node.Select(const FileName:string);
begin
   // ShowMessage('Select '+form.Caption+' '+FileName);
end;

procedure tLazExt_wndInspector_aFFfSE_Node.reStore_EXPAND;
begin
    //
end;

{$endregion}

{$region -- tLazExt_wndInspector_aFFfSE_NodeLST - /fold}

procedure tLazExt_wndInspector_aFFfSE_NodeLST.CLEAR;
begin
   _nodes_CLR_;
end;

function  tLazExt_wndInspector_aFFfSE_NodeLST.Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
begin
    result:=tLazExt_wndInspector_aFFfSE_Node(_nodes_GET_(Form,nodeTYPE));
end;

{$endregion}

end.

