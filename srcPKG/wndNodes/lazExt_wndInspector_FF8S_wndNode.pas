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

{$define in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Select}
{$define in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}

//--- # PopUp menu -------------------------------------------------------------
// Добавлять пункты меню к PopUpMenu "Дерева Зависимостей"
{$define in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}
{$define in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}
{$define in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}
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
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Select}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}
{$unDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}
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
{$undef _local___prc_treeNode_do_expandAllParent_}
{$undef _local___treeNode_paint_miniMap_Active}


{$unDef _fuckUp__ide_object_WND_onActivate_}
{$unDef _fuckUp__ide_object_WND_onDeActivate_}
{$unDef _fuckUp__ide_object_VTV_onAddition_}
{$unDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{$unDef _fuckUp__ide_object_VTV_onAdvancedCustomDraw_}

//==============================================================================

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___AutoExpand}
    {$define _local___prc_treeNode_do_expandAllParent_}
{$else}
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


//====== ДОП рисование

// --- рисование всяких МАРКЕРОВ

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{$else}
    // это Бесполезно будет
    {$unDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
{$endIf}
{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
{$endIf}

// --- рисование МиниКарта

{$unDef _local___treeNode_paint_miniMap_}
{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Select}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDraw_}
    {$define _local___treeNode_paint_miniMap_}
{$endIf}
{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
    {$define _fuckUp__ide_object_VTV_onAdvancedCustomDraw_}
    {$define _local___treeNode_paint_miniMap_}
{$endIf}




//==============================================================================

// --- событие добавления узлов в дерево

{$define _local___NodeListHave_onNodeAdd_}
{$define _fuckUp__ide_object_VTV_onAddition_}
{$ifNdef in0k_LazIdeEXT_wndInspector_FF8S___AutoMODE}
    {$unDef _local___NodeListHave_onNodeAdd_}
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
{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Select}
    {$define _local___use_Graphics_}
    {$define _local___use_Themes_}
{$endIf}
{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
    {$define _local___use_Graphics_}
{$endIf}

//==============================================================================
// работа с PopUP

{$undef _fuckUp__ide_object_IPM_onPopUp_}
{$undef _local___use_Menus_}
{$undef _local___treeView_popUp_}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}
    {$define _fuckUp__ide_object_IPM_onPopUp_}
    {$define _local___prc_treeNode_do_expandAllParent_}
    {$define _local___treeView_popUp_}
    {$define _local___use_Menus_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}
    {$define _fuckUp__ide_object_IPM_onPopUp_}
    {$define _local___prc_treeNode_do_expandAllParent_}
    {$define _local___treeView_popUp_}
    {$define _local___use_Menus_}
{$endIf}
{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}
    {$define _fuckUp__ide_object_IPM_onPopUp_}
    {$define _local___prc_treeNode_do_expandAllParent_}
    {$define _local___treeView_popUp_}
    {$define _local___use_Menus_}
{$endIf}

{%endregion}


{ю$define in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}


uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     Forms, ComCtrls, TreeFilterEdit, Controls,
     {$ifDef _local___use_Classes_}Classes,{$endIf}
     {$ifDef _local___use_Themes_}Themes,{$endIf}
     {$ifDef _local___use_Graphics_}Graphics,{$endIf}
     {$ifDef _local___use_Menus_}Menus,{$endIf}
     SrcEditorIntf, LCLProc, LCL,
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
    {$ifDef _local___prc_treeNode_do_expandAllParent_}
    procedure _treeNode_do_expandAllParent_(const node:TTreeNode); inline;
    {$endif}
  protected
   _slctNode_:TTreeNode; //< последний отмеченный узел
   _slctFile_:string;    //< последний отмеченный узел (имя файла) нужен для отлова событый связанных с "перевставкой узлов"
    procedure _slctNode_SET_(const value:TTreeNode);
    procedure _slctNode_do_selectInTREE_;
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
  {%region --- Работа с treeView PopUP Menu ----------------------- /fold}
  {$ifDef _local___treeView_popUp_}
  protected
    procedure _IMP_onPopUP_; virtual;
  protected
    function  _IMP_PopupMenu_FND_   (const PM:TPopupMenu; const AnEvent:TNotifyEvent):TMenuItem;
    function  _IMP_PopupMenu_CRT_   (const PM:TPopupMenu; const AnEvent:TNotifyEvent):TMenuItem;
  private
    procedure _IMP_do_treeView_Collapse_All_;
  protected
    function  _IMP_prepare_Separator_:TMenuItem;
    {$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}
    procedure _IMP_do_treeViewPopUp_Collapse_All({%H-}Sender:TObject);
    function  _IMP_prepare_menuItem_Collapse_All_:TMenuItem;
    {$endIf}
    {$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}
    procedure _IMP_do_treeViewPopUp_Collapse_withOutFocused({%H-}Sender:TObject);
    function  _IMP_prepare_menuItem_Collapse_withOutFocused:TMenuItem;
    {$endIf}
    {$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}
    procedure _IMP_do_treeViewPopUp_Collapse_withOutActive({%H-}Sender:TObject);
    function  _IMP_prepare_menuItem_Collapse_withOutActive:TMenuItem;
    {$endIf}
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
  {$ifDef _fuckUp__ide_object_IPM_onPopUp_}
  private //< ФакАпим Событие "появление PopUP"
   _ide_object_IPM_onPopUp_original_:TNotifyEvent;
    procedure _IPM_onPopUp_myCustom_(Sender:TObject);
  {$endIf}
  private //< ФакАпим УДАЛЕНИЕ узла из дерева
   _ide_object_VTV_onDeletion_original_:TTVExpandedEvent;
    procedure _VTV_onDeletion_myCustom_(Sender:TObject; Node:TTreeNode);
  {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDrawItem_}
  private //< ФакАпим рисование УЗЛА
   _ide_object_VTV_onAdvancedCustomDrawItem_original_:TTVAdvancedCustomDrawItemEvent;
    procedure _VTV_onAdvancedCustomDrawItem_myCustom_(Sender:TCustomTreeView; Node:TTreeNode; State:TCustomDrawState; Stage:TCustomDrawStage; var PaintImages,DefaultDraw:Boolean);
  {$endIf}
  {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDraw_}
  private //< ФакАпим рисование ВСЕГО
   _ide_object_VTV_onAdvancedCustomDraw_original_:TTVAdvancedCustomDrawEvent;
    procedure _VTV_onAdvancedCustomDraw_myCustom_(Sender:TCustomTreeView; const ARect:TRect; Stage:TCustomDrawStage; var DefaultDraw:Boolean);
  {$endIf}
  {%endregion}
  {%region --- собятия для родителя ------------------------------- /fold}
  {$ifDef _local___NodeListHave_onNodeAdd_}
  private //< событие для радителя ... "узел добавлен"
   _owner_onNodeAdd_:TNotifyEvent;
  public
    property ownerEvent_onNodeAdd:TNotifyEvent read _owner_onNodeAdd_ write _owner_onNodeAdd_;
  {$endIf}
  {%endregion}
  {%region --- ДоРисовка Интерфейса ------------------------------- /fold}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
  private //< рисование: МАРКЕР АКТИВНЫЙ
    procedure _VTV_draw_nodeMRK__actvFrme_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
    procedure _VTV_onAdvancedCustomDrawItem_nodeMARK_active_(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_nodeMARK_acFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
    procedure _VTV_onAdvancedCustomDrawItem_nodeMARK_(const Sender:TCustomTreeView; const Node:TTreeNode);
    {$endif}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
  private //< рисование: МАРКЕР "сворачиваемости"
    procedure _VTV_draw_nodeMRK__clspMARK_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
    procedure _VTV_onAdvancedCustomDrawItem_clspMARK_(const Sender:TCustomTreeView; const Node:TTreeNode);
    {$endif}
    {$ifDef _local___treeNode_paint_miniMap_}
  private // общее по миниКарте
    function  _VTV_find_topLastCollapsed_(const Node:TTreeNode):TTreeNode;
    function  _VTV_miniMap_select_width_ :integer; inline;
    procedure _VTV_miniMap_calculate_rects_     (const Sender:TCustomTreeView; const FullHeight:integer; const Node:TTreeNode; var nodeRect,mMapRect:Trect);
    procedure _VTV_onAdvancedCustomDraw_miniMap_(const Sender:TCustomTreeView; const ARect:TRect);
    {$endif}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Select}
  private // миниКарта: выделенный
    procedure _VTV_onAdvancedCustomDraw_miniMap_select_(const Sender:TCustomTreeView; const ARect:TRect; const fullHeight:integer; const Node:TTreeNode);
    {$endIf}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
  private // миниКарта: АКТИВНЫЙ
    function  _VTV_miniMap_active_width_:integer; inline;
    function  _VTV_miniMap_active_r_POS_:integer; inline;
    procedure _VTV_onAdvancedCustomDraw_miniMap_active_(const Sender:TCustomTreeView; const ARect:TRect; const fullHeight:integer; const Node:TTreeNode);
    {$endIf}
  {%endRegion}


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
  {$ifDef _local___NodeListHave_onNodeAdd_}
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

const
   _cVTV_color_Active_=clHighlight;
   _cVTV_color_Grayed_=clBtnShadow;


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
    {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDraw_}
   _ide_object_VTV_onAdvancedCustomDraw_original_:=nil;
    {$endIf}
    {$ifDef _fuckUp__ide_object_IPM_onPopUp_}
   _ide_object_IPM_onPopUp_original_:=NIL;
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
            {$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDraw_}
           _ide_object_VTV_onAdvancedCustomDraw_original_:=_treeView_.OnAdvancedCustomDraw;
           _treeView_.OnAdvancedCustomDraw:=@_VTV_onAdvancedCustomDraw_myCustom_;
            {$endIf}
            //---
            {$ifDef _fuckUp__ide_object_IPM_onPopUp_}
            if Assigned(_treeView_.PopupMenu) then begin
               _ide_object_IPM_onPopUp_original_:=_treeView_.PopupMenu.OnPopup;
               _treeView_.PopupMenu.OnPopup:=@_IPM_onPopUp_myCustom_;
            end;
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

{$ifDef _local___prc_treeNode_do_expandAllParent_}
// разворачивание ВСЕХ родиетелей узла
procedure tLazExt_wndInspector_FF8S_wndNode._treeNode_do_expandAllParent_(const node:TTreeNode);
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
               _treeNode_do_expandAllParent_(_slctNode_)
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
    if Stage=cdPostPaint then _VTV_onAdvancedCustomDrawItem_nodeMARK_(Sender,Node);
    {$endif}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
    //--- маркер СВОРАЧИВАЕМОСТИ
    if Stage=cdPostPaint then _VTV_onAdvancedCustomDrawItem_clspMARK_(Sender,Node);
    {$endif}
end;
{$endif}

{$ifDef _fuckUp__ide_object_VTV_onAdvancedCustomDraw_}
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDraw_myCustom_(Sender:TCustomTreeView; const ARect:TRect; Stage:TCustomDrawStage; var DefaultDraw:Boolean);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_VTV_onAdvancedCustomDraw_original_) then _ide_object_VTV_onAdvancedCustomDraw_original_(Sender,ARect,Stage,DefaultDraw);
    //--- моя "нагрузка" ----------------------------------------
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
    if Stage=cdPostPaint then _VTV_onAdvancedCustomDraw_miniMap_(Sender,ARect);
    {$endif}
end;
{$endIf}

//------------------------------------------------------------------------------

{$ifDef _fuckUp__ide_object_IPM_onPopUp_}
procedure tLazExt_wndInspector_FF8S_wndNode._IPM_onPopUp_myCustom_(Sender:TObject);
begin
    //--- вызов ОРИГИНАЛЬНОГО обработчика, то что было изначально
    if Assigned(_ide_object_IPM_onPopUp_original_) then _ide_object_IPM_onPopUp_original_(Sender);
    //--- моя "нагрузка" ----------------------------------------
   _IMP_onPopUP_;
end;
{$endIf}

{%endregion}

{%region --- Система Слежение за Развернутыми Узлами (ССзРУ) ------ /fold}
{$ifDef lazExt_ProjectInspector_aFFfSE__TSfEN_ON}
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

{$endif lazExt_ProjectInspector_aFFfSE__TSfEN_ON}
{%endregion}

{%region --- Работа с treeView PopUP Menu ------------------------- /fold}
{$ifDef _local___treeView_popUp_}

procedure tLazExt_wndInspector_FF8S_wndNode._IMP_onPopUP_;
begin
    // do nofing
end;

//------------------------------------------------------------------------------

function tLazExt_wndInspector_FF8S_wndNode._IMP_PopupMenu_FND_(const PM:TPopupMenu; const AnEvent:TNotifyEvent):TMenuItem;
var i:integer;
begin
    result:=nil;
    if not( Assigned(PM) and Assigned(AnEvent)) then exit;
    //---
    for i:=0 to PM.Items.Count-1 do begin
        if PM.Items[i].OnClick=AnEvent then begin
            result:=PM.Items[i];
            BREAK;
        end;
    end;
end;

function tLazExt_wndInspector_FF8S_wndNode._IMP_PopupMenu_CRT_(const PM:TPopupMenu; const AnEvent:TNotifyEvent):TMenuItem;
begin
    result:=TMenuItem.Create(self.Form);
    PM.Items.Add(result);
    //---
    result.OnClick:=AnEvent;
    result.Checked:=false;
    result.ShowAlwaysCheckable:=false;
    result.Visible:=true;
    result.RadioItem:=false;
    result.ImageIndex:=-1;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_FF8S_wndNode._IMP_do_treeView_Collapse_All_;
begin
   _treeView_.BeginUpdate;
   _treeView_.FullCollapse;
   _treeView_.EndUpdate;
end;

//------------------------------------------------------------------------------

const {todo: а как же быть с переводом????}
  _cPopUpMenu__CORE_Collapse_All__Caption_='Collapse All';

function tLazExt_wndInspector_FF8S_wndNode._IMP_prepare_Separator_:TMenuItem;
begin
    result:=_IMP_PopupMenu_CRT_(_treeView_.PopupMenu,nil);
    result.Caption:='-';
end;

//------------------------------------------------------------------------------

{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_All}

procedure tLazExt_wndInspector_FF8S_wndNode._IMP_do_treeViewPopUp_Collapse_All(Sender:TObject);
begin
    if not Assigned(_treeView_) then Exit; //< на всяк пожарный
    //---
   _IMP_do_treeView_Collapse_All_
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const {todo: а как же быть с переводом????}
  _cPopUpMenu__Collapse_All__Caption_=_cPopUpMenu__CORE_Collapse_All__Caption_;
  _cPopUpMenu__Collapse_All__Hint_   ='';

function tLazExt_wndInspector_FF8S_wndNode._IMP_prepare_menuItem_Collapse_All_:TMenuItem;
begin
    result:=_IMP_PopupMenu_FND_(_treeView_.PopupMenu,@_IMP_do_treeViewPopUp_Collapse_All);
    if not Assigned(result) then begin
        result:=_IMP_PopupMenu_CRT_(_treeView_.PopupMenu,@_IMP_do_treeViewPopUp_Collapse_All);
        result.Caption:=_cPopUpMenu__Collapse_All__Caption_;
        result.Hint   :=_cPopUpMenu__Collapse_All__Hint_;
    end;
    result.Enabled:=TRUE;
end;

{$endIf}

{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutFocused}

procedure tLazExt_wndInspector_FF8S_wndNode._IMP_do_treeViewPopUp_Collapse_withOutFocused(Sender:TObject);
begin
    if not ( Assigned(_treeView_) and Assigned(_treeView_.Selected) ) then Exit; //< на всяк пожарный
    //---
   _treeView_.BeginUpdate; //< он коммулятивный
       _IMP_do_treeView_Collapse_All_;
       _treeNode_do_expandAllParent_(_treeView_.Selected);
   _treeView_.EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const {todo: а как же быть с переводом????}
  _cPopUpMenu__Collapse_withOutFocused__Caption_=_cPopUpMenu__CORE_Collapse_All__Caption_+' (^) Focused';
  _cPopUpMenu__Collapse_withOutFocused__Hint_   =_cPopUpMenu__CORE_Collapse_All__Caption_+' without Focused node';

function tLazExt_wndInspector_FF8S_wndNode._IMP_prepare_menuItem_Collapse_withOutFocused:TMenuItem;
begin
    result:=_IMP_PopupMenu_FND_(_treeView_.PopupMenu,@_IMP_do_treeViewPopUp_Collapse_withOutFocused);
    if not Assigned(result) then begin
        result:=_IMP_PopupMenu_CRT_(_treeView_.PopupMenu,@_IMP_do_treeViewPopUp_Collapse_withOutFocused);
        result.Caption:=_cPopUpMenu__Collapse_withOutFocused__Caption_;
        result.Hint   :=_cPopUpMenu__Collapse_withOutFocused__Hint_;
    end;
    result.Enabled:=Assigned(_treeView_.Selected);
end;

{$endIf}

{$IfDef in0k_LazIdeEXT_wndInspector_FF8S___treeViewPopUp_Collapse_withOutActive}

procedure tLazExt_wndInspector_FF8S_wndNode._IMP_do_treeViewPopUp_Collapse_withOutActive(Sender:TObject);
begin
    if not ( Assigned(_treeView_) and Assigned(_slctNode_) ) then Exit; //< на всяк пожарный
    //---
   _treeView_.BeginUpdate; //< он коммулятивный
        _IMP_do_treeView_Collapse_All_;
        _treeNode_do_expandAllParent_(_slctNode_);
   _treeView_.EndUpdate;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const {todo: а как же быть с переводом????}
  _cPopUpMenu__Collapse_withOutActive__Caption_=_cPopUpMenu__CORE_Collapse_All__Caption_+' (^) Active';
  _cPopUpMenu__Collapse_withOutActive__Hint_   =_cPopUpMenu__CORE_Collapse_All__Caption_+' without Active node';

function tLazExt_wndInspector_FF8S_wndNode._IMP_prepare_menuItem_Collapse_withOutActive:TMenuItem;
begin
    result:=_IMP_PopupMenu_FND_(_treeView_.PopupMenu,@_IMP_do_treeViewPopUp_Collapse_withOutActive);
    if not Assigned(result) then begin
        result:=_IMP_PopupMenu_CRT_(_treeView_.PopupMenu,@_IMP_do_treeViewPopUp_Collapse_withOutActive);
        result.Caption:=_cPopUpMenu__Collapse_withOutActive__Caption_;
        result.Hint   :=_cPopUpMenu__Collapse_withOutActive__Hint_;
    end;
    result.Enabled:=Assigned(_slctNode_);
end;

{$endIf}

{$endif}
{%endregion}

{%region --- рисование ДОП примитивов ----------------------------- /fold}

{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_ActiveFileFromSoureceEdit}
// рисование: МАРКЕР АКТИВНЫЙ

// рисуем Прямоугольник с линией Справа
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_draw_nodeMRK__actvFrme_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
var rect:TRect;
begin
    rect:=Node.DisplayRect(TRUE);
    // прямоугольник выделения
    Sender.Canvas.Pen.Color:=Color;
    Sender.Canvas.Frame(rect);
    // линия вправо (если она влазит в экран)
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
    if rect.Right<sender.ClientWidth-_VTV_miniMap_active_r_POS_ then begin
    {$else}
    if rect.Right<sender.ClientWidth then begin
    {$endif}
        rect.Top:=(rect.Bottom+rect.Top) div 2;
        rect.Left:=sender.ClientWidth;//  Sender.Canvas.Width;
        {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
        rect.Left:=rect.Left-_VTV_miniMap_active_r_POS_;
        {$endif}
        // !!! тут Right и Left НАОБОРОТ !!!
        Sender.Canvas.Line(rect.Right,rect.Top,rect.Left,rect.Top);
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// рисование: Усиливаем выделение АКТИВНОГО
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_nodeMARK_active_(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
     node.IsVisible;
    if Assigned(_slctNode_) and (_slctNode_=node) then begin // _treeNode_isCurrentActive_(Node) then begin
        if _ide_ActiveSourceEdit_fileName_=treeNode_NAME(_slctNode_)
        then _VTV_draw_nodeMRK__actvFrme_(Sender,Node,_cVTV_color_Active_)
        else _VTV_draw_nodeMRK__actvFrme_(Sender,Node,_cVTV_color_Grayed_);
    end;
end;

// рисование: это для ПАПКИ (которая возможно свернута и содержит в себе _slctNode_)
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_nodeMARK_acFLDR_(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
    if (not Node.Expanded) then begin //< и она ДОЛЖНА быть ОБЯЗАТЕЛЬНО свернута
        if Assigned(_slctNode_) and (_slctNode_.HasAsParent(Node)) then begin
            if _ide_ActiveSourceEdit_fileName_=treeNode_NAME(_slctNode_)
            then _VTV_draw_nodeMRK__actvFrme_(Sender,Node,_cVTV_color_Active_)
            else _VTV_draw_nodeMRK__actvFrme_(Sender,Node,_cVTV_color_Grayed_);
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// рисование: все что связанной с отметкой для АКТИВНОГО файла
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_nodeMARK_(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
    if Assigned(_slctNode_) then begin //< иначе бестолку
        if (_slctNode_<>Node) then begin
           _VTV_onAdvancedCustomDrawItem_nodeMARK_acFLDR_(Sender,Node);
        end
        else begin
           _VTV_onAdvancedCustomDrawItem_nodeMARK_active_(Sender,Node);
        end;
    end;
end;

{$endif}


{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___mark_TrackingSystemForExpanded}
// рисование: МАРКЕР авто-Сворачивания

// рисуем Уголок слева
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_draw_nodeMRK__clspMARK_(const Sender:TCustomTreeView; const Node:TTreeNode; const Color:TColor);
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
    //---
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDrawItem_clspMARK_(const Sender:TCustomTreeView; const Node:TTreeNode);
begin
    if _TSfEN__node_willBeCollapsed_(Node) then _VTV_draw_nodeMRK__clspMARK_(Sender,Node,_cVTV_color_Active_)
   else
    if _TSfEN__node_willBeNoVisible_(Node) then _VTV_draw_nodeMRK__clspMARK_(Sender,Node,_cVTV_color_Grayed_);
end;

{$endif}


{$ifDef _local___treeNode_paint_miniMap_} //------------------------------------

const {todo: подумать как избавиться от ХорКорного определения константы}
  // ширина маркера на миниКарте для ВЫДЕЛЕННОГО узла (тот который в фокусе)
 _cVTV_onAdvancedCustomDraw_miniMap_select_minWidth=4;
  //<от этой константы все остальное расчитывается

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_wndInspector_FF8S_wndNode._VTV_miniMap_select_width_:integer;
begin
    result:=_cVTV_onAdvancedCustomDraw_miniMap_select_minWidth;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// расчитать положение на миниКарте (верх-низ)
procedure tLazExt_wndInspector_FF8S_wndNode._VTV_miniMap_calculate_rects_(const Sender:TCustomTreeView; const FullHeight:integer; const Node:TTreeNode; var nodeRect,mMapRect:Trect);
begin
    nodeRect:=Node.DisplayRect(true);
    mMapRect:=nodeRect;
    if Sender.ClientHeight<FullHeight then begin
        // тут маштаб работает, иначе один в один
        mMapRect.Top:=trunc((Node.Top/FullHeight)*(Sender.ClientHeight-(nodeRect.Bottom-nodeRect.Top))); //< чуть сжимаем размер миникарты
        mMapRect.Bottom:=mMapRect.Top+(nodeRect.Bottom-nodeRect.Top);
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function  tLazExt_wndInspector_FF8S_wndNode._VTV_find_topLastCollapsed_(const Node:TTreeNode):TTreeNode;
var tmp:TTreeNode;
begin
    result:=node;
    tmp:=result.Parent;
    while Assigned(tmp){and(tmp.TreeView.Items[0]<>tmp)} do begin
        if not tmp.Expanded then result:=tmp;
        //-->
        tmp:=tmp.Parent;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDraw_miniMap_(const Sender:TCustomTreeView; const ARect:TRect);
var fullHeight:integer;
    node:tTreeNode;
begin
    // проверим... стоит ли вообще шевелиться
    if not (Assigned(_slctNode_) or Assigned(Sender.Selected)) then EXIT; //< делать то НЕЧЕГО

    // расчитаем ПОЛНУЮ высоты содержимого (подсмотрел в исходниках tTreeView)
    node:=sender.Items.GetLastExpandedSubNode;
    if not Assigned(node) then EXIT;  //< что-то пошло не так
    fullHeight:=node.Top+node.Height; // полная высота СОДЕРЖИМОГО дерева

    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Select}
    node:=Sender.Selected; //< рисуем миниМап для узла в фокусе
    if Assigned(node) then begin
       _VTV_onAdvancedCustomDraw_miniMap_select_(Sender,ARect,fullHeight,node);
    end;
    {$endif}
    {$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}
    node:=_slctNode_; //< рисуем миниМап для АКТИВНОГО узла
    if Assigned(node) then begin
       _VTV_onAdvancedCustomDraw_miniMap_active_(Sender,ARect,fullHeight,node);
    end;
    {$endif}
end;

{$endif}


{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Select} //-------------------

procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDraw_miniMap_select_(const Sender:TCustomTreeView; const ARect:TRect; const fullHeight:integer; const Node:TTreeNode);
var nodeRect,mMapRect:tRect;
    Details: TThemedElementDetails;
    N:TTreeNode;
begin
    // что ПРеДСТАВЛЯЕТ наш узел (это может быть один из свернутых родителей)
    N:=_VTV_find_topLastCollapsed_(Node);

    //---
    // расчитываем положение и размер на МиниКарте
   _VTV_miniMap_calculate_rects_(Sender,fullHeight,N,nodeRect,mMapRect);
    mMapRect.Right:=ARect.Right;
    mMapRect.Left :=ARect.Right-_VTV_miniMap_select_width_;

    //---
    // рисуем САМ маркер
    if (tvoThemedDraw in Sender.Options) then begin
        if Sender.Focused //and node.IsVisible
        then Details:=ThemeServices.GetElementDetails(ttItemSelected)
        else Details:=ThemeServices.GetElementDetails(ttItemSelectedNotFocus);
        ThemeServices.DrawElement(Sender.Canvas.Handle, Details, mMapRect, nil)
    end
    else begin
        if Sender.Focused //and node.IsVisible
        then Sender.Canvas.Pen.Color:=Sender.SelectionColor
        else Sender.Canvas.Pen.Color:=clScrollBar;
        Sender.Canvas.Rectangle(mMapRect);
    end;
    //---
    // по необходимости рисуем маркер для "свернутого" отца
    if (N<>Node)and(N.IsVisible) then begin //< ага, УЗЕЛ не видно ... он свернут в родителя "N"
        // он еще НЕ должен совпадать _slctNode_ или его "свернутым родителеем"
        if NOT (Assigned(_slctNode_)and((N=_slctNode_)or(N=_VTV_find_topLastCollapsed_(_slctNode_)))) then begin
            // рисуем САМ маркер
            if (tvoThemedDraw in Sender.Options) then begin
                Details:=ThemeServices.GetElementDetails(ttItemSelectedNotFocus);
                ThemeServices.DrawElement(Sender.Canvas.Handle, Details, nodeRect, nil)
            end
            else begin
                Sender.Canvas.Brush.Color:=clScrollBar;
                Sender.Canvas.FrameRect(nodeRect);
            end;
        end;
    end;
end;

{$endIf}


{$ifDef in0k_LazIdeEXT_wndInspector_FF8S___miniMap_Active}//--------------------

function tLazExt_wndInspector_FF8S_wndNode._VTV_miniMap_active_width_:integer;
begin
    result:=2*_VTV_miniMap_select_width_;
end;

function tLazExt_wndInspector_FF8S_wndNode._VTV_miniMap_active_r_POS_:integer;
begin
    result:=_VTV_miniMap_active_width_-1;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_wndInspector_FF8S_wndNode._VTV_onAdvancedCustomDraw_miniMap_active_(const Sender:TCustomTreeView; const ARect:TRect; const fullHeight:integer; const Node:TTreeNode);
var nodeRect,mMapRect:tRect;
    D,x:integer;
    N:TTreeNode;
begin
    // что ПРеДСТАВЛЯЕТ наш узел (это может быть один из свернутых родителей)
    N:=_VTV_find_topLastCollapsed_(Node);

    //---
    // расчитываем положение и размер на МиниКарте
   _VTV_miniMap_calculate_rects_(Sender,fullHeight,N,nodeRect,mMapRect);
    mMapRect.Right:=ARect.Right;
    mMapRect.Left :=ARect.Right-_VTV_miniMap_active_width_;
    // ужимаем высоту на ТРЕТЬ
    d:=(mMapRect.Bottom-mMapRect.Top)div 3; if d=0 then d:=1;
    mMapRect.Top   :=mMapRect.Top+D;
    mMapRect.Bottom:=mMapRect.Bottom-D;

    //---
    // рисуем САМ маркер
    if _ide_ActiveSourceEdit_fileName_=treeNode_NAME(Node)
    then Sender.Canvas.Pen.Color:=_cVTV_color_Active_
    else Sender.Canvas.Pen.Color:=_cVTV_color_Grayed_;
    Sender.Canvas.Brush.Color:=sender.BackgroundColor;
    Sender.Canvas.Rectangle(mMapRect);
    //---
    // линия до "основного маркера"
    if Assigned(N) then begin
        mMapRect.Left:=ARect.Right-_VTV_miniMap_active_r_POS_; // место ВЕРТИКАЛЬНОЙ линии
        nodeRect:=N.DisplayRect(true);
        //---
        if mMapRect.Left<=nodeRect.Right then begin // прямоуголиник пересекаются ...
            // соединаем соответствующие стороны
            if mMapRect.Bottom<nodeRect.Top then Sender.Canvas.Line(mMapRect.Left,mMapRect.Bottom,mMapRect.Left,nodeRect.Top)
           else
            if nodeRect.Bottom<mMapRect.Top then Sender.Canvas.Line(mMapRect.Left,nodeRect.Bottom,mMapRect.Left,mMapRect.Top);
        end
        else begin // рисем линию до СЕРЕДИННОЙ, от нужной стороны
            X:=nodeRect.Top+(nodeRect.Bottom-nodeRect.top)div 2;
            if X<mMapRect.Top then Sender.Canvas.Line(mMapRect.Left,X,mMapRect.Left,mMapRect.Top)
           else
            if mMapRect.Bottom<X then Sender.Canvas.Line(mMapRect.Left,mMapRect.Bottom,mMapRect.Left,X);
        end;
    end;
end;

{$endIf}

{%endregion}

{$endregion} //------------- End of Class --- tLazExt_wndInspector_FF8S_wndNode <

{$region -- tLazExt_wndInspector_FF8S_NodeLST ------------------- /fold}

procedure tLazExt_wndInspector_FF8S_NodeLST.CLEAR;
begin
   _nodes__CLR_;
end;

function  tLazExt_wndInspector_FF8S_NodeLST.Nodes_GET(const Form:TCustomForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_FF8S_wndNode;
begin
    result:=tLazExt_wndInspector_FF8S_wndNode(fuckUpForms_GET(Form,nodeTYPE));
    {$ifDef _local___NodeListHave_onNodeAdd_}
    result.ownerEvent_onNodeAdd:=_owner_onNodeAdd_; //< чет не знаю куда еще воткнуть :-(
    {$endIf}
end;

{$endregion}

end.

