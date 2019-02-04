program VclSpringPlayground;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Plus.Vcl.PageControlFactory in 'Plus.Vcl.PageControlFactory.pas',
  Frame.ArticlesGrid in 'Frame.ArticlesGrid.pas' {FrameArticlesGrid: TFrame},
  Helper.TDBGrid in 'Helper.TDBGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
