unit in0k_lazExt_DEBUG;

{$mode objfpc}{$H+}

interface

uses MenuIntf, Controls, IDEWindowIntf,  Dialogs,
  SysUtils, Forms, StdCtrls, ActnList, Classes;


type

  pMethod=^tMethod;

  Twnd_in0kLazExt_DEBUG = class(TForm)
    a_StayOnTop: TAction;
    a_Clear: TAction;
    a_Save: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    procedure a_ClearExecute(Sender: TObject);
    procedure a_StayOnTopExecute(Sender: TObject);
    procedure a_StayOnTopUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  public
    procedure Message(const TextMSG:string);
    procedure Message(const msgTYPE,msgTEXT:string);
  end;

procedure RegisterInIdeLAZARUS;
procedure DEBUG_window_SHOW;

procedure DEBUG(const msgTYPE,msgTEXT:string);
procedure DEBUG(const         msgTEXT:string);

function  addr2str(const p:pointer):string; inline;
function  addr2txt(const p:pointer):string; inline;
function  mthd2txt(const p:pMethod):string; inline;



{$ifNdef ASSERTIONS}
procedure Assert(const B:boolean; const T:string);
{$endIf}
implementation
{$ifNdef ASSERTIONS}
procedure Assert(const B:boolean; const T:string);
begin
    if not B then MessageDlg('lazExt_ProjectInspecrot_aFFfSE ASSERT',T,mtWarning,[mbOK],0);
end;
{$endIf}

const _c_WndDBG_Caption_='[eventLog] lazExt_ProjectInspecrot_aFFfSE';

//==============================================================================

{%region --- for IDE lazarus -------------------------------------- /fold}

procedure _onClickIdeMenuItem_(Sender: TObject);
begin
    DEBUG_window_SHOW;
end;

procedure RegisterInIdeLAZARUS;
begin
    RegisterIDEMenuCommand(itmViewIDEInternalsWindows, _c_WndDBG_Caption_,_c_WndDBG_Caption_,nil,@_onClickIdeMenuItem_);
end;

{%endregion}

{%region --- local INSTANCE  -------------------------------------- /fold}

var _WndDBG_:Twnd_in0kLazExt_DEBUG;

procedure DEBUG_window_SHOW;
begin
    if not Assigned(_WndDBG_) then _WndDBG_:=Twnd_in0kLazExt_DEBUG.Create(Application);
    IDEWindowCreators.ShowForm(_WndDBG_,true);
end;

procedure DEBUG(const msgTYPE,msgTEXT:string);
begin
    if Assigned(_WndDBG_) then _WndDBG_.Message(msgTYPE,msgTEXT);
end;

procedure DEBUG(const msgTEXT:string);
begin
    if Assigned(_WndDBG_) then _WndDBG_.Message(msgTEXT);
end;

{%endregion}

{%region --- Pointer to TEXT -------------------------------------- /fold}

function addr2str(const p:pointer):string;
begin
    result:=IntToHex({%H-}PtrUint(p),sizeOf(PtrUint)*2);
end;

const _c_addr2txt_SMB_='$';
const _c_addr2txt_DVT_=':';

function addr2txt(const p:pointer):string;
begin
    result:=_c_addr2txt_SMB_+addr2str(p);
end;

function mthd2txt(const p:pMethod):string;
begin
    result:=_c_addr2txt_SMB_+addr2str(p^.Code)+_c_addr2txt_DVT_+addr2str(p^.Data)
end;

{%endregion}

//==============================================================================

{$R *.lfm}

procedure Twnd_in0kLazExt_DEBUG.FormClose(Sender:TObject; var CloseAction:TCloseAction);
begin
    CloseAction:=caFree;
   _WndDBG_:=NIL;
end;

procedure Twnd_in0kLazExt_DEBUG.FormCreate(Sender: TObject);
begin
    Caption  :=_c_WndDBG_Caption_;
    FormStyle:=fsStayOnTop;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure Twnd_in0kLazExt_DEBUG.a_ClearExecute(Sender: TObject);
begin
    memo1.Clear;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure Twnd_in0kLazExt_DEBUG.a_StayOnTopExecute(Sender: TObject);
begin
    if self.FormStyle=fsStayOnTop then self.FormStyle:=fsNormal
    else self.FormStyle:=fsStayOnTop;
end;

procedure Twnd_in0kLazExt_DEBUG.a_StayOnTopUpdate(Sender: TObject);
begin // ????
    tAction(Sender).Checked:=(self.FormStyle=fsStayOnTop);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const
  _c_bOPN_='[';
  _c_bCLS_=']';
  _c_PRBL_=' '; //< ^-) изменить имя

procedure Twnd_in0kLazExt_DEBUG.Message(const TextMSG:string);
var tmp:string;
begin
    DateTimeToString(tmp,'hh:mm:ss`zzz',now);
    with memo1 do begin
        Lines.Insert(0,tmp+_c_PRBL_+TextMSG);
        SelLength:=0;
        SelStart :=0;
    end;
end;

procedure Twnd_in0kLazExt_DEBUG.Message(const msgTYPE,msgTEXT:string);
begin
    if msgTYPE<>''
    then Message(_c_bOPN_+msgTYPE+_c_bCLS_+_c_PRBL_+msgTEXT)
    else Message(                                   msgTEXT);
end;

initialization
 _WndDBG_:=nil;
finalization
 _WndDBG_.Free;
end.

