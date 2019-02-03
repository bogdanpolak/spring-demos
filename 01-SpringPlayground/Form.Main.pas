unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    ActionList1: TActionList;
    actListAndSelectMany: TAction;
    actTObjectDataSet: TAction;
    Action3: TAction;
    procedure actListAndSelectManyExecute(Sender: TObject);
    procedure actTObjectDataSetExecute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    DBGridArticles: TDBGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Spring,
  Spring.Collections,
  Spring.Data.ObjectDataSet,
  Spring.Collections.Extensions,
  Plus.Vcl.Timer;

type
  TEnumerableHelper = class helper for TEnumerable
    class function SelectMany<T>(const source: IEnumerable < IEnumerable < T >>
      ): IEnumerable<T>; overload; static;
  end;

class function TEnumerableHelper.SelectMany<T>(const source: IEnumerable <
  IEnumerable < T >> ): IEnumerable<T>;
begin
  Result := Spring.Collections.Extensions.TSelectManyIterator<IEnumerable<T>,
    T>.Create(source,
    function(x: IEnumerable<T>): IEnumerable<T>
    begin
      Result := x;
    end);
end;

function IntegerJoin(const separator: string;
const values: Spring.Collections.IEnumerable<Integer>): string; overload;
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

procedure TForm1.actListAndSelectManyExecute(Sender: TObject);
var
  InnerList1: IList<Integer>;
  InnerList2: IList<Integer>;
  OuterList: IList<IEnumerable<Integer>>;
  Concated: IEnumerable<Integer>;
begin
  InnerList1 := TCollections.CreateList<Integer>([1, 2, 3]);
  InnerList2 := TCollections.CreateList<Integer>([4, 5]);
  OuterList := TCollections.CreateList < IEnumerable < Integer >>
    ([InnerList1, InnerList2]);
  Concated := TEnumerable.SelectMany<Integer>(OuterList);
  actListAndSelectMany.Caption := IntegerJoin(',', Concated);
end;

type
  TArticle = class
  private
    FID: Integer;
    FDesignation: string;
  public
    constructor Create(Id: Integer; const Designation: string);
    property Id: Integer read FID write FID;
    property Designation: string read FDesignation write FDesignation;
  end;
  { TArticle }

constructor TArticle.Create(Id: Integer; const Designation: string);
begin
  FID := Id;
  FDesignation := Designation;
end;

procedure TForm1.actTObjectDataSetExecute(Sender: TObject);
var
  Articles: IList<TArticle>;
  ArticlesDataset: TObjectDataSet;
  fldId: TIntegerField;
  fldDesignation: TStringField;
begin
  Articles := TCollections.CreateList<TArticle>(true);
  Articles.add(TArticle.Create(1, 'Article 1'));
  Articles.add(TArticle.Create(2, 'Article 2'));
  Articles.add(TArticle.Create(3, 'Article 3'));

  if Assigned(DBGridArticles) then
    DBGridArticles.Free;

  DBGridArticles := TDBGrid.Create(Self);

  ArticlesDataset := TObjectDataSet.Create(DBGridArticles);
  ArticlesDataset.DataList := Articles as IObjectList;
  fldId := TIntegerField.Create(ArticlesDataset);
  fldId.FieldKind := fkData;
  fldId.Name := 'fid';
  fldId.FieldName := 'ID';
  fldId.Dataset := ArticlesDataset;
  fldDesignation := TStringField.Create(ArticlesDataset);
  fldDesignation.Size := 100;
  fldDesignation.FieldKind := fkData;
  fldDesignation.FieldName := 'Designation';
  fldDesignation.Dataset := ArticlesDataset;
  ArticlesDataset.Open;

  DBGridArticles.DataSource := TDataSource.Create(DBGridArticles);
  DBGridArticles.DataSource.Dataset := ArticlesDataset;
  DBGridArticles.AlignWithMargins := true;
  DBGridArticles.Align := alClient;
  DBGridArticles.Parent := Self;
end;

procedure TForm1.Action3Execute(Sender: TObject);
begin
  // TODO:
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  aAction: TContainedAction;
  aParent: TWinControl;
  aActionList: TActionList;
begin
  aParent := GroupBox1;
  aActionList := ActionList1;
  for i := 0 to aActionList.ActionCount - 1 do
  begin
    aAction := aActionList.Actions[i];
    with TButton.Create(Self) do
    begin
      Action := aAction;
      AlignWithMargins := true;
      Align := alTop;
      Parent := aParent;
    end;
  end;
end;

end.
