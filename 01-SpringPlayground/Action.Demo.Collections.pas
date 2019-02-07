unit Action.Demo.Collections;

interface

uses
  System.StrUtils,
  Generics.Collections,
  Spring.Collections,
  Plus.Vcl.DemoAction;

type
  TIntegerStringPair = Generics.Collections.TPair<integer, string>;

  TActionDemoCollection = class(TDemoAction)
  private
    function CreateDemoCollection: IList<TIntegerStringPair>;
    procedure DoListOperationsDemo;
    procedure DoPairSelectionInList;
    procedure DoSpringSetDemo;
    procedure DoSetEqualityComarerDemo;
  protected
    procedure DoInitialiaze; override;
    procedure DoExecute; override;
  public
  end;

implementation

uses
  Spring,
  System.Generics.Defaults,
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

procedure TActionDemoCollection.DoListOperationsDemo;
var
  List: IList<TIntegerStringPair>;
  Predicate: Spring.TPredicate<TIntegerStringPair>;
  Enumerable: IEnumerable<TIntegerStringPair>;
  Action: TAction<TIntegerStringPair>;
begin
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
  ConsoleWrite('ForEach(Action)');
  Action := procedure(const Pair: TIntegerStringPair)
    begin
      ConsoleWrite('  Action :' + PairToString(Pair))
    end;
  List.ForEach(Action);
end;

procedure TActionDemoCollection.DoPairSelectionInList;
var
  List: IList<TIntegerStringPair>;
  PairFirst, PairLast, PairAt4, PairMin, PairMax: TIntegerStringPair;
  i: integer;
begin
  List := CreateDemoCollection;
  PairFirst := List.First;
  PairLast := List.Last;
  PairAt4 := List.ElementAt(4); // zero-based
  ConsoleWrite('First: ' + PairToString(PairFirst));
  ConsoleWrite('Last: ' + PairToString(PairFirst));
  ConsoleWrite('ElementAt(4): ' + PairToString(PairAt4));
  // ---
  for i := 0 to List.Count do
    List.Exchange(random(List.Count), random(List.Count));
  PairMin := List.Min;
  PairMax := List.Max;
  ConsoleWrite('Shuflle:');
  ConsoleWrite('  ' + PairsToString(List));
  ConsoleWrite('  Min: ' + PairToString(PairMin));
  ConsoleWrite('  Max: ' + PairToString(PairMax));
end;

procedure TActionDemoCollection.DoSpringSetDemo;
var
  List: IList<TIntegerStringPair>;
  SetOfPair: ISet<TIntegerStringPair>;
  Enumerable: IEnumerable<TIntegerStringPair>;
begin
  List := CreateDemoCollection;
  SetOfPair := TCollections.CreateSet<TIntegerStringPair>(List);
  ConsoleWrite('CreateSet<TIntegerStringPair>(List)');
  ConsoleWrite('  ' + PairsToString(SetOfPair));
  Enumerable := SetOfPair.Shuffled;
  ConsoleWrite('  Shuffled: ' + PairsToString(Enumerable));
  Enumerable := SetOfPair.Shuffled;
  ConsoleWrite('  Shuffled: ' + PairsToString(Enumerable));
end;

procedure TActionDemoCollection.DoSetEqualityComarerDemo;
var
  PairComparer: IEqualityComparer<TIntegerStringPair>;
  Set123Polish: ISet<TIntegerStringPair>;
  Set2German: ISet<TIntegerStringPair>;
  Set2Polish: ISet<TIntegerStringPair>;
  IsSubsetGer: Boolean;
  IsSubsetPol: Boolean;
  Verb: string;
begin
  PairComparer := TDelegatedEqualityComparer<TIntegerStringPair>.Create(
    function(const Left, Right: TIntegerStringPair): Boolean
    begin
      Result := Left.Key = Right.Key;
    end,
    function(const Pair: TIntegerStringPair): integer
    begin
      // Result := 0; // Pair.Values are ignored
      // --
      // Result := Length(Pair.Value);
      // ---
      Result := BobJenkinsHash(Pair.Value[1], Length(Pair.Value) *
         SizeOf(Pair.Value[1]), 0);
    end);
  Set123Polish := TCollections.CreateSet<TIntegerStringPair>(PairComparer);
  Set123Polish.Add(TIntegerStringPair.Create(1, 'jeden'));
  Set123Polish.Add(TIntegerStringPair.Create(2, 'dwa'));
  Set123Polish.Add(TIntegerStringPair.Create(3, 'trzy'));
  Set2German := TCollections.CreateSet<TIntegerStringPair>(PairComparer);
  Set2German.Add(TIntegerStringPair.Create(2, 'zwei'));
  IsSubsetGer := Set2German.IsSubsetOf(Set123Polish);
  Set2Polish := TCollections.CreateSet<TIntegerStringPair>(PairComparer);
  Set2Polish.Add(TIntegerStringPair.Create(2, 'dwa'));
  IsSubsetPol := Set2Polish.IsSubsetOf(Set123Polish);
  ConsoleWrite('ISet.IsSubset, IEqualityComparer<TIntegerStringPair>');
  ConsoleWrite('  Set123Polish: ' + PairsToString(Set123Polish));
  ConsoleWrite('  Set2German: ' + PairsToString(Set2German));
  ConsoleWrite('  Set2Polish: ' + PairsToString(Set2Polish));
  Verb := IfThen(IsSubsetGer, 'is subset', 'isn''t subset');
  ConsoleWrite('  * Set2German '+Verb+' of Set123Polish');
  Verb := IfThen(IsSubsetPol, 'is subset', 'isn''t subset');
  ConsoleWrite('  * Set2Polish '+Verb+' of Set123Polish');
end;

procedure TActionDemoCollection.DoExecute;
begin
  ConsoleWrite('---------------------------------------------------');
  ConsoleWrite('*** Spring4D.Base Collection Demo ***');
  DoListOperationsDemo;
  DoPairSelectionInList;
  DoSpringSetDemo;
  DoSetEqualityComarerDemo;
end;

end.
