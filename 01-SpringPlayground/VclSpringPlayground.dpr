program VclSpringPlayground;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Plus.Vcl.PageControlFactory in 'Plus.Vcl.PageControlFactory.pas',
  Frame.ArticlesGrid in 'Frame.ArticlesGrid.pas' {FrameArticlesGrid: TFrame},
  Helper.TDBGrid in 'Helper.TDBGrid.pas',
  Plus.Vcl.ActionGuiBuilder in 'Plus.Vcl.ActionGuiBuilder.pas',
  Action.DemoSpring.TEnum in 'Action.DemoSpring.TEnum.pas',
  Frame.Console in 'Frame.Console.pas' {FrameConsole: TFrame},
  Plus.Vcl.DemoAction in 'Plus.Vcl.DemoAction.pas',
  Action.DemoSpring.Predicate in 'Action.DemoSpring.Predicate.pas',
  Action.DemoSpring.Nullable in 'Action.DemoSpring.Nullable.pas',
  Plus.Spring.EnumerableUtils in 'Plus.Spring.EnumerableUtils.pas',
  Action.Demo.Collections in 'Action.Demo.Collections.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
