unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, CKeysOnForm, ComCtrls, Grids;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Edit1: TEdit;
    spClose: TSpeedButton;
    StringGrid1: TStringGrid;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    ListBox1: TListBox;
    cbESCSalir: TCheckBox;
    Label1: TLabel;
    cbNext: TCheckBox;
    cbPrevious: TCheckBox;
    cbENTERTAB: TCheckBox;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    KeysOnForm1: TKeysOnForm;
    procedure spCloseClick(Sender: TObject);
    procedure cbESCSalirClick(Sender: TObject);
    procedure cbENTERTABClick(Sender: TObject);
    procedure cbNextClick(Sender: TObject);
    procedure cbPreviousClick(Sender: TObject);
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

  if (cbESCSalir.Checked) then begin
    spClose.Caption := 'ESC - ';
  end
  else begin
    spClose.Caption := '';
  end;

  spClose.Caption := spClose.Caption + MSG_CLOSE;
  // Activate
  KeysOnForm1.CloseOnEscape := cbESCSalir.Checked;

end;

procedure TForm1.cbENTERTABClick(Sender: TObject);
begin
  KeysOnForm1.EnterAsTab := cbENTERTAB.Checked;
end;

procedure TForm1.cbNextClick(Sender: TObject);
begin
  KeysOnForm1.NextControlOnALTRight := cbNext.Checked;
end;

procedure TForm1.cbPreviousClick(Sender: TObject);
begin
  KeysOnForm1.PriorControlOnALTLeft := cbPrevious.Checked;
end;

end.
