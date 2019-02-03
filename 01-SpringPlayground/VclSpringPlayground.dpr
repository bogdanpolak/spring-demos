program VclSpringPlayground;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  Spring.DesignPatterns in 'Base\Spring.DesignPatterns.pas',
  Spring.Events.Base in 'Base\Spring.Events.Base.pas',
  Spring.Events in 'Base\Spring.Events.pas',
  Spring.Helpers in 'Base\Spring.Helpers.pas',
  Spring.MethodIntercept in 'Base\Spring.MethodIntercept.pas',
  Spring in 'Base\Spring.pas',
  Spring.Reflection in 'Base\Spring.Reflection.pas',
  Spring.ResourceStrings in 'Base\Spring.ResourceStrings.pas',
  Spring.SystemUtils in 'Base\Spring.SystemUtils.pas',
  Spring.Times in 'Base\Spring.Times.pas',
  Spring.ValueConverters in 'Base\Spring.ValueConverters.pas',
  Spring.VirtualClass in 'Base\Spring.VirtualClass.pas',
  Spring.VirtualInterface in 'Base\Spring.VirtualInterface.pas',
  Spring.Collections.Adapters in 'Base\Collections\Spring.Collections.Adapters.pas',
  Spring.Collections.Base in 'Base\Collections\Spring.Collections.Base.pas',
  Spring.Collections.Dictionaries in 'Base\Collections\Spring.Collections.Dictionaries.pas',
  Spring.Collections.Enumerable in 'Base\Collections\Spring.Collections.Enumerable.pas',
  Spring.Collections.Events in 'Base\Collections\Spring.Collections.Events.pas',
  Spring.Collections.Extensions in 'Base\Collections\Spring.Collections.Extensions.pas',
  Spring.Collections.LinkedLists in 'Base\Collections\Spring.Collections.LinkedLists.pas',
  Spring.Collections.Lists in 'Base\Collections\Spring.Collections.Lists.pas',
  Spring.Collections.MultiMaps in 'Base\Collections\Spring.Collections.MultiMaps.pas',
  Spring.Collections in 'Base\Collections\Spring.Collections.pas',
  Spring.Collections.Queues in 'Base\Collections\Spring.Collections.Queues.pas',
  Spring.Collections.Sets in 'Base\Collections\Spring.Collections.Sets.pas',
  Spring.Collections.Stacks in 'Base\Collections\Spring.Collections.Stacks.pas',
  Spring.Collections.Trees in 'Base\Collections\Spring.Collections.Trees.pas',
  Spring.Data.ActiveX in 'Data\ObjectDataSet\Spring.Data.ActiveX.pas',
  Spring.Data.ExpressionParser.Functions in 'Data\ObjectDataSet\Spring.Data.ExpressionParser.Functions.pas',
  Spring.Data.ExpressionParser in 'Data\ObjectDataSet\Spring.Data.ExpressionParser.pas',
  Spring.Data.IndexList in 'Data\ObjectDataSet\Spring.Data.IndexList.pas',
  Spring.Data.ObjectDataSet in 'Data\ObjectDataSet\Spring.Data.ObjectDataSet.pas',
  Spring.Data.ValueConverters in 'Data\ObjectDataSet\Spring.Data.ValueConverters.pas',
  Spring.Data.VirtualDataSet in 'Data\ObjectDataSet\Spring.Data.VirtualDataSet.pas',
  Plus.Vcl.Timer in 'Plus.Vcl.Timer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
