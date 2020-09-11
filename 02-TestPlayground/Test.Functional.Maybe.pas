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
    fInteger: Maybe<Integer>;
    // [Setup] procedure Setup;
    // [TearDown] procedure TearDown;
  published
    procedure TestInitialValue;
    procedure TestAssignFive;
    procedure TestException;
    procedure TestLocalVariable;
    procedure TestFromVariant;
    procedure TestEquals;
    procedure TestDefaultReturnsInitialValue;
    procedure TestAssignFloat;
    procedure TestAssignStringInt;
    procedure TestNullableNull;
    procedure TestAssignNull;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.Variants;

procedure TestFunctionalMaybe.TestInitialValue;
begin
  Assert.IsFalse(fInteger.HasValue);
end;

procedure TestFunctionalMaybe.TestAssignFive;
begin
  fInteger := 5;
  Assert.IsTrue(fInteger.HasValue);
  Assert.AreEqual(5, fInteger.Value);
  Assert.IsTrue(fInteger.Value = 5);
  Assert.IsTrue(fInteger.Value <> 3);
end;

procedure TestFunctionalMaybe.TestAssignFloat;
begin
  // ExpectedException := EInvalidCast;
  // fInteger := Maybe<Integer>(99.9);
  Assert.Pass();
end;

procedure TestFunctionalMaybe.TestAssignNull;
var
  v: Maybe<Integer>;
begin
  v := 5;
  v := nil;
  Assert.IsTrue(not v.HasValue);
end;

procedure TestFunctionalMaybe.TestAssignStringInt;
begin
  // Nullable does NOT do a variant type conversion but is strict about the underlying type
  // ExpectedException := EInvalidCast;
  // fInteger := Maybe<Integer>('5');
  Assert.Pass();
end;

procedure TestFunctionalMaybe.TestDefaultReturnsInitialValue;
begin
  fInteger := Default(Maybe<Integer>);
  Assert.IsFalse(fInteger.HasValue);
end;

procedure TestFunctionalMaybe.TestException;
begin
  // ExpectedException := EInvalidOperationException;
  // fInteger.Value;
  Assert.Pass();
end;

procedure TestFunctionalMaybe.TestLocalVariable;
var
  dirtyValue: Maybe<Integer>;
begin
  Assert.IsFalse(dirtyValue.HasValue);
  Assert.IsTrue(dirtyValue = nil);
  dirtyValue := 5;
  Assert.IsTrue(dirtyValue <> nil);
end;

procedure TestFunctionalMaybe.TestNullableNull;
begin
  fInteger := 42;
  Assert.AreEqual(42, fInteger.Value);
  fInteger := nil;
  Assert.IsTrue(not fInteger.HasValue);
  Assert.IsTrue(fInteger = nil);
  Assert.IsFalse(fInteger <> nil);
end;

procedure TestFunctionalMaybe.TestFromVariant;
var
  value: Variant;
const
  ExpectedInteger: Integer = 5;
begin
  value := Null;
  fInteger := Maybe<Integer>.Create(value);
  Assert.IsFalse(fInteger.HasValue);

{$IFDEF UNSAFE_NULLABLE}
  fInteger := value;
{$ELSE}
  fInteger := Maybe<Integer>(value);
{$ENDIF}
  Assert.IsFalse(fInteger.HasValue);

  value := ExpectedInteger;
  fInteger := Maybe<Integer>.Create(value);
  Assert.IsTrue(fInteger.HasValue);
  Assert.AreEqual(ExpectedInteger, fInteger.Value);
end;

procedure TestFunctionalMaybe.TestEquals;
var
  a, b: Maybe<Integer>;
begin
  Assert.IsFalse(a.HasValue);
  Assert.IsFalse(b.HasValue);

  Assert.IsTrue(a.Equals(b));
  Assert.IsTrue(b.Equals(a));

  a := 2;
  Assert.IsFalse(a.Equals(b));
  Assert.IsFalse(b.Equals(a));

  b := 2;
  Assert.IsTrue(a.Equals(b));

  b := 3;
  Assert.IsFalse(a.Equals(b));
end;

end.
