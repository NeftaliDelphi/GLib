program Demo_CustomizeGrid_IBX;

uses
  Forms,
  Unit1_IBX in 'Unit1_IBX.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
