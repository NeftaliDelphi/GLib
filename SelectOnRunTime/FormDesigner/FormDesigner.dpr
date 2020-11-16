program FormDesigner;

uses
  Forms,
  FCrear in 'FCrear.pas' {FormCrear},
  FTools in 'FTools.pas' {FormTools};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Form Designer';
  Application.CreateForm(TFormCrear, FormCrear);
  Application.CreateForm(TFormTools, FormTools);
  Application.Run;
end.
