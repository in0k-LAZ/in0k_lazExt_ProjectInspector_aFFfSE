unit lazExt_wndInspector_aFFfSE_node;

{$mode objfpc}{$H+}

interface

uses Forms, Dialogs,
  Classes, SysUtils;


type

 tLazExt_wndInspector_aFFfSE_Node=class
  protected
   _frm_:tForm; //< окно, которое мы обрабатываем
  public
    constructor Create(const aForm:tForm); virtual;
  public
    property Form:tForm read _frm_;
  public
    procedure FuckUP_SET; virtual;
    procedure FuckUP_CLR; virtual;
  public
    procedure Select(const FileName:string); virtual;
    procedure reStore_EXPAND; virtual;
  end;

 tLazExt_wndInspector_aFFfSE_NodeTYPE=class of tLazExt_wndInspector_aFFfSE_Node;

implementation

constructor tLazExt_wndInspector_aFFfSE_Node.Create(const aForm:tForm);
begin
   _frm_:=aForm;
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_SET;
begin
    ShowMessage('FuckUP_SET');
end;

procedure tLazExt_wndInspector_aFFfSE_Node.FuckUP_CLR;
begin
    ShowMessage('FuckUP_CLR');
end;

procedure tLazExt_wndInspector_aFFfSE_Node.Select(const FileName:string);
begin
   // ShowMessage('Select '+form.Caption+' '+FileName);
end;

procedure tLazExt_wndInspector_aFFfSE_Node.reStore_EXPAND;
begin
    //
end;

end.

