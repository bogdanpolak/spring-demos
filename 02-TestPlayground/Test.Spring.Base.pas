unit Test.Spring.Base;

interface

uses
  DUnitX.TestFramework;

type
  {$M+}
  [TestFixture]
  TestSpringBase = class(TObject)
  public
    // [Setup] procedure Setup;
    // [TearDown] procedure TearDown;
  published
    procedure Nullable;
    procedure Tuples;
    procedure TArrayExtention;
    procedure Vector;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  Spring,
  Spring.Collections;

type
  TIntVector = Vector<Integer>;

  TIntVectorHelper = record helper for TIntVector
    function ToString(): string;
  end;

function TIntVectorHelper.ToString(): string;
var
  elem: Integer;
begin
  Result := '';
  for elem in self do
    Result := IfThen(Result = '', '[' + elem.ToString, Result + ', ' + elem.ToString);
  if not Result.IsEmpty then
    Result := Result + ']';
end;

procedure TestSpringBase.Nullable;
var
  aVaule1: Nullable<TStringList>;
  aVaule2: Nullable<TStringList>;
  aVaule3: Nullable<IList<Integer>>;
  sl2: TStringList;
begin
  aVaule1 := TStringList.Create();
  aVaule1.Value.Add('Aaaaa');
  Assert.AreEqual(False, aVaule2.HasValue);
  sl2 := aVaule2.GetValueOrDefault;
  aVaule3 := TCollections.CreateList<Integer>();
  aVaule3.Value.AddRange([1,2,3]);

  Assert.AreEqual(1, aVaule1.Value.Count);
  Assert.IsTrue(aVaule1.HasValue);
  Assert.IsNull(sl2);
  Assert.IsTrue(aVaule3.HasValue);
  // Guard.CheckNotNull(sl2,'"sl2" is null');
  // Guard.CheckTrue(aVaule2.HasValue,'"aVaule2" has no value');
  // Guard.CheckInheritsFrom(aVaule1.Value, TComponent, '');
  // Guard.RaiseArgumentFormatException('Aaaaa');
end;

procedure TestSpringBase.Tuples;
var
  aTupleISD: Tuple<Integer, String, Double>;
  aKeyValue: Tuple<String, Variant>;
begin
  aTupleISD.Create(1, 'Ala ma kota', 22.5);
  aKeyValue := Tuple<String, Variant>.Create('contacts','{"aaa":1, "bbb":2.0}');

  Assert.AreEqual('Ala ma kota',aTupleISD.Value2);
  Assert.AreEqual(22.5,aTupleISD.Value3,0.000001);
  Assert.AreEqual('contacts',aKeyValue.Value1);
end;

procedure TestSpringBase.TArrayExtention;
var
  arr1: TArray<Integer>;
  arr2: TArray<Integer>;
begin
  arr1 := TArray.Copy<Integer>([5, 4, 3, 1, 2]);
  arr2 := TArray.Copy<Integer>(arr1);
  TArray.Sort<Integer>(arr2);

  Assert.AreEqual(3, arr2[2]);
end;

procedure TestSpringBase.Vector;
var
  aIntVect: Vector<Integer>;
  aVect2: TIntVector;
begin
  aIntVect.Add(1);
  aIntVect.Add([2, 3, 4, 5]);
  aIntVect.Add([6, 7, 8, 9, 10]);
  aVect2 := aIntVect.Slice(5, 3);

  Assert.AreEqual('[6, 7, 8]', aVect2.ToString);
end;

initialization

TDUnitX.RegisterTestFixture(TestSpringBase);

end.
