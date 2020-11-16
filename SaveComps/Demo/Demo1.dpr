program Demo1;

uses
  Forms,
  Unit1Demo1 in 'Unit1Demo1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
