program demo_sortedbistbox;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}
{$R CSortListBox.dcr}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
