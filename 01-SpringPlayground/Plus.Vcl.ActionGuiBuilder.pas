unit Plus.Vcl.ActionGuiBuilder;

interface

uses
  System.Classes,
  System.Actions,
  System.Generics.Collections,
  Vcl.ActnList,
  Vcl.Controls;

type
  TActionsArray = array of TContainedAction;

  TActionGuiBuilder = class(TComponent)
  private
    FActions: TList<TContainedAction>;
  protected
    procedure GuardCheckProperties; virtual;
    procedure DoBuildButtonsAlignedTop(aParent: TWinControl); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddActions(aActions: TActionsArray) overload;
    procedure AddActions(aActionList: TActionList) overload;
    procedure BuildButtons(aParent: TWinControl);
    class procedure BuildButtonsOnActionList (const aParent: TWinControl; const aActionList: TActionList);
  end;

implementation

uses
  System.SysUtils,
  Vcl.StdCtrls;  // TButton

resourcestring
  SActionListIsRequired = 'Action list is required. Please provide it' +
    ' through TActionGuiBuilder.SetActions method';

{ TActionGuiBuilder }

constructor TActionGuiBuilder.Create(aOwner: TComponent);
begin
  inherited;
  FActions := TList<TContainedAction>.Create;
end;

destructor TActionGuiBuilder.Destroy;
begin
  FActions.Free;
  inherited;
end;

procedure TActionGuiBuilder.AddActions(aActions: TActionsArray);
var
  i: Integer;
begin
  FActions.Clear;
  FActions.Count := Length(aActions);
  for i := 0 to FActions.Count - 1 do
    FActions[i] := aActions[i];
end;

procedure TActionGuiBuilder.AddActions(aActionList: TActionList);
var
  i: Integer;
begin
  FActions.Clear;
  FActions.Count := aActionList.ActionCount;
  for i := 0 to FActions.Count - 1 do
    FActions[i] := aActionList.Actions[i];
end;

procedure TActionGuiBuilder.GuardCheckProperties;
begin
  if FActions = nil then
    raise System.SysUtils.EArgumentNilException.Create(SActionListIsRequired);
end;

procedure TActionGuiBuilder.DoBuildButtonsAlignedTop(aParent: TWinControl);
var
  aAction: TContainedAction;
  aTop: Integer;
begin
  // TODO: aTop :=  max(Control[i].Top) + 32
  // TODO: 32 - magic number
  // author: @bogdanpolak
  //  * Dodaj sprawdzenie maksymalnej wartoœci Top wczeœniej dodanych
  //    kontrolek do aParent
  //  * Czy 32 wystarczy?
  // TODO: High DPI support
  // author: @bogdanpolak
  //  * Uwaga! High DPI support - wymaga uruchomienia DoBuild w OnFormReady,
  //    a nie w FormCreate (!!!)
  //  * Dyskusja: Mo¿e lepiej dodaæ osobn¹ metodê ResizeControls, która
  //    dostosuje kontrolki do HighDPI
  aTop := 999;
  for aAction in FActions do
  begin
    with TButton.Create(aParent) do
    begin
      Action := aAction;
      AlignWithMargins := true;
      Top := aTop;
      Align := alTop;
      Parent := aParent;
    end;
    aTop := aTop + 32;
  end;
end;

procedure TActionGuiBuilder.BuildButtons(aParent: TWinControl);
begin
  GuardCheckProperties;
  DoBuildButtonsAlignedTop (aParent);
end;

class procedure TActionGuiBuilder.BuildButtonsOnActionList(
  const aParent: TWinControl; const aActionList: TActionList);
var
  Builder: TActionGuiBuilder;
begin
  Builder := TActionGuiBuilder.Create(nil);
  try
    Builder.AddActions(aActionList);
    Builder.BuildButtons(aParent);
  finally
    Builder.Free;
  end;
end;

end.
