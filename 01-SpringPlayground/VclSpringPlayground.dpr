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
  Plus.Vcl.DemoAction in 'Plus.Vcl.DemoAction.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
