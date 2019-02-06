unit Plus.Spring.EnumerableUtils;

interface

uses
  Spring.Collections;

type
  TEnumerableUtils = class
    class function Join(const separator: string;
      const values: IEnumerable<Integer>): string; overload;
  end;

implementation

uses
  System.SysUtils;

class function TEnumerableUtils.Join(const separator: string;
const values: Spring.Collections.IEnumerable<Integer>): string;
var
  e: Spring.Collections.IEnumerator<Integer>;
begin
  e := values.GetEnumerator;
  if not e.MoveNext then
    Exit('');
  Result := e.Current.ToString;
  while e.MoveNext do
    Result := Result + separator + e.Current.ToString;
end;

end.
