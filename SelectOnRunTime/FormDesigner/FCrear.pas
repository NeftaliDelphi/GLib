unit FCrear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ComCtrls, StdCtrls,
  CSelectOnRunTime, FTools, TypInfo;

type

  THControl = Class(TControl);

  TFormCrear = class(TForm)
    SelectOnRunTime1: TSelectOnRunTime;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    _ControlsCreated:Integer;
    _comp:TControl;

    function _CrearComponente(Sender: TObject; X, Y: Integer):TControl;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;

    procedure Paint; override;
  public

  published
  end;


var
  FormCrear: TFormCrear;

implementation

{$R *.dfm}

uses
  Math;



procedure TFormCrear.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _comp := _CrearComponente(Sender, X, Y);
end;

procedure TFormCrear.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  newW, newH:Integer;
begin

end;


function TFormCrear._CrearComponente(Sender: TObject; X, Y: Integer):TControl;
var
  comp:TComponent;
  none:Boolean;
  CreateClass:TComponentClass;
  Name:String;
  pInfo: PTypeInfo;

  //----------------------------------------------------------
  function __CreateComp():TComponent;
  begin

    Result := nil;
    // Crearlo
    if Assigned(CreateClass) then begin
      comp := CreateClass.Create(Self);

      // Nombre (RTTI)
      pInfo := comp.ClassInfo;
      Name := pInfo^.Name;

      // TWinControl?
      if (comp is TWinControl) then begin
        TWinControl(comp).ParentWindow := TWinControl(Sender).Handle;
        TWinControl(comp).Parent := TWinControl(Sender);
        TWinControl(comp).Name := Name + IntToStr(_ControlsCreated);
        TWinControl(comp).Left := X;
        TWinControl(comp).Top := Y;
      end
      // no deriva de tWinControl, por ejemplo TLabel
      else if (comp is TControl) then begin
        TControl(comp).Parent := TWinControl(Sender);
        TControl(comp).Name := Name + IntToStr(_ControlsCreated);
        TControl(comp).Left := X;
        TControl(comp).Top := Y;
      end;
      _ControlsCreated := _ControlsCreated + 1;
      Result := comp;
    end;

  end;
  //----------------------------------------------------------
  procedure __UpButton();
  begin
    // Desactivar el botón
    if Assigned(FormTools.ButtonDown) then begin
      // Marcar la flecha
      TToolBar(FormTools.ButtonDown.Parent).Buttons[0].Down := True;
      FormTools.ButtonDown := nil;
    end;
  end;
  //----------------------------------------------------------
  procedure __TrackEvent();
  begin
    // Si hay contro asignado?
    if Assigned(comp) then begin
      // "Enganchar" el evento
      THControl(comp).OnMouseDown := FormMouseDown;
    end;
  end;
  //----------------------------------------------------------
begin

  comp := nil;
  none := False;
  CreateClass := nil;

  // Hay algun boton pulsado?
  if (FormTools.ButtonIndex <> -1) then begin

    // Estandard
    if (FormTools.pcTools.ActivePage = FormTools.tsEstandard) then begin
      // Acceder al coonstructor de la clase
      CreateClass := FormTools.ControlsClassPStd[FormTools.ButtonIndex];
    end
    else if (FormTools.pcTools.ActivePage = FormTools.tsContainers) then begin
      // Acceder al coonstructor de la clase
      CreateClass := FormTools.ControlsClassPCon[FormTools.ButtonIndex];
    end
    else if (FormTools.pcTools.ActivePage = FormTools.tsAdditional) then begin
       // Acceder al coonstructor de la clase
      CreateClass := FormTools.ControlsClassPAdd[FormTools.ButtonIndex];
    end;

    // Crear
    comp := __CreateComp();
    // Boton por defecto de nuevop
    __UpButton();
    // Evento OnMouseDown
    __TrackEvent();
  end
  else begin
    none := True;
  end;


  // No hay nada para crear?
  if (none) then begin
    // No es el form ?
    if (Sender <> Self) then begin
      SelectOnRunTime1.SelectControl := TControl(Sender);
    end
    else begin
      SelectOnRunTime1.Selected := False;     
      SelectOnRunTime1.SelectControl := nil;
    end;
  end
  else begin
    SelectOnRunTime1.SelectControl := TControl(comp);
  end;

  Result := TControl(comp);

end;

procedure TFormCrear.SpeedButton1Click(Sender: TObject);
begin

  SelectOnRunTime1.Selected := False;
  SelectOnRunTime1.SelectControl := nil;


end;

procedure TFormCrear.WMWindowPosChanging(
  var Message: TWMWindowPosChanging);
begin

  inherited;

  if (Self.ComponentState <> []) then begin
    Exit;
  end;

  // Posicionar las barras
  FormTools.Top := Self.Top - FormTools.Height;
  FormTools.Left := Self.Left;

end;

procedure TFormCrear.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ctl:TControl;
begin

  // se ha pulsado ESCAPE?
  if (Key = VK_ESCAPE) then begin
    // Seleccionado Algo?
    if (SelectOnRunTime1.Selected) and (Assigned(SelectOnRunTime1.SelectControl)) then begin
      ctl := SelectOnRunTime1.SelectControl.Parent;

      // Asignado el padre?
      if Assigned(ctl) then begin
        // pasarle la seleccion
        SelectOnRunTime1.SelectControl := ctl;
      end;
    end;
  end;

end;


procedure TFormCrear.Paint;
var
  i,j:Integer;
begin

  inherited;

  i := 0;
  j := 0;

  // pintamos...
  while (i < Self.Width) do begin
    while (j < Self.Height) do begin
      Self.Canvas.Pixels[i, j] := clMaroon;
      j := j + 8{GridSize};
    end;
    j := 0;
    i := i + 8{GridSize};
  end;

end;

end.
