unit lazExt_wndInspector_aFFfSE_wndNode_ProjectInspector;

{$mode objfpc}{$H+}

interface
{$I in0k_lazExt_SETTINGs.inc}
{$ifDef lazExt_ProjectInspector_aFFfSE__EventLOG_mode}
    {$define _debugLOG_}
{$endIf}

uses {$ifDef _debugLOG_}in0k_lazExt_DEBUG,{$endIf}
    Forms, ComCtrls, TreeFilterEdit,
  LCLVersion,
  lazExt_wndInspector_aFFfSE_wndNode;


const

 cLazExt_wndInspector_aFFfSE_nodeProjectInspector_classNAME='';

type

 tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector=class(tLazExt_wndInspector_aFFfSE_Node)
  protected
    function  treeView_find  (const Owner:TCustomForm):tTreeView;                      override;
    function  treeNode_NAME  (const Owner:tTreeView; const treeNode:TTreeNode):string; override;
  private
   _onAddition_old_:TTVExpandedEvent;
    procedure _onAddition_new_(Sender: TObject; Node: TTreeNode);
  public
    class function OfMyType(const testForm:TCustomForm):boolean; override;
  public
    procedure FuckUP_SET; override;
    procedure FuckUP_CLR; override;
  public
    //procedure Select(const FileName:string); override;
  end;

implementation

const
 cFormClassName='TProjectInspectorForm';

 cCompNameName='ItemsTreeView';
// ItemsTreeView

//------------------------------------------------------------------------------

class function tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.OfMyType(const testForm:TCustomForm):boolean;
begin
    result:=testForm.ClassNameIs(cFormClassName);
end;

//------------------------------------------------------------------------------

procedure tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.FuckUP_SET;
begin
    inherited;
    if Assigned(_treeView_) then begin
        _onAddition_old_     :=_treeView_.OnAddition;
        _treeView_.OnAddition:=@_onAddition_new_;
    end;
end;

procedure tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.FuckUP_CLR;
begin
    if Assigned(_treeView_) then begin
        _treeView_.OnAddition:=_onAddition_old_;
    end;
    inherited;
end;

//------------------------------------------------------------------------------

function tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.treeView_find(const Owner:TCustomForm):tTreeView;
var i:integer;
begin //< тупо идем по ВСЕМ контролам в форме ... и исчем по имени (((
    result:=nil;
    for i:=0 to Form.ControlCount-1 do begin
        if (form.Controls[i] is TTreeView) and
           (form.Controls[i].Name=cCompNameName)
        then begin
            result:=TTreeView(form.Controls[i]);
            break;
        end;
    end;
end;




{%region --- FuckUP lazarusSRC --- /fold ---------------}

{$if lcl_fullversion = 1060001 }
    {$define fuckUp_01}
{$else}
    {$WARNING 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_01}
{$endif}

{%region --- fuckUp_01 --- /fold}
{$ifDef fuckUp_01}{$note 'tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector use FuckUP_01'}
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

{function tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector._treeNode_fnd_(const FileName:string):TTreeNode;
var tmp:tObject;
begin
    {$ifDef _debugLOG_}
    DEBUG('_treeNode_fnd_','--->');
    {$endIf}
    result:=nil;
    if Assigned(_TreeView_) then begin
        result:=_TreeView_.Items.GetFirstNode;
        while Assigned(result) do begin
            {$ifDef _debugLOG_}
            DEBUG('nodeText='+result.Text);
            {$endIf}
            tmp:=TObject(result.Data);
            if Assigned(tmp) then begin
                if tmp is TFileNameItem then begin
                    tmp:=TObject(TFileNameItem(tmp).Data);
                    if Assigned(tmp) then begin
                        if tmp.ClassName='TPENodeData' then begin
                            if _TPENodeData_(tmp).Name=fileName then begin
                                break;
                            end;
                        end;
                    end;
                end;
            end;
            result:=result.GetNext;
        end;
    end;
    {$ifDef _debugLOG_}
    DEBUG('_treeNode_fnd_','<---'+addr2txt(result));
    {$endIf}
end;}

function tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.treeNode_NAME(const Owner:tTreeView; const treeNode:TTreeNode):string;
var tmp:tObject;
begin
    result:=inherited;
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

{%endregion}

{procedure tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector.Select(const FileName:string);
var _treeNode_:TTreeNode;
begin
    if (not Assigned(_TreeView_)) or (FileName='') then _treeNode_:=nil
    else _treeNode_:=_treeNode_fnd_(FileName);
    //---
   _treeView_select_(_treeView_,_treeNode_);
{    if Assigned(_treeView_) and Assigned(_treeNode_) then begin
        with _treeView_ do begin
            BeginUpdate;
            ClearSelection();
            Selected:=_treeNode_;
            EndUpdate;
        end;
    end; }
end;}


procedure tLazExt_wndInspector_aFFfSE_wndNode_ProjectInspector._onAddition_new_(Sender: TObject; Node: TTreeNode);
begin
    DEBUG('_onAddition_new_',Node.Text);
    //---
    if Assigned(_onAddition_old_) then _onAddition_old_(Sender,Node);
    //---
    if Assigned(_treeView_) and Assigned(Node) then begin
        DEBUG('_onAddition_new_ CMP',fileName_inSE+' '+treeNode_NAME(_treeView_,Node));
        if fileName_inSE=treeNode_NAME(_treeView_,Node) then begin
           _do_treeView_select_(Node);
        end;
    end;
end;

end.

