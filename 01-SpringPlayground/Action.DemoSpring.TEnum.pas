unit Action.DemoSpring.TEnum;

interface

uses
  System.Classes,
  Plus.Vcl.WorkAction;

type
  TActionDemoSpringTEnum = class(TWorkAction)
  private
    procedure DoEnumerateNamesAndValues;
    procedure DoParseEnumValueFromNameAsString;
    procedure ConsoleWrite(const s: string);
  protected
    procedure DoInitialiaze; override;
    procedure DoExecute; override;
  end;

implementation

uses
  System.Types,
  System.SysUtils,
  System.Messaging,
  Spring;

procedure TActionDemoSpringTEnum.DoInitialiaze;
begin
  Self.Caption := 'Demo Spring4D: Spring.TEnum';
end;

procedure TActionDemoSpringTEnum.ConsoleWrite(const s: string);
begin
  TMessageManager.DefaultManager.SendMessage(Self,
    TMessage<UnicodeString>.Create(s), True);
end;

type
  TNumberEnum = (One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten);

procedure TActionDemoSpringTEnum.DoEnumerateNamesAndValues;
var
  Values: TIntegerDynArray;
  Names: TStringDynArray;
  StrNames: string;
  StrValues: string;
  Val: integer;
begin
  Names := Spring.TEnum.GetNames<TNumberEnum>;
  Values := Spring.TEnum.GetValues<TNumberEnum>;
  StrNames := String.Join(', ', Names);
  StrValues := '';
  for Val in Values do
  begin
    if StrValues = '' then
      StrValues := Val.ToString
    else
      StrValues := StrValues + ', ' + Val.ToString;
  end;
  ConsoleWrite('Names = TEnum.GetNames<TNumberEnum>:');
  ConsoleWrite('  (' + StrNames + ')');
  ConsoleWrite('Values = TEnum.GetValues<TNumberEnum>:');
  ConsoleWrite('  (' + StrValues + ')');
end;

procedure TActionDemoSpringTEnum.DoParseEnumValueFromNameAsString;
var
  aNumberEnum: TNumberEnum;
  s: string;
begin
  aNumberEnum := Spring.TEnum.Parse<TNumberEnum>( 'SeVeN' );
  if aNumberEnum = Seven then
    ConsoleWrite('[OK] Seven was properly parsed');
  try
    aNumberEnum := Spring.TEnum.Parse<TNumberEnum>( 'Eleven' );
  except on E: Spring.EFormatException do
    ConsoleWrite('[Exception] Eleven was not parsed. (EFormatException)')
  end;
end;

procedure TActionDemoSpringTEnum.DoExecute;
begin
  // --------------------------------------------------------------------
  ConsoleWrite('----------------------------------------');
  ConsoleWrite('*** Spring TEnum Demo ***');
  if Spring.TEnum.IsValid<TNumberEnum>(Four) then
    ConsoleWrite(Spring.TEnum.GetName<TNumberEnum>(Four) +
      ' is one of the value');
  DoEnumerateNamesAndValues;
  DoParseEnumValueFromNameAsString;
  ConsoleWrite('----------------------------------------');
end;

end.
