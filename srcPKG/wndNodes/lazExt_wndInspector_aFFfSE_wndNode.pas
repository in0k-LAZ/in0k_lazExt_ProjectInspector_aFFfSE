unit lazExt_wndInspector_aFFfSE_wndNode;

{$mode objfpc}{$H+}

interface
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.

uses {$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}in0k_lazExt_DEBUG,sysutils,{$endIf}

     Classes, Forms, ComCtrls, TreeFilterEdit,   Controls, Graphics,
     SrcEditorIntf,



     LCLVersion, //< в зависимости от версий, разные способы работы
     in0k_lazIdeSRC_FuckUpForm;

type

 tLazExt_wndInspector_aFFfSE_Node=class(tIn0k_lazIdeSRC_FuckUpForm)
  public
    class function OfMyType(const testForm:TCustomForm):boolean;  virtual;
    function  treeView_FIND(const ownerWnd:TCustomForm):tTreeView;virtual;
    function  treeNode_NAME(const treeNode:TTreeNode  ):string;   virtual;
  public
    procedure FuckUP_onSET; override;
    procedure FuckUP_onCLR; override;
  protected
    function  _ide_ActiveSourceEdit_fileName_:string;
  protected
   _treeView_:tTreeView; //< дерево с которым работаем
   _slctNode_:TTreeNode; //< последний отмеченный узел
  protected
    //function  treeView_findByNAME(const OwnerWnd:TCustomForm; const treeNAME:string):tTreeView;
    //function  treeNode_find  (const Owner:tTreeView; const FileName:string):TTreeNode;
    procedure treeView_select(const Owner:tTreeView; const treeNode:TTreeNode);
  protected
    //    function  _do_treeView_find_  :tTreeView;
    function  _do_treeNode_find_  (const FileName:string):TTreeNode;
    procedure _do_treeView_select_(const treeNode:TTreeNode);

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

  {%region --- сабЕвентинг событий форма и её компанентов --------- /fold}
  private //< ФакАпим получение фокуса формой
   _ide_object_WND_onActivate_original_:TNotifyEvent;
    procedure _WND_onActivate_myCustom_(Sender:TObject);
  private //< ФакАпим добавление нового узла в дерево
   _ide_object_VTV_onAddition_original_:TTVExpandedEvent;
    procedure _VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
  private //< ФакАпим добавление нового узла в дерево
   _ide_object_VTV_onAdvancedCustomDrawItem_original_:TTVAdvancedCustomDrawItemEvent;
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_(Sender:TCustomTreeView; Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages,DefaultDraw:Boolean);
  {%endregion}
  private //< рисование ДОП примитивов
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_selected(const Sender:TCustomTreeView; const Node:TTreeNode);
  protected
    function  _treeNode_isCurrentActive_(const treeNode:TTreeNode):boolean;
  private //< событие для радителя ... "узел добавлен"
   _owner_onAdd_:TNotifyEvent;
  public
    property onAddition:TNotifyEvent read _owner_onAdd_ write _owner_onAdd_;
  public
    constructor Create{(const aForm:TCustomForm)}; override;
    destructor DESTROY; override;
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

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(lazExt_ProjectInspector_aFFfSE__EventLOG_mode) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debugLOG_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}

{$region -- tLazExt_wndInspector_aFFfSE_NodeLST - /fold}

constructor tLazExt_wndInspector_aFFfSE_Node.Create{(const aForm:TCustomForm)};
begin
    inherited;
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

//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
// определить что форма является моим подопечным, и может тут обрабатываться.
// тут наследники ДОЛЖНЫ описать проверку
//

class function tLazExt_wndInspector_aFFfSE_Node.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=Assigned(testForm);
end;

//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
// поиск дерева (компонента TreeView) в котором "перечислены" подключенные
// к проекту файлы, именно это дерево мы будем "мурыжить"
//

{%region --- определение способа поиска --------------------------- /fold}
// тут возможно в разных версиях Лазаруса придется поступать по разному
{$if     (lcl_major=1) and (lcl_minor=4) and (lcl_release=4)}
    {$define fuckUp_TreeView_byNAME_01}
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=2)}
    {$define fuckUp_TreeView_byNAME_01}
{$else} //< способ по умолчанию
    {$define fuckUp_TreeView_byNAME_01}
    {$WARNING 'NOT Tested in this LazarusIDE version'}
{$endif}
{%endregion}

// - - - реализации способов - - - - - - - - - - - - - - - - - - - - - - - - - -

{%region --- fuckUp_TreeView_byNAME_01 ---------------------------- /fold}
{$ifDef fuckUp_TreeView_byNAME_01}

const //< мда ... именно такое название у компонента
 _c_treeView_Name_ ='ItemsTreeView';

function _treeView_findByNAME_(const OwnerWnd:TCustomForm):tTreeView; inline;
var i:integer;
begin //< тупо идем по ВСЕМ контролам в форме ... и исчем по имени (((
    result:=nil;
    for i:=0 to OwnerWnd.ControlCount-1 do begin
        if (OwnerWnd.Controls[i] is TTreeView) and       //< оно дерево
           (OwnerWnd.Controls[i].Name=_c_treeView_Name_) //< ещё и имя совпадает
        then begin
            result:=TTreeView(OwnerWnd.Controls[i]);
            break;
        end;
    end;
end;

{$endIf}
{%endregion}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_wndInspector_aFFfSE_Node.treeView_FIND(const ownerWnd:TCustomForm):tTreeView;
begin //< тупо идем по ВСЕМ контролам в форме ... и исчем по имени (((
    {$ifDef fuckUp_TreeView_byNAME_01}
    result:=_treeView_findByNAME_(ownerWnd); {$note 'treeView_FIND use fuckUp_TreeView_byNAME_01'}
    {$else}
    result:=nil
    {$endIf}
end;

//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
// получение ПОЛНОГО имени узла дерева (TTreeView)
// # для файлов - это должен быть "полный" путь, именно по нему происходит
//   поиск
// # для всех остальных - просто "название узла" (treeNode.Text)
//

{%region --- определение способа получения ------------------------ /fold}
// тут возможно в разных версиях Лазаруса придется поступать по разному
{$if     (lcl_major=1) and (lcl_minor=4) and (lcl_release=4)}
    {$define fuckUp_TreeViewNodeData_01}
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=2)}
    {$define fuckUp_TreeViewNodeData_01}
{$else} //< способ по умолчанию
    {$define fuckUp_TreeViewNodeData_01}
    {$WARNING 'NOT Tested in this LazarusIDE version'}
{$endif}
{%endregion}

// - - - реализации способов - - - - - - - - - - - - - - - - - - - - - - - - - -

{%region --- fuckUp_TreeViewNodeData_01 --------------------------- /fold}
{$ifDef fuckUp_TreeViewNodeData_01}
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

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_wndInspector_aFFfSE_Node.treeNode_NAME(const treeNode:TTreeNode):string;
begin
    {$ifDef fuckUp_TreeViewNodeData_01}
    result:=_treeNode_NAME_(treeNode); {$note 'treeNode_NAME use fuckUp_TreeViewNodeData_01'}
    {$else}
    result:=treeNode.Text;
    {$endIf}
end;

//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_onSET;
begin
    inherited;
    // !!! тут должно быть Assigned(Form), иначе это ОГРОМНЫЙ косяк
    {todo: подумать об окошке с просьбой сообщить мне и удалить компонент}
    if Assigned(Form) then begin //< гм ... по идее другово и не может быть
        //---
       _ide_object_WND_onActivate_original_:=Form.OnActivate;
        Form.OnActivate:=@_WND_onActivate_myCustom_;
        //---
       _treeView_:=treeView_FIND(FORM);
        if Assigned(_treeView_) then begin
            _ide_object_VTV_onAddition_original_:=_treeView_.OnAddition;
            _treeView_.OnAddition:=@_VTV_onAddition_myCustom_;
             //---
            _ide_object_VTV_onAdvancedCustomDrawItem_original_:=_treeView_.OnAdvancedCustomDrawItem;
            _treeView_.OnAdvancedCustomDrawItem:=@_VTV_onAdvancedCustomDrawItem_myCustom_;
        end
        else begin //< это ОГРОМНЫЙ касяк ... надо чтобы мне сообщили
            {todo: окошко с просьбой сообщить мне и удалить компонент}
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

// имя файла, открытово в ТЕКУЩЕМ АКТИВНОМ редакторе IDE
function tLazExt_wndInspector_aFFfSE_Node._ide_ActiveSourceEdit_fileName_:string;
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

function tLazExt_wndInspector_aFFfSE_Node._treeNode_isCurrentActive_(const treeNode:TTreeNode):boolean;
begin
    result:=_ide_ActiveSourceEdit_fileName_=treeNode_NAME(treeNode);
end;

//------------------------------------------------------------------------------

// вот ... все ради этого ...
procedure tLazExt_wndInspector_aFFfSE_Node.Select(const FileName:string);
var treeNode:TTreeNode;
begin
    treeNode:=_do_treeNode_find_(FileName);
    if Assigned(treeNode) then begin
        // основная часть ... переместить фокус (выделение) на найденный узел
       _do_treeView_select_(treeNode);
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_Node.reStore_EXPAND;
begin
    //
end;

//------------------------------------------------------------------------------

{function  tLazExt_wndInspector_aFFfSE_Node._do_treeView_find_:tTreeView;
begin
    result:=nil;
    if Assigned(Form) then result:=treeView_FIND(Form);
    {$ifDef _debugLOG_}
    if Assigned(result)
    then DEBUG('_do_treeView_find_',result.ClassName+':'+result.Name+addr2txt(Result))
    else DEBUG('_do_treeView_find_','NOT found !!!');
    {$endIf}
end;}

function  tLazExt_wndInspector_aFFfSE_Node._do_treeNode_find_(const FileName:string):TTreeNode;
begin
    result:=nil;
    if Assigned(Form) and Assigned(_treeView_) then begin
        result:=_treeView_.Items.GetFirstNode;
        while Assigned(result) do begin
            if FileName=treeNode_NAME(result) then BREAK; //< нашли родимого
            result:=result.GetNext;
        end;
    end;
    {$ifDef _debugLOG_}
    if Assigned(result) then DEBUG('_do_treeNode_find_', addr2txt(Result)+':'+Result.Text)
    else begin
       if not Assigned(Form) then DEBUG('ERROR 001','Form is NULL')
      else
       if not Assigned(_treeView_) then DEBUG('ERROR 002','_treeView_ is NULL')
      else begin
       DEBUG('_do_treeNode_find_','NOT found !!! "'+FileName+'"');
       end;
    end
    {$endIf};
end;

procedure tLazExt_wndInspector_aFFfSE_Node._do_treeView_select_(const treeNode:TTreeNode);
begin
   _slctNode_:=treeNode;
    if Assigned(Form) and Assigned(_treeView_) and Assigned(treeNode) and (not treeNode.Selected) then begin
        if
        with _treeView_ do begin
            BeginUpdate;
            expandedNodesTracking_reStore;
            ClearSelection;
            Selected:=treeNode;
            EndUpdate;
        end;

       _treeView_.Invalidate;
        treeNode.Update;


        {$ifDef _debugLOG_}
        DEBUG('treeView_select','SELECT'+addr2txt(treeNode)+' "'+treeNode_NAME(treeNode)+'"');
        {$endIf}
    end
    {$ifDef _debugLOG_}
    else begin
       if not Assigned(Form) then DEBUG('SKIP treeView_select','not Assigned(Owner)')
      else
       if not Assigned(treeNode) then DEBUG('SKIP treeView_select','not Assigned(treeNode)')
      else
       if treeNode.Selected then DEBUG('SKIP treeView_select','treeNode('+addr2txt(treeNode)+').Selected==TRUE')
      else begin
          DEBUG('SKIP treeView_select','XZ')
       end;
    end
    {$endIf};




    {if Assigned(Form) and Assigned(_treeView_) and Assigned(treeNode)
    then begin
        treeView_select(_treeView_,treeNode);
    end; }
end;




//------------------------------------------------------------------------------


//------------------------------------------------------------------------------

{function tLazExt_wndInspector_aFFfSE_Node.treeView_findByNAME(const OwnerWnd:TCustomForm; const treeNAME:string):tTreeView;
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
end;}

{function tLazExt_wndInspector_aFFfSE_Node.treeNode_find(const Owner:tTreeView; const FileName:string):TTreeNode;
begin
    result:=Owner.Items.GetFirstNode;
    while Assigned(result) do begin
        if FileName=treeNode_NAME(result) then begin
            BREAK; //< нашли родимого
        end;
        result:=result.GetNext;
    end;
end;}

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


//------------------------------------------------------------------------------


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


{%region --- сабЕвентинг событий форма и её компанентов --------- /fold}

// при получении окном фокуса
procedure tLazExt_wndInspector_aFFfSE_Node._WND_onActivate_myCustom_(Sender:TObject);
begin
    //--- моя "нагрузка" ----------------------------------------
    if Assigned(Sender) and (Sender=Form) then begin {todo: перестраховка, подумать про необходимость}
       expandedNodesTracking_workOFF; //< отключаем систему слежения
       {$ifDef _debugLOG_}
       DEBUG('expandedNodesTracking','OFF');
       {$endIf}
    end;
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_WND_onActivate_original_) then _ide_object_WND_onActivate_original_(Sender);
end;

// при добавление нового узла в дерево
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onAddition_original_) then _ide_object_VTV_onAddition_original_(Sender,Node);
    //--- моя "нагрузка" ----------------------------------------
    if Assigned(_owner_onAdd_) then _owner_onAdd_(self);
end;

// при рисовании узла у дерева
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onAdvancedCustomDrawItem_original_) then _ide_object_VTV_onAdvancedCustomDrawItem_original_(Sender,Node,State,Stage,PaintImages,DefaultDraw);
    //--- моя "нагрузка" ----------------------------------------
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

{%endregion}


{$endregion}

{$region -- tLazExt_wndInspector_aFFfSE_NodeLST - /fold}

procedure tLazExt_wndInspector_aFFfSE_NodeLST.CLEAR;
begin
   _nodes__CLR_;
end;

function  tLazExt_wndInspector_aFFfSE_NodeLST.Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
begin
    {$ifDef _debugLOG_}
    DEBUG('Nodes_GET','Nodes_GETNodes_GETNodes_GETNodes_GETNodes_GETNodes_GETNodes_GET');
    {$endIf}
    result:=tLazExt_wndInspector_aFFfSE_Node(fuckUpForms_GET(Form,nodeTYPE));
end;

{$endregion}

end.

