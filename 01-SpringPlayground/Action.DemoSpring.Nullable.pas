unit Action.DemoSpring.Nullable;

interface

uses
  Spring,
  Plus.Vcl.DemoAction;

type
  TActionDemoNullable = class(TDemoAction)
  private
    procedure ConsoleLogValue(const value: Nullable<Boolean>);
  protected
    procedure DoInitialiaze; override;
    procedure DoExecute; override;
  public
  end;

implementation

uses
  System.SysUtils;

procedure TActionDemoNullable.DoInitialiaze;
begin
  inherited;
  Caption := 'Spring.Base Nullable Demo';
end;

procedure TActionDemoNullable.ConsoleLogValue(const value: Nullable<Boolean>);
begin
  if value.HasValue then
  begin
    if value.value then
      ConsoleWrite('Value set to: True')
    else
      ConsoleWrite('Value set to: False');
  end
  else
    ConsoleWrite('Value set to: Null')
end;

procedure TActionDemoNullable.DoExecute;
var
  NullableBoolean: Nullable<Boolean>;
begin
  ConsoleWrite('----------------------------------------');
  ConsoleWrite('*** Spring4D.Base Nullable Demo ***');
  try
    ConsoleWrite(BoolToStr(NullableBoolean.value));
  except
    on E: EInvalidOperationException do
      ConsoleWrite
        ('[Exception] Value has not been set (EInvalidOperationException)');
  end;
  ConsoleLogValue(NullableBoolean);
  NullableBoolean := True;
  ConsoleLogValue(NullableBoolean);
  NullableBoolean := False;
  ConsoleLogValue(NullableBoolean);
end;

end.
