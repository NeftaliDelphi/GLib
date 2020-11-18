unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, CPanelCuad, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    gridPanel: TPanelCuad;
    Label1: TLabel;
    chkVisualizar: TCheckBox;
    Label2: TLabel;
    spTamanyo: TSpinEdit;
    cbColor: TColorBox;
    procedure chkVisualizarClick(Sender: TObject);
    procedure spTamanyoChange(Sender: TObject);
    procedure cbColorChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.chkVisualizarClick(Sender: TObject);
begin
  gridPanel.GridVisible := chkVisualizar.Checked;
end;

procedure TForm1.spTamanyoChange(Sender: TObject);
begin
  gridPanel.GridSize := spTamanyo.Value;
end;

procedure TForm1.cbColorChange(Sender: TObject);
begin
  gridPanel.GridColor := cbColor.Selected; 
end;

end.
