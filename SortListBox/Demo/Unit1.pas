unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CSortListBox, Buttons, ExtCtrls, SHELLAPI;

type
  TForm1 = class(TForm)
    SortListBox1: TSortListBox;
    Edit1: TEdit;
    Memo1: TMemo;
    Button5: TButton;
    Panel2: TPanel;
    spClose: TSpeedButton;
    Label2: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  // Añadir elementos
  SortListBox1.Items.Add('Enero');
  SortListBox1.Items.Add('Febrero');
  SortListBox1.Items.Add('Marzo');
  SortListBox1.Items.Add('Abril');
  SortListBox1.Items.Add('Mayo');

end;

procedure TForm1.Button4Click(Sender: TObject);
begin

  SortListBox1.Items.Add(Edit1.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SortListBox1.DeleteSelected;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:Integer;
  Str, Val, Name:String;
begin
  // Limpiar
  Memo1.Clear;
  // Para todos los elementos
  for i := 0 to (SortListBox1.Items.Count - 1) do begin
    Str := SortListBox1.Items[i] + '--';
    // Pintar
    if (SortListBox1.SortDESC[i]) then begin
      Str := Str + 'DESC';
    end
    else begin
      Str := Str + 'ASC';
    end;
    Memo1.Lines.Add(Str);
  end;

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  // ASCENDENTE
  SortListBox1.SortDESC[3] := False;
  // DESCENDENTE
  SortListBox1.SortDESC[4] := True;
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
    ShellExecute(Handle,
               'open',
               'http://neftali.clubdelphi.com',
               nil,
               nil,
               SW_SHOW);
end;

end.

