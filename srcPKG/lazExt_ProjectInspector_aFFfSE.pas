unit lazExt_ProjectInspector_aFFfSE;

{$mode objfpc}{$H+}

interface

{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
     ProjectIntf, LazIDEIntf,


     //in0k_lazarusIdeSRC_wndDEBUG,
     messages, Dialogs, Controls, ComCtrls,
     SrcEditorIntf, IDECommands,  TreeFilterEdit,
     in0k_lazIdeSRC_SourceEditor_onActivate,

     lazExt_wndInspector_aFFfSE_wndNode,
     lazExt_wndInspector_aFFfSE_wndNode_ProjectInspector,
     lazExt_wndInspector_aFFfSE_wndNode_PackageEditor,



     Classes, Forms;

type

 tLazExt_ProjectInspector_aFFfSE=class
  protected
   _SourceEditor_onActivate_:tIn0k_lazIdeSRC_SourceEditor_onActivate;
    procedure _SourceEditor_onActivate_EVENT_(Sender: TObject);
  protected
   _wndNodes_:tLazExt_wndInspector_aFFfSE_NodeLST;
  protected
    function  _getFileName_fromSourceEdit:string;
  protected
    procedure _select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
    procedure _select_inSCREEN_(const fileName:string);
  protected
    function _Event_ProjectChanged_(Sender:TObject; AProject:TLazProject):TModalResult;
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
   _wndNodes_:=tLazExt_wndInspector_aFFfSE_NodeLST.Create;
    //---
   _SourceEditor_onActivate_:=tIn0k_lazIdeSRC_SourceEditor_onActivate.Create;
   _SourceEditor_onActivate_.onEvent:=@_SourceEditor_onActivate_EVENT_;
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
   _SourceEditor_onActivate_.LazarusIDE_SetUP;
    LazarusIDE.AddHandlerOnIDEClose(@LazarusIDE_OnIDEClose);
    LazarusIDE.AddHandlerOnProjectOpened(@_Event_ProjectChanged_,TRUE);
end;

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_Clean;
begin
   _SourceEditor_onActivate_.LazarusIDE_Clean;
   _wndNodes_.CLEAR;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_OnIDEClose(Sender:TObject);
begin
    LazarusIDE_Clean;
end;


function tLazExt_ProjectInspector_aFFfSE._getFileName_fromSourceEdit:string;
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

procedure tLazExt_ProjectInspector_aFFfSE._SourceEditor_onActivate_EVENT_(Sender:TObject);
begin
    {$ifDef _debugLOG_}
    DEBUG('_SourceEditor_onActivate_', '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    {$endIf}
    if Assigned(tIn0k_lazIdeSRC_SourceEditor_onActivate(Sender).SourceEditor)
    then begin
       _select_inSCREEN_(tIn0k_lazIdeSRC_SourceEditor_onActivate(Sender).SourceEditor.FileName);
    end;
    {$ifDef _debugLOG_}
    DEBUG('_SourceEditor_onActivate_', '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
    {$endIf}
end;

function tLazExt_ProjectInspector_aFFfSE._Event_ProjectChanged_(Sender:TObject; AProject:TLazProject):TModalResult;
begin
    {$ifDef _debugLOG_}
    DEBUG('_Event_ProjectChanged_', '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    {$endIf}
    result:=mrOk;
   _select_inSCREEN_(_getFileName_fromSourceEdit);
    {$ifDef _debugLOG_}
    DEBUG('_Event_ProjectChanged_', '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
var tmp:tLazExt_wndInspector_aFFfSE_Node;
begin
    tmp:=_wndNodes_.Nodes_GET(Form,nodeTYPE);
    if Assigned(tmp) then begin //< перестраховка
        {$ifDef _debugLOG_}
        DEBUG('do SELECT', 'form'+addr2txt(Form)+' fileName:"'+fileName+'"');
        {$endIf}
        tmp.Select(fileName);
    end;
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

end.

