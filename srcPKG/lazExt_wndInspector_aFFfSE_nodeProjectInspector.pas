unit lazExt_wndInspector_aFFfSE_nodeProjectInspector;

{$mode objfpc}{$H+}

interface

uses Forms, ComCtrls, TreeFilterEdit,
  LCLVersion,
  lazExt_wndInspector_aFFfSE_node;


const

 cLazExt_wndInspector_aFFfSE_nodeProjectInspector_classNAME='';

type

 tLazExt_wndInspector_aFFfSE_nodeProjectInspector=class(tLazExt_wndInspector_aFFfSE_Node)
  private
   _TV_:tTreeView;
  protected
    function _treeView_:tTreeView;
    function _treeNode_fnd_(const FileName:string):TTreeNode;

    //function _Select_(const FileName:string);
  public
    constructor Create(const aForm:tForm); override;
    procedure Select(const FileName:string); override;
  end;

function Form_of_this_TYPE(const Form:tForm):boolean;

implementation

const
 cFormClassName='TProjectInspectorForm';

 cCompNameName='ItemsTreeView';
// ItemsTreeView


function Form_of_this_TYPE(const Form:tForm):boolean;
begin
    result:=Form.ClassNameIs(cFormClassName);
end;

//==============================================================================


constructor tLazExt_wndInspector_aFFfSE_nodeProjectInspector.Create(const aForm:tForm);
begin
    inherited Create(aForm);
   _TV_:=nil;
end;

function tLazExt_wndInspector_aFFfSE_nodeProjectInspector._TreeView_:tTreeView;
var i:integer;
begin
    if not Assigned(_TV_) then begin
        if Assigned(_frm_) then begin
            for i:=0 to _frm_.ControlCount-1 do begin
                  if (form.Controls[i] is TTreeView) and
                     (form.Controls[i].Name=cCompNameName)
                  then begin
                      _TV_:=TTreeView(form.Controls[i]);
                      break;
                  end;
            end;
        end;
    end;
    //---
    result:=_TV_;
end;

{%region --- FuckUP lazarusSRC --- /fold ---------------}


{$if lcl_fullversion = 1060001 }
    {$define fuckUp_01}
{$else}
    {$hint 'NOT Tested in this LazarusIDE version'}
    {$define fuckUp_01}
{$endif}


{%region --- fuckUp_01 --- /fold}
{$ifDef fuckUp_01}{$hint 'lazExt_wndInspector_aFFfSE_nodeProjectInspector use FuckUP_01'}

// "lazDIR"\packager\PackageEditor.pas

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

{$endIf}
{%endregion}




{%endregion}


function tLazExt_wndInspector_aFFfSE_nodeProjectInspector._treeNode_fnd_(const FileName:string):TTreeNode;
var tmp:tObject;
begin
    result:=nil;
    if Assigned(_TreeView_) then begin
        result:=_TreeView_.Items.GetFirstNode;
        while Assigned(result) do begin
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
end;


procedure tLazExt_wndInspector_aFFfSE_nodeProjectInspector.Select(const FileName:string);
var _treeNode_:TTreeNode;
begin
    if (not Assigned(_TreeView_)) or (FileName='') then _treeNode_:=nil
    else _treeNode_:=_treeNode_fnd_(FileName);
    //---
    if Assigned(_treeView_) and Assigned(_treeNode_) then begin
        with _treeView_ do begin
            BeginUpdate;
            ClearSelection();
            Selected:=_treeNode_;
            EndUpdate;
        end;
    end;
end;

end.

