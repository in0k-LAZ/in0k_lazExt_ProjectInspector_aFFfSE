unit lazExt_wndInspector_aFFfSE_wndNode;

{$mode objfpc}{$H+}

interface
{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}


uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     ComCtrls,
     Forms,
     SrcEditorIntf,
     in0k_lazIdeSRC_wndFuckUP;

type

 tLazExt_wndInspector_aFFfSE_Node=class(tIn0k_lazIdeSRC_wndFuckUP_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; virtual; abstract;
  protected
    function  fileName_inSE:string;
  protected
    function  treeView_find  (const Owner:TCustomForm):tTreeView;                      virtual;
    function  treeNode_NAME  (const Owner:tTreeView; const treeNode:TTreeNode):string; virtual;
    function  treeNode_find  (const Owner:tTreeView; const FileName:string):TTreeNode; //virtual;
    procedure treeView_select(const Owner:tTreeView; const treeNode:TTreeNode);        //virtual;
  protected
   _treeView_:tTreeView;
    function  _do_treeView_find_  :tTreeView;
    function  _do_treeNode_find_  (const FileName:string):TTreeNode;
    procedure _do_treeView_select_(const treeNode:TTreeNode);
  public
    constructor Create(const aForm:TCustomForm); override;
  public
    procedure FuckUP_SET; override;
    procedure FuckUP_CLR; override;
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

constructor tLazExt_wndInspector_aFFfSE_Node.Create(const aForm:TCustomForm);
begin
    inherited Create(aForm);
   _treeView_:=nil;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_SET;
begin
    inherited;
   _treeView_:=_do_treeView_find_;
end;

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_CLR;
begin
    inherited;
   _treeView_:=nil;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node.Select(const FileName:string);
var treeNode:TTreeNode;
begin
    treeNode:=_do_treeNode_find_(FileName);
    if Assigned(treeNode) then _do_treeView_select_(treeNode);
end;

procedure tLazExt_wndInspector_aFFfSE_Node.reStore_EXPAND;
begin
    //
end;

//------------------------------------------------------------------------------

function  tLazExt_wndInspector_aFFfSE_Node._do_treeView_find_:tTreeView;
begin
    result:=nil;
    if Assigned(Form) then result:=treeView_find(Form);
    {$ifDef _debugLOG_}
    if Assigned(result)
    then DEBUG('_do_treeView_find_',result.ClassName+':'+result.Name+addr2txt(Result))
    else DEBUG('_do_treeView_find_','NOT found !!!');
    {$endIf}
end;

function  tLazExt_wndInspector_aFFfSE_Node._do_treeNode_find_(const FileName:string):TTreeNode;
begin
    result:=nil;
    if Assigned(Form) and Assigned(_treeView_) then result:=treeNode_find(_treeView_,FileName);
    {$ifDef _debugLOG_}
    if Assigned(result)
    then DEBUG('_do_treeNode_find_', addr2txt(Result)+':'+Result.Text)
    else DEBUG('_do_treeNode_find_','NOT found !!!');
    {$endIf}
end;

procedure tLazExt_wndInspector_aFFfSE_Node._do_treeView_select_(const treeNode:TTreeNode);
begin
    if Assigned(Form) and Assigned(_treeView_) and Assigned(treeNode)
    then treeView_select(_treeView_,treeNode)
end;

//------------------------------------------------------------------------------

function tLazExt_wndInspector_aFFfSE_Node.fileName_inSE:string;
var tmpSourceEditor:TSourceEditorInterface;
begin
    result:='';
    if Assigned(SourceEditorManagerIntf) then begin //< запредельной толщины презерватив
        tmpSourceEditor:=SourceEditorManagerIntf.ActiveEditor;
        if Assigned(tmpSourceEditor) then begin //< чуть потоньше, но тоже толстоват
            result:=tmpSourceEditor.FileName;
        end;
    end;
end;

//------------------------------------------------------------------------------

function tLazExt_wndInspector_aFFfSE_Node.treeNode_NAME(const Owner:tTreeView; const treeNode:TTreeNode):string;
begin
    result:=treeNode.Text;
end;

function tLazExt_wndInspector_aFFfSE_Node.treeView_find(const Owner:TCustomForm):tTreeView;
begin
    result:=nil;
end;

function tLazExt_wndInspector_aFFfSE_Node.treeNode_find(const Owner:tTreeView; const FileName:string):TTreeNode;
begin
    result:=Owner.Items.GetFirstNode;
    while Assigned(result) do begin
        if FileName=treeNode_NAME(Owner,result) then begin
            BREAK; //< нашли родимого
        end;
        result:=result.GetNext;
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_Node.treeView_select(const Owner:tTreeView; const treeNode:TTreeNode);
begin
    if Assigned(Owner) and Assigned(treeNode) then begin
        with Owner do begin
            BeginUpdate;
            ClearSelection;
            Selected:=treeNode;
            EndUpdate;
        end;
    end;
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

