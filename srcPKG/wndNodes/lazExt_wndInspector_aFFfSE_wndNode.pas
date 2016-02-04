unit lazExt_wndInspector_aFFfSE_wndNode;

{$mode objfpc}{$H+}

interface
{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}
{$if declared(in0k_lazExt_DEBUG)}
{$endIf}


uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG, sysutils,{$endIf}
     Classes, Forms, ComCtrls, TreeFilterEdit,   Controls, Graphics,
     SrcEditorIntf,



     LCLVersion, //< в зависимости от версий, разные способы работы
     in0k_lazIdeSRC_FuckUpForm;

type

 tLazExt_wndInspector_aFFfSE_Node=class(tIn0k_lazIdeSRC_FuckUpForm)
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
   _slctNode_:TTreeNode;
    function  _do_treeView_find_  :tTreeView;
    function  _do_treeNode_find_  (const FileName:string):TTreeNode;
    procedure _do_treeView_select_(const treeNode:TTreeNode);
  protected
    function  _fileName_fromActiveSourceEdit_:string;
    function  _treeNode_isCurrentActive_(const treeNode:TTreeNode):boolean;

  {%region --- Слежение ра развернутыми узлами --- /fold}
  private
   _expandedNodesTracking_WORK_:boolean;           //< система ВКЛЮЧЕНА
   _expandedNodesTracking_List_:TStringList;       //<
    procedure _expandedNodesTracking_set_WORK_(const value:boolean);
    procedure _expandedNodesTracking_state_Save_;  //<
    procedure _expandedNodesTracking_state_reSet_; //<
    function  _expandedNodesTracking_state_(const treeNode:tTreeNode):boolean; //<
  protected
    procedure  expandedNodesTracking_reStore;
    procedure  expandedNodesTracking_workOFF;
  {%endregion}

  private //< ФакАпим получение фокуса формой
   _ide_object_WND_onActivate_original_:TNotifyEvent;
    procedure _WND_onActivate_myCustom_(Sender:TObject);
  private //< ФакАпим добавление нового узла в дерево
   _ide_object_VTV_onAddition_original_:TTVExpandedEvent;
    procedure _VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
  private //< ФакАпим добавление нового узла в дерево
   _ide_object_VTV_onAdvancedCustomDrawItem_original_:TTVAdvancedCustomDrawItemEvent;
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_(Sender:TCustomTreeView; Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages,DefaultDraw:Boolean);
  private //< рисование ДОП примитивов
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_selected(const Sender:TCustomTreeView; const Node:TTreeNode);
  private //< событие для радителя ... "узел добавлен"
   _owner_onAdd_:TNotifyEvent;
  public
    property onAddition:TNotifyEvent read _owner_onAdd_ write _owner_onAdd_;
  public
    constructor Create{(const aForm:TCustomForm)}; override;
    destructor DESTROY; override;
  public
    procedure FuckUP_onSET; override;
    procedure FuckUP_onCLR; override;
  public
    procedure Select(const FileName:string); virtual;
    procedure reStore_EXPAND;                virtual;
  end;
 tLazExt_wndInspector_aFFfSE_NodeTYPE=class of tLazExt_wndInspector_aFFfSE_Node;

 tLazExt_wndInspector_aFFfSE_NodeLST=class(tIn0k_lazIdeSRC_FuckUpFrms_LIST)
  public
   procedure CLEAR;
   function  Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
  end;

implementation

{$region -- tLazExt_wndInspector_aFFfSE_NodeLST - /fold}

constructor tLazExt_wndInspector_aFFfSE_Node.Create{(const aForm:TCustomForm)};
begin
    inherited;// Create(aForm);
   _expandedNodesTracking_WORK_:=FALSE;
   _expandedNodesTracking_List_:=TStringList.Create;
   _treeView_:=nil;
   _slctNode_:=nil;
end;

destructor tLazExt_wndInspector_aFFfSE_Node.DESTROY;
begin
    inherited;
   _expandedNodesTracking_List_.FREE;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_onSET;
begin
    inherited;
    if Assigned(Form) then begin
        //---
       _ide_object_WND_onActivate_original_:=Form.OnActivate;
        Form.OnActivate:=@_WND_onActivate_myCustom_;
        //---
       _treeView_:=_do_treeView_find_;
        if Assigned(_treeView_) then begin
            _ide_object_VTV_onAddition_original_:=_treeView_.OnAddition;
            _treeView_.OnAddition:=@_VTV_onAddition_myCustom_;
             //---
            _ide_object_VTV_onAdvancedCustomDrawItem_original_:=_treeView_.OnAdvancedCustomDrawItem;
            _treeView_.OnAdvancedCustomDrawItem:=@_VTV_onAdvancedCustomDrawItem_myCustom_;
        end;
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_onCLR;
begin
    if Assigned(_treeView_) then begin
        _treeView_.OnAddition:=_ide_object_VTV_onAddition_original_;
        _treeView_.OnAdvancedCustomDrawItem:=_ide_object_VTV_onAdvancedCustomDrawItem_original_;
    end;
   _treeView_:=nil;
    //---
    if Assigned(Form) then begin
        Form.OnActivate:=_ide_object_WND_onActivate_original_;
    end;
    inherited;
end;

//------------------------------------------------------------------------------

function tLazExt_wndInspector_aFFfSE_Node._fileName_fromActiveSourceEdit_:string;
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

function tLazExt_wndInspector_aFFfSE_Node._treeNode_isCurrentActive_(const treeNode:TTreeNode):boolean;
begin
    result:=_fileName_fromActiveSourceEdit_=treeNode_NAME(treeNode);
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
   _slctNode_:=treeNode;
    if Assigned(Form) and Assigned(_treeView_) and Assigned(treeNode)
    then begin
        treeView_select(_treeView_,treeNode);
    end;
end;

//------------------------------------------------------------------------------

{$if     (lcl_major=1) and (lcl_minor=4)}
    {$define fuckUp_TreeViewNodeData_01}
{$elseif (lcl_major=1) and (lcl_minor=6)}
    {$define fuckUp_TreeViewNodeData_01}
{$else}
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_TreeViewNodeData_01}
{$endif}

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
            expandedNodesTracking_reStore;
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

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
begin
    //--- то что было
    if Assigned(_ide_object_VTV_onAdvancedCustomDrawItem_original_) then _ide_object_VTV_onAdvancedCustomDrawItem_original_(Sender,Node,State,Stage,PaintImages,DefaultDraw);
    //--- моя добавка
    if (_expandedNodesTracking_WORK_) then begin
        if Stage=cdPostPaint then begin
            if not _expandedNodesTracking_state_(node) then begin
               _VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(Sender,Node);
            end;
        end;
    end;
    //--- усиливаем выделение текущего файла при просмотре БЕЗ фокуса
    if Stage=cdPostPaint then begin
       _VTV_onAdvancedCustomDrawItem_myCustom_selected(Sender,Node);
    end;
    //----
    if (Stage=cdPostPaint)and(Assigned(_slctNode_))
       and(_slctNode_.HasAsParent(Node))
       and(not Node.Expanded)
    then begin
       _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(Sender,Node);
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// рисование: МАРКЕР авто-Сворачивания
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(const Sender:TCustomTreeView; const Node:TTreeNode);
var r:TRect;
    y:Integer;
begin
    {// рисование КВАДРАТИКА
    r:=Node.DisplayRect(true);
    y:=(r.Bottom-r.Top) div 4;
    // хочу получить квадратик )))
    r.Right:=r.Left  +1;
    r.Left :=r.Left-y+1;
    r.Bottom:=r.Top+y;
    // ---
    Sender.Canvas.Pen.Color:=clgreen;
    Sender.Canvas.Frame(R);}
    {рисование ТРЕУГОЛЬНИКА}
    r:=Node.DisplayRect(true);
    y:=((r.Bottom-r.Top) div 4);
    y:=y-1;
    if y<=0 then y:=1;
    // ---
   { r.Right:=r.Left  -2;//1;
    r.Left :=r.Left-y-2;//+1;
    r.Top  :=r.Top+1;
    r.Bottom:=r.Top+y;
    Sender.Canvas.Pen.Color:=clHighlight;// clgreen;
    Sender.Canvas.Line(r.Left,r.Top, r.Right,r.Top);
    Sender.Canvas.Line(r.Right,r.Top, r.Right,r.Bottom);
    Sender.Canvas.Line(r.Right,r.Bottom, r.Left,r.Top);    }

     r.Left :=r.Left+1;
     r.Right:=r.Left+y;
     //r.Top  :=r.Top+1;
     r.Bottom:=r.Top+y;
     r.Top:=r.Top+1;
     r.Bottom:=r.Bottom+1;
     Sender.Canvas.Pen.Color:=clHighlight;// clgreen;
     Sender.Canvas.Line(r.Left,r.Top,r.Right,r.Top);
     //Sender.Canvas.Line(r.Right,r.Top,r.Left,r.Bottom);
     Sender.Canvas.Line(r.Left,r.Bottom,r.Left,r.Top);
end;

procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
var r:TRect;
    y:Integer;
begin
    if Assigned(_slctNode_) and _slctNode_.HasAsParent(Node) and(not Node.Expanded) then begin
        r:=Node.DisplayRect(TRUE);
        Sender.Canvas.Pen.Color:=clgreen;
        Sender.Canvas.Frame(R);
        y:=(r.Bottom+r.Top) div 2;
        //Sender.Canvas.Line(0,y,r.Left,y);
        Sender.Canvas.Line(r.Right,y,Sender.Canvas.Width,y);

      { r:=Node.DisplayRect(true);
        y:=((r.Bottom-r.Top) div 4);
        y:=y-1;
        if y<=0 then y:=1;

         r.Left :=r.Left+1;
         r.Right:=r.Left+y;
         r.Bottom:=r.Bottom-1;
         r.Top:=r.Bottom-y;
         Sender.Canvas.Pen.Color:=clRed;
         Sender.Canvas.Line(r.Left,r.Bottom,r.Left, r.Top);
         Sender.Canvas.Line(r.Left,r.Bottom,r.Right,r.Bottom);}
    end;
end;


// рисование: Усиливаем выделение АКТИВНОГО
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_selected(const Sender:TCustomTreeView; const Node:TTreeNode);
var r:TRect;
    y:Integer;
begin
    if _treeNode_isCurrentActive_(Node) then begin
        r:=Node.DisplayRect(TRUE);
        Sender.Canvas.Pen.Color:=clgreen;
        Sender.Canvas.Frame(R);
        y:=(r.Bottom+r.Top) div 2;
        //Sender.Canvas.Line(0,y,r.Left,y);
        Sender.Canvas.Line(r.Right,y,Sender.Canvas.Width,y);
    end;
end;

{%region --- Слежение ра развернутыми узлами ---------------------- /fold}

// запомнить текущее состояние "развернутости узлов"
procedure tLazExt_wndInspector_aFFfSE_Node._expandedNodesTracking_state_Save_;
var tmp:tTreeNode;
begin //< тупо сохраняем ИМЕНА всех РАЗВЕРНУТЫХ узлов в список
    if Assigned(_treeView_) then begin
       _expandedNodesTracking_List_.Clear;
        tmp:=_treeView_.Items.GetFirstNode;
        while Assigned(tmp) do begin
            if tmp.Expanded then begin
               _expandedNodesTracking_List_.Add(treeNode_NAME(tmp));
            end;
            tmp:=tmp.GetNext;
        end;
        {$ifDef _debugLOG_}
        DEBUG('expandedNodesTracking','SAVE. In List '+inttostr(_expandedNodesTracking_List_.Count)+' node(s).');
        {$endIf}
    end;
end;

// переустановть из запомненного состояние "развернутости узлов"
procedure tLazExt_wndInspector_aFFfSE_Node._expandedNodesTracking_state_reSet_;
var tmp:tTreeNode;
begin //< проходим по ВСЕМ узлам, если ИМЯ найдено в списке => развернут
    if Assigned(_treeView_)and(_expandedNodesTracking_List_.Count>0) then begin
       _treeView_.Items.BeginUpdate; {todo: проверить необходимость}
        tmp:=_treeView_.Items.GetFirstNode;
        while Assigned(tmp) do begin
            tmp.Expanded:=(_expandedNodesTracking_List_.IndexOf(treeNode_NAME(tmp))>=0);
            tmp:=tmp.GetNext;
        end;
       _treeView_.Items.EndUpdate; {todo: проверить необходимость}
        {$ifDef _debugLOG_}
        DEBUG('expandedNodesTracking','ReSTORE. In List '+inttostr(_expandedNodesTracking_List_.Count)+' node(s).');
        {$endIf}
    end;
end;

// проверить состояние узла
function tLazExt_wndInspector_aFFfSE_Node._expandedNodesTracking_state_(const treeNode:tTreeNode):boolean;
var tmp:tTreeNode;
begin
    result:=false;
    if Assigned(treeNode) then begin {todo: проверить необходимость}
        result:=true;
        tmp:=treeNode.Parent;
        while Assigned(tmp) do begin
            if _expandedNodesTracking_List_.IndexOf(treeNode_NAME(tmp))<0 then begin
                result:=false;
                BREAK;
            end;
            tmp:=tmp.Parent;
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_wndInspector_aFFfSE_Node._expandedNodesTracking_set_WORK_(const value:boolean);
begin
    if value<>_expandedNodesTracking_WORK_ then begin
       _expandedNodesTracking_List_.Clear;
       _expandedNodesTracking_WORK_:=value;
        if _expandedNodesTracking_WORK_ then _expandedNodesTracking_state_Save_;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node.expandedNodesTracking_workOFF;
begin
   _expandedNodesTracking_set_WORK_(FALSE);
end;

procedure tLazExt_wndInspector_aFFfSE_Node.expandedNodesTracking_reStore;
begin
    if _expandedNodesTracking_WORK_
    then _expandedNodesTracking_state_reSet_    //< восстановить состояние "свернутости"
    else _expandedNodesTracking_set_WORK_(TRUE) //< ВКЛЮЧИТЬ систему отслеживания
end;

{%endregion}

procedure tLazExt_wndInspector_aFFfSE_Node._WND_onActivate_myCustom_(Sender:TObject);
begin
    //--- моя нагрузка
    if Assigned(Sender) and (Sender=Form) then begin {todo: перестраховка, подумать про необходимость}
       expandedNodesTracking_workOFF; //< отключаем систему слежения
       {$ifDef _debugLOG_}
       DEBUG('expandedNodesTracking','OFF');
       {$endIf}
    end;
    //--- то что было
    if Assigned(_ide_object_WND_onActivate_original_) then _ide_object_WND_onActivate_original_(Sender);
end;

{$endregion}

{$region -- tLazExt_wndInspector_aFFfSE_NodeLST - /fold}

procedure tLazExt_wndInspector_aFFfSE_NodeLST.CLEAR;
begin
   _nodes__CLR_;
end;

function  tLazExt_wndInspector_aFFfSE_NodeLST.Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
begin
    result:=tLazExt_wndInspector_aFFfSE_Node(Forms_GET(Form,nodeTYPE));
end;

{$endregion}

end.

