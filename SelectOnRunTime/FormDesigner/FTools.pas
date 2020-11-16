unit FTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, ExtCtrls, ToolWin, ImgList;

type

  // Array de Constructores de las pestañas
  TControlsClassStandard = array [0..8] of TComponentClass;
  TControlsClassContainers = array [0..5] of TComponentClass;
  TControlsClassAdditional = array [0..5] of TComponentClass;
  // NOTA: Cada botón tiene el TAG correspondiente

  TFormTools = class(TForm)
    pcTools: TPageControl;
    tsEstandard: TTabSheet;
    tsContainers: TTabSheet;
    tbStandard: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ilStandard: TImageList;
    tsAdditional: TTabSheet;
    ilContainers: TImageList;
    ilAdditional: TImageList;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    tbContainers: TToolBar;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    tbAdditional: TToolBar;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    pnlC: TPanel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure pnlCClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FButtonDown: TToolButton;
    FControlsClassPAdd: TControlsClassAdditional;
    FControlsClassPCon: TControlsClassContainers;
    FControlsClassPStd: TControlsClassStandard;
    function GetButtonIndex: Integer;


  public
//    ControlsClassPStd:TControlsClassStandard;
//    ControlsClassPCon:TControlsClassContainers;
//    ControlsClassPAdd:TControlsClassAdditional;

    // Tag del boton
    property ButtonIndex:Integer read GetButtonIndex;
    // botonpulsado
    property ButtonDown:TToolButton read FButtonDown write FButtonDown;
    // Constructores
    property ControlsClassPStd:TControlsClassStandard read FControlsClassPStd
      write FControlsClassPStd;
    property ControlsClassPCon:TControlsClassContainers read FControlsClassPCon
      write FControlsClassPCon;
    property ControlsClassPAdd:TControlsClassAdditional read FControlsClassPAdd
      write FControlsClassPAdd;

  end;


var
  FormTools: TFormTools;



implementation

{$R *.dfm}

uses
  FCrear, ShellAPI, StdCtrls, Grids;

procedure TFormTools.SpeedButton1Click(Sender: TObject);
begin
  FormCrear.SelectOnRunTime1.Selected := False;
  FormCrear.SelectOnRunTime1.SelectControl := nil;
end;

procedure TFormTools.pnlCClick(Sender: TObject);
begin
    ShellExecute(Handle,
             'open',
             'http://neftali.clubdelphi.com/',
             nil,
             nil,
             SW_SHOW);

end;

procedure TFormTools.ToolButton1Click(Sender: TObject);
begin

  // Deseleccionar el actual
  FormCrear.SelectOnRunTime1.Selected := False;
  FormCrear.SelectOnRunTime1.SelectControl := nil;
  Self.FButtonDown := nil;
  // Ss un ToolButton?
  if (Sender is TToolButton) then begin
    Self.FButtonDown := TToolButton(Sender);
  end;


end;

procedure TFormTools.FormCreate(Sender: TObject);
begin
  // relllenar los arrays de constructores  de la pestaña Standard
  Self.FControlsClassPStd[0] := nil;
  Self.FControlsClassPStd[1] := TLabel;
  Self.FControlsClassPStd[2] := TEdit;
  Self.FControlsClassPStd[3] := TMemo;
  Self.FControlsClassPStd[4] := TButton;
  Self.FControlsClassPStd[5] := TCheckBox;
  Self.FControlsClassPStd[6] := TRadioButton;
  Self.FControlsClassPStd[7] := TListBox;
  Self.FControlsClassPStd[8] := TComboBox;

  // relllenar los arrays de constructores  de la pestaña Containers
  Self.FControlsClassPCon[0] := nil;
  Self.FControlsClassPCon[1] := TGroupBox;
  Self.FControlsClassPCon[2] := TRadioGroup;
  Self.FControlsClassPCon[3] := TPanel;
  Self.FControlsClassPCon[4] := TPageControl;
  Self.FControlsClassPCon[5] := TScrollBox;

  // relllenar los arrays de constructores  de la pestaña Additional
  Self.FControlsClassPAdd[0] := nil;
  Self.FControlsClassPAdd[1] := TImage;
  Self.FControlsClassPAdd[2] := TStringGrid;
  Self.FControlsClassPAdd[3] := TRichEdit;
  Self.FControlsClassPAdd[4] := TProgressBar;
  Self.FControlsClassPAdd[5] := TScrollBar;

end;

procedure TFormTools.FormShow(Sender: TObject);
begin

  // Activar la primera página
  pcTools.ActivePageIndex := 0;
  
end;

function TFormTools.GetButtonIndex(): Integer;
begin
  Result := -1;
  // Asignado el boton
  if Assigned(Self.FButtonDown) then begin
    Result := Self.FButtonDown.Tag;
  end;
end;

end.
