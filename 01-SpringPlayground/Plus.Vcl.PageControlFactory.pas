unit Plus.Vcl.PageControlFactory;

interface

uses
  System.Classes,
  Vcl.ComCtrls,
  Vcl.Forms;

type
  TPageControlFactory = class (TComponent)
  private
    FPageControl: TPageControl;
    procedure SetPageControl(const aPageControl: TPageControl);
  public
    function CreateFrame<T: TFrame> (const Caption: string): T;
    property PageControl: TPageControl read FPageControl write SetPageControl;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Controls;

{ TPageControlFactory }

function TPageControlFactory.CreateFrame<T>(const Caption: string): T;
var
  TabSheet: TTabSheet;
  AFrame: TFrame;
begin
  if FPageControl=nil then
    raise Exception.Create('Required PageControl component')
  else begin
    TabSheet := TTabSheet.Create(PageControl);
    TabSheet.Caption := Caption;
    TabSheet.PageControl := PageControl;
    PageControl.ActivePage := TabSheet;
    AFrame := T.Create(TabSheet);
    AFrame.Parent := TabSheet;
    AFrame.Align := alClient;
    Result := AFrame as T;
  end;
end;

procedure TPageControlFactory.SetPageControl(const aPageControl: TPageControl);
begin
  FPageControl := aPageControl;
end;

end.
