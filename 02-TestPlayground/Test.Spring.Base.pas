unit Test.Spring.Base;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TMyTestObject = class(TObject)
  public
    // [Setup] procedure Setup;
    // [TearDown] procedure TearDown;
  published
    procedure Test1;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  Spring;

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

procedure TMyTestObject.Test1;
var
  aVaule1: Nullable<TStringList>;
  aVaule2: Nullable<TStringList>;
  sl1: TStringList;
  aTupleISD: Tuple<Integer, String, Double>;
  arr1: TArray<Integer>;
  arr2: TArray<Integer>;
  aIntVect: Vector<Integer>;
  aVect2: TIntVector;
begin
  aVaule1 := TStringList.Create();
  aVaule1.Value.Add('Aaaaa');
  Assert.AreEqual(1, aVaule1.Value.Count);
  Assert.AreEqual(False, aVaule2.HasValue);
  sl1 := aVaule2.GetValueOrDefault;
  Assert.IsNull(sl1);

  // Guard.CheckNotNull(sl1,'sl1');

  aTupleISD.Create(1, 'Ala ma kota', 22.5);

  arr1 := TArray.Copy<Integer>([5, 4, 3, 1, 2]);
  arr2 := TArray.Copy<Integer>(arr1);
  TArray.Sort<Integer>(arr2);
  Assert.AreEqual(3, arr2[2]);

  aIntVect.Add(1);
  aIntVect.Add([2, 3, 4, 5]);
  aIntVect.Add([6, 7, 8, 9, 10]);
  aVect2 := aIntVect.Slice(5, 3);
  Assert.AreEqual('[6, 7, 8]', aVect2.ToString);
end;

initialization

TDUnitX.RegisterTestFixture(TMyTestObject);

end.
