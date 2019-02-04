unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Actions,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList,
  Vcl.StdCtrls,
  Data.DB,
  Plus.Vcl.PageControlFactory, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    ActionList1: TActionList;
    actListAndSelectMany: TAction;
    actTObjectDataSet: TAction;
    Action3: TAction;
    PageControl1: TPageControl;
    procedure actListAndSelectManyExecute(Sender: TObject);
    procedure actTObjectDataSetExecute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    PageControlFactory: TPageControlFactory;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Spring,
  Spring.Collections,
  Spring.Data.ObjectDataSet,
  Spring.Collections.Extensions, Frame.ArticlesGrid;

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

procedure TForm1.actTObjectDataSetExecute(Sender: TObject);
var
  Articles: IList<TArticle>;
  ArticlesDataset: TObjectDataSet;
  fldId: TIntegerField;
  fldDesignation: TStringField;
  aFrame: TFrameArticlesGrid;
begin
  aFrame := PageControlFactory.CreateFrame<TFrameArticlesGrid>
    ('Articles - Object list in a TDataSet');
  ArticlesDataset := TObjectDataSet.Create(aFrame);
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

  Articles := TCollections.CreateList<TArticle>(true);
  Articles.add(TArticle.Create(1, 'Article 1'));
  Articles.add(TArticle.Create(12945,
    'How to Unlock Your Hidden Creative Genius'));
  Articles.add(TArticle.Create(2, 'Article 2'));
  Articles.add(TArticle.Create(3, 'Article 3'));
  ArticlesDataset.DataList := Articles as IObjectList;
  ArticlesDataset.Open;

  aFrame.ArticleList := Articles;
  aFrame.DataSource1.Dataset := ArticlesDataset;
  aFrame.OnCloseFrame := (
    procedure(Sender: TFrame)
    begin
      (Sender.Owner as TTabSheet).Free;
    end);
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
  ReportMemoryLeaksOnShutdown := True;
  // ------------------------------------------------------------
  PageControlFactory := TPageControlFactory.Create(Self);
  PageControlFactory.PageControl := PageControl1;
  PageControl1.Align := alClient;
  // ------------------------------------------------------------
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
  // ------------------------------------------------------------
end;

end.
