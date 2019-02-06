unit Action.DemoSpring.Predicate;

interface

uses
  Plus.Vcl.DemoAction;

type
  TActionDemoPredicate = class(TDemoAction)
  private
    procedure DemoPredicateIsLessThan10;
    procedure DemoFilterListWithPredicate;
    procedure DemoFlipCoins;
  protected
    procedure DoInitialiaze; override;
    procedure DoExecute; override;
  public
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  Spring,
  Spring.Collections,
  Spring.Collections.Lists, Plus.Spring.EnumerableUtils;

procedure TActionDemoPredicate.DoInitialiaze;
begin
  inherited;
  Caption := 'Spring.Base Predicate Demo';
end;

procedure TActionDemoPredicate.DemoPredicateIsLessThan10;
var
  IsLessThan10: TPredicate<integer>;
  Number: integer;
  isLess: Boolean;
begin
  Number := 1 + random(20);
  IsLessThan10 := function(const aValue: integer): Boolean
    begin
      Result := aValue < 10;
    end;
  isLess := IsLessThan10(Number);
  // ** Log:
  ConsoleWrite('Predicate: IsLessThan10');
  ConsoleWrite('  Random number: ' + Number.ToString);
  ConsoleWrite('  ' + IfThen(isLess, Number.ToString + ' is smaller than 10',
    Number.ToString + ' is bigger or equal than 10'));
end;

procedure TActionDemoPredicate.DemoFilterListWithPredicate;
var
  List: IList<integer>;
  IsLessThan50: TPredicate<integer>;
  FirstLess50: IEnumerable<integer>;
  WhereLess50: IEnumerable<integer>;
begin
  List := TList<integer>.Create([3, 6, 8, 34, 65, 86, 20, 70, 10, 90]);
  IsLessThan50 := function(const aInt: integer): Boolean
    begin
      Result := aInt < 50;
    end;
  WhereLess50 := List.Where(IsLessThan50);
  FirstLess50 := List.TakeWhile(IsLessThan50);
  // ** Log:
  ConsoleWrite('Filter list using predicate (item < 50)');
  ConsoleWrite('  List:');
  ConsoleWrite('  [' + TEnumerableUtils.Join(', ', List) + ']');
  ConsoleWrite('  List.Where:');
  ConsoleWrite('  [' + TEnumerableUtils.Join(', ', WhereLess50) + ']');
  ConsoleWrite('  List.TakeWhile:');
  ConsoleWrite('  [' + TEnumerableUtils.Join(', ', FirstLess50) + ']');
end;

procedure TActionDemoPredicate.DemoFlipCoins;
var
  FlipResults: IList<integer>;
  i: integer;
  TestTrue: TPredicate<integer>;
  ListWithTrue: IEnumerable<integer>;
const
  TotalFlips = 10000;
begin
  FlipResults := TList<integer>.Create;
  for i := 1 to TotalFlips do
    FlipResults.Add(random(2));
  TestTrue := function(const aValue: integer): Boolean
    begin
      Result := aValue = 1;
    end;
  ListWithTrue := FlipResults.Where(TestTrue);
  // ** Log:
  ConsoleWrite('Flip Coins');
  ConsoleWrite(Format('  Total heads: %d out of %d', [ListWithTrue.Count,
    TotalFlips]));
end;

procedure TActionDemoPredicate.DoExecute;
begin
  ConsoleWrite('----------------------------------------');
  ConsoleWrite('*** Spring4D.Base Predicate Demo ***');
  Randomize;
  DemoPredicateIsLessThan10;
  DemoFilterListWithPredicate;
  DemoFlipCoins;
end;

end.
