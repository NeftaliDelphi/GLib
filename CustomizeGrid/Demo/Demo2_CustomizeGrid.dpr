program Demo2_CustomizeGrid;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form1};

{$R *.res}
{$R Flags.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
