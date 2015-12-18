unit lazExt_ProjectInspector_aFFfSE;

{$mode objfpc}{$H+}

interface

{$define _EventLOG_}

uses in0k_lazExt_DEBUG, messages, Dialogs, ComCtrls,
     SrcEditorIntf, IDECommands,  TreeFilterEdit,
     Classes, Forms;

type




 tLazExt_ProjectInspector_aFFfSE=class
  function _wndOInsp_find_inSCREEN_:TCustomForm;
  function _wndOInsp_find_inFORM_(form:TCustomForm):TTreeView;
  function _wndOInsp_find_inTreeView_(treeView:TTreeView; const fileName:string):pointer;

  {%region --- Active SourceEditorWindow -------------------------- /fold}
   protected
    _ide_Window_SEW_:TSourceEditorWindowInterface; //< текущee АКТИВНОЕ окно редактирования
    _ide_Window_SEW_onDeactivate_original:TNotifyEvent;    //< его событие
     procedure _SEW_onDeactivate_myCustom(Sender:TObject); //< моя подстава
     procedure _SEW_rePlace_onDeactivate(const wnd:tForm);
     procedure _SEW_reStore_onDeactivate(const wnd:tForm);
   private
     procedure _SEW_SET(const wnd:TSourceEditorWindowInterface);
   {%endRegion}
  {%region --- IdeEVENT ------------------------------------------- /fold}
   strict private //< обработка событий
     function  _ideEvent_DO_EVENT_:boolean;
   strict private //< обработка событий
    _ideEvent_Editor_:TSourceEditorInterface;
     procedure _ideEvent_exeEvent_;
     procedure _ideEvent_semEditorActivate(Sender:TObject);
     procedure _ideEvent_semWindowFocused (Sender:TObject);
   strict private //< регистрация событий
     procedure _ideEvent_register_;
   {%endRegion}
  public
    constructor Create;
    destructor DESTROY; override;
  public
    procedure RegisterInIdeLAZARUS;
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
end;

destructor tLazExt_ProjectInspector_aFFfSE.DESTROY;
begin
    inherited;
end;

procedure tLazExt_ProjectInspector_aFFfSE.RegisterInIdeLAZARUS;
begin
   _ideEvent_register_;
end;

//------------------------------------------------------------------------------

const //< тут возможно придется определять относительно ВЕРСИИ ЛАЗАРУСА
 _c_TN_='TProjectInspectorForm';
 _c_TV_='ItemsTreeView';


//  _cOInsp_ObjectInspector_TFormClass_=TObjectInspectorDlg;

// исчем экземпляр окна в массиве Screen.Forms
//  поиск по типу!
function tLazExt_ProjectInspector_aFFfSE._wndOInsp_find_inSCREEN_:TCustomForm;
var i:integer;
begin
    result:=nil;
    for i:=0 to Screen.FormCount-1 do begin
        if Screen.Forms[i].ClassName =  _c_TN_ then begin
            result:=Screen.Forms[i];
            break;
        end;
    end;
    {$ifDEF _EventLOG_}
    if Assigned(result)
    then DEBUG('_wndOInsp_find_inSCREEN_','FOUND '+result.ClassName+addr2txt(result))
    else DEBUG('_wndOInsp_find_inSCREEN_','NOT found');
    {$endIf}
end;

function tLazExt_ProjectInspector_aFFfSE._wndOInsp_find_inFORM_(form:TCustomForm):tTreeView;
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
end;

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


function tLazExt_ProjectInspector_aFFfSE._wndOInsp_find_inTreeView_(treeView:TTreeView; const fileName:string):pointer;
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


end;

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
   _ideEvent_Editor_:=NIL;
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
   result:=true;
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

    tmp:=_wndOInsp_find_inSCREEN_;
    if Assigned(tmp) then tmp:=_wndOInsp_find_inFORM_(tCustomForm(tmp));
    if Assigned(tmp) then tmp:=_wndOInsp_find_inTreeView_(TTreeView(tmp),Filename);
   //
end;

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
end;

//------------------------------------------------------------------------------

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

procedure tLazExt_ProjectInspector_aFFfSE._ideEvent_semWindowFocused(Sender:TObject);
begin
    {$ifDEF _EventLOG_}
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
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tLazExt_ProjectInspector_aFFfSE._ideEvent_register_;
begin
    SourceEditorManagerIntf.RegisterChangeEvent(semWindowFocused,  @_ideEvent_semWindowFocused);
    SourceEditorManagerIntf.RegisterChangeEvent(semEditorActivate, @_ideEvent_semEditorActivate);
end;

{%endRegion}


end.

