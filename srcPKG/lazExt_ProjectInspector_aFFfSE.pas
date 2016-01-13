unit lazExt_ProjectInspector_aFFfSE;

{$mode objfpc}{$H+}

interface

{$define _EventLOG_}

uses
     in0k_lazExt_DEBUG, messages, Dialogs, ComCtrls,
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
    procedure _select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
    procedure _select_inSCREEN_(const fileName:string);
  public
    constructor Create;
    destructor DESTROY; override;
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
end;

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_Clean;
begin
   _SourceEditor_onActivate_.LazarusIDE_Clean;
   _wndNodes_.CLEAR;
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._SourceEditor_onActivate_EVENT_(Sender:TObject);
begin
    if Assigned(tIn0k_lazIdeSRC_SourceEditor_onActivate(Sender).SourceEditor)
    then begin
       _select_inSCREEN_(tIn0k_lazIdeSRC_SourceEditor_onActivate(Sender).SourceEditor.FileName);
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
var tmp:tLazExt_wndInspector_aFFfSE_Node;
begin
    tmp:=_wndNodes_.Nodes_GET(Form,nodeTYPE);
    if Assigned(tmp) then begin //< перестраховка
        tmp.Select(fileName);
    end;
end;

procedure tLazExt_ProjectInspector_aFFfSE._select_inSCREEN_(const fileName:string);
var i:integer;
  tmp:tForm;
begin
    for i:=0 to Screen.FormCount-1 do begin
        tmp:=Screen.Forms[i];
        if tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.OfMyType(tmp)
        then _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector)
       else
        if tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor.OfMyType(tmp)
        then _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFFfSE_wndNode_PackageEditor);
    end;
end;

end.

