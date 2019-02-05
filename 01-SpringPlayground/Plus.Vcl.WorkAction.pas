unit Plus.Vcl.WorkAction;

interface

uses
  System.Classes,
  System.Actions;

type
  TWorkAction = class (TContainedAction)
  private
    procedure EventOnExecute (Sender: TObject);
  protected
    procedure DoInitialiaze; virtual; abstract;
    procedure DoExecute; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TWorkAction }

constructor TWorkAction.Create(AOwner: TComponent);
begin
  inherited;
  DoInitialiaze;
  Self.OnExecute := EventOnExecute;
end;

procedure TWorkAction.EventOnExecute(Sender: TObject);
begin
  DoExecute;
end;

end.
