{: TKeysOnForm  Component Version 1.0 - Suite GLib
   Copyright (©) 2005,  by Germán Estévez (Neftalí)

TKeysOnForm 1.0: Permite gestionar de forma sencilla (sin código) algunas de
las combinaciones de teclas más utilizadas en los formularios. Basta con soltar
el componente sobre el formulario y activar las propiedades deseadas segun el
comportamiento que queramos.

    * ENTER  para cambiar de campo.
    * ESC para cerrar el formulario
    * Avanzar al siguiente control
    * Retrasar al anterior control
    * Teclas de función
    * ...
=========================================================================
IMPORTANTE PROGRAMADORES: Por favor, si tienes comentarios, mejoras, ampliaciones,
  errores y/o cualquier otro tipo de sugerencia envíame un mail a: 
  german_ral@hotmail.com
  
IMPORTANT PROGRAMMERS: please, if you have comments, improvements, enlargements, 
errors and/or any another type of suggestion send a mail to: 
german_ral@hotmail.com  
=========================================================================


@author   	Germán Estévez
@email		  german_ral@hotmail.com
}
unit CKeysOnForm;
{=========================================================================

  CKeysOnForm

  Componente

  Propósito : Gestion de teclas en un Form

========================================================================
  Historia de las Versiones
------------------------------------------------------------------------

  12/02/2003   
  * Creación.
------------------------------------------------------------------------
   ...

=========================================================================

  Errores detectados no corregidos

=========================================================================}



//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  {Generales} Windows, Messages, SysUtils, Classes, Forms, Controls, StdCtrls;

type

  {: indica direccion; Adelante y atrás}
  TGoCtl = (goNEXTCTL, goPREVCTL);

  {:Compoenente para gestionar teclas pulsadas sobre el Form.}
  TKeysOnForm = class(TComponent)
  private
    FParentForm: TForm;         // Form. padre
    FCloseOnEscape: Boolean;    // cerrar con el ESC?
    FEscapeButton:TButton;      // Boton asociado a la tecla ESC.
    FEnterAsTab: Boolean;       // El enter funciona como el TAB?

    FFunctionKeysButton: array[1..10] of TControl;
    FOnFunctionKeys: array[1..10] of TKeyEvent;
    FPriorControlOnALTLeft: Boolean;
    FNextControlOnALTRight: Boolean;

    // rutina propia para KeyDown.
    procedure _MyOnkeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    // Rutina propia para keyPress
    procedure _MyOnkeyPress(Sender: TObject; var Key: Char);
    // Se ejecuta cuando se pulsa una tecla de función; Para pasar al botón asociado.
    procedure _PulsedFunctionKey(Index:Integer; Sender: TObject;
                                 var Key: Word; Shift: TShiftState);

    // Funciones provadas de accesoa propiedades.
    procedure SetEscapeButton(const Value: TButton);
    procedure SetCloseOnEscape(const Value: Boolean);
    function GetFunctionKeysButton(const Index: Integer): TControl;
    procedure SetFunctionKeysButton(const Index: Integer; const Value: TControl);
    function GetOnFunctionKeys(const Index: Integer): TKeyEvent;
    procedure SetOnFunctionKeys(const Index: Integer; const Value: TKeyEvent);

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //: Form al que pertenece el componente
    property ParentForm:TForm read FParentForm write FParentForm;

  published
    { Published declarations }
    //: Si se desea cerrar el Form con la tecla ESCAPE
    property CloseOnEscape:Boolean read FCloseOnEscape write SetCloseOnEscape;

    //: "ligar" la tecla ESC a la pulsación de un botón
    property EscapeButton:TButton read FEscapeButton write SetEscapeButton;

    //: Botones asociados a las pulsaciones de teclas de función
    property F1Button:TControl index 1 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F2Button:TControl index 2 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F3Button:TControl index 3 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F4Button:TControl index 4 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F5Button:TControl index 5 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F6Button:TControl index 6 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F7Button:TControl index 7 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F8Button:TControl index 8 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F9Button:TControl index 9 read GetFunctionKeysButton write SetFunctionKeysButton;
    property F10Button:TControl index 10 read GetFunctionKeysButton write SetFunctionKeysButton;

    //: indica si el ENTER funciona como la tabulacion (cambia de campo)
    property EnterAsTab:Boolean read FEnterAsTab write FEnterAsTab;
    //: Tecla de acceso para el control anterior activada?
    property PriorControlOnALTLeft:Boolean read FPriorControlOnALTLeft
      write FPriorControlOnALTLeft;
    //: Tecla de acceso para el control siguiente activada?
    property NextControlOnALTRight:Boolean read FNextControlOnALTRight
      write FNextControlOnALTRight;

    property OnF1:TKeyEvent index 1 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF2:TKeyEvent index 2 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF3:TKeyEvent index 3 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF4:TKeyEvent index 4 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF5:TKeyEvent index 5 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF6:TKeyEvent index 6 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF7:TKeyEvent index 7 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF8:TKeyEvent index 8 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF9:TKeyEvent index 9 read GetOnFunctionKeys write SetOnFunctionKeys;
    property OnF10:TKeyEvent index 10 read GetOnFunctionKeys write SetOnFunctionKeys;

  end;

// Cabeceras de funciones
procedure Register;


//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  {Generales} Menus, Buttons, DB;


{:Registra el componente.
  @param    Sin parámetros}
procedure Register;
begin
  RegisterComponents('GLib', [TKeysOnForm]);
end;


//: Constructor de la clase
constructor TKeysOnForm.Create(AOwner: TComponent);
begin

  inherited;

  if not (AOWner is TForm) then begin
    Exception.Create('El Owner debe ser un Form');
  end;

  Self.FParentForm := (AOwner as TForm);

  FParentForm.KeyPreview := True;
  //NOTA: Utilizamos KeyUp pq se utiliza menos que KeyDown.
  FParentForm.OnKeyUp := _MyOnkeyDown;
  FParentForm.OnKeyPress := _MyOnkeyPress;

end;


//: Destructor de la clase
destructor TKeysOnForm.Destroy();
begin
  inherited;
end;


//: Funcion de acceso a la propiedad FxButton.
function TKeysOnForm.GetFunctionKeysButton(const Index: Integer): TControl;
begin
  Result := FFunctionKeysButton[Index];
end;

function TKeysOnForm.GetOnFunctionKeys(const Index: Integer): TKeyEvent;
begin
  Result := FOnFunctionKeys[Index];
end;

procedure TKeysOnForm.SetCloseOnEscape(const Value: Boolean);
begin
  // Ha cambiado ?
  if (Self.FCloseOnEscape <> Value) then begin
    FCloseOnEscape := Value;
  end;

    // Se ha qactivado ?
  if (Self.FCloseOnEscape) then begin
    Self.FEscapeButton := nil;
  end;

end;

procedure TKeysOnForm.SetEscapeButton(const Value: TButton);
begin
  // ha cambiado ?
  if (Self.FEscapeButton <> Value) then begin
    FEscapeButton := Value;
  end;

  // Se ha qactivado ?
  if Assigned(Self.FEscapeButton) then begin
    Self.FCloseOnEscape := False;
  end;
end;

procedure TKeysOnForm.SetFunctionKeysButton(const Index: Integer; const Value: TControl);
begin
  // Ha cambiado ?
  if (FFunctionKeysButton[Index] <> Value) then begin
    FFunctionKeysButton[Index] := Value;
  end;

  // Se ha asignado? => Desactivar el evento (son incompatibles)
  if Assigned(Value) then begin
    FOnFunctionKeys[Index] := nil;
  end;
end;


procedure TKeysOnForm.SetOnFunctionKeys(const Index: Integer; const Value: TKeyEvent);
begin
  // Ha cambiado ?
  FOnFunctionKeys[Index] := Value;

  // Se ha asignado? => Desactivar el boton  (son incompatibles)
  if Assigned(Value) then begin
    FFunctionKeysButton[Index] := nil;
  end;
end;

//: Capturamos la rutina OnKeyPress.
procedure TKeysOnForm._MyOnkeyPress(Sender: TObject; var Key: Char);
begin

  // Se ha pulsado ENTER ?
  if Ord(key) = VK_RETURN then begin
    // Activada la propiedad EnterAsTAB?
    if Self.FEnterAsTab then begin

      // no ha pulsado otras teclas (ALT, CTRL, SHIFT)
      //+G  Falla al pulsar ENTER sobre un CHECKBOX (DataAware)
      try
        // Irse al siguiente control
        ParentForm.Perform (WM_NEXTDLGCTL, Integer(goNEXTCTL), 0);
      except
        on E:EDataBaseError do begin
          // Nada
        end; // EDataBaseEroor
      end; // try...
    end;
  end; // If..VK_ENTER

end;

//: Capturamos la rutina OnKeyDown.
procedure TKeysOnForm._MyOnkeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  // Se ha pulsado ESCAPE?
  if key = VK_ESCAPE then begin
    if FCloseOnEscape then begin
      Self.FParentForm.Close;
    end;

    // Asinado un botón a la tecla ESCAPE?
    if Assigned(FEscapeButton) then begin
      TButton(FEscapeButton).OnClick(Self);
    end;
  end;

  // Pulsada F1?
  if key = VK_F1 then begin
    _PulsedFunctionKey(1, Sender, Key, Shift);
  end;
  // Pulsda F2?
  if key = VK_F2 then begin
    _PulsedFunctionKey(2, Sender, Key, Shift);
  end;
  if key = VK_F3 then begin
    _PulsedFunctionKey(3, Sender, Key, Shift);
  end;
  if key = VK_F4 then begin
    _PulsedFunctionKey(4, Sender, Key, Shift);
  end;
  if key = VK_F5 then begin
    _PulsedFunctionKey(5, Sender, Key, Shift);
  end;
  if key = VK_F6 then begin
    _PulsedFunctionKey(6, Sender, Key, Shift);
  end;
  if key = VK_F7 then begin
    _PulsedFunctionKey(7, Sender, Key, Shift);
  end;
  if key = VK_F8 then begin
    _PulsedFunctionKey(8, Sender, Key, Shift);
  end;
  if key = VK_F9  then begin
    _PulsedFunctionKey(9, Sender, Key, Shift);
  end;
  if key = VK_F10 then begin
    _PulsedFunctionKey(10, Sender, Key, Shift);
  end;

  // Activada la tecla de ir al control anterior?
  if (Self.FPriorControlOnALTLeft) then begin
    if (key = VK_LEFT) then begin
      // Pulsado ALT y no las otras
      if ((ssAlt in Shift) and
          (not (ssShift in Shift)) and
          (not (ssCtrl in Shift))) then begin

        // Control siguiente
        Self.FParentForm.Perform (WM_NEXTDLGCTL, Integer(goPREVCTL), 0);
      end;
    end;
  end;

  // Activada la tecla de ir al control Siguiente?
  if (Self.FNextControlOnALTRight) then begin
    if (key = VK_RIGHT) then begin
      // Pulsado ALT y no las otras
      if ((ssAlt in Shift) and
          (not (ssShift in Shift)) and
          (not (ssCtrl in Shift))) then begin

        // Control siguiente
        Self.FParentForm.Perform (WM_NEXTDLGCTL, Integer(goNEXTCTL), 0);
      end;
    end;
  end;

end;

//: Se ejecuta cuando se pulsa una tecla de función; Para pasar al botón asociado.
procedure TKeysOnForm._PulsedFunctionKey(Index: Integer; Sender: TObject;
                                         var Key: Word; Shift: TShiftState);
var
  Comp:TControl;
begin

  // Sólo nos interesan si ha pulsado las teclas de función solas...
  if (ssShift in Shift) or
     (ssAlt in Shift) or
     (ssCtrl in Shift) then begin
    Exit;
  end;

  // Asignado el evento ?
  if Assigned(FOnFunctionKeys[Index]) then begin
    FOnFunctionKeys[Index](Sender, key, Shift);
  end;

  // Asignado el botón ?
  if Assigned(FFunctionKeysButton[Index]) then begin
    Comp := FFunctionKeysButton[Index];

    if (Comp is TButton) then begin
      TButton(Comp).OnClick(Self);
    end;
    if (Comp is TSpeedButton) then begin
      TSpeedButton(Comp).OnClick(Self);
    end;
  end;
end;

end.
