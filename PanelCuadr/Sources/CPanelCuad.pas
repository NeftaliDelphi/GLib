{
TPanelCuad  Component Version 1.0 - Suite GLib
Copyright (©) 2005,  by Germán Estévez (Neftalí)

  Permite crear un panel con cuadrícula.
  Se puede definir el color y ancho de la cuad´ricula que se quiere.

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

unit CPanelCuad;
{
=========================================================================

  CPanelCuad.pas

  Componente

  Permite crear un panel con cuadrícula.
  Se puede definir el color y ancho de la cuad´ricula que se quiere.

========================================================================
  Historia de las Versiones
------------------------------------------------------------------------

  16/03/2006  Germán Estévez

  * Creación.

=========================================================================

  Errores detectados no corregidos

=========================================================================
}

//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  {generales} Windows, Messages, SysUtils, Classes, Controls, ExtCtrls,
    Graphics;

type

  {: Clase para definir un Panel que pinte sobre él una cuadrícula. }
  TPanelCuad = class(TPanel)
  private
    FGridColor: TColor;
    FGridVisible: Boolean;
    FGridSize: Integer;
    // ,étodos de escritura de propiedades.
    procedure SetGridColor(const Value: TColor);
    procedure SetGridSize(const Value: Integer);
    procedure SetGridVisible(const Value: Boolean);

  protected
    //: Redefinimos el Paint.
    procedure Paint; override;
  public
    //: Constructor redefinido.
    constructor Create(AOwner: TComponent); override;

  published

    //: Color de la cuadricula.
    property GridColor:TColor read FGridColor write SetGridColor;
    //: Si está visible o no la Cuadrícula
    property GridVisible:Boolean read FGridVisible write SetGridVisible;
    //: Espaciado de la cuadricula.
    property GridSize:Integer read FGridSize write SetGridSize;

  end;

procedure Register;

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

procedure Register;
begin
  RegisterComponents('GLib', [TPanelCuad]);
end;

//: Constructor redefinido.
constructor TPanelCuad.Create(AOwner: TComponent);
begin
  inherited;

  // Inicializar
  FGridColor := clMaroon;
  FGridVisible := True;
  FGridSize := 8;
end;

//: Método de pintado.
procedure TPanelCuad.Paint();
var
  i,j:Integer;
begin

  inherited;

  // No hay que Pintar
  if not (Self.FGridVisible) then begin
    Exit;
  end;

  i := 0;
  j := 0;

  // pintamos...
  while (i < Self.Width) do begin
    while (j < Self.Height) do begin
      Self.Canvas.Pixels[i, j] := Self.FGridColor;
      j := j + FGridSize;
    end;
    j := 0;
    i := i + FGridSize;
  end;
end;

procedure TPanelCuad.SetGridColor(const Value: TColor);
begin
  FGridColor := Value;
  Paint;
end;

procedure TPanelCuad.SetGridSize(const Value: Integer);
begin
  FGridSize := Value;
  Paint;
end;

procedure TPanelCuad.SetGridVisible(const Value: Boolean);
begin
  FGridVisible := Value;
  Paint;
end;

end.
