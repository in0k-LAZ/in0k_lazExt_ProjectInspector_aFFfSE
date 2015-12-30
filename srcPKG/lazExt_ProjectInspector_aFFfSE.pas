unit lazExt_ProjectInspector_aFFfSE;

{$mode objfpc}{$H+}

interface

{$define _EventLOG_}

uses
     in0k_lazExt_DEBUG, messages, Dialogs, ComCtrls,
     SrcEditorIntf, IDECommands,  TreeFilterEdit,
     in0k_lazIdeSRC_SourceEditor_onActivate,

     lazExt_wndInspector_aFFfSE_node,
     lazExt_wndInspector_aFFfSE_nodeProjectInspector,
     lazExt_wndInspector_aFFfSE_nodePackageEditor,



     Classes, Forms;

type

 tLazExt_ProjectInspector_aFFfSE=class
  protected
   _SourceEditor_onActivate_:tIn0k_lazIdeSRC_SourceEditor_onActivate;
    procedure _SourceEditor_onActivate_EVENT_(Sender: TObject);
  protected
   _nodes_:TList;
    procedure _nodes_CLR;
    procedure _nodes_del_(const Form:tForm);
    function  _nodes_fnd_(const Form:tForm):tLazExt_wndInspector_aFFfSE_Node;
    function  _nodes_GET_(const Form:tForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
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

{$ifDEF _EventLOG_}
const
   _cPleaseReport_=
        LineEnding+
        'EN: Please report this error to the developer.'+LineEnding+
        'RU: Пожалуйста, сообщите об этой ошибке разработчику.'+
        LineEnding;
{$endIf}


constructor tLazExt_ProjectInspector_aFFfSE.Create;
begin
 {  {$ifDef _lazExt_aBTF_CodeExplorer_API_001_}
   _IDECommand_OpnCEV_:=NIL;
    {$endIf}
    {$ifDef _lazExt_aBTF_CodeExplorer_API_004_}
   _ide_Window_CEV_:=NIL;
    {$endIf}
   _ide_Window_SEW_:=NIL;  }

   _SourceEditor_onActivate_:=tIn0k_lazIdeSRC_SourceEditor_onActivate.Create;
   _SourceEditor_onActivate_.onEvent:=@_SourceEditor_onActivate_EVENT_;

   _nodes_:=TList.Create;
end;

destructor tLazExt_ProjectInspector_aFFfSE.DESTROY;
begin
   _nodes_CLR;
   _SourceEditor_onActivate_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_SetUP;
begin
   _SourceEditor_onActivate_.LazarusIDE_SetUP;
end;

procedure tLazExt_ProjectInspector_aFFfSE.LazarusIDE_Clean;
begin
   _SourceEditor_onActivate_.LazarusIDE_Clean;
   _nodes_CLR;
end;


//------------------------------------------------------------------------------



{function tLazExt_ProjectInspector_aFFfSE._wndOInsp_find_inFORM_(form:TCustomForm):tTreeView;
var i:integer;
begin
    result:=nil;
    if Assigned(form) then begin
        for i:=0 to form.ControlCount-1 do begin
            if (form.Controls[i] is TTreeView) and
               (form.Controls[i].Name=_c_TV_)
            then begin
                result:=TTreeView(form.Controls[i]);
                break;
            end;
        end;
    end;
    {$ifDEF _EventLOG_}
    if Assigned(result)
    then DEBUG('_wndOInsp_find_inFORM_','FOUND '+result.ClassName+addr2txt(result))
    else DEBUG('_wndOInsp_find_inFORM_','NOT found');
    {$endIf}
end; }

type

   TPENodeType = (
    penFile,
    penDependency
    );

   type
  TPkgFileType = (
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

TPENodeData = class(TTFENodeData)
public
  Typ: TPENodeType;
  Name: string; // file or package name
  Removed: boolean;
  FileType: TPkgFileType;
  Next: TPENodeData;
//   constructor Create(aTyp: TPENodeType; aName: string; aRemoved: boolean);
end;


{function tLazExt_ProjectInspector_aFFfSE._wndOInsp_find_inTreeView_(treeView:TTreeView; const fileName:string):pointer;
var tmp:TTreeNode;
    o: tObject;
begin
   result:=nil;
 //   tmp.GetNext;
   tmp:=treeView.Items.GetFirstNode;
   while Assigned(tmp) do begin
       //tmp.Text;
       DEBUG('node',tmp.Text);
       //o:= tmp.
       o:=TObject(tmp.Data);
       if Assigned(o) then begin
           DEBUG('node-',o.ClassName) ;
           if o is TFileNameItem then begin
                o:=TObject(TFileNameItem(o).Data);
                if Assigned(o) then begin
                    DEBUG('node=',o.ClassName) ;
                    if o.ClassName='TPENodeData' then begin
                        DEBUG('node+',TPENodeData(o).Name);
                        if TPENodeData(o).Name=fileName then begin
                            result:=tmp;
                            DEBUG('nodeFFFFFFFFFFF',TPENodeData(o).Name);
                            break;
                        end;

                    end;
                end;


       end;



       end;
       {|}

       //---
       tmp:=tmp.GetNext;
   end;
   //treeView.
   if Assigned(result) then begin
       treeView.BeginUpdate;
            treeView.ClearSelection();
            treeView.Selected:=TTreeNode(result);
           // treeView.
 //           treeView.Selected.EndEdit();
       treeView.EndUpdate;
//       TTreeNode(result).Focused:=TRUE;
//       treeView.Repaint;
       //treeView.Invalidate;
       //TTreeNode(result).
       //treeView;
       //treeView.ClearSelection();
       //treeView.Selected:=TTreeNode(result);
   end;


end;   }

(*

{%region --- Active SourceEditorWindow ---------------------------- /fold}

{Идея: отловить момент "выхода" из окна редактирования.
    Используем "грязны" метод: аля "сабКлассинг", заменяем на СОБСТВЕННУЮ
    реализацию событие `onDeactivate`.
}

// НАШЕ событие, при `onDeactivate` ActiveSrcWND
procedure tLazExt_ProjectInspector_aFFfSE._SEW_onDeactivate_myCustom(Sender:TObject);
begin
    {$ifDEF _EventLOG_}
    DEBUG('_SEW_onDeactivate_myCustom','--->>> Sender'+addr2txt(Sender));
    {$endIf}

    // отмечаем что ВЫШЛИ из окна
   _ide_Window_SEW_:=NIL;
   //_ideEvent_Editor_:=NIL;
    // восстановить событие `onDeactivate` на исходное, и выполнияем его
    if Assigned(Sender) then begin
        if Sender is TSourceEditorWindowInterface then begin
           _SEW_reStore_onDeactivate(tForm(Sender));
            with TSourceEditorWindowInterface(Sender) do begin
                if Assigned(OnDeactivate) then OnDeactivate(Sender);
                {$ifDEF _EventLOG_}
                DEBUG('OK','TSourceEditorWindowInterface('+addr2txt(sender)+').OnDeactivate executed');
                {$endIf}
            end;
        end
        else begin
            {$ifDEF _EventLOG_}
            DEBUG('ER','Sender is NOT TSourceEditorWindowInterface');
            {$endIf}
        end;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('ER','Sender==NIL');
        {$endIf}
    end;

    {$ifDEF _EventLOG_}
    DEBUG('_SEW_onDeactivate_myCustom','---<<<');
    {$endIf}
end;

//------------------------------------------------------------------------------

// ЗАМЕНЯЕМ `onDeactivate` на собственное
procedure tLazExt_ProjectInspector_aFFfSE._SEW_rePlace_onDeactivate(const wnd:tForm);
begin
    if Assigned(wnd) and (wnd.OnDeactivate<>@_SEW_onDeactivate_myCustom) then begin
       _ide_Window_SEW_onDeactivate_original:=wnd.OnDeactivate;
        wnd.OnDeactivate:=@_SEW_onDeactivate_myCustom;
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_rePlace_onDeactivate','rePALCE wnd'+addr2txt(wnd));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_rePlace_onDeactivate','SKIP wnd'+addr2txt(wnd));
        {$endIf}
    end
end;

// ВОСТАНАВЛИВАЕМ `onDeactivate` на то что было
procedure tLazExt_ProjectInspector_aFFfSE._SEW_reStore_onDeactivate(const wnd:tForm);
begin
    if Assigned(wnd) and (wnd.OnDeactivate=@_SEW_onDeactivate_myCustom) then begin
        wnd.OnDeactivate:=_ide_Window_SEW_onDeactivate_original;
       _ide_Window_SEW_onDeactivate_original:=NIL;
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_reStore_onDeactivate','wnd'+addr2txt(wnd));
        {$endIf}
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('_SEW_reStore_onDeactivate','SKIP wnd'+addr2txt(wnd));
        {$endIf}
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._SEW_SET(const wnd:TSourceEditorWindowInterface);
begin
    if wnd<>_ide_Window_SEW_ then begin
        if Assigned(_ide_Window_SEW_)
        then begin
           _SEW_reStore_onDeactivate(_ide_Window_SEW_);
            {$ifDEF _EventLOG_}
            DEBUG('ERROR','_SEW_SET inline var _ide_Window_SEW_<>NIL');
            ShowMessage('_SEW_SET inline var _ide_Window_SEW_<>NIL'+_cPleaseReport_);
            {$endIf}
        end;
       _SEW_rePlace_onDeactivate(wnd);
       _ide_Window_SEW_:=wnd;
    end;
end;

{%endRegion}

{%region --- IdeEVENT semEditorActivate --------------------------- /fold}

function  tLazExt_ProjectInspector_aFFfSE._ideEvent_DO_EVENT_:boolean;
var tmp     :pointer;
    srcEditor:TSourceEditorInterface;
    Filename:string;

begin      //< gjktpyfz yfuheprf
{   result:=true;
   {$ifDEF _EventLOG_}
   DEBUG('DO EVENT','-----');
   {$endIf}


    srcEditor:=SourceEditorManagerIntf.ActiveEditor;
    Filename:='';
    if Assigned(srcEditor) then begin
        Filename:=srcEditor.FileName;
    end;
    {$ifDEF _EventLOG_}
    DEBUG('Filename',Filename);
    {$endIf}

    tmp:=_select_inSCREEN_;
    if Assigned(tmp) then tmp:=_wndOInsp_find_inFORM_(tCustomForm(tmp));
    if Assigned(tmp) then tmp:=_wndOInsp_find_inTreeView_(TTreeView(tmp),Filename);
   //      }
end;

(*
// основное рабочее событие
procedure tLazExt_ProjectInspector_aFFfSE._ideEvent_exeEvent_;
var tmpSourceEditor:TSourceEditorInterface;
begin
    {*1> причины использования _ideEvent_Editor_
        механизм с приходится использовать из-за того, что
        при переключение "Вкладок Редактора Исходного Кода" вызов данного
        события происходит аж 3(три) раза. Используем только ПЕРВЫЙ вход.
        -----
        еще это событие происходит КОГДА идет навигация (прыжки по файлу)
    }
    if Assigned(SourceEditorManagerIntf) then begin //< запредельной толщины презерватив
        tmpSourceEditor:=SourceEditorManagerIntf.ActiveEditor;
        if Assigned(tmpSourceEditor) then begin //< чуть потоньше, но тоже толстоват
            if (tmpSourceEditor<>_ideEvent_Editor_) then begin
                // МОЖНО попробовать выполнить ПОЛЕЗНУЮ нагрузку
                if _ideEvent_DO_EVENT_
                then _ideEvent_Editor_:=tmpSourceEditor
                else _ideEvent_Editor_:=NIL;
            end
            else begin
                {$ifDEF _EventLOG_}
                DEBUG('SKIP','already processed');
                {$endIf}
            end;
        end
        else begin
           _ideEvent_Editor_:=nil;
            {$ifDEF _EventLOG_}
            DEBUG('ER','ActiveEditor is NULL');
            {$endIf}
        end;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('ER','IDE not ready');
        {$endIf}
    end;
end;*)

//------------------------------------------------------------------------------

(*
procedure tLazExt_ProjectInspector_aFFfSE._ideEvent_semEditorActivate(Sender:TObject);
begin
    {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semEditorActivate','--->>>'+' sender'+addr2txt(Sender));
    {$endIf}

    if assigned(_ide_Window_SEW_) //< запускаемся только если окно
    then _ideEvent_exeEvent_      //  редактирования в ФОКУСЕ
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('SKIP','ActiveSourceWindow is UNfocused');
        {$endIf}
    end;

    {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semEditorActivate','---<<<');
    {$endIf}
end;
*)
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_ProjectInspector_aFFfSE._onWindowFocused_ProjectInspector_(const Form:TForm);
begin
   ShowMessage((Form).ClassName+' '+(Form).Caption);
end;

procedure tLazExt_ProjectInspector_aFFfSE._onWindowFocused_PackageInspector_(const Form:TForm);
begin

end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_ProjectInspector_aFFfSE._ideEvent_semWindowFocused(Sender:TObject);
begin
    if Assigned(Sender) and (Sender is TForm) then begin //< перестраховка
        //if Sender.ClassNameIs(_c_TN_) then begin
        //   _onWindowFocused_ProjectInspector_(TForm(Sender));
        //end
        //else
        //ShowMessage(TForm(Sender).ClassName);
    end;





   { {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semWindowFocused','--->>>'+' sender'+addr2txt(Sender));
    {$endIf}

    if Assigned(Sender) and (Sender is TSourceEditorWindowInterface) then begin
       _SEW_SET(TSourceEditorWindowInterface(Sender));
        if Assigned(_ide_Window_SEW_) then begin
           _ideEvent_exeEvent_;
        end
        else begin
            {$ifDEF _EventLOG_}
            DEBUG('SKIP WITH ERROR','BIG ERROR: ower _ide_Window_SEW_ found');
            {$endIf}
        end;
    end
    else begin
        {$ifDEF _EventLOG_}
        DEBUG('SKIP','Sender undef');
        {$endIf}
    end;

    {$ifDEF _EventLOG_}
    DEBUG('ideEVENT:semWindowFocused','---<<<');
    {$endIf} }
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._ideEvent_register_;
begin
//    SourceEditorManagerIntf.RegisterChangeEvent(semWindowFocused,  @_ideEvent_semWindowFocused);
//    SourceEditorManagerIntf.RegisterChangeEvent(semEditorActivate, @_ideEvent_semEditorActivate);
end;

{%endRegion}

*)
//---------

{function tLazExt_ProjectInspector_aFFfSE._nodes_fnd_(const Form:tForm):integer;
var i:integer;
    d:pAFFfSE_Node;
begin
    result:=-1;
    for i:=0 to _nodes_.Count-1 do begin
        d:=pAFFfSE_Node(_nodes_.Items[i]);
        if Assigned(d) then begin
            if d^.Form=Form then begin
                result:=i;
                BREAK;
            end;
        end;
    end;
end;}


{procedure tLazExt_ProjectInspector_aFFfSE._fuckUp_Node_DST_(const Node:pAFFfSE_Node);
begin
    //---
    dispose(Node);
end;}


procedure tLazExt_ProjectInspector_aFFfSE._nodes_CLR;
var i:integer;
  tmp:tLazExt_wndInspector_aFFfSE_Node;
begin
    for i:=0 to _nodes_.Count-1 do begin
        tmp:=tLazExt_wndInspector_aFFfSE_Node(_nodes_.Items[i]);
        if Assigned(tmp) then begin
            _nodes_.Items[i]:=nil;
             tmp.Free;
        end;
    end;
   _nodes_.Clear;
end;

procedure tLazExt_ProjectInspector_aFFfSE._nodes_del_(const Form:tForm);
var i:integer;
  tmp:tLazExt_wndInspector_aFFfSE_Node;
begin
    for i:=0 to _nodes_.Count-1 do begin
        tmp:=tLazExt_wndInspector_aFFfSE_Node(_nodes_.Items[i]);
        if Assigned(tmp)and(tmp.Form=Form) then begin
           _nodes_.Delete(i);
            tmp.FuckUP_CLR;
            tmp.Free;
            BREAK;
        end;
    end;
end;

function tLazExt_ProjectInspector_aFFfSE._nodes_fnd_(const Form:tForm):tLazExt_wndInspector_aFFfSE_Node;
var i:integer;
  tmp:tLazExt_wndInspector_aFFfSE_Node;
begin
    result:=nil;
    for i:=0 to _nodes_.Count-1 do begin
        tmp:=tLazExt_wndInspector_aFFfSE_Node(_nodes_.Items[i]);
        if Assigned(tmp) then begin
            if tmp.Form=Form then begin
                result:=tmp;
                BREAK;
            end;
        end;
    end;
end;

function tLazExt_ProjectInspector_aFFfSE._nodes_GET_(const Form:tForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE):tLazExt_wndInspector_aFFfSE_Node;
begin
    result:=_nodes_fnd_(Form);
    if not Assigned(result) then begin
        result:=nodeTYPE.Create(Form);
        result.FuckUP_SET;
       _nodes_.Add(result);
    end;
end;


//------------------------------------------------------------------------------

{function tLazExt_ProjectInspector_aFFfSE._fuckUp_ProjectInspector_(const Form:TForm):pAFFfSE_Node;
begin
    result:=_nodes_fnd_(Form);
    if not Assigned(result) then begin
        result:=new(pAFFfSE_Node);
        result^.Form:=Form;
        result^.tFRM:=FT_ProjectInspector;
       _nodes_.Add(result);
        ShowMessage(Form.caption);
    end;
end;}


{function tLazExt_ProjectInspector_aFFfSE._fuckUp_PackageInspector_(const Form:TForm):pAFFfSE_Node;
begin
    result:=_nodes_fnd_(Form);
    if not Assigned(result) then begin
        result:=new(pAFFfSE_Node);
        result^.Form:=Form;
        result^.tFRM:=FT_PackageInspector;
       _nodes_.Add(result);
        ShowMessage(Form.caption);
    end;
end;}

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._select_inWindow_(const fileName:string; const Form:TForm; const nodeTYPE:tLazExt_wndInspector_aFFfSE_NodeTYPE);
var tmp:tLazExt_wndInspector_aFFfSE_Node;
begin
    tmp:=_nodes_GET_(Form,nodeTYPE);
    tmp.Select(fileName);
end;

procedure tLazExt_ProjectInspector_aFFfSE._select_inSCREEN_(const fileName:string);
var i:integer;
  tmp:tForm;
begin
    for i:=0 to Screen.FormCount-1 do begin
        tmp:=Screen.Forms[i];
        if lazExt_wndInspector_aFFfSE_nodeProjectInspector.Form_of_this_TYPE(tmp)
        then _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFFfSE_nodeProjectInspector)
       else
        if lazExt_wndInspector_aFFfSE_nodePackageEditor.Form_of_this_TYPE(tmp)
        then _select_inWindow_(fileName,tmp,tLazExt_wndInspector_aFFfSE_nodePackageEditor);
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._SourceEditor_onActivate_EVENT_(Sender:TObject);
begin
    if Assigned(tIn0k_lazIdeSRC_SourceEditor_onActivate(Sender).SourceEditor)
    then begin
       _select_inSCREEN_(tIn0k_lazIdeSRC_SourceEditor_onActivate(Sender).SourceEditor.FileName);
    end;
end;

end.

