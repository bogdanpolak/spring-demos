unit Frame.Console;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Actions,
  Vcl.ActnList;

type
  TFrameConsole = class(TFrame)
    grbxCommands: TGroupBox;
    Button2: TButton;
    Button1: TButton;
    Memo1: TMemo;
    ActionList1: TActionList;
    actClearLog: TAction;
    actCloseFrame: TAction;
    procedure actClearLogExecute(Sender: TObject);
    procedure actCloseFrameExecute(Sender: TObject);
  private
    FOnCloseFrame: TProc<TFrame>;
    procedure SetOnCloseFrame(const Value: TProc<TFrame>);
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoConsoleWrite (const msg: String);
    property OnCloseFrame: TProc<TFrame> read FOnCloseFrame
      write SetOnCloseFrame;
  end;

implementation

{$R *.dfm}

uses
  System.Messaging,
  Spring;

constructor TFrameConsole.Create(AOwner: TComponent);
begin
  inherited;
  Memo1.Align := alClient;
  Memo1.Clear;
  Button1.Action := actClearLog;
  Button2.Action := actCloseFrame;
  TMessageManager.DefaultManager.SubscribeToMessage(TMessage<UnicodeString>,
    procedure(const Sender: TObject; const M: TMessage)
    begin
      Self.DoConsoleWrite((M as TMessage<UnicodeString>).Value)
    end);
end;

procedure TFrameConsole.DoConsoleWrite(const msg: String);
begin
  Memo1.Lines.Add(msg)
end;

procedure TFrameConsole.SetOnCloseFrame(const Value: TProc<TFrame>);
begin
  FOnCloseFrame := Value;
end;

procedure TFrameConsole.actClearLogExecute(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TFrameConsole.actCloseFrameExecute(Sender: TObject);
begin
  Self.Visible := False;
  if not Assigned(FOnCloseFrame) then
    Guard.RaiseArgumentException('event: OnCloseFrame is requred');
  FOnCloseFrame(Self);
end;

end.
