unit lazExt_wndInspector_FF8S_wndNode;

{$mode objfpc}{$H+}
interface
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : Описание ------------ /fold }
//-- ВНИМАНИЕ !!! это ТОЛЬКО список с оисанием !!! ---------------------------//
//   настройки могут БУДУТ ПЕРЕОПРЕДЕЛЕНЫ ниже при подключении                //
//   файла настроек "компонента-Расширения" (`in0k_lazExt_SETTINGs.inc`).     //
//----------------------------------------------------------------------------//

//--- # DebugLOG_mode ----------------------------------------------------------
// Режим логирования.
// В код включаются вызовы `DEBUG` с описанием текущих событий и состояний.
{$define in0k_LazIdeEXT_wndInspector_FF8S___DebugLOG}
//------------------------------------------------------------------------------


//-------------------------------------------------------- # treeView_autoExpand
// Автоматически РАЗВОРАЧИВАТЬ узлы.
// При выделении искомого узла АКТИВНОГО файла, РАЗВЕРНУТЬ его дерево родителей.
{$define in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
//------------------------------------------------------------------------------

//------------------------------------------------------ # treeView_autoCollapse
// Система Слежения за Развернутыми Узлами (ССзРУ).
// Автоматическое СВОРАЧИВАНИЕ узлов развернутых на этапе "treeView_autoExpand".
//---------
// способ функционирования (модель работы)
{$define in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
//------------------------------------------------------------------------------


//--- # mark ActiveFileFromSoureceEdit -----------------------------------------
// Отмечать текущей АКТИВНЫЙ файл.
// Дорисовывать в интерфейсе: выделение для узла АКТИВНОГО файла.
{$define in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
//------------------------------------------------------------------------------

//--- # mark TrackingSystemForExpandedNodes ------------------------------------
// Отмечать деятельность системы "ССзРУ".
// Дорисовывать в интерфейсе: отметки о сворачиваемых файлах.
{$define in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
//------------------------------------------------------------------------------

{%endregion}
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : ОЧИСТКА ------------- /fold }
//----------------------------------------------------------------------------//
//   очистка (отключение) ВСЕХ настроек, перед применением конфигурации из    //
//   файла настроек "компонента-Расширения" (`in0k_lazExt_SETTINGs.inc`).     //
//----------------------------------------------------------------------------//
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___DebugLOG}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
{%endregion}
{$i in0k_lazExt_SETTINGs.inc} // настройка-конфигурация Компонента-Расширения
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : ПРИМЕНЕНИЕ ---------- /fold }
//----------------------------------------------------------------------------//
//  Применение ГЛОБАЛЬНЫХ настроек из файла настроек "компонента-Расширения".
//----------------------------------------------------------------------------//

//--- дебаг -----------------
{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___DebugLOG}
    {$define _debugLOG_}//< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}

//==============================================================================

{$undef _local___use_Classes_}
{$undef _local___use_Graphics_}

{$unDef _fuckUp__ide_object_WND_onActivate_}
{$unDef _fuckUp__ide_object_WND_onDeActivate_}
{$unDef _fuckUp__ide_object_VTV_onAddition_}
{$unDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}

//==============================================================================

{$ifNdef in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
    // БЕЗ автоматического разворачивания это НЕИМЕЕТ СМЫСЛА
    {$undef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
    {$undef lazExt_ProjectInspector_aFFfSE__TrackingSystemForExpanded_mode_02}
{$endIf}

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
    {$define  lazExt_ProjectInspector_aFFfSE__TSfEN_ON}
    {$define _fuckUp__ide_object_WND_onActivate_}
    {ю$define _fuckUp__ide_object_WND_onDeActivate_}
{$endIf}

{$ifDef lazExt_ProjectInspector_aFFfSE__treeView_expandedTracking_mode_02}
    {$define lazExt_ProjectInspector_aFFfSE__TSfEN_ON}
    {$undef  _future_treeView_expandedTracking_mode_01}
    {$define _future_treeView_expandedTracking_mode_02}
{$endIf}

//==============================================================================

{$ifnDef lazExt_ProjectInspector_aFFfSE__TSfEN_ON}
    // БЕЗ слежения это НЕвозможно
    {$unDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
{$endIf}

//==============================================================================

// --- определяем, будет ли ДОП рисование

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{$endIf}
{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{$endIf}

//==============================================================================

// --- событие добавления узлов в дерево

{$define _local__NodeListHave_onNodeAdd_}
{$define _fuckUp__ide_object_VTV_onAddition_}
{$ifNdef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE}
    {$unDef _local__NodeListHave_onNodeAdd_}
    {$unDef _fuckUp__ide_object_VTV_onAddition_}
{$endIf}

//==============================================================================
// частное использование библиотек

{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
    {$define _local___use_Classes_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
    {$define _local___use_Graphics_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
    {$define _local___use_Graphics_}
{$endIf}




{%endregion}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     Forms, ComCtrls, TreeFilterEdit, Controls,
     {$ifDef _local___use_Classes_}Classes,{$endIf}
     {$ifDef _local___use_Graphics_}Graphics,{$endIf}

     SrcEditorIntf,
     in0k_lazIdeSRC_FuckUpForm;

type

  // БАЗОВыЙ, для обработки интерисуемых окон
 tLazExt_wndInspector_FF8S_wndNode=class(tIn0k_lazIdeSRC_FuckUpForm)
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
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
    procedure _slctNode_do_expandAllParent_(const node:TTreeNode); inline;
    {$endif}
  protected
  {%region --- Система Слежение за Развернутыми Узлами (ССзРУ) ---- /fold}
  {$ifDef lazExt_ProjectInspector_aFFfSE__TSfEN_ON}
    {%region --- ВАРИАНТ №1 ("ССзРУ" m01) ------------------------ /fold}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
  private
   _TSfENm01__WORK_:boolean;       //< система ВКЛЮЧЕНА
    procedure _TSfENm01__WORK_set_(const value:boolean);
  private
   _TSfENm01__listExpandedNodes_:TStringList;      //< список "ННчС"
    procedure _TSfENm01_listExpandedNodes__2List_; //<
    procedure _TSfENm01_listExpandedNodes__2Tree_; //<
  private
    function  _TSfENm01__node_willBeCollapsed_(const node:TTreeNode):boolean;
    function  _TSfENm01__node_willBeNoVisible_(const node:TTreeNode):boolean;
    {$endIf}
    {%endregion}
    {%region --- "ССзРУ" Степень СВЕРНУТОСТИ для рисования ------- /fold}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
  protected
    function _TSfEN__node_willBeCollapsed_(const node:TTreeNode):boolean;
    function _TSfEN__node_willBeNoVisible_(const node:TTreeNode):boolean;
    {$endIf}
    {%endregion}
  {$endif}
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
  {$ifDef _fuckUp__ide_object_VTV_onAddition_}
  private //< ФакАпим ДОБАВЛЕНИЕ нового узла в дерево
   _ide_object_VTV_onAddition_original_:TTVExpandedEvent;
    procedure _VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
  {$endIf}
  private //< ФакАпим УДАЛЕНИЕ узла из дерева
   _ide_object_VTV_onDeletion_original_:TTVExpandedEvent;
    procedure _VTV_onDeletion_myCustom_(Sender:TObject; Node:TTreeNode);
  {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
  private //< ФакАпим РИСОВАНИЕ
   _ide_object_VTV_onAdvancedCustomDrawItem_original_:TTVAdvancedCustomDrawItemEvent;
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_(Sender:TCustomTreeView; Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages,DefaultDraw:Boolean);
  private //< рисование ДОП примитивов
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
    procedure _VTV_drawMARK_selected_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_selected_(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
    {$endif}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
    procedure _VTV_drawMARK_clspMARK_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(const Sender:TCustomTreeView; const Node:TTreeNode);
    {$endif}
  {$endIf}
  {%endregion}
  {%region --- собятия для родителя ------------------------------- /fold}
  {$ifDef _local__NodeListHave_onNodeAdd_}
  private //< событие для радителя ... "узел добавлен"
   _owner_onNodeAdd_:TNotifyEvent;
  public
    property ownerEvent_onNodeAdd:TNotifyEvent read _owner_onNodeAdd_ write _owner_onNodeAdd_;
  {$endIf}
  {%endregion}
  public
    constructor Create{(const aForm:TCustomForm)}; override;
    destructor DESTROY; override;
  public
    function  Select(const FileName:string):boolean; virtual;
  end;
 tLazExt_wndInspector_aFFfSE_NodeTYPE=class of tLazExt_wndInspector_FF8S_wndNode;

  // ХРАНИТЕЛЬ списка окон, которые мы обрабатываем
 tLazExt_wndInspector_FF8S_NodeLST=class(tIn0k_lazIdeSRC_FuckUpFrms_LIST)
  {%region --- собятия для родителя ------------------------------- /fold}
  {$ifDef _local__NodeListHave_onNodeAdd_}
  private //< событие для радителя ... "узел добавлен"
   _owner_onNodeAdd_:TNotifyEvent;
  public
    property ownerEvent_onNodeAdd:TNotifyEvent read _owner_onNodeAdd_ write _owner_onNodeAdd_;
  {$endIf}
  {%endregion}
  public
    procedure CLEAR;
    function  Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_FF8S_wndNode;
  end;

implementation
uses LCLVersion;

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется DEBUG
    //                       а также и моя "система имен и папок"
    {$define _debugLOG_}     //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}

{$region -- tLazExt_wndInspector_FF8S_wndNode ----------------- /fold}

constructor tLazExt_wndInspector_FF8S_wndNode.Create{(const aForm:TCustomForm)};
begin
    inherited;
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
   _TSfENm01__WORK_:=FALSE;
   _TSfENm01__listExpandedNodes_:=TStringList.Create;
    {$endIf}
    //---
   _treeView_:=nil;
   _slctNode_:=nil;
   _slctFile_:='';
    //---
    {$ifDef _fuckUp__ide_object_VTV_onAddition_}
   _ide_object_VTV_onAddition_original_:=NIL;
    {$endIf}
   _ide_object_VTV_onDeletion_original_:=NIL;
    {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
   _ide_object_VTV_onAdvancedCustomDrawItem_original_:=nil;
    {$endIf}
end;

destructor tLazExt_wndInspector_FF8S_wndNode.DESTROY;
begin
    inherited;
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
   _TSfENm01__listExpandedNodes_.FREE;
    {$endIf}
end;

//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
// определить что форма является моим подопечным, и может тут обрабатываться.
// тут наследники ДОЛЖНЫ описать проверку
//

class function tLazExt_wndInspector_FF8S_wndNode.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=Assigned(testForm);
end;

//
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
// поиск дерева (компонента TreeView) в котором "перечислены" подключенные
// к проекту зависимости (файлы), именно это дерево мы будем "мурыжить"
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

function tLazExt_wndInspector_FF8S_wndNode.treeView_FIND(const ownerWnd:TCustomForm):tTreeView;
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

function tLazExt_wndInspector_FF8S_wndNode.treeNode_NAME(const treeNode:TTreeNode):string;
begin
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___DebugLOG}
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
//
//
//
//
//
//

procedure tLazExt_wndInspector_FF8S_wndNode.FuckUP_onSET;
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
             {$ifDef _fuckUp__ide_object_VTV_onAddition_}
            _ide_object_VTV_onAddition_original_:=_treeView_.OnAddition;
            _treeView_.OnAddition:=@_VTV_onAddition_myCustom_;
             {$endIf}
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

procedure tLazExt_wndInspector_FF8S_wndNode.FuckUP_onCLR;
begin
    if Assigned(_treeView_) then begin
        {$ifDef _fuckUp__ide_object_VTV_onAddition_}
       _treeView_.OnAddition:=_ide_object_VTV_onAddition_original_;
        {$endIf}
       _treeView_.OnDeletion:=_ide_object_VTV_onDeletion_original_;
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
function tLazExt_wndInspector_FF8S_wndNode._ide_ActiveSourceEdit_fileName_:string;
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

// вот ... все ради этого ...
// @ret true нашелся
// @ret false нет ... это не из нашего
function tLazExt_wndInspector_FF8S_wndNode.Select(const FileName:string):boolean;
var treeNode:TTreeNode;
begin
    {$ifDef _debugLOG_}
    DEBUG('SELECT in INSPECTOR','>>> "'+self.Form.Caption+'"');
    {$endIf}
    result  :=false;
    treeNode:=NIL;
    if Assigned(Form) and Assigned(_treeView_) then begin
        // сначала ИСЧЕМ узел с указанным именем
        treeNode:=_treeView_.Items.GetFirstNode;
        while Assigned(treeNode) do begin
            if FileName=treeNode_NAME(treeNode) then begin //< нашли родимого
                result:=TRUE;
                BREAK;
            end;
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

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_FF8S_wndNode._treeView_SET_(const value:tTreeView);
begin
   _treeView_:=value;
    if Assigned(_treeView_) then begin
       _treeView_set_DO_autoExpand_;
    end;
end;

procedure tLazExt_wndInspector_FF8S_wndNode._treeView_set_DO_autoExpand_;
begin
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
      _treeView_.Options:=_treeView_.Options+[tvoAutoExpand];
    {$else}
      _treeView_.Options:=_treeView_.Options-[tvoAutoExpand];
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_FF8S_wndNode._slctNode_SET_(const value:TTreeNode);
begin
    {$ifDef _debugLOG_}
       DEBUG('SELECT', addr2txt(value)+':"'+treeNode_NAME(value)+'"');
    {$endIf}
   _slctNode_:=value;
   _slctFile_:=treeNode_NAME(_slctNode_);
    //--- воот ... теперь пошлу тут разные фичи ----------------------------
    {$ifdef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
    if _TSfENm01__WORK_ then _TSfENm01_listExpandedNodes__2Tree_
    else _TSfENm01__WORK_set_(TRUE);
    {$endIf}
    // это БЕЗ условная фича, ради неё и писался этот компанент
   _slctNode_do_selectInTREE_;
    //---
    {$ifdef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_} //< это важно ТОЛЬКО при подрисовке
   _slctNode_.Update;
    {$endIf}
end;

// переместить ВЫДЕЛЕНИЕ на _slctNode_ узел
procedure tLazExt_wndInspector_FF8S_wndNode._slctNode_do_selectInTREE_;
begin
    if Assigned(Form) and Assigned(_treeView_) and Assigned(_slctNode_) then begin
        with _treeView_ do begin
            BeginUpdate;
            if not _slctNode_.Selected then begin //< не будем гонять попусту
                    ClearSelection;
                    Selected:=_slctNode_;
            end{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
            else begin // убедимся что ВСЕ родители узла РАЗВЕРНУТЫ
               _slctNode_do_expandAllParent_(_slctNode_)
            end{$endif};
            EndUpdate;
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

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
// разворачивание ВСЕХ родиетелей узла
procedure tLazExt_wndInspector_FF8S_wndNode._slctNode_do_expandAllParent_(const node:TTreeNode);
var tmp:TTreeNode;
begin
    tmp:=node.Parent;
    while Assigned(tmp) do begin
        tmp.Expand(false);
        tmp:=tmp.Parent;
    end;
end;
{$endif}

//------------------------------------------------------------------------------

{%region --- сабЕвентинг событий форма и её компанентов ----------- /fold}

{$ifDef _fuckUp__ide_object_WND_onActivate_}
// при получении окном фокуса
procedure tLazExt_wndInspector_FF8S_wndNode._WND_onActivate_myCustom_(Sender:TObject);
begin
    //--- моя "нагрузка" ----------------------------------------
    {$ifdef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
    if Assigned(Sender) and (Sender=Form) then begin {todo: перестраховка, подумать про необходимость}
       _TSfENm01__WORK_set_(false); // отключяаем слежение нафиг
    end;
    {$endIf}
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

{$ifDef _fuckUp__ide_object_VTV_onAddition_}
// при добавление нового узла в дерево
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAddition_myCustom_(Sender:TObject; Node:TTreeNode);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onAddition_original_) then _ide_object_VTV_onAddition_original_(Sender,Node);
    //--- моя "нагрузка" ----------------------------------------
    if Assigned(_owner_onNodeAdd_) then _owner_onNodeAdd_(self);
end;
{$endif}

// при удалении узла из дерева
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onDeletion_myCustom_(Sender:TObject; Node:TTreeNode);
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
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_myCustom_(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onAdvancedCustomDrawItem_original_) then _ide_object_VTV_onAdvancedCustomDrawItem_original_(Sender,Node,State,Stage,PaintImages,DefaultDraw);
    //--- моя "нагрузка" ----------------------------------------
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
    //--- выделение текущего файла
    if Stage=cdPostPaint then begin
       _VTV_onAdvancedCustomDrawItem_myCustom_selected_(Sender,Node);
       _VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(Sender,Node);
    end;
    {$endif}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
    //--- маркер СВОРАЧИВАЕМОСТИ
    if Stage=cdPostPaint then begin
       _VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(Sender,Node);
    end;
    {$endif}
end;
{$endif}

{%endregion}

{$ifDef lazExt_ProjectInspector_aFFfSE__TSfEN_ON}
{%region --- Система Слежение за Развернутыми Узлами (ССзРУ) ------ /fold}
//  "Системе Слежения за Развернутыми Узлами" (ССзРУ)
//  "Tracking System for Expanded Nodes" (TSfEN)

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01}
{%region --- Слежение за развернутыми узлами mode_01 -------------- /fold}
//  #ВАРИАНТ №1. Идея и реализация
{   Туповато, но работает.
### Идея фукционирования:
  - Автоматически поддерживать состояния свернутых/развернутых узлов на
    основе "Некого НаЧального Состояния" (ННчС).
    Алгоритм выделения узла следующий:
    -- восстанавливаем "ННчС"
    -- выделяем узел дерева, это приводит к возможному "раскрытию"
       дополнительных узлов дорева, с чем мы успешно боремся в предыдущем
       пункте
  - Моментом для фиксировании "ННчС" считаем:
    -- ПОТЕРЯ окном фокуса (пользователь настроил состояние дерева, и это
       состояние мы поддерживаем)
    -- попытка выделить файл при ОТКЛЮЧЕННОЙ "ССзРУ"
  - Момент ОТКЛЮЧЕНИЯ "ССзРУ":
    -- изначально "ССзРУ" отключена
    -- ПОЛУЧЕНИЕ фокуса. Пользователь ВОШёЛ в дерево и руками настраивает
       его состояния

### Реализация:
  - _expandedNodesTracking_List_ -- список ИМЕН развернутых узлов (это "ННчС")

}// и далее по коду (он же самодокументирующийся :-P )

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_wndInspector_FF8S_wndNode._TSfENm01__WORK_set_(const value:boolean);
begin
    if value<>_TSfENm01__WORK_ then begin
        if _treeView_.Focused
        then _TSfENm01__WORK_:=FALSE // НЕЛЬЗЯ включить, пока окно в фокусе
        else _TSfENm01__WORK_:=value;
        {$ifDef _debugLOG_}
            if _TSfENm01__WORK_
            then DEBUG('expandedNodesTracking','ON')
            else DEBUG('expandedNodesTracking','off');
        {$endIf}
       _TSfENm01__listExpandedNodes_.Clear;
        if _TSfENm01__WORK_ then _TSfENm01_listExpandedNodes__2List_;
    end;
end;

//------------------------------------------------------------------------------

// запомнить текущее состояние "развернутости узлов"
procedure tLazExt_wndInspector_FF8S_wndNode._TSfENm01_listExpandedNodes__2List_;
var tmp:tTreeNode;
begin //< тупо сохраняем ИМЕНА всех РАЗВЕРНУТЫХ узлов в список
    if Assigned(_treeView_) then begin
       _TSfENm01__listExpandedNodes_.Clear;
        tmp:=_treeView_.Items.GetFirstNode;
        while Assigned(tmp) do begin
            if tmp.Expanded then begin
               _TSfENm01__listExpandedNodes_.Add(treeNode_NAME(tmp));
            end;
            tmp:=tmp.GetNext;
        end;
        {$ifDef _debugLOG_}
        DEBUG('_TSfENm01_listExpandedNodes__2List_','SAVE. In List '+inttostr(_TSfENm01__listExpandedNodes_.Count)+' node(s).');
        {$endIf}
    end;
end;

// переустановть из запомненного состояние "развернутости узлов"
procedure tLazExt_wndInspector_FF8S_wndNode._TSfENm01_listExpandedNodes__2Tree_;
var tmp:tTreeNode;
begin //< проходим по ВСЕМ узлам, если ИМЯ найдено в списке => развернут
    if Assigned(_treeView_)and(_TSfENm01__listExpandedNodes_.Count>0) then begin
       _treeView_.Items.BeginUpdate; {todo: проверить необходимость}
        tmp:=_treeView_.Items.GetFirstNode;
        while Assigned(tmp) do begin
            tmp.Expanded:=(_TSfENm01__listExpandedNodes_.IndexOf(treeNode_NAME(tmp))>=0);
            tmp:=tmp.GetNext;
        end;
       _treeView_.Items.EndUpdate; {todo: проверить необходимость}
        {$ifDef _debugLOG_}
        DEBUG('_TSfENm01_listExpandedNodes__2Tree_','ReSTORE. In List '+inttostr(_TSfENm01__listExpandedNodes_.Count)+' node(s).');
        {$endIf}
    end;
end;

//------------------------------------------------------------------------------

function tLazExt_wndInspector_FF8S_wndNode._TSfENm01__node_willBeCollapsed_(const node:TTreeNode):boolean;
begin // если система РАБОТАЕТ и его НЕТ в списке => мы его СВОРАЧИВАЕМ
    result:=_TSfENm01__WORK_ and (_TSfENm01__listExpandedNodes_.IndexOf(treeNode_NAME(node))<0);
end;

function tLazExt_wndInspector_FF8S_wndNode._TSfENm01__node_willBeNoVisible_(const node:TTreeNode):boolean;
var tmp:tTreeNode;
begin // если свернут моего папу => меня не будет видно
    result:=false;
    if _TSfENm01__WORK_ then begin //< имеет смысл только если система работает
        tmp:=node.Parent;
        while Assigned(tmp) do begin
            result:=_TSfENm01__node_willBeCollapsed_(tmp);
            if result then BREAK;
            tmp:=tmp.Parent;
        end;
    end;
end;

{%endregion}
{$endIf}

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
{%region --- "ССзРУ" Степень СВЕРНУТОСТИ для рисования ------------ /fold}

// этот узел - ПАПКА (и она РАЗВЕРНУТА) и будет свернута
function tLazExt_wndInspector_FF8S_wndNode._TSfEN__node_willBeCollapsed_(const node:TTreeNode):boolean;
begin //<   | возможно лишняя проверка
    result:=Assigned(node) and node.HasChildren and node.Expanded;
    if result then begin //< мдя ... это папка, уточним состояние
        {$if defined(in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01)}
            result:=_TSfENm01__node_willBeCollapsed_(node);
       {$else}
            result:=FALSE;
        {$endIf}
    end;
end;

// этот узел перестанет быть виден, при сворачивании родительских
function tLazExt_wndInspector_FF8S_wndNode._TSfEN__node_willBeNoVisible_(const node:TTreeNode):boolean;
begin //<   | возможно лишняя проверка
    result:=Assigned(node);
    if result then begin //< мдя ... это папка, уточним состояние
        {$if defined(in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE_AutoCollapse_mode01)}
            result:=_TSfENm01__node_willBeNoVisible_(node);
       {$else}
            result:=FALSE;
        {$endIf}
    end;
end;

{%endregion}
{$endIf}

{%endregion}
{$endif lazExt_ProjectInspector_aFFfSE__TSfEN_ON}

{$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{%region --- рисование ДОП примитивов ----------------------------- /fold}

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}

// рисуем Прямоугольник с линией Справа
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_drawMARK_selected_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
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
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_myCustom_selected_(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
    if Assigned(_slctNode_) and (_slctNode_=node) then begin // _treeNode_isCurrentActive_(Node) then begin
        if _ide_ActiveSourceEdit_fileName_=treeNode_NAME(_slctNode_)
        then _VTV_drawMARK_selected_(Sender,Node,clHighlight)
        else _VTV_drawMARK_selected_(Sender,Node,clBtnShadow);
    end;
end;

procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_myCustom_slctFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
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


{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}

// рисуем Уголок слева
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_drawMARK_clspMARK_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
var r:TRect;
begin
    Sender.Canvas.Pen.Color:=Color;
    r:=Node.DisplayRect(TRUE);
    // вычисляем (-: очевидно же по коду :-)  r.Bottom -- как ТЕМП переменная
    r.Bottom:=((r.Bottom-r.Top) div 4);
    r.Bottom:=r.Bottom-1; if r.Bottom<=0 then r.Bottom:=1;
    //
    r.Left :=r.Left+1;
    r.Right:=r.Left+r.Bottom+1;
    r.Top   :=1+r.Top;
    r.Bottom:=1+r.Top+r.Bottom;
    // РИСУЕМ
    Sender.Canvas.Line(r.Left,r.Top   ,r.Right,r.Top);
    Sender.Canvas.Line(r.Left,r.Bottom,r.Left ,r.Top);
end;

// рисование: МАРКЕР авто-Сворачивания
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_myCustom_clspMARK(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
    if _TSfEN__node_willBeCollapsed_(Node) then _VTV_drawMARK_clspMARK_(Sender,Node,clHighlight)
   else
    if _TSfEN__node_willBeNoVisible_(Node) then _VTV_drawMARK_clspMARK_(Sender,Node,clBtnShadow);
end;

{$endif}

{%endregion}
{$endif _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}

{$endregion} //------------- End of Class --- tLazExt_wndInspector_FF8S_wndNode <

{$region -- tLazExt_wndInspector_FF8S_NodeLST ------------------- /fold}

procedure tLazExt_wndInspector_FF8S_NodeLST.CLEAR;
begin
   _nodes__CLR_;
end;

function  tLazExt_wndInspector_FF8S_NodeLST.Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_FF8S_wndNode;
begin
    result:=tLazExt_wndInspector_FF8S_wndNode(fuckUpForms_GET(Form,nodeTYPE));
    {$ifDef _local__NodeListHave_onNodeAdd_}
    result.ownerEvent_onNodeAdd:=_owner_onNodeAdd_; //< чет не знаю куда еще воткнуть :-(
    {$endIf}
end;

{$endregion}

end.

