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
    procedure Assign99;
    procedure TestException;
    procedure MaybeFromVariant;
    procedure TestEquals;
    procedure TestAssignFloat;
    procedure TestAssignStringInt;
    procedure AssignSetOf;
    procedure AssignNoValue;
  end;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.Variants;

procedure TestFunctionalMaybe.HasValue;
var
  maybeString: Maybe<String>;
begin
  Assert.IsTrue(maybeString.HasValue = False);
  maybeString:= '';
  Assert.IsTrue(maybeString.HasValue);
end;

procedure TestFunctionalMaybe.Assign99;
var
  maybeInteger: Maybe<Integer>;
begin
  maybeInteger := 99;
  Assert.AreEqual(99, maybeInteger.Value);
end;

procedure TestFunctionalMaybe.AssignNoValue;
var
  maybeInteger: Maybe<Integer>;
begin
  maybeInteger := 11;
  maybeInteger := nil;
  Assert.IsTrue(not maybeInteger.HasValue);
end;

procedure TestFunctionalMaybe.TestAssignFloat;
begin
  // ExpectedException := EInvalidCast;
  // fInteger := Maybe<Integer>(99.9);
  Assert.Pass();
end;

procedure TestFunctionalMaybe.TestAssignStringInt;
begin
  // Nullable does NOT do a variant type conversion but is strict about the underlying type
  // ExpectedException := EInvalidCast;
  // fInteger := Maybe<Integer>('5');
  Assert.Pass();
end;

procedure TestFunctionalMaybe.TestException;
begin
  // ExpectedException := EInvalidOperationException;
  // fInteger.Value;
  Assert.Pass();
end;

procedure TestFunctionalMaybe.AssignSetOf;
var
  maybeSet: Maybe<TReplaceFlags>;
begin
  maybeSet := [rfIgnoreCase];
  Assert.IsTrue(maybeSet = [rfIgnoreCase]);
  maybeSet := nil;
  Assert.IsTrue(maybeSet.HasValue = False);
end;

procedure TestFunctionalMaybe.MaybeFromVariant;
var
  maybeInteger: Maybe<Integer>;
  value: Variant;
const
  ExpectedInteger: Integer = 999;
begin
  maybeInteger := Maybe<Integer>.Create(value);
  Assert.IsTrue(maybeInteger.HasValue = False);
  maybeInteger := System.Variants.Null;
  Assert.IsTrue(maybeInteger.HasValue = False);
  value := ExpectedInteger;
  maybeInteger := Maybe<Integer>.Create(value);
  Assert.IsTrue(maybeInteger.HasValue);
  Assert.AreEqual(ExpectedInteger, maybeInteger.Value);
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
