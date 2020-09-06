unit Frame.ArticlesGrid;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Actions,
  Data.DB,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ActnList,
  Spring.Collections;

type
  TArticle = class
  private
    FID: Integer;
    FDesignation: string;
  public
    constructor Create(Id: Integer; const Designation: string);
    property Id: Integer read FID write FID;
    property Designation: string read FDesignation write FDesignation;
    function ToString: string; override;
  end;

type
  TFrameArticlesGrid = class(TFrame)
    DBNavigator1: TDBNavigator;
    grbxNavigation: TGroupBox;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    grbxShowList: TGroupBox;
    Button1: TButton;
    tmrFrameReady: TTimer;
    Splitter1: TSplitter;
    Memo1: TMemo;
    Button2: TButton;
    ActionList1: TActionList;
    actShowList: TAction;
    actCloseFrame: TAction;
    procedure actCloseFrameExecute(Sender: TObject);
    procedure actShowListExecute(Sender: TObject);
    procedure tmrFrameReadyTimer(Sender: TObject);
  private
    FArticleList: IList<TArticle>;
    FOnCloseFrame: TProc<TFrame>;
    procedure SetArticleList(const Value: IList<TArticle>);
    procedure SetOnCloseFrame(const OnCloseProc: TProc<TFrame>);
  public
    property ArticleList: IList<TArticle> read FArticleList
      write SetArticleList;
    property OnCloseFrame: TProc<TFrame> read FOnCloseFrame
      write SetOnCloseFrame;
    constructor Create(Owner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses
  Spring,
  Helper.TDBGrid;

{ TArticle }

constructor TArticle.Create(Id: Integer; const Designation: string);
begin
  FID := Id;
  FDesignation := Designation;
end;

function TArticle.ToString: string;
begin
  Result := Format('{"id":%d, "designation":"%s"}', [Id, Designation]);
end;

{ TFrameArticlesGrid }

constructor TFrameArticlesGrid.Create(Owner: TComponent);
begin
  inherited;
  DBGrid1.Align := alClient;
end;

procedure TFrameArticlesGrid.actCloseFrameExecute(Sender: TObject);
begin
  Self.Visible := False;
  if not Assigned(FOnCloseFrame) then
    Guard.RaiseArgumentException('event: OnCloseFrame is requred');
  FOnCloseFrame(Self);
end;

procedure TFrameArticlesGrid.actShowListExecute(Sender: TObject);
var
  Article: TArticle;
begin
  Memo1.Lines.Add('----------------------------------');
  if not Assigned(ArticleList) then
    Guard.RaiseArgumentException('property: ArtilceList is requred');
  for Article in FArticleList do
    Memo1.Lines.Add(Article.ToString);
  grbxShowList.Width := 256;
end;

procedure TFrameArticlesGrid.SetArticleList(const Value: IList<TArticle>);
begin
  FArticleList := Value;
end;

procedure TFrameArticlesGrid.SetOnCloseFrame(const OnCloseProc: TProc<TFrame>);
begin
  FOnCloseFrame := OnCloseProc;
end;

procedure TFrameArticlesGrid.tmrFrameReadyTimer(Sender: TObject);
begin
  tmrFrameReady.Enabled := False;
  // ----------------
  DBGrid1.AutoSizeColumns();
end;

end.
