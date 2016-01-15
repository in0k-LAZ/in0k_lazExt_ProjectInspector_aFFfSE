unit lazExt_wndInspector_aFFfSE_wndNode;

{$mode objfpc}{$H+}

interface
{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}


uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     Classes, Forms, ComCtrls, TreeFilterEdit,
     LCLVersion, //< в зависимости от версий, разные способы работы
     in0k_lazIdeSRC_wndFuckUP;

type

 tLazExt_wndInspector_aFFfSE_Node=class(tIn0k_lazIdeSRC_wndFuckUP_Node)
  public
    class function OfMyType(const testForm:TCustomForm):boolean; virtual; abstract;
  protected
    function  treeView_FIND(const ownerWnd:TCustomForm):tTreeView;virtual;
    function  treeNode_NAME(const treeNode:TTreeNode):string;     virtual;
  protected
    function  treeView_findByNAME(const OwnerWnd:TCustomForm; const treeNAME:string):tTreeView;
    function  treeNode_find  (const Owner:tTreeView; const FileName:string):TTreeNode;
    procedure treeView_select(const Owner:tTreeView; const treeNode:TTreeNode);
  protected
   _treeView_:tTreeView;
    function  _do_treeView_find_  :tTreeView;
    function  _do_treeNode_find_  (const FileName:string):TTreeNode;
    procedure _do_treeView_select_(const treeNode:TTreeNode);
  private //< ФакАпим добавление нового узла в дерево
   _ide_object_VTV_onAddition_original_:TTVExpandedEvent;
    procedure _VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
  private //< событие для радителя ... "узел добавлен"
   _owner_onAdd_:TNotifyEvent;
  public
    property onAddition:TNotifyEvent read _owner_onAdd_ write _owner_onAdd_;
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
    if Assigned(_treeView_) then begin
        _ide_object_VTV_onAddition_original_:=_treeView_.OnAddition;
        _treeView_.OnAddition:=@_VTV_onAddition_myCustom_;
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_CLR;
begin
    inherited;
    if Assigned(_treeView_) then begin
        _treeView_.OnAddition:=_ide_object_VTV_onAddition_original_;
    end;
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
    if Assigned(Form) and Assigned(_treeView_) then begin
        result:=treeNode_find(_treeView_,FileName);
    end;
    {$ifDef _debugLOG_}
    if Assigned(result)
    then DEBUG('_do_treeNode_find_', addr2txt(Result)+':'+Result.Text)
    else DEBUG('_do_treeNode_find_','NOT found !!! "'+FileName+'"');
    {$endIf}
end;

procedure tLazExt_wndInspector_aFFfSE_Node._do_treeView_select_(const treeNode:TTreeNode);
begin
    if Assigned(Form) and Assigned(_treeView_) and Assigned(treeNode)
    then treeView_select(_treeView_,treeNode)
end;

//------------------------------------------------------------------------------

{$if lcl_fullversion = 1060001 }
    {$define fuckUp_TreeViewNodeData_01}
{$else}
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_TreeViewNodeData_01}
{$endif}

{$define fuckUp_TreeViewNodeData_01}
{%region --- fuckUp_TreeViewNodeData_01 --- /fold}
{$ifDef fuckUp_TreeViewNodeData_01}{$note 'treeNode_NAME use fuckUp_TreeViewNodeData_01'}
// взято из "lazDIR"\packager\PackageEditor.pas

type
 _TPENodeType_=(penFile,penDependency);

 _TPkgFileType_= (
        pftUnit,    // file is pascal unit
        pftVirtualUnit,// file is virtual pascal unit
        pftMainUnit, // file is the auto created main pascal unit
        pftLFM,     // lazarus form text file
        pftLRS,     // lazarus resource file
        pftInclude, // include file
        pftIssues,  // file is issues xml file
        pftText,    // file is text (e.g. copyright or install notes)
        pftBinary   // file is something else
        );

 _TPENodeData_=class(TTFENodeData)
    public
      Typ: _TPENodeType_;
      Name: string; // file or package name
      Removed: boolean;
      FileType: _TPkgFileType_;
      Next: _TPENodeData_;
    end;

//------------------------------------------------------------------------------

function _treeNode_NAME_(const treeNode:TTreeNode):string;
var tmp:tObject;
begin
    result:=treeNode.Text;
    tmp:=TObject(treeNode.Data);
    if Assigned(tmp) then begin
        if tmp is TFileNameItem then begin
            tmp:=TObject(TFileNameItem(tmp).Data);
            if Assigned(tmp) then begin
                if tmp.ClassName='TPENodeData' then begin
                    result:=_TPENodeData_(tmp).Name;
                end;
            end;
        end;
    end;
end;

{$endIf}
{%endregion}

//------------------------------------------------------------------------------

function tLazExt_wndInspector_aFFfSE_Node.treeNode_NAME(const treeNode:TTreeNode):string;
begin
    {$ifDef fuckUp_TreeViewNodeData_01}
    result:=_treeNode_NAME_(treeNode);
    {$else}
    result:=treeNode.Text;
    {$endIf}
end;

const
 cCompNameName ='ItemsTreeView';

function tLazExt_wndInspector_aFFfSE_Node.treeView_FIND(const ownerWnd:TCustomForm):tTreeView;
begin //< тупо идем по ВСЕМ контролам в форме ... и исчем по имени (((
    result:=treeView_findByNAME(OwnerWnd,cCompNameName);
end;

//------------------------------------------------------------------------------

function tLazExt_wndInspector_aFFfSE_Node.treeView_findByNAME(const OwnerWnd:TCustomForm; const treeNAME:string):tTreeView;
var i:integer;
begin //< тупо идем по ВСЕМ контролам в форме ... и исчем по имени (((
    result:=nil;
    for i:=0 to OwnerWnd.ControlCount-1 do begin
        if (OwnerWnd.Controls[i] is TTreeView) and (OwnerWnd.Controls[i].Name=treeNAME)
        then begin
            result:=TTreeView(OwnerWnd.Controls[i]);
            break;
        end;
    end;
end;

function tLazExt_wndInspector_aFFfSE_Node.treeNode_find(const Owner:tTreeView; const FileName:string):TTreeNode;
begin
    result:=Owner.Items.GetFirstNode;
    while Assigned(result) do begin
        if FileName=treeNode_NAME(result) then begin
            BREAK; //< нашли родимого
        end;
        result:=result.GetNext;
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_Node.treeView_select(const Owner:tTreeView; const treeNode:TTreeNode);
begin
    if Assigned(Owner) and Assigned(treeNode) and (not treeNode.Selected) then begin
        with Owner do begin
            BeginUpdate;
            ClearSelection;
            Selected:=treeNode;
            EndUpdate;
        end;
        {$ifDef _debugLOG_}
        DEBUG('treeView_select','SELECT'+addr2txt(treeNode)+' "'+treeNode_NAME(treeNode)+'"');
        {$endIf}
    end
    {$ifDef _debugLOG_}
    else begin
       if not Assigned(Owner) then DEBUG('SKIP treeView_select','not Assigned(Owner)')
      else
       if not Assigned(treeNode) then DEBUG('SKIP treeView_select','not Assigned(treeNode)')
      else
       if treeNode.Selected then DEBUG('SKIP treeView_select','treeNode('+addr2txt(treeNode)+').Selected==TRUE')
      else begin
          DEBUG('SKIP treeView_select','XZ')
       end;
    end
    {$endIf};
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
begin
    DEBUG('_VTV_onAddition_myCustom',treeNode_NAME(Node));
    //---
    if Assigned(_ide_object_VTV_onAddition_original_) then _ide_object_VTV_onAddition_original_(Sender,Node);
    //---
    if Assigned(_owner_onAdd_) then _owner_onAdd_(self);
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

