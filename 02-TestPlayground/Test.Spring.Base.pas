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

procedure TMyTestObject.Test1;
begin
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);
end.
