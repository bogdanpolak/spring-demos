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
  protected
    procedure DoInitialiaze; override;
    procedure DoExecute; override;
  end;

implementation

uses
  System.Types,
  Spring;

procedure TActionDemoSpringTEnum.DoInitialiaze;
begin
  Self.Caption := 'Spring4D TEnum Demo';
end;

type
  TNumberEnum = (One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten);

procedure TActionDemoSpringTEnum.DoEnumerateNamesAndValues;
var
  Values: TIntegerDynArray;
  Names: TStringDynArray;
  Val: integer;
  S: String;
begin
  Names := Spring.TEnum.GetNames<TNumberEnum>;
  Values := Spring.TEnum.GetValues<TNumberEnum>;

  WriteLn('Here are all the Names for TNumberEnum: ');
  for S in Names do
    WriteLn(S);
  WriteLn('Here are all the values for TNumberEnum: ');
  for Val in Values do
    WriteLn(Val);
  WriteLn('Here are all the value strings for TNumberEnum: ');
  for Val in Values do
    Spring.TEnum.GetName<TNumberEnum>(Val);
end;

procedure TActionDemoSpringTEnum.DoParseEnumValueFromNameAsString;
var
  NE: TNumberEnum;
  S: string;
begin
  S := 'Seven';
  NE := Spring.TEnum.Parse<TNumberEnum>(S);
  if S = Spring.TEnum.GetName<TNumberEnum>(NE) then
    WriteLn(S, ' was properly parsed as ', TEnum.GetName<TNumberEnum>(NE))
  else
    WriteLn('The TEnum.Parse call failed');
end;

procedure TActionDemoSpringTEnum.DoExecute;
begin
  // --------------------------------------------------------------------
  if Spring.TEnum.IsValid<TNumberEnum>(Four) then
    WriteLn(Spring.TEnum.GetName<TNumberEnum>(Four), ' is a valid enum value');
  // --------------------------------------------------------------------
  DoEnumerateNamesAndValues;
  // --------------------------------------------------------------------
  DoParseEnumValueFromNameAsString;
end;

end.
