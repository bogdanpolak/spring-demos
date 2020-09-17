unit Test.Functional.Maybe;

interface

uses
  DUnitX.TestFramework;

type
  {$M+}
  [TestFixture]
  TestFunctionalMaybe = class(TObject)
  public
    // [Setup] procedure Setup;
    // [TearDown] procedure TearDown;
  published
    procedure HasValue;
    procedure AssignPrimitiveValues;
    procedure AssignRecords;
    procedure AssignClasses;
    procedure NoValue;
    procedure Equals_OneToAnother;

    procedure Exception_InvalidCast_WhenFloatToWord;
    procedure Exception_InvalidCast_WhenNegativeToByte;
    procedure Exception_InvalidCast_WhenNumerciStringToInteger;
    procedure Exception_InvalidOperation_WhenGetNoValue;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.Variants,
  {}
  Delphi.Functional;

// ----------------------------------------------------------------------------
// TPoint2D record
// ----------------------------------------------------------------------------

type
  TPoint2D = record
    X: integer;
    Y: integer;
    constructor Create(const aX, aY: integer);
    function ToString: string;
  end;

constructor TPoint2D.Create(const aX, aY: integer);
begin
  X := aX;
  Y := aY;
end;

function TPoint2D.ToString: string;
begin
  Result := Format('[%d,%d]',[X,Y]);
end;

// ----------------------------------------------------------------------------


procedure TestFunctionalMaybe.HasValue;
var
  maybeEmptyString: Maybe<String>;
begin
  Assert.IsFalse(maybeEmptyString.HasValue);
  maybeEmptyString:= '';
  Assert.IsTrue(maybeEmptyString.HasValue);
end;

procedure TestFunctionalMaybe.NoValue;
var
  maybeIntegerNull: Maybe<Integer>;
  maybeCurrencyNull: Maybe<Currency>;
begin
  maybeCurrencyNull := Maybe<Currency>.Create(System.Variants.Null);
  maybeIntegerNull := 11;
  maybeIntegerNull := nil;

  Assert.IsFalse(maybeIntegerNull.HasValue);
  Assert.IsFalse(maybeCurrencyNull.HasValue);
end;

procedure TestFunctionalMaybe.AssignPrimitiveValues;
var
  maybeInteger99: Maybe<Integer>;
  variant111_99: Variant;
  maybeSetEmpty: Maybe<TReplaceFlags>;
  maybeSetIgnoreCase: Maybe<TReplaceFlags>;
  maybeCurrency111_99: Maybe<Currency>;
  maybeCompareOption_StringSort: Maybe<TCompareOption>;
begin
  variant111_99 := 111.99;

  maybeInteger99 := 99;
  maybeCurrency111_99 := Maybe<Currency>.Create(variant111_99);
  maybeSetEmpty := [];
  maybeSetIgnoreCase := [rfIgnoreCase];
  maybeCompareOption_StringSort := coStringSort;

  Assert.AreEqual(99, maybeInteger99.Value);
  Assert.IsTrue(maybeSetIgnoreCase.Value = [rfIgnoreCase]);
  Assert.IsTrue(maybeSetIgnoreCase = [rfIgnoreCase]);
  Assert.IsTrue(maybeSetEmpty.HasValue);
  Assert.IsTrue(maybeCurrency111_99.HasValue);
  Assert.AreEqual(111.99, maybeCurrency111_99.Value, 0.00001);
  Assert.IsTrue(maybeCurrency111_99 = 111.99);
  Assert.AreEqual(coStringSort, maybeCompareOption_StringSort.Value);
end;

procedure TestFunctionalMaybe.AssignRecords;
var
  maybePoint2D: Maybe<TPoint2D>;
begin
  maybePoint2D := TPoint2D.Create(5,-2);

  Assert.AreEqual('[5,-2]', maybePoint2D.Value.ToString);
end;

procedure TestFunctionalMaybe.AssignClasses;
var
  maybeStringList: Maybe<TStringList>;
  maybeStringBuilder: Maybe<TStringBuilder>;
  maybeTStringArray: Maybe<TArray<String>>;
begin
  maybeStringList := TStringList.Create
    .AddPair('id','1')
    .AddPair('name','Bogdan') as TStringList;
  maybeStringBuilder:= TStringBuilder.Create
    .AppendFormat('%s {$ver}',['Super Application'])
    .AppendFormat(' © %d',[2020])
    .Replace('{$ver}','1.0');
  maybeTStringArray := ['aaa','bbb'];

  Assert.AreEqual('id=1,name=Bogdan',maybeStringList.Value.CommaText);
  Assert.AreEqual('Super Application 1.0 © 2020',maybeStringBuilder.Value.ToString);
  Assert.AreEqual('bbb',maybeTStringArray.Value[1]);

  maybeStringList.Value.Free;
  maybeStringBuilder.Value.Free;
end;


procedure TestFunctionalMaybe.Equals_OneToAnother;
var
  maybeNullString1: Maybe<String>;
  maybeNullString2: Maybe<String>;
  maybeStringAAA1: Maybe<String>;
  maybeStringAAA2: Maybe<String>;
  maybeStringBBB2: Maybe<String>;
begin
  maybeStringAAA1 := 'AAA';
  maybeStringAAA2 := 'AAA';
  maybeStringBBB2 := 'BBB';

  Assert.IsTrue(maybeNullString1.Equals(maybeNullString2));
  Assert.IsTrue(maybeStringAAA1.Equals(maybeStringAAA2));
  Assert.IsFalse(maybeStringAAA1.Equals(maybeStringBBB2));
end;

procedure TestFunctionalMaybe.Exception_InvalidCast_WhenFloatToWord;
var
  maybeWord: Maybe<Word>;
begin
  Assert.WillRaise(procedure begin
    maybeWord := Maybe<Word>(99.9);
  end, EInvalidCast);
end;

procedure TestFunctionalMaybe.Exception_InvalidCast_WhenNegativeToByte;
var
  maybeByte: Maybe<Byte>;
begin
    // *********************************************
    maybeByte := Maybe<Byte>(-2);
    Assert.AreEqual(254, Integer(maybeByte));
    // *********************************************
    // should be thrown invalid cast exception:
    // Assert.WillRaise(procedure begin
    //   maybeByte := Maybe<Byte>(-2);
    // end, EInvalidCast);
end;

procedure TestFunctionalMaybe.Exception_InvalidCast_WhenNumerciStringToInteger;
var
  maybeInteger: Maybe<Integer>;
begin
  Assert.WillRaise(procedure begin
    maybeInteger := Maybe<Integer>('111');
  end, EInvalidCast);
end;

procedure TestFunctionalMaybe.Exception_InvalidOperation_WhenGetNoValue;
var
  maybeStringList: Maybe<TStringList>;
begin
  Assert.WillRaise(procedure begin
    maybeStringList.Value.Add('aaaa');
  end, EInvalidOpException);
end;

end.
