unit lazExt_ProjectInspector_aFFfSE;

{$mode objfpc}{$H+}

interface
{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}

uses Classes, Dialogs, Controls, Forms,
     {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     ProjectIntf, LazIDEIntf, SrcEditorIntf, IDECommands,
     LCLIntf, //< это для GetTickCount64
     //---
     in0k_lazIdeSRC_SourceEditor_onActivate,
     //---

     lazExt_wndInspector_aFFfSE_wndNode,
     lazExt_wndInspector_aFFfSE_wndNode_ProjectInspector,
     lazExt_wndInspector_aFFfSE_wndNode_PackageEditor;

type

 tLazExt_ProjectInspector_aFFfSE=class
  private
   _heldCall_THREAD_  :TThread;
   _heldCall_timeST_  :QWord;
    procedure _heldCall_execute_;
    procedure _heldCall_setUp_;
  protected
   _SourceEditor_onActivate_:tIn0k_lazIdeSRC_SourceEditor_onActivate;
  protected
   _wndNodes_:tLazExt_wndInspector_aFFfSE_NodeLST;
  protected
    function  _fileName_fromActiveSourceEdit_:string;
  protected //< ОСНОВНАЯ часть ... суть
    procedure _select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
    procedure _select_inSCREEN_(const fileName:string);
    procedure _select_;
    procedure _select_heldCall_;
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

constructor tLazExt_ProjectInspector_aFFfSE.Create;
begin
    _heldCall_THREAD_  :=nil;
    _heldCall_timeST_  :=0;

    _wndNodes_:=tLazExt_wndInspector_aFFfSE_NodeLST.Create;
    //---
   _SourceEditor_onActivate_:=tIn0k_lazIdeSRC_SourceEditor_onActivate.Create;
end;

destructor tLazExt_ProjectInspector_aFFfSE.DESTROY;
begin
   _SourceEditor_onActivate_.FREE;
   _wndNodes_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_SetUP;
begin
   _wndNodes_.CLEAR;
   _SourceEditor_onActivate_.onEvent:=@_Event_SourceEditor_onActivate_;
   _SourceEditor_onActivate_.LazarusIDE_SetUP;
    LazarusIDE.AddHandlerOnIDEClose(@LazarusIDE_OnIDEClose);
end;

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_Clean;
begin
   _SourceEditor_onActivate_.onEvent:=nil;
   _SourceEditor_onActivate_.LazarusIDE_Clean;
   _wndNodes_.CLEAR;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_OnIDEClose(Sender:TObject);
begin
    LazarusIDE_Clean;
end;

//------------------------------------------------------------------------------

function tLazExt_ProjectInspector_aFFfSE._fileName_fromActiveSourceEdit_:string;
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

procedure tLazExt_ProjectInspector_aFFfSE._select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
var tmp:tLazExt_wndInspector_aFFfSE_Node;
begin
    tmp:=_wndNodes_.Nodes_GET(Form,nodeTYPE);
    if Assigned(tmp) then begin //< перестраховка
        {todo: шлифануть}
        tmp.onAddition:=@_Event_wndNodes_ProjectAddNode_; //< по идее не тут место, но куда лучше воткнуть ... устал думать на сегодня
        tmp.Select(fileName);
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG('do _select_inWindow_', 'SKIP');
    end;
    {$endIf}
end;

procedure tLazExt_ProjectInspector_aFFfSE._select_inSCREEN_(const fileName:string);
var i:integer;
  tmp:tForm;
begin
    if fileName<>'' then begin
        for i:=0 to Screen.FormCount-1 do begin
            tmp:=Screen.Forms[i];
            if tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.OfMyType(tmp)
            then _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector)
           else
            if tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor.OfMyType(tmp)
            then _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor);
        end;
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG('do _select_inSCREEN_', 'SKIP');
    end;
    {$endIf}
end;

procedure tLazExt_ProjectInspector_aFFfSE._select_;
var fileName:string;
begin
    fileName:=_fileName_fromActiveSourceEdit_;
    if fileName<>'' then _select_inSCREEN_(fileName);
end;

procedure tLazExt_ProjectInspector_aFFfSE._select_heldCall_;
begin
    //
    // зачем так сложно? источник проблем окно "Project Inspector"
    // # обновление идет ПОСЛЕ обновления "SourceEdit"
    // # в TreeView объекты сначала добавляются а потом "инициализируются"
    //
    // поэтому, даем возможность отработать алгоритмам, и тока потом приcтупаем
    // к нашим непосредственным задачам, надеясь что деятельность IDE закончена
    //
    TThread.Synchronize(nil,@_heldCall_setUp_);
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._Event_SourceEditor_onActivate_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_SourceEditor_onActivate_', '>>>');
    {$endIf}
    if Assigned(tIn0k_lazIdeSRC_SourceEditor_onActivate(Sender).SourceEditor)
    then begin
        _select_heldCall_;
    end;
end;

procedure tLazExt_ProjectInspector_aFFfSE._Event_wndNodes_ProjectAddNode_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_wndNodes_ProjectAddNode_', '>>>');
    {$endIf}
   _select_heldCall_;
end;

//------------------------------------------------------------------------------

{$region --- _THeldCallTHREAD_ ------------------------------------ /fold}

type
_THeldCallTHREAD_=class(TThread)
  private
   _owner_:tLazExt_ProjectInspector_aFFfSE;
  public
    Constructor Create(Owner:tLazExt_ProjectInspector_aFFfSE);
  protected
    procedure Execute; override;
  end;

Constructor _THeldCallTHREAD_.Create(Owner:tLazExt_ProjectInspector_aFFfSE);
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
            Synchronize(@ _owner_._heldCall_execute_);
            // какая-то странная и по ходу излишняя перестраховка
            if _owner_._heldCall_THREAD_<>self then Terminate;
        except Terminate; end;
    until Terminated;
end;

{$endregion}

//GetTickCount

procedure tLazExt_ProjectInspector_aFFfSE._heldCall_execute_;
begin // call only `Synchronize(@_heldCall_execute_)`
    if GetTickCount64-_heldCall_timeST_<100 then begin
        if Assigned(_heldCall_THREAD_) then _heldCall_THREAD_.Terminate;
       _heldCall_THREAD_:=nil;
       _heldCall_timeST_:=0;
       _select_;
    end;
end;

procedure tLazExt_ProjectInspector_aFFfSE._heldCall_setUp_;
begin // call only `Synchronize(@_heldCall_setUp_)`
   _heldCall_timeST_:=GetTickCount64;
    if not Assigned(_heldCall_THREAD_) then begin
       _heldCall_THREAD_:=_THeldCallTHREAD_.Create(self);
    end;
end;

end.

