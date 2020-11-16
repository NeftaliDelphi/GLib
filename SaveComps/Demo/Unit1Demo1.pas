{
Unit de prueba para el componente TSaveComps  Component Version 1.2 - Suite GLib
Copyright (©) 2005,  by Germán Estévez (Neftalí)

  Permite guardar la posicion de todos los controles que se encuentran en el
  formulario. Utiliza un fichero INI.
  Es indispensable para grabar la posición de un componente que tenga definida
  la propiedad Name (para controles creados en RunTime).

Utilización/Usage:
  Coloque el componente en el frmulario y activelo.
  Place the component in the form and enable it.


=========================================================================
IMPORTANTE PROGRAMADORES: Por favor, si tienes comentarios, mejoras, ampliaciones,
  errores y/o cualquier otro tipo de sugerencia envíame un mail a:
  german_ral@hotmail.com

IMPORTANT PROGRAMMERS: please, if you have comments, improvements, enlargements,
errors and/or any another type of suggestion send a mail to:
german_ral@hotmail.com
=========================================================================

@author Germán Estévez (Neftalí)
@cat Package GLib
}
unit Unit1Demo1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, Grids,
  ActnList, CSelectOnRunTime, ShellAPI, CSaveComps;

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
    SaveComps: TSaveComps;
    Button2: TButton;
    procedure ActionCerrarExecute(Sender: TObject);
    procedure cbESCSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbComponenteChange(Sender: TObject);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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


procedure TForm1.cbESCSalirClick(Sender: TObject);
begin
  ActionActivarDesactivar.Execute;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  i:Integer;
  index:Integer;
begin

  cbComponente.Clear;
  cbComponente.Items.Add('<<Ninguno>>');

  for i := 0 to (ComponentCount - 1) do begin
    if (Components[i] is TControl) then begin
      if (Components[i].Name <> '') then begin
        cbComponente.Items.Add(Components[i].Name);
      end;
    end;
  end;

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


procedure TForm1.Button1Click(Sender: TObject);
begin

  // Prop. Color
  ListBox1.Color := clInfoBk;
  // Prop. Caption
  RadioButton1.Caption := 'Nuevo caption';
  // Prop. Checked
  CheckBox1.Checked := True;
  CheckBox1.Alignment := taLeftJustify;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Left := Memo1.Left + 5;
 // Memo1.Width := memo1.Width + 1;
end;

end.
