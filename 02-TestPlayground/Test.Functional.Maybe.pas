unit Test.Functional.Maybe;

interface

uses
  DUnitX.TestFramework,
  Delphi.Functional;

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
    procedure NoValue;
    procedure Equals_OneToAnother;

    procedure Exception_InvalidCast_WhenFloatToWord;
    procedure Exception_InvalidCast_WhenNumerciStringToInteger;
    procedure Exception_InvalidOperation_WhenGetNoValue;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.Variants;

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
begin
  variant111_99 := 111.99;

  maybeInteger99 := 99;
  maybeCurrency111_99 := Maybe<Currency>.Create(variant111_99);
  maybeSetEmpty := [];
  maybeSetIgnoreCase := [rfIgnoreCase];

  Assert.AreEqual(99, maybeInteger99.Value);
  Assert.IsTrue(maybeSetIgnoreCase.Value = [rfIgnoreCase]);
  Assert.IsTrue(maybeSetIgnoreCase = [rfIgnoreCase]);
  Assert.IsTrue(maybeSetEmpty.HasValue);
  Assert.IsTrue(maybeCurrency111_99.HasValue);
  Assert.AreEqual(111.99, maybeCurrency111_99.Value, 0.00001);
  Assert.IsTrue(maybeCurrency111_99 = 111.99);
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
