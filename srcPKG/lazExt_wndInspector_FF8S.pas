unit lazExt_wndInspector_FF8S;
//< Главный класс компонента-Расширения

{todo: описание и документация}

{$mode objfpc}{$H+}
interface
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : Описание ------------ /fold }
//                                                                      //----//
//   ВНИМАНИЕ !!! это ТОЛЬКО список с оисанием !!!                            //
//   настройки могут БУДУТ ПЕРЕОПРЕДЕЛЕНЫ ниже при подключении                //
//   файла настроек "компонента-Расширения" (`in0k_lazExt_SETTINGs.inc`).     //
//                                                                            //
//----------------------------------------------------------------------------//

//--- # DebugLOG_mode --------------------------------------------------------//
// Режим логирования.
// В код включаются вызовы `DEBUG` с описанием текущих событий и состояний.
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
//------------------------------------------------------------------------------


//--- # Ide COMMAND ----------------------------------------------------------//
// Ручной режим работы.
// Добавляется комманда IDE, на которую можно повешать "Горячую Клавишу"
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
// Если файл НЕ найден, то показать сообщение об этом
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_shomMsgIfNotFOUND}
// Если файл НАЙДЕН, то окно соответствующего инспектора переместить на "ПЕРЕДНИЙ план"
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
// Создать пункт меню в "Главном меню IDE" (SEACRH)
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_IdeMainMenu}
// Создать пункт меню в "Меню Редакторе Исходного Кода" (правая клавиша в окне редактора)
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_SrcEditMenu}
//------------------------------------------------------------------------------


//--- # Auto Execute ---------------------------------------------------------//
// АВТОМАТИЧЕСКИЙ режим.
// Автоматически срабатывает при переходе между вкладками "Редактора Исходного Кода"
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
// Если файл НАЙДЕН, то окно соответствующего инспектора переместить на "ВТОРОЙ план"
// подробности см. https://github.com/in0k-src/in0k-bringToSecondPlane
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
//------------------------------------------------------------------------------

{%endregion}
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : ОЧИСТКА ------------- /fold }
//   ВСЕ отключаем, перед применением настроек !!!                      //----//
//----------------------------------------------------------------------------//
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_shomMsgIfNotFOUND}
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_IdeMainMenu}
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_SrcEditMenu}
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
{%endregion}
{$i in0k_lazExt_SETTINGs.inc} // КОНФИГУРАЦИЯ компонента-Расширения.
{%region --- "НАСТРОйКИ уровня КОМПИЛЯЦИИ" : ПРИМЕНЕНИЕ ---------- /fold }

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
    {$define _debugLOG_}//< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}

//===== РУЧНОЙ режим  ==========================================================
{$ifNDEF in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand} // не имеет смысла
    {$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
    {$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_IdeMainMenu}
    {$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_SrcEditMenu}
{$endIf}

{$undef _local___use_MenuIntf_}
{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_IdeMainMenu}
    {$define _local___use_MenuIntf_}
{$endIf}
{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_SrcEditMenu}
    {$define _local___use_MenuIntf_}
{$endIf}




//===== АВТО режим, отложенный запуск ==========================================
{$define _local___select_heldCall_}
//------------------------------------------------------------------------------
{$ifNDEF in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute} // не имеет смысла
    {$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
    {$undef _local___select_heldCall_}
{$endIf}

//===== перетягивание форм по "слоям" (на передний на второй поан) =============
{$undef _local___wndZOrederMoving_}
//------------------------------------------------------------------------------
{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
    {$define _local___wndZOrederMoving_}
{$endIf}
{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
    {$define _local___wndZOrederMoving_}
{$endIf}

{%endregion}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     Classes, Forms,
     LazIDEIntf, SrcEditorIntf,
     LCLIntf, //< это для GetTickCount64 в (Laz 1.4) {todo: обернуть в предКомпиляцию}
     //--- ручной режим
     {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
     IDECommands, LCLType, //< регистрация комманды
     {$endIf}
     {$ifDef _local___use_MenuIntf_}
     MenuIntf,//< добавление пунктов меню
     {$endIf}
     {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_shomMsgIfNotFOUND}
     Dialogs, //< показ сообщенй
     {$endIf}
     //--- авто режим
     {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
     in0k_lazIdeSRC_SourceEditor_onActivate, //< отлов событий
     {$endIf}
     {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
     in0k_lazIdeSRC_B2SP, //< для переноса окон
     {$endIf}
     //---
     lazExt_wndInspector_aFNcAFSE_wndNode,
     lazExt_wndInspector_aFNcAFSE_wndNode_ProjectInspector,
     lazExt_wndInspector_aFNcAFSE_wndNode_PackageEditor;

{$ifDef _local___select_heldCall_}
CONST // ОЧЕНЬ ВАЖНАЯ константа, задержка (в мс) от события до начала выполнения
      // моих фокусов. На моей машине достаточно 100мс.
  clazExt_wndInspector_aFNcAFSE__timeHeldCallForSelect=100;
      // подробности см. `_select_heldCall_`.
      {todo: придумать, как избавиться от константы используя события дерева}
{$endIf}

type

 tLazExt_wndInspector_aFNcAFSE=class
  {%region --- организация отложенного вызова -------------------- /fold }
  {$ifDef _local___select_heldCall_}
  strict private
   _heldCall_THREAD_  :TThread;
   _heldCall_timeST_  :QWord;
    procedure _heldCall_doSetUp_;
    procedure _heldCall_execute_;
  private
    procedure _heldCall_select_execute_;
    procedure _heldCall_select_doSetUp_;
  {$endIf}
  {%endregion}
  {%region --- перемещение окон по оси ZZZ ----------------------- /fold }
  {$ifDef _local___wndZOrederMoving_}
  private
   _wndZOrederMoving_mode:byte; // какой именно способ будет использован
  protected
    procedure _wndZOrederMoving_mode_set_(const mode:byte);
    procedure _wndZOrederMoving_OFF_;
    procedure _wndZOrederMoving_         (const form:TCustomForm);
  {$endIf}
  {%endregion}
  protected
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
   _SourceEditor_onActivate_:tIn0k_lazIdeSRC_SourceEditor_onActivate;
    {$endIf}
  protected
   _lair_nodes_wndInspector_:tLazExt_wndInspector_aFFfSE_NodeLST;
  protected
    function  _fileName_fromActiveSourceEdit_:string;

  protected //< ОСНОВНАЯ часть ... суть
    function  _select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):boolean;
    function  _select_inSCREEN_(const fileName:string):boolean;
    function  _select_:boolean;  //< ПРЯМОЙ вызов
  protected //< РУЧНОЕ событие
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
    procedure _Event_IdeCommand_Execute_(Sender:TObject);
    {$endIf}
  protected //< АВТО событие
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
    procedure _select_heldCall_; //< ОТЛОЖЕННЫЙ вызов
    procedure _Event_SourceEditor_onActivate_(Sender:TObject);
    procedure _Event_wndNodes_ProjectAddNode_(Sender:TObject);
    {$endIf}
  public
    constructor Create;
    destructor DESTROY; override;
  protected
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
    procedure _LazarusIDE_SetUP__mode_ideCommand_;
    procedure _LazarusIDE_CLEAN__mode_ideCommand_;
    {$endIf}
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
    procedure _LazarusIDE_SetUP__mode_autoExecute_;
    procedure _LazarusIDE_CLEAN__mode_autoExecute_;
    {$endIf}
  protected
    procedure  LazarusIDE_OnIDEClose(Sender:TObject);
  public
    procedure  LazarusIDE_SetUP;
    procedure  LazarusIDE_CLEAN;
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

constructor tLazExt_wndInspector_aFNcAFSE.Create;
begin
     {$ifDef _local___select_heldCall_}
    _heldCall_THREAD_  :=nil;
    _heldCall_timeST_  :=0;
     {$endIf}
     {$ifDef _local___wndZOrederMoving_}
    _wndZOrederMoving_OFF_;
     {$endIf}
     //---
    _lair_nodes_wndInspector_:=tLazExt_wndInspector_aFFfSE_NodeLST.Create;
end;

destructor tLazExt_wndInspector_aFNcAFSE.DESTROY;
begin
   _lair_nodes_wndInspector_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFNcAFSE.LazarusIDE_SetUP;
begin
   _lair_nodes_wndInspector_.CLEAR;
    LazarusIDE.AddHandlerOnIDEClose(@LazarusIDE_OnIDEClose);
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
   _LazarusIDE_SetUP__mode_ideCommand_;
    {$endIf}
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
   _LazarusIDE_SetUP__mode_autoExecute_
    {$endIf}
end;

procedure tLazExt_wndInspector_aFNcAFSE.LazarusIDE_Clean;
begin
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
   _LazarusIDE_CLEAN__mode_autoExecute_;
    {$endIf}
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
   _LazarusIDE_CLEAN__mode_ideCommand_;
    {$endIf}
   _lair_nodes_wndInspector_.CLEAR;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
procedure tLazExt_wndInspector_aFNcAFSE._LazarusIDE_SetUP__mode_autoExecute_;
begin
   _lair_nodes_wndInspector_.ownerEvent_onNodeAdd:=@_Event_wndNodes_ProjectAddNode_;
   _SourceEditor_onActivate_:=tIn0k_lazIdeSRC_SourceEditor_onActivate.Create;
   _SourceEditor_onActivate_.onEvent:=@_Event_SourceEditor_onActivate_;
   _SourceEditor_onActivate_.LazarusIDE_SetUP;
end;
{$endIf}

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
procedure tLazExt_wndInspector_aFNcAFSE._LazarusIDE_CLEAN__mode_autoExecute_;
begin
   _SourceEditor_onActivate_.onEvent:=nil;
   _SourceEditor_onActivate_.LazarusIDE_Clean;
   _SourceEditor_onActivate_.FREE;
   _SourceEditor_onActivate_:=nil;
end;
{$endIf}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}

{todo: а как же быть с переводом????}

const _cIdeCommand_NAME_='Find File in "Inspector"';
const _cIdeCommand_DESC_='Find current activ in source edit File in "Inspector" windows';

procedure tLazExt_wndInspector_aFNcAFSE._LazarusIDE_SetUP__mode_ideCommand_;
var Key:TIDEShortCut;
    Cat:TIDECommandCategory;
 {%H-}MyTool:TIDECommand;
begin
    Key   :=IDEShortCut(VK_F,[ssShift, ssAlt, ssCtrl],VK_UNKNOWN,[]);
    Cat   :=IDECommandList.FindCategoryByName(CommandCategoryToolMenuName);
    MyTool:=RegisterIDECommand(Cat, _cIdeCommand_NAME_,_cIdeCommand_DESC_, Key, @_Event_IdeCommand_Execute_,nil);
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_IdeMainMenu}
    // пункт меню В ГЛАВНОМ (Search)
    RegisterIDEMenuCommand(mnuSearch, _cIdeCommand_DESC_, _cIdeCommand_NAME_, nil, nil, MyTool);
    {$endIf}
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_SrcEditMenu}
    // пункт меню в редакторе исходного кода (по правой клавише)
    RegisterIDEMenuCommand(SrcEditMenuSectionFirstStatic,_cIdeCommand_DESC_, _cIdeCommand_NAME_, nil, nil, MyTool);
    {$endIf}
end;
{$endIf}

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
procedure tLazExt_wndInspector_aFNcAFSE._LazarusIDE_CLEAN__mode_ideCommand_;
begin
     // по ходу оно само все отписывается ...
end;
{$endIf}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_wndInspector_aFNcAFSE.LazarusIDE_OnIDEClose(Sender:TObject);
begin
    LazarusIDE_Clean;
end;

//------------------------------------------------------------------------------

// имя файла в ТЕКУЩЕМ активном окне редактора
function tLazExt_wndInspector_aFNcAFSE._fileName_fromActiveSourceEdit_:string;
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

{%region --- организация отложенного вызова -------------------- /fold }

// а вот почему я не захотел таймером пользоваться!? ... загадка (сам не помню)
//------------------------------------------------------------------------------
// По идее тут ВСЕ должно быть потокоБезопасно.
// Обеспечиваем это посредством `TThread.Synchronize(..)`.

{$ifDef _local___select_heldCall_}

{%region --- _THeldCallTHREAD_ ------------------------------------ /fold}

type
_THeldCallTHREAD_=class(TThread)
  private
   _owner_:tLazExt_wndInspector_aFNcAFSE;
  public
    Constructor Create(Owner:tLazExt_wndInspector_aFNcAFSE);
  protected
    procedure Execute; override;
  end;

Constructor _THeldCallTHREAD_.Create(Owner:tLazExt_wndInspector_aFNcAFSE);
begin
    inherited Create(true);
    FreeOnTerminate:=TRUE;
   _owner_:=Owner;
    Start;
end;

procedure _THeldCallTHREAD_.Execute;
begin
    repeat
        ThreadSwitch;
        try // собственно выполняем МЕТОД
           _owner_._heldCall_select_execute_;
            //Synchronize(@ _owner_._heldCall_execute_);
        except Terminate; end;
    until Terminated;
end;

{%endregion}

procedure tLazExt_wndInspector_aFNcAFSE._heldCall_execute_;
begin // call only `Synchronize(@_heldCall_execute_)`
    if GetTickCount64-_heldCall_timeST_<clazExt_wndInspector_aFNcAFSE__timeHeldCallForSelect then begin
        if Assigned(_heldCall_THREAD_) then _heldCall_THREAD_.Terminate;
       _heldCall_THREAD_:=nil;
       _heldCall_timeST_:=0;
        {$ifDef _debugLOG_}
        DEBUG('_select_', '>>>>>>>>>>>>>>>>>>>');
        {$endIf}
       _select_; //< собственно ВОТ он вызов моего кода :-)
    end;
end;

procedure tLazExt_wndInspector_aFNcAFSE._heldCall_doSetUp_;
begin // call only `Synchronize(@_heldCall_setUp_)`
   _heldCall_timeST_:=GetTickCount64;
    if not Assigned(_heldCall_THREAD_) then begin
       _heldCall_THREAD_:=_THeldCallTHREAD_.Create(self);
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFNcAFSE._heldCall_select_doSetUp_;
begin
    TThread.Synchronize(nil,@_heldCall_doSetUp_);
end;

procedure tLazExt_wndInspector_aFNcAFSE._heldCall_select_execute_;
begin
    TThread.Synchronize(nil,@_heldCall_execute_);
end;

{$endif}

{%endregion}

{%region --- перемещение окон по оси ZZZ ----------------------- /fold }

{$ifDef _local___wndZOrederMoving_}

const
  _cWndZOrederMoving_mode_0=0; // НЕТ никакого перемещения
   {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
  _cWndZOrederMoving_mode_1=1; // переместить на ПЕРВЫЙ план
   {$endIf}
   {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
  _cWndZOrederMoving_mode_2=2; // переместить на ВТОРОЙ план
   {$endIf}

procedure tLazExt_wndInspector_aFNcAFSE._wndZOrederMoving_mode_set_(const mode:byte);
begin
   _wndZOrederMoving_mode:=mode;
end;

procedure tLazExt_wndInspector_aFNcAFSE._wndZOrederMoving_OFF_;
begin
   _wndZOrederMoving_mode_set_(_cWndZOrederMoving_mode_0);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_wndInspector_aFNcAFSE._wndZOrederMoving_(const form:TCustomForm);
begin
    if Assigned(form) then begin
        case _wndZOrederMoving_mode of
        {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
          _cWndZOrederMoving_mode_1: form.BringToFront; // переместить на ПЕРВЫЙ план
        {$endIf}
        {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
          _cWndZOrederMoving_mode_2: In0k_lazIdeSRC___B2SP(form); // переместить на ВТОРОЙ
        {$endIf}
        end;
       _wndZOrederMoving_OFF_;// поработали и ладьненько ... хватит
    end;
end;

{$endIf}
{%endregion}

//------------------------------------------------------------------------------

// поиск в КОНКРЕТНОМ окне
function tLazExt_wndInspector_aFNcAFSE._select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):boolean;
var tmp:tLazExt_wndInspector_aFNcAFSE_wndNode;
begin
    result:=FALSE;
    tmp:=_lair_nodes_wndInspector_.Nodes_GET(Form,nodeTYPE);
    if Assigned(tmp) then begin //< перестраховка
        result:=tmp.Select(fileName);
        {$ifDef _local___wndZOrederMoving_}
        if result then begin //< если оно тут ... попробуем переместить окно
           _wndZOrederMoving_(Form)
        end;
        {$endIf}
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG('SKIP','do _select_inWindow_');
    end;
    {$endIf}
end;

// поиск файла во ВСЕХ окнах
function tLazExt_wndInspector_aFNcAFSE._select_inSCREEN_(const fileName:string):boolean;
var i:integer;
  tmp:tForm;
begin
    result:=false;
    if fileName<>'' then begin
        for i:=0 to Screen.FormCount-1 do begin
            tmp:=Screen.Forms[i];
            if tLazExt_wndInspector_aFNcAFSE_wndNode_ProjectInspector.OfMyType(tmp) then begin
                if _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFNcAFSE_wndNode_ProjectInspector)
                then result:=true;
            end
           else
            if tLazExt_wndInspector_aFNcAFSE_wndNode_PackageEditor.OfMyType(tmp) then begin
                if _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFNcAFSE_wndNode_PackageEditor)
                then result:=true;
            end;
        end;
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG('SKIP','do _select_inSCREEN_');
    end;
    {$endIf}
end;

function tLazExt_wndInspector_aFNcAFSE._select_:boolean;
begin // такое САМОЕ главное событие ... и такое короткое стало
    result:=_select_inSCREEN_(_fileName_fromActiveSourceEdit_);
end;

{$ifDef _local___select_heldCall_}
procedure tLazExt_wndInspector_aFNcAFSE._select_heldCall_;
begin
    //
    // зачем так сложно? источник проблем окно "Project Inspector"
    // # обновление идет ПОСЛЕ обновления "SourceEdit"
    // # в TreeView объекты сначала добавляются а потом "инициализируются"
    //
    // поэтому, даем возможность отработать алгоритмам, и тока потом приcтупаем
    // к нашим непосредственным задачам, надеясь что деятельность IDE закончена
    //
    // задержка задается константой `clazExt_wndInspector_aFNcAFSE__timeHeldCallForSelect`.
    // на моем компе достаточно задержки в 100мс.
    //
   _heldCall_select_doSetUp_;
end;
{$endIf}

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand}
procedure tLazExt_wndInspector_aFNcAFSE._Event_IdeCommand_Execute_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_IdeCommand_Execute_', '>>>');
    {$endIf}
    // тут ВСЕ выполняется из "ГЛАВНОГО" потока ... можно применить ПРЯМОЙ вызов
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_useBringToFront}
   _wndZOrederMoving_mode_set_(1);
    {$endIf}

    {$ifNDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_IdeCommand_shomMsgIfNotFOUND}
   _select_;
    {$else}
    if NOT _select_ then begin
        MessageDlg('Not found','File'+LineEnding+'"'+_fileName_fromActiveSourceEdit_+'"'+LineEnding+'NOT found in opened "Inspector" windows.',mtWarning,[mbOK],0);
    end;
    {$endIf}
end;
{$endIf}

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
procedure tLazExt_wndInspector_aFNcAFSE._Event_SourceEditor_onActivate_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_SourceEditor_onActivate_', '>>>');
    {$endIf}
    {$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute_useBringToSecondPlane}
   _wndZOrederMoving_mode_set_(2);
    {$endIf}
   _select_heldCall_;
end;
{$endIf}

{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___mode_AutoExecute}
procedure tLazExt_wndInspector_aFNcAFSE._Event_wndNodes_ProjectAddNode_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_wndNodes_ProjectAddNode_', '>>>');
    {$endIf}
   _select_heldCall_;
end;
{$endIf}

end.

