unit Action.Demo.CustomerCollection;

interface

uses
  Spring.Collections,
  Plus.Vcl.DemoAction;

type
  TCustomer = class
  strict private
    FLastName: string;
    FSalary: integer;
    FFirstName: string;
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetSalary(const Value: integer);
  public
    constructor Create(aFirstName: string; aLastName: string; aSalary: integer);
    function ToString: string;
    property FirstName: string read FFirstName write SetFirstName;
    property LastName: string read FLastName write SetLastName;
    property Salary: integer read FSalary write SetSalary;
  end;

  TActionDemoCustomers = class(TDemoAction)
  private
    function CreateAndFillCustomers: IList<TCustomer>;
    procedure CustomersConsoleWrite(custs: IEnumerable<TCustomer>);
  protected
    procedure DoInitialiaze; override;
    procedure DoExecute; override;
  public
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.Generics.Defaults,
  Spring;


// ---------------------------------------------------------------
// ---------------------------------------------------------------
// TCustomer
// ---------------------------------------------------------------

constructor TCustomer.Create(aFirstName, aLastName: string; aSalary: integer);
begin
  inherited Create;
  FirstName := aFirstName;
  LastName := aLastName;
  Salary := aSalary;
end;

procedure TCustomer.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TCustomer.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

procedure TCustomer.SetSalary(const Value: integer);
begin
  FSalary := Value;
end;

function TCustomer.ToString: string;
begin
  Result := '{' + self.FirstName + ' ' + self.LastName + ' : ' +
    FormatFloat('###,###,###.00', self.Salary) + '}';
end;

// ---------------------------------------------------------------
// ---------------------------------------------------------------

function TActionDemoCustomers.CreateAndFillCustomers: IList<TCustomer>;
var
  Customers: IList<TCustomer>;
begin
  Customers := TCollections.CreateObjectList<TCustomer>(True);
  Customers.Add(TCustomer.Create('Nick', 'Hodges', 1000000));
  Customers.Add(TCustomer.Create('Michael', 'Miller', 500000));
  Customers.Add(TCustomer.Create('Bill', 'Johnson', 67009));
  Customers.Add(TCustomer.Create('Sally', 'Anderson', 33443));
  Customers.Add(TCustomer.Create('George', 'Wilson', 120987));
  Customers.Add(TCustomer.Create('Alice', 'Fritchman', 49887));
  Customers.Add(TCustomer.Create('Henry', 'Moser', 91234));
  Customers.Add(TCustomer.Create('Lisa', 'Williams', 66000));
  Customers.Add(TCustomer.Create('Allen', 'Rogers', 77000));
  Customers.Add(TCustomer.Create('Wendy', 'Harding', 88000));
  Result := Customers;
end;

procedure TActionDemoCustomers.CustomersConsoleWrite
  (custs: IEnumerable<TCustomer>);
var
  Customer: TCustomer;
begin
  for Customer in custs do
    ConsoleWrite('  ' + Customer.ToString);
end;

function CompareBySalary(const Left, Right: TCustomer): integer;
begin
end;

function CompareByName(const Left, Right: TCustomer): integer;
begin
  Result := CompareText(Left.LastName, Right.LastName);
end;

{ TActionDemoCollection }

procedure TActionDemoCustomers.DoInitialiaze;
begin
  Caption := 'Customer Collection Demo'
end;

function CompareInteger(Left: integer; Right: integer): integer; inline;
begin
  if Left = Right then
    Result := 0
  else if Left < Right then
    Result := -1
  else
    Result := 1;
end;

procedure TActionDemoCustomers.DoExecute;
var
  Customers: IList<TCustomer>;
  CustomerSalaryComparison: TComparison<TCustomer>;
  CustomerLastNameComparison: TComparison<TCustomer>;
  LowSalaryCustomers: IEnumerable<TCustomer>;
begin
  ConsoleWrite('---------------------------------------------------');
  ConsoleWrite('*** Spring4D.Base Customer Collection Demo ***');
  Customers := CreateAndFillCustomers;
  ConsoleWrite('Customers:');
  CustomersConsoleWrite(Customers);
  CustomerSalaryComparison := function(const Left, Right: TCustomer): integer
    begin
      Result := CompareInteger(Left.Salary, Right.Salary)
    end;
  CustomerLastNameComparison := function(const Left, Right: TCustomer): integer
    begin
      Result := CompareText(Left.LastName, Right.LastName);
    end;
  ConsoleWrite('Sorting by Salary:');
  Customers.Sort(CustomerSalaryComparison);
  CustomersConsoleWrite(Customers);
  ConsoleWrite('Sorting by Last Name:');
  Customers.Sort(CustomerLastNameComparison);
  CustomersConsoleWrite(Customers);
  LowSalaryCustomers := Customers.Where(
    function(const c: TCustomer): boolean
    begin
      Result := c.Salary <= 70000;
    end);
  ConsoleWrite('Low Salary Cusomers (Salary < 70000)');
  CustomersConsoleWrite(LowSalaryCustomers);
end;

end.
