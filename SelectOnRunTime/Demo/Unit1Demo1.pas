unit Unit1Demo1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, Grids,
  ActnList, CSelectOnRunTime, ShellAPI;

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
    cbESCSalir: TCheckBox;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    SelectOnRunTime: TSelectOnRunTime;
    ActionList1: TActionList;
    Shape1: TShape;
    Image2: TImage;
    ActionActivarDesactivar: TAction;
    ActionCerrar: TAction;
    cbComponente: TComboBox;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Memo2: TMemo;
    Label4: TLabel;
    Memo3: TMemo;
    Label5: TLabel;
    Button1: TButton;
    cbMOve: TCheckBox;
    cbResize: TCheckBox;
    cbChange: TCheckBox;
    Panel4: TPanel;
    ListBox1: TListBox;
    cbTag: TCheckBox;
    procedure ActionCerrarExecute(Sender: TObject);
    procedure ActionActivarDesactivarExecute(Sender: TObject);
    procedure cbESCSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbComponenteChange(Sender: TObject);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label5Click(Sender: TObject);
    procedure SelectOnRunTimeCanResize(Sender: TObject;
      var CanResize: Boolean);
    procedure SelectOnRunTimeCanMove(Sender: TObject; Control: TControl;
      var CanMove, CanMoveOutParent: Boolean);
    procedure cbTagClick(Sender: TObject);
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



procedure TForm1.ActionCerrarExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm1.ActionActivarDesactivarExecute(Sender: TObject);
begin
  SelectOnRunTime.Active := cbESCSalir.Checked;
end;

procedure TForm1.cbESCSalirClick(Sender: TObject);
begin
  ActionActivarDesactivar.Execute;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  i:Integer;
  index:Integer;
begin

  cbComponente.Items.Add('<<Ninguno>>');

  for i := 0 to (ComponentCount - 1) do begin
    if (Components[i] is TControl) then begin
      if (Components[i].Name <> '') then begin
        cbComponente.Items.Add(Components[i].Name);
      end;
    end;
  end;

  cbESCSalir.Checked := SelectOnRunTime.Active;

  // Buscar si hay alguno seleccionado
  if Assigned(SelectOnRuntime.SelectControl) then begin
    index := cbComponente.Items.IndexOf(SelectOnRuntime.SelectControl.Name);
    // encontrado?
    if (index <> -1) then begin
      cbComponente.ItemIndex := index;
    end;
  end;

end;

procedure TForm1.cbComponenteChange(Sender: TObject);
var
  ctl:TComponent;
begin


  if (cbComponente.Text = '<<Ninguno>>') then begin
    SelectOnRunTime.SelectControl := nil;
    Exit;
  end;

  ctl := Self.FindComponent(cbComponente.Text);

  if Assigned(CTL) then begin
    if (ctl is TControl) then begin
      SelectOnRunTime.SelectControl := nil;
      SelectOnRunTime.SelectControl := TControl(ctl);

      SelectOnRunTime.Selected := cbChange.Checked;
      SelectOnRunTime.SelectTaggedControls := cbTag.Checked;
    end;
  end;
end;

procedure TForm1.Memo1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MessageDlg('Cuando no seleccionamos éste control, funciona lo que haya programado en el evento OnMouseDown; Cuando está en modo selección éste evento "se pierde"'+#13+#10+'When this control is not selected, the event programmed (OnMouseDown) is on; When it''s in selection-mode the code pogrammed in event "is lost".', mtWarning, [mbOK], 0);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
      ShellExecute(Handle,
               'open',
               'http://neftali.clubdelphi.com/delphi_componentes.html',
               nil,
               nil,
               SW_SHOW);
end;


procedure TForm1.SelectOnRunTimeCanResize(Sender: TObject;
  var CanResize: Boolean);
begin
  CanResize := cbResize.Checked;
end;

procedure TForm1.SelectOnRunTimeCanMove(Sender: TObject; Control: TControl;
  var CanMove, CanMoveOutParent: Boolean);
begin
  CanMove := cbMOve.Checked;
  CanMoveOutParent := False{True};
end;

procedure TForm1.cbTagClick(Sender: TObject);
begin
  SelectOnRunTime.Selected := cbChange.Checked;
  SelectOnRunTime.SelectTaggedControls := cbTag.Checked;
end;

end.
