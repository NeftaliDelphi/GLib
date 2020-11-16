program DemoRestaurante;

uses
  Forms,
  FMain in 'FMain.pas' {FormMain},
  FConfigMesa in 'FConfigMesa.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
