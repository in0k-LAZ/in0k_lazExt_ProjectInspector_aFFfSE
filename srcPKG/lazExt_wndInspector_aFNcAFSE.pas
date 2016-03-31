unit lazExt_wndInspector_aFNcAFSE;
//< Главный класс компонента-Расширения

{todo: описание и документация}

{$mode objfpc}{$H+}
interface
{%region --- описание НАСТРОЕК УРОВНЯ КОМПИЛЯЦИИ ----------------- /fold }
//-- ВНИМАНИЕ !!! это ТОЛЬКО список с оисанием !!! ---------------------------//
//   настройки могут БУДУТ ПЕРЕОПРЕДЕЛЕНЫ ниже при подключении                //
//   файла настроек "компонента-Расширения" (`in0k_lazExt_SETTINGs.inc`).     //
//----------------------------------------------------------------------------//

//--- # DebugLOG_mode --------------------------------------------------------//
// Режим логирования.
// В код включаются вызовы `DEBUG` с описанием текущих событий и состояний.
{$define in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
//------------------------------------------------------------------------------

{%endregion}
{%region --- ОЧИСТКА настроек перед конфигурацией ---------------- /fold }
{$unDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
{%endregion}
{$i in0k_lazExt_SETTINGs.inc} // КОНФИГУРАЦИЯ компонента-Расширения.
{%region --- применение настроек и доп.конфигурация -------------- /fold }
{$ifDef in0k_LazIdeEXT_wndInspector_aFNcAFSE___DebugLOG_mode}
    {$define _debugLOG_}//< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debugLOG_}
{$endIf}
{%endregion}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     Classes, Dialogs, Controls, Forms,
     ProjectIntf, LazIDEIntf, SrcEditorIntf, IDECommands,
     LCLIntf, //< это для GetTickCount64 в (Laz 1.4) {todo: обернуть в предКомпиляцию}
     //---
     in0k_lazIdeSRC_SourceEditor_onActivate,
     //---
     lazExt_wndInspector_aFNcAFSE_wndNode,
     lazExt_wndInspector_aFNcAFSE_wndNode_ProjectInspector,
     lazExt_wndInspector_aFNcAFSE_wndNode_PackageEditor;


CONST // ОЧЕНЬ ВАЖНАЯ константа, задержка (в мс) от события до начала выполнения
      // моих фокусов. На моей машине достаточно 100мс.
  clazExt_wndInspector_aFNcAFSE__timeHeldCallForSelect=100;
      // подробности см. `_select_heldCall_`.
      {todo: придумать, как избавиться от константы используя события дерева}
type

 tLazExt_wndInspector_aFNcAFSE=class
  {%region --- организация отложенного вызова -------------------- /fold }
  strict private
   _heldCall_THREAD_  :TThread;
   _heldCall_timeST_  :QWord;
    procedure _heldCall_doSetUp_;
    procedure _heldCall_execute_;
  private
    procedure _heldCall_select_execute_;
    procedure _heldCall_select_doSetUp_;
  {%endregion}
  protected
   _SourceEditor_onActivate_:tIn0k_lazIdeSRC_SourceEditor_onActivate;
   _lair_nodes_wndInspector_:tLazExt_wndInspector_aFFfSE_NodeLST;
  protected
    function  _fileName_fromActiveSourceEdit_:string;
  protected //< ОСНОВНАЯ часть ... суть
    procedure _select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
    procedure _select_inSCREEN_(const fileName:string);
    procedure _select_;          //< ПРЯМОЙ вызов
    procedure _select_heldCall_; //< ОТЛОЖЕННЫЙ вызов
  protected //< события, по которым надо что-то поделать
    procedure _Event_SourceEditor_onActivate_(Sender:TObject);
    procedure _Event_wndNodes_ProjectAddNode_(Sender:TObject);
  public
    constructor Create;
    destructor DESTROY; override;
  protected
    procedure LazarusIDE_OnIDEClose(Sender:TObject);
  public
    procedure LazarusIDE_SetUP;
    procedure LazarusIDE_Clean;
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
    _heldCall_THREAD_  :=nil;
    _heldCall_timeST_  :=0;
     //---
    _lair_nodes_wndInspector_:=tLazExt_wndInspector_aFFfSE_NodeLST.Create;
    _lair_nodes_wndInspector_.ownerEvent_onNodeAdd:=@_Event_wndNodes_ProjectAddNode_;
    _SourceEditor_onActivate_:=tIn0k_lazIdeSRC_SourceEditor_onActivate.Create;
end;

destructor tLazExt_wndInspector_aFNcAFSE.DESTROY;
begin
   _SourceEditor_onActivate_.FREE;
   _lair_nodes_wndInspector_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFNcAFSE.LazarusIDE_SetUP;
begin
   _lair_nodes_wndInspector_.CLEAR;
   _SourceEditor_onActivate_.onEvent:=@_Event_SourceEditor_onActivate_;
   _SourceEditor_onActivate_.LazarusIDE_SetUP;
    LazarusIDE.AddHandlerOnIDEClose(@LazarusIDE_OnIDEClose);
end;

procedure tLazExt_wndInspector_aFNcAFSE.LazarusIDE_Clean;
begin
   _SourceEditor_onActivate_.onEvent:=nil;
   _SourceEditor_onActivate_.LazarusIDE_Clean;
   _lair_nodes_wndInspector_.CLEAR;
end;

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

{%region --- организация отложенного вызова ---------------------- /fold }

// а вот почему я не захотел таймером пользоваться!? ... загадка (сам не помню)
//------------------------------------------------------------------------------
// По идее тут ВСЕ должно быть потокоБезопасно.
// Обеспечиваем это посредством `TThread.Synchronize(..)`.

{$region --- _THeldCallTHREAD_ ------------------------------------ /fold}

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

{$endregion}

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

{%endregion}

//------------------------------------------------------------------------------

// поиск в КОНКРЕТНОМ окне
procedure tLazExt_wndInspector_aFNcAFSE._select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
var tmp:tLazExt_wndInspector_aFNcAFSE_wndNode;
begin
    tmp:=_lair_nodes_wndInspector_.Nodes_GET(Form,nodeTYPE);
    if Assigned(tmp) then begin //< перестраховка
        tmp.Select(fileName);
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG('SKIP','do _select_inWindow_');
    end;
    {$endIf}
end;

// поиск файла во ВСЕХ окнах
procedure tLazExt_wndInspector_aFNcAFSE._select_inSCREEN_(const fileName:string);
var i:integer;
  tmp:tForm;
begin
    if fileName<>'' then begin
        for i:=0 to Screen.FormCount-1 do begin
            tmp:=Screen.Forms[i];
            if tLazExt_wndInspector_aFNcAFSE_wndNode_ProjectInspector.OfMyType(tmp) then begin
               _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFNcAFSE_wndNode_ProjectInspector)
            end
           else
            if tLazExt_wndInspector_aFNcAFSE_wndNode_PackageEditor.OfMyType(tmp) then begin
               _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFNcAFSE_wndNode_PackageEditor);
            end;
        end;
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG('SKIP','do _select_inSCREEN_');
    end;
    {$endIf}
end;

procedure tLazExt_wndInspector_aFNcAFSE._select_;
begin // такое САМОЕ главное событие ... и такое короткое стало
   _select_inSCREEN_(_fileName_fromActiveSourceEdit_);
end;

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

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFNcAFSE._Event_SourceEditor_onActivate_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_SourceEditor_onActivate_', '>>>');
    {$endIf}
   _select_heldCall_;
end;

procedure tLazExt_wndInspector_aFNcAFSE._Event_wndNodes_ProjectAddNode_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_wndNodes_ProjectAddNode_', '>>>');
    {$endIf}
   _select_heldCall_;
end;

end.

