unit FConfigMesa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, ComCtrls, ToolWin, ExtCtrls, ImgList;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    PanelToolBar: TPanel;
    ToolBarButtons: TToolBar;
    tbSepButtons: TToolButton;
    ToolBar1: TToolBar;
    tbSepAceptar: TToolButton;
    tbAceptar: TToolButton;
    tbCancelar: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    ActionList1: TActionList;
    ActionAceptar: TAction;
    ActionCancelar: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
