unit lazExt_wndInspector_aFFfSE_wndNode;

{$mode objfpc}{$H+}
interface
{%region --- Описание НАСТРОЕК уровня КОМПИЛЯЦИИ ----------------- /fold }

//// ВНИМАНИЕ !!!
//// настройки могут быть ПЕРЕОПРЕДЕЛЕНЫ ниже при подключении
//// файла настроек "компанента-Расширения" (`in0k_lazExt_SETTINGs.inc`).

//--- # treeView_autoExpand ----------------------------------------------------
// Автоматически РАЗВОРАЧИВАТЬ узлы при выделении
//
//{$define lazExt_ProjectInspector_aFFfSE__treeView_autoExpand}
//
//------------------------------------------------------------------------------


//--- # DebugLOG_mode ----------------------------------------------------------
// Режим логирования.
//  В код включаются вызовы `DEBUG` с описанием текущих событий и состояний.
//
//{$define in0k_lazIdeSRC_FuckUpForm__DebugLOG_mode}
//
//------------------------------------------------------------------------------

{%endregion}
{$i in0k_lazExt_SETTINGs.inc} //< настройки компанента-Расширения.

uses {$ifDef lazExt_ProjectInspector_aFFfSE__DebugLOG_mode}in0k_lazExt_DEBUG,{$endIf}
     Classes, Forms, ComCtrls, TreeFilterEdit,   Controls, Graphics,
     SrcEditorIntf,  Dialogs,
     LCLVersion, //< в зависимости от версий, разные способы работы
     in0k_lazIdeSRC_FuckUpForm;



{%region --- применение "НАСТРОЕК уровня КОМПИЛЯЦИИ" ------------- /fold }

{$unDef _fuckUp__ide_object_WND_onActivate_}
{$unDef _fuckUp__ide_object_WND_onDeActivate_}
{$unDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}



{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_01}
    {$define _fuckUp__ide_object_WND_onActivate_}
    {$define _fuckUp__ide_object_WND_onDeActivate_}
{$endIf}

{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_02}
    {$undef  _future_treeView_expandedTracking_mode_01}
    {$define _future_treeView_expandedTracking_mode_02}
{$endIf}

{$if not (
        defined(lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_01)
        or
        defined(lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_02)
         )
}//< БЕЗ слежения это НЕвозможно
    {$unDef lazExt_ProjectInspector_aFFfSE__treeView_mark_autoCollapseNode}
{$endIf}


{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_ActiveFile}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{$endIf}
{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_autoCollapseNode}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{$endIf}


//{$ifunDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
//    {$undef lazExt_ProjectInspector_aFFfSE__treeView_mark_autoCollapseNode}
//{$endIf}




{%endregion}





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
    function _ide_ActiveSourceEdit_fileName_:string;
  protected
   _treeView_:tTreeView; //< дерево с которым работаем
    procedure _treeView_SET_(const value:tTreeView);
    procedure _treeView_set_DO_autoExpand_;
  protected
   _slctNode_:TTreeNode; //< последний отмеченный узел
   _slctFile_:string;    //< последний отмеченный узел (имя файла) нужен для отлова событый связанных с "перевставкой узлов"
    procedure _slctNode_SET_(const value:TTreeNode);
    procedure _slctNode_do_selectInTREE_;
    //function  treeView_findByNAME(const OwnerWnd:TCustomForm; const treeNAME:string):tTreeView;
    //function  treeNode_find  (const Owner:tTreeView; const FileName:string):TTreeNode;
    //procedure treeView_select(const Owner:tTreeView; const treeNode:TTreeNode);
  protected

    //    function  _do_treeView_find_  :tTreeView;
    //function  _do_treeNode_find_  (const FileName:string):TTreeNode;
//    procedure _do_treeView_select_(const treeNode:TTreeNode);

  {%region --- Слежение ра развернутыми узлами --- /fold}
    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_01}
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
    procedure  expandedNodesTracking_workON;
    {$endIf}
  {%endregion}

  {%region --- сабЕвентинг событий форма и её компанентов --------- /fold}
  {$ifDef _fuckUp__ide_object_WND_onActivate_}
  private //< ФакАпим получение фокуса формой
   _ide_object_WND_onActivate_original_:TNotifyEvent;
    procedure _WND_onActivate_myCustom_(Sender:TObject);
  {$endIf}
  {$ifDef _fuckUp__ide_object_WND_onDeActivate_}
  private //< ФакАпим потерю фокуса формой
   _ide_object_WND_onDeActivate_original_:TNotifyEvent;
    procedure _WND_onDeActivate_myCustom_(Sender:TObject);
  {$endIf}
  private //< ФакАпим ДОБАВЛЕНИЕ нового узла в дерево
   _ide_object_VTV_onAddition_original_:TTVExpandedEvent;
    procedure _VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
  private //< ФакАпим УДАЛЕНИЕ узла из дерева
   _ide_object_VTV_onDeletion_original_:TTVExpandedEvent;
    procedure _VTV_onDeletion_myCustom_(Sender:TObject; Node:TTreeNode);
  {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
  private //< ФакАпим РИСОВАНИЕ
   _ide_object_VTV_onAdvancedCustomDrawItem_original_:TTVAdvancedCustomDrawItemEvent;
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_(Sender:TCustomTreeView; Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages,DefaultDraw:Boolean);
  private //< рисование ДОП примитивов
    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_ActiveFile}
    procedure _VTV_drawMARK_selected_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_selected_(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
    {$endif}
    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_autoCollapseNode}
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(const Sender:TCustomTreeView; const Node:TTreeNode);
    {$endif}
  {$endIf}
  {%endregion}
  protected
    function  _treeNode_isCurrentActive_(const treeNode:TTreeNode):boolean;
  private //< событие для радителя ... "узел добавлен"
   _owner_onNodeAdd_:TNotifyEvent;
  public
    constructor Create{(const aForm:TCustomForm)}; override;
    destructor DESTROY; override;
  public
    property  ownerEvent_onNodeAdd:TNotifyEvent read _owner_onNodeAdd_ write _owner_onNodeAdd_;
    procedure Select(const FileName:string); virtual;
    procedure reStore_EXPAND;                virtual;
  end;
 tLazExt_wndInspector_aFFfSE_NodeTYPE=class of tLazExt_wndInspector_aFFfSE_Node;

 tLazExt_wndInspector_aFFfSE_NodeLST=class(tIn0k_lazIdeSRC_FuckUpFrms_LIST)
  private //< событие для радителя ... "узел добавлен"
   _owner_onNodeAdd_:TNotifyEvent;
  public
    property  ownerEvent_onNodeAdd:TNotifyEvent read _owner_onNodeAdd_ write _owner_onNodeAdd_;
    procedure CLEAR;
    function  Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
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

{$region -- tLazExt_wndInspector_aFFfSE_Node ---------------------- /fold}

constructor tLazExt_wndInspector_aFFfSE_Node.Create{(const aForm:TCustomForm)};
begin
    inherited;
    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_01}
   _expandedNodesTracking_WORK_:=FALSE;
   _expandedNodesTracking_List_:=TStringList.Create;
    {$endIf}
    //---
   _treeView_:=nil;
   _slctNode_:=nil;
   _slctFile_:='';
    //---
   _ide_object_VTV_onAddition_original_:=NIL;
   _ide_object_VTV_onDeletion_original_:=NIL;
    {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
   _ide_object_VTV_onAdvancedCustomDrawItem_original_:=nil;
    {$endIf}
end;

destructor tLazExt_wndInspector_aFFfSE_Node.DESTROY;
begin
    inherited;
    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_01}
   _expandedNodesTracking_List_.FREE;
    {$endIf}
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
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=4)}
    {$define fuckUp_TreeView_byNAME_01}
{$else} //< способ по умолчанию
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_TreeView_byNAME_01}
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
    result:=_treeView_findByNAME_(ownerWnd);
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
{$elseif (lcl_major=1) and (lcl_minor=6) and (lcl_release=0) and (lcl_patch=4)}
    {$define fuckUp_TreeViewNodeData_01}
{$else} //< способ по умолчанию
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_TreeViewNodeData_01}
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
    {$ifDef lazExt_ProjectInspector_aFFfSE__DebugLOG_mode}
        if not Assigned(treeNode) then DEBUG('ERROR-ERROR-ERROR','in treeNode_NAME treeNode=NIL');
    {$endif}
    if Assigned(treeNode) then begin
        {$ifDef fuckUp_TreeViewNodeData_01}
        result:=_treeNode_NAME_(treeNode);
        {$else}
        result:=treeNode.Text;
        {$endIf}
    end
    else result:='';
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
        {$ifDef _fuckUp__ide_object_WND_onActivate_}
       _ide_object_WND_onActivate_original_:=Form.OnActivate;
        Form.OnActivate:=@_WND_onActivate_myCustom_;
        {$endIf}
        //---
        {$ifDef _fuckUp__ide_object_WND_onDeActivate_}
       _ide_object_WND_onDeActivate_original_:=Form.OnDeactivate;
        Form.OnDeactivate:=@_WND_onDeActivate_myCustom_;
        {$endIf}
        //---
       _treeView_SET_(treeView_FIND(FORM));
        if Assigned(_treeView_) then begin
            _ide_object_VTV_onAddition_original_:=_treeView_.OnAddition;
            _treeView_.OnAddition:=@_VTV_onAddition_myCustom_;
             //---
            _ide_object_VTV_onDeletion_original_:=_treeView_.OnDeletion;
            _treeView_.OnDeletion:=@_VTV_onDeletion_myCustom_;
             //---
             {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
            _ide_object_VTV_onAdvancedCustomDrawItem_original_:=_treeView_.OnAdvancedCustomDrawItem;
            _treeView_.OnAdvancedCustomDrawItem:=@_VTV_onAdvancedCustomDrawItem_myCustom_;
             {$endIf}
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
         {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
        _treeView_.OnAdvancedCustomDrawItem:=_ide_object_VTV_onAdvancedCustomDrawItem_original_;
         {$endIf}
    end;
   _treeView_:=nil;
    //---
    if Assigned(Form) then begin
        {$ifDef _fuckUp__ide_object_WND_onActivate_}
        Form.OnActivate  :=_ide_object_WND_onActivate_original_;
        {$endIf}
        {$ifDef _fuckUp__ide_object_WND_onDeActivate_}
        Form.OnDeactivate:=_ide_object_WND_onDeActivate_original_;
        {$endIf}
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
begin {todo: подумать, а может Compare?}
    result:=_ide_ActiveSourceEdit_fileName_=treeNode_NAME(treeNode);
end;

//------------------------------------------------------------------------------

// вот ... все ради этого ...
procedure tLazExt_wndInspector_aFFfSE_Node.Select(const FileName:string);
var treeNode:TTreeNode;
begin
    {$ifDef _debugLOG_}
    DEBUG('SELECT in INSPECTOR','>>> "'+self.Form.Caption+'"');
    {$endIf}
    treeNode:=NIL;
    if Assigned(Form) and Assigned(_treeView_) then begin
        // сначала ИСЧЕМ узел с указанным именем
        treeNode:=_treeView_.Items.GetFirstNode;
        while Assigned(treeNode) do begin
            if FileName=treeNode_NAME(treeNode) then BREAK; //< нашли родимого
            treeNode:=treeNode.GetNext;
        end;
        // если НИЧЕГО не нашли проверим ...
        // может мы сюда попали после "перевставки узлов" или "удалении" и т.д.
        if (not Assigned(treeNode))and (not Assigned(_slctNode_)) and (_slctFile_<>'') then begin
           _slctNode_:=_treeView_.Items.GetFirstNode;
            while Assigned(_slctNode_) do begin
                if _slctFile_=treeNode_NAME(_slctNode_) then BREAK; //< нашли родимого
               _slctNode_:=_slctNode_.GetNext;
            end;
            {$ifdef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_} //< это важно ТОЛЬКО при подрисовке
            if Assigned(_slctNode_)
            then _slctNode_.Update
            else _treeView_.Update;
            {$endIf};
        end;
    end{$ifDef _debugLOG_}
    else begin
        if not Assigned(Form) then DEBUG('ERROR 001','Form is NULL')
       else
        if not Assigned(_treeView_) then DEBUG('ERROR 002','_treeView_ is NULL');
    end{$endIf};
    // собсно, то ради чего всё и затевалось
    if Assigned(treeNode) then begin
        // основная часть ... переместить фокус (выделение) на найденный узел
       _slctNode_SET_(treeNode);
    end
    {$ifdef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_} //< это важно ТОЛЬКО при подрисовке
    // если мы НЕ рисуем ... то парить комп НЕ надо
    else begin
        if Assigned(_slctNode_) then begin
            _slctNode_.Update; //< возможно мы перешли в другое окно
        end;
    end{$endIf};
    //---------------------------------
    {$ifDef _debugLOG_}
    DEBUG('SELECT in INSPECTOR','<<<-----<<<');
    {$endIf}
end;

procedure tLazExt_wndInspector_aFFfSE_Node.reStore_EXPAND;
begin
    //
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node._treeView_SET_(const value:tTreeView);
begin
   _treeView_:=value;
    if Assigned(_treeView_) then begin
       _treeView_set_DO_autoExpand_;
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_Node._treeView_set_DO_autoExpand_;
begin
    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_autoExpand}
      _treeView_.Options:=_treeView_.Options+[tvoAutoExpand];
    {$else}
      _treeView_.Options:=_treeView_.Options-[tvoAutoExpand];
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node._slctNode_SET_(const value:TTreeNode);
begin
    {$ifDef _debugLOG_}
       DEBUG('SELECT', addr2txt(value)+':"'+treeNode_NAME(value)+'"');
    {$endIf}
   _slctNode_:=value;
   _slctFile_:=treeNode_NAME(_slctNode_);
    //--- воот ... теперь пошлу тут разные фичи ----------------------------
    {$ifdef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_01}
    expandedNodesTracking_reStore;
    {$endIf}
    // это БЕЗ условная фича, ради неё и писался этот компанент
   _slctNode_do_selectInTREE_;
    //---
    {$ifdef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_} //< это важно ТОЛЬКО при подрисовке
   _slctNode_.Update;
    {$endIf}
end;


// переместить ВЫДЕЛЕНИЕ на _slctNode_ узел
procedure tLazExt_wndInspector_aFFfSE_Node._slctNode_do_selectInTREE_;
begin
    if Assigned(Form) and Assigned(_treeView_) and Assigned(_slctNode_) then begin
        if not _slctNode_.Selected then begin //< ну будем гонять попусту
            with _treeView_ do begin
                BeginUpdate;
                ClearSelection;
                Selected:=_slctNode_;
                EndUpdate;
            end;
        end;
    end{$ifDef _debugLOG_}
    else begin
       if not Assigned(Form) then DEBUG('ERROR','not Assigned(Owner)')
      else
       if not Assigned(_treeView_) then DEBUG('ERROR','not Assigned(_treeView_)')
      else
       if not Assigned(_slctNode_) then DEBUG('ERROR','not Assigned(_slctNode_)')
    end{$endIf};
end;

//------------------------------------------------------------------------------

{%region --- сабЕвентинг событий форма и её компанентов ----------- /fold}

{$ifDef _fuckUp__ide_object_WND_onActivate_}
// при получении окном фокуса
procedure tLazExt_wndInspector_aFFfSE_Node._WND_onActivate_myCustom_(Sender:TObject);
begin
    //--- моя "нагрузка" ----------------------------------------
    if Assigned(Sender) and (Sender=Form) then begin {todo: перестраховка, подумать про необходимость}
       expandedNodesTracking_workOFF; //< отключаем систему слежения
    end;
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_WND_onActivate_original_) then _ide_object_WND_onActivate_original_(Sender);
end;
{$endif}

{$ifDef _fuckUp__ide_object_WND_onDeActivate_}
// при ПОТЕРЕ окном фокуса
procedure tLazExt_wndInspector_aFFfSE_Node._WND_onDeActivate_myCustom_(Sender:TObject);
begin
    //--- моя "нагрузка" ----------------------------------------
    if Assigned(Sender) and (Sender=Form) then begin {todo: перестраховка, подумать про необходимость}
       expandedNodesTracking_workON; //< отключаем систему слежения
    end;
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_WND_onDeActivate_original_) then _ide_object_WND_onDeActivate_original_(Sender);
end;
{$endif}

//------------------------------------------------------------------------------

// при добавление нового узла в дерево
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onAddition_original_) then _ide_object_VTV_onAddition_original_(Sender,Node);
    //--- моя "нагрузка" ----------------------------------------
    if Assigned(_owner_onNodeAdd_) then _owner_onNodeAdd_(self);
end;

// при удалении узла из дерева
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onDeletion_myCustom_(Sender:TObject; Node:TTreeNode);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onDeletion_original_) then _ide_object_VTV_onDeletion_original_(Sender,Node);
    //--- моя "нагрузка" ----------------------------------------
    if Node=_slctNode_ then begin
       _slctNode_:=nil;
        {$ifDef _debugLOG_}
        DEBUG('DELETE','delete Selected Node:"'+_slctFile_+'"')
        {$endIf};
    end;
end;

{$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
// при рисовании узла у дерева
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onAdvancedCustomDrawItem_original_) then _ide_object_VTV_onAdvancedCustomDrawItem_original_(Sender,Node,State,Stage,PaintImages,DefaultDraw);
    //--- моя "нагрузка" ----------------------------------------

    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_autoCollapseNode}
    if (_expandedNodesTracking_WORK_) then begin
        if Stage=cdPostPaint then begin
            if not _expandedNodesTracking_state_(node) then begin
               _VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(Sender,Node);
            end;
        end;
    end;
    {$endif}
    {$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_ActiveFile}
    //--- выделение текущего файла
    if Stage=cdPostPaint then begin
       _VTV_onAdvancedCustomDrawItem_myCustom_selected_(Sender,Node);
       _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(Sender,Node);
    end;
   { //----
    if (Stage=cdPostPaint)and(Assigned(_slctNode_))
       and(_slctNode_.HasAsParent(Node))
       and(not Node.Expanded)
    then begin
       _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(Sender,Node);
    end; }
    {$endif}
end;
{$endif}

{%endregion}

{$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{%region --- рисование ДОП примитивов ---------------------------- /fold }


{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_autoCollapseNode}

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

{$endif}


{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_mark_ActiveFile}

// рисуем Прямоугольник с линией Справа
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_drawMARK_selected_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
var r:TRect;
begin
    Sender.Canvas.Pen.Color:=Color;
    r:=Node.DisplayRect(TRUE);
    Sender.Canvas.Frame(R);
    r.Top:=(r.Bottom+r.Top) div 2;
    Sender.Canvas.Line(r.Right,r.Top,Sender.Canvas.Width,r.Top);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// рисование: Усиливаем выделение АКТИВНОГО
procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_selected_(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
    if Assigned(_slctNode_) and (_slctNode_=node) then begin // _treeNode_isCurrentActive_(Node) then begin
        if _ide_ActiveSourceEdit_fileName_=treeNode_NAME(_slctNode_)
        then _VTV_drawMARK_selected_(Sender,Node,clHighlight)
        else _VTV_drawMARK_selected_(Sender,Node,clBtnShadow);
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_Node._VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
    // это для ПАПКИ
    if (not Node.Expanded) then begin //< и она ДОЛЖНА быть ОБЯЗАТЕЛЬНО свернута
        if Assigned(_slctNode_) and (_slctNode_.HasAsParent(Node)) then begin
            if _ide_ActiveSourceEdit_fileName_=treeNode_NAME(_slctNode_)
            then _VTV_drawMARK_selected_(Sender,Node,clHighlight)
            else _VTV_drawMARK_selected_(Sender,Node,clBtnShadow);
        end;
    end;
end;

{$endif}



{%endregion}
{$endif _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}

{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_01}
{%region --- Слежение ра развернутыми узлами mode_01 -------------- /fold}

// провто под
//
//


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
        {$ifDef _debugLOG_}
            if value
            then DEBUG('expandedNodesTracking','ON')
            else DEBUG('expandedNodesTracking','off');
        {$endIf}
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

procedure tLazExt_wndInspector_aFFfSE_Node.expandedNodesTracking_workON;
begin
   _expandedNodesTracking_set_WORK_(TRUE);
end;

procedure tLazExt_wndInspector_aFFfSE_Node.expandedNodesTracking_reStore;
begin
    if _expandedNodesTracking_WORK_
    then _expandedNodesTracking_state_reSet_    //< восстановить состояние "свернутости"
    //else _expandedNodesTracking_set_WORK_(TRUE) //< ВКЛЮЧИТЬ систему отслеживания
end;

{%endregion}
{$endIf}


{$endregion}

{$region -- tLazExt_wndInspector_aFFfSE_NodeLST ------------------- /fold}

procedure tLazExt_wndInspector_aFFfSE_NodeLST.CLEAR;
begin
   _nodes__CLR_;
end;

function  tLazExt_wndInspector_aFFfSE_NodeLST.Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
begin
    result:=tLazExt_wndInspector_aFFfSE_Node(fuckUpForms_GET(Form,nodeTYPE));
    result.ownerEvent_onNodeAdd:=_owner_onNodeAdd_; //< чет не знаю куда еще воткнуть :-(
end;

{$endregion}

end.

