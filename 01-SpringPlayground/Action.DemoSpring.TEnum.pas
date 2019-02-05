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
    procedure WriteLn(const s: string);
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
  WriteLn('TEnum.GetNames<TNumberEnum>: [' + StrNames + ']');
  WriteLn('TEnum.GetNames<TNumberEnum>: [' + StrValues + ']');
end;

procedure TActionDemoSpringTEnum.DoParseEnumValueFromNameAsString;
var
  NE: TNumberEnum;
  s: string;
begin
  s := 'Seven';
  NE := Spring.TEnum.Parse<TNumberEnum>(s);
  if s = Spring.TEnum.GetName<TNumberEnum>(NE) then
    WriteLn(s + ' was properly parsed as ' + TEnum.GetName<TNumberEnum>(NE))
  else
    WriteLn('The TEnum.Parse call failed');
end;

procedure TActionDemoSpringTEnum.WriteLn(const s: string);
begin

end;

procedure TActionDemoSpringTEnum.DoExecute;
begin
  // --------------------------------------------------------------------
  if Spring.TEnum.IsValid<TNumberEnum>(Four) then
    WriteLn(Spring.TEnum.GetName<TNumberEnum>(Four)+' is one of the enum value');
  // --------------------------------------------------------------------
  DoEnumerateNamesAndValues;
  // --------------------------------------------------------------------
  DoParseEnumValueFromNameAsString;
end;

end.
