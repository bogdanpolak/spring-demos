unit Form.Main;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Actions,
  System.Messaging,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB,
  Plus.Vcl.PageControlFactory,
  Plus.Vcl.ActionGuiBuilder;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    ActionList1: TActionList;
    actListAndSelectMany: TAction;
    actTObjectDataSet: TAction;
    actLoggerDemo: TAction;
    PageControl1: TPageControl;
    procedure FormCreate(Sender: TObject);
    procedure actListAndSelectManyExecute(Sender: TObject);
    procedure actTObjectDataSetExecute(Sender: TObject);
    procedure actLoggerDemoExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
  private
    PageControlFactory: TPageControlFactory;
    ActionGuiBuilder: TActionGuiBuilder;
    // --------------------------------
    FrameConsole: TFrame;
    // --------------------------------
    procedure OnConsoleWriteMessage(const Sender: TObject;
      const M: System.Messaging.TMessage);
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
  Spring.Collections.Extensions,
  // ----------------------------
  Spring.Logging,
  Spring.Logging.Loggers,
  Spring.Logging.Appenders,
  Spring.Logging.Controller,
  // ----------------------------
  Action.DemoSpring.TEnum,
  Action.DemoSpring.Nullable,
  Action.DemoSpring.Predicate,
  // ----------------------------
  Frame.ArticlesGrid,
  Frame.Console,
  Plus.Spring.EnumerableUtils;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := true;
  // ------------------------------------------------------------
  PageControlFactory := TPageControlFactory.Create(Self);
  PageControlFactory.PageControl := PageControl1;
  PageControl1.Align := alClient;
  // ------------------------------------------------------------
  ActionGuiBuilder := TActionGuiBuilder.Create(Self);
  ActionGuiBuilder.AddActions([actListAndSelectMany, actTObjectDataSet,
    actLoggerDemo, TActionDemoSpringTEnum.Create(Self),
    TActionDemoNullable.Create(Self),TActionDemoPredicate.Create(Self)]);
  ActionGuiBuilder.BuildButtons(GroupBox1);
  // ------------------------------------------------------------
  TMessageManager.DefaultManager.SubscribeToMessage(TMessage<UnicodeString>,
    OnConsoleWriteMessage);
end;

procedure TForm1.OnConsoleWriteMessage(const Sender: TObject;
  const M: System.Messaging.TMessage);
var
  frm: TFrameConsole;
begin
  if FrameConsole = nil then
  begin
    frm := PageControlFactory.CreateFrame<TFrameConsole>('Console write log');
    frm.OnCloseFrame := (
      procedure(Sender: TFrame)
      begin
        FrameConsole := nil;
        (Sender.Owner as TTabSheet).Free;
      end);
    frm.DoConsoleWrite((M as TMessage<UnicodeString>).Value);
    FrameConsole := frm;
  end;
end;


// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// Demo: Spring4D List manipulation, using TSelectManyIterator
// * IList<Integer>
// * OuterList: IList<IEnumerable<Integer>>
// * TEnumerableHelper.SelectMany<Integer>
// ------------------------------------------------------------------------

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
  actListAndSelectMany.Caption := TEnumerableUtils.Join(',', Concated);
end;


// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// Demo: IList<TArticle> ==> TObjectDataSet
// * using and managing TObjectDataSet component
// used in this demo:
// * TPageControlFactory component
// * THelperDBGrid.AutoSizeColumns
// ------------------------------------------------------------------------

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


// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// Demo: Simple construction of the ILogger interface
// * TLoggerController as ILoggerController
// * TFileLogAppender as ILogAppender
// -----------------------------------------------------------------------
// More info about Spring4D logging system and better way of usint loggers:
// * https://groups.google.com/forum/#!topic/spring4d/0E6GX-cfVrU
// * TLoggingConfiguration.LoadFromString - using Spring Container
// TODO: Prepare example with TLoggingConfigurationBuilder and configuration
// -----------------------------------------------------------------------
// Loger functionality comments:
// Subject: Clearing the log file
// * The log file is cleared between an app restarts
// * https://stackoverflow.com/questions/43150531/logger-implementation-to-use-in-spring4d
// -----------------------------------------------------------------------
// ------------------------------------------------------------------------

procedure TForm1.actLoggerDemoExecute(Sender: TObject);
var
  Controller: ILoggerController;
  Logger: ILogger;
  Appender: ILogAppender;
  Exception1: EAbort;
  sl: TStringList;
begin
  // --------------------------------------------------------------
  Controller := Spring.Logging.Controller.TLoggerController.Create;
  Logger := Spring.Logging.Loggers.TLogger.Create(Controller);
  Appender := Spring.Logging.Appenders.TFileLogAppender.Create;
  with Appender as TFileLogAppender do
  begin
    Levels := [TLogLevel.Warn, TLogLevel.Info, TLogLevel.Text, TLogLevel.Fatal];
    FileName := 'spring4d.txt';
  end;
  Controller.AddAppender(Appender);
  // --------------------------------------------------------------
  Logger.Enter(Self.ClassType, 'actLoggerDemoExecute');
  Logger.Log('first message');
  Logger.Warn('first WARN message');
  Exception1 := EAbort.Create('');
  Logger.Error('Error ... (not sent to appender)', Exception1);
  Exception1.Free;
  sl := TStringList.Create;
  try
    try
      sl[1] := 'abc';
    except
      on e: EStringListError do
        Logger.Fatal(e.Message, e);
    end;
  finally
    sl.Free;
  end;
  Logger.Leave(Self.ClassType, 'actLoggerDemoExecute');
  // --------------------------------------------------------------
end;


// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// Demo:
// ------------------------------------------------------------------------

procedure TForm1.Action1Execute(Sender: TObject);
begin
  // TODO:
end;


// ------------------------------------------------------------------------
// ------------------------------------------------------------------------
// Demo:
// ------------------------------------------------------------------------

procedure TForm1.Action2Execute(Sender: TObject);
begin
  // TODO:
end;

end.
