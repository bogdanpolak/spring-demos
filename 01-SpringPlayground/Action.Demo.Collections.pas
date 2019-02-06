unit Action.Demo.Collections;

interface

uses
  Generics.Collections,
  Spring.Collections,
  Plus.Vcl.DemoAction;

type
  TIntegerStringPair = Generics.Collections.TPair<integer, string>;

  TActionDemoCollection = class(TDemoAction)
  private
    function CreateDemoCollection: IList<TIntegerStringPair>;
  protected
    procedure DoInitialiaze; override;
    procedure DoExecute; override;
  public
  end;

implementation

uses
  Spring,
  System.SysUtils;

procedure TActionDemoCollection.DoInitialiaze;
begin
  Caption := 'Spring4D.Base Collection Demo'
end;

function PairToString(aPair: TIntegerStringPair): string;
begin
  Result := Format('[%d] => %s', [aPair.Key, aPair.Value]);
end;

function PairsToString(Pairs: IEnumerable<TIntegerStringPair>): string;
var
  e: IEnumerator<TIntegerStringPair>;
begin
  e := Pairs.GetEnumerator;
  if e.MoveNext then
  begin
    Result := '[' + PairToString(e.Current);
    while e.MoveNext do
      Result := Result + ', ' + PairToString(e.Current);
    Result := Result + ']';
  end;
end;

function TActionDemoCollection.CreateDemoCollection: IList<TIntegerStringPair>;
var
  List_1_4: IList<TIntegerStringPair>;
  List_5_9: IList<TIntegerStringPair>;
  List_1_9: IList<TIntegerStringPair>;
begin
  List_1_4 := TCollections.CreateList<TIntegerStringPair>;
  List_1_4.Add(TIntegerStringPair.Create(1, 'one'));
  List_1_4.Add(TIntegerStringPair.Create(2, 'two'));
  List_1_4.Add(TIntegerStringPair.Create(3, 'three'));
  List_1_4.Add(TIntegerStringPair.Create(4, 'four'));
  List_5_9 := TCollections.CreateList<TIntegerStringPair>
    ([TIntegerStringPair.Create(5, 'five'), TIntegerStringPair.Create(6, 'six'),
    TIntegerStringPair.Create(7, 'seven'), TIntegerStringPair.Create(8,
    'eight')]);
  List_5_9.Add(TIntegerStringPair.Create(9, 'nine'));
  List_1_9 := List_1_4;
  List_1_9.AddRange(List_5_9);
  Result := List_1_9;
end;

procedure TActionDemoCollection.DoExecute;
var
  List: IList<TIntegerStringPair>;
  Predicate: Spring.TPredicate<TIntegerStringPair>;
  Enumerable: IEnumerable<TIntegerStringPair>;
  Action: TAction<TIntegerStringPair>;
  PairFirst, PairLast, PairAt4, PairMin, PairMax: TIntegerStringPair;
begin
  ConsoleWrite('----------------------------------------');
  ConsoleWrite('*** Spring4D.Base Collection Demo ***');
  // ---
  List := CreateDemoCollection;
  ConsoleWrite('Create List:');
  ConsoleWrite('  ' + PairsToString(List));
  // ---
  Predicate := function(const Pair: TIntegerStringPair): Boolean
    begin
      Result := Pair.Key mod 2 = 0;
    end;
  Enumerable := List.Where(Predicate);
  ConsoleWrite('Where( Predicate (key mod 2 = 0) )');
  ConsoleWrite('  ' + PairsToString(Enumerable));
  // ---
  Enumerable := List.Skip(7);
  ConsoleWrite('Skip( 7 )');
  ConsoleWrite('  ' + PairsToString(Enumerable));
  // ---
  Enumerable := List.Take(7);
  ConsoleWrite('Take( 7 )');
  ConsoleWrite('  ' + PairsToString(Enumerable));
  // ---
  Predicate := function(const Pair: TIntegerStringPair): Boolean
    begin
      Result := Pair.Key < 5;
    end;
  Enumerable := List.SkipWhile(Predicate);
  ConsoleWrite('SkipWhile( Predicate(Key < 5) )');
  ConsoleWrite('  ' + PairsToString(Enumerable));
  // ---
  Predicate := function(const Pair: TIntegerStringPair): Boolean
    begin
      Result := Pair.Key < 5;
    end;
  Enumerable := List.TakeWhile(Predicate);
  ConsoleWrite('TakeWhile( Predicate(Key < 5) )');
  ConsoleWrite('  ' + PairsToString(Enumerable));
  // ---
  Enumerable := List.Reversed;
  ConsoleWrite('Reversed');
  ConsoleWrite('  ' + PairsToString(Enumerable));
  // ---
  PairFirst := List.First;
  PairLast := List.Last;
  PairAt4 := List.ElementAt(4); // zero-based
  PairMin := List.Min;
  PairMax := List.Max;
  ConsoleWrite('First: ' + PairToString(PairFirst));
  ConsoleWrite('Last: ' + PairToString(PairFirst));
  ConsoleWrite('ElementAt(4): ' + PairToString(PairAt4));
  ConsoleWrite('Min: ' + PairToString(PairMin));
  ConsoleWrite('Max: ' + PairToString(PairMax));
  // ---
  ConsoleWrite('ForEach(Action)');
  Action := procedure(const Pair: TIntegerStringPair)
    begin
      ConsoleWrite('  Action :'+PairToString(Pair))
    end;
  List.ForEach(Action);
  // ---
  Enumerable := TCollections.CreateSet<TIntegerStringPair>(List);
  ConsoleWrite('CreateSet<TIntegerStringPair>(List)');
  ConsoleWrite('  ' + PairsToString(Enumerable));
end;

end.
