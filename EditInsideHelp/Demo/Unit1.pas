unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, Grids,
  CEditInsideHelp, ShellAPI;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    spClose: TSpeedButton;
    cbESCSalir: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtHelp: TEdit;
    pnlColor: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    EditInsideHelp1: TEditInsideHelp;
    EditInsideHelp2: TEditInsideHelp;
    Label7: TLabel;
    EditInsideHelp3: TEditInsideHelp;
    ColorDialog: TColorDialog;
    procedure spCloseClick(Sender: TObject);
    procedure cbESCSalirClick(Sender: TObject);
    procedure pnlColorClick(Sender: TObject);
    procedure edtHelpChange(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  MSG_CLOSE = '&Cerrar/&Close';

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.spCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm1.cbESCSalirClick(Sender: TObject);
begin

  EditInsideHelp1.InsideHelpActive := not EditInsideHelp1.InsideHelpActive;
  EditInsideHelp2.InsideHelpActive := not EditInsideHelp2.InsideHelpActive;
  EditInsideHelp3.InsideHelpActive := not EditInsideHelp3.InsideHelpActive;


end;



procedure TForm1.pnlColorClick(Sender: TObject);
begin
  // Cambiar el color
  if (ColorDialog.Execute) then begin
    EditInsideHelp1.InsideHelpFont.Color := ColorDialog.Color;
    pnlColor.Color := ColorDialog.Color;
  end;
end;

procedure TForm1.edtHelpChange(Sender: TObject);
begin
  // Cambiar el texto
  EditInsideHelp1.InsideHelpText := edtHelp.Text;
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
    ShellExecute(Handle,
             'open',
             'http://neftali.clubdelphi.com/delphi_componentes.html',
             nil,
             nil,
             SW_SHOW);

end;

end.
