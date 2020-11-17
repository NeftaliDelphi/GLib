{
TEditInsideHelp  Component Version 1.0 - Suite GLib
Copyright (©) 2005,  by Germán Estévez (Neftalí)

  Permite definir un texto de ayuda en la parte interna del control de edición.
  El texto desaparace cuando el control contiene algun texto que el usuario ha
  añadido. Permite modificar el texto que aparece y el color de éste.
  Basta con activar la propiedad InsideHelpActive.

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
unit CEditInsideHelp;
{
=========================================================================

  CEditInsideHelp.pas

  Componente

  Propósito: Permite definir un texto de ayuda en la parte interna del control
  de edición. El texto desaparace cuando el control contiene algun texto que
  el usuario ha añadido.

========================================================================
  Historia de las Versiones
------------------------------------------------------------------------

	09/12/2008
	*		Changed InsideHelpColor by InsideHelpFont for more customization possibilities.
			(thanks Ariel Martín  from Cuba)	

  23/01/2006  Germán Estévez
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
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics;

type
  {: Clase que define el componente TEditInsideHelp.}
  TEditInsideHelp = class(TEdit)
  private
    FInsideHelpActive: Boolean;
    FInsideHelpText  : String;
    FInsideHelpFont  : TFont;

    procedure SetInsideHelpActive(const Value: Boolean);
    procedure SetInsideHelpText(const Value: String);
    procedure SetInsideHelpFont(const Value: TFont);
    procedure InsideHelpFontChange(Sender: TObject);

  protected
    //: Capturamos el evento se repintado.
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    //: Capturamos el evento de salida para pintar.
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

  public
    //: Redefinimos el constructor.
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    //: Permite definir el texto de ayuda.
    property InsideHelpText:String read FInsideHelpText write SetInsideHelpText;
    //: Permite activar la característica de ayuda interior.
    property InsideHelpActive:Boolean read FInsideHelpActive write SetInsideHelpActive;
    //: Permite definir la letra de la ayuda interior
    property InsideHelpFont : TFont read FInsideHelpFont write SetInsideHelpFont;

  end;

// Constantes para el componente
const
  DEFAULT_COLOR = clScrollBar;

procedure Register;

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  Forms;

//: Procedimniento de registro.
procedure Register;
begin
  RegisterComponents('GLib', [TEditInsideHelp]);
end;


procedure TEditInsideHelp.CMExit(var Message: TCMExit);
begin
  Self.Repaint;
end;

constructor TEditInsideHelp.Create(AOwner: TComponent);
begin
  inherited;

  // Inicializaciones
  Self.FInsideHelpActive := False;
  Self.FInsideHelpText   := Self.FInsideHelpText;

  FInsideHelpFont        := TFont.Create;
  FInsideHelpFont.Name   := 'Arial';
  FInsideHelpFont.Color  := clGray;

  FInsideHelpFont.OnChange := InsideHelpFontChange;
end;



destructor TEditInsideHelp.Destroy;
begin
  FInsideHelpFont.Free;
  inherited;
end;

procedure TEditInsideHelp.InsideHelpFontChange(Sender: TObject);
begin
  //Perform(CM_FONTCHANGED, 0, 0);
  //Pintar
  Self.Repaint;
end;

procedure TEditInsideHelp.SetInsideHelpActive(const Value: Boolean);
begin
  // Activar
  Self.FInsideHelpActive := Value;
  // repintar
  Self.Repaint;
end;

procedure TEditInsideHelp.SetInsideHelpFont(const Value: TFont);
begin
  FInsideHelpFont.Assign(Value);
  // repintar
  Repaint;  
end;

procedure TEditInsideHelp.SetInsideHelpText(const Value: String);
begin
  Self.FInsideHelpText := Value;
  // repintar
  Repaint;
end;

procedure TEditInsideHelp.WMPaint(var Message: TWMPaint);
var
  MCanvas: TControlCanvas;
  //DrawBounds: TRect;
begin

  // Casos en los que no hacemos nada
  if (Self.Text <> '') or (not Self.FInsideHelpActive) then begin
    inherited;
    Exit;
  end;

  inherited;

  MCanvas := TControlCanvas.Create;
  //DrawBounds := ClientRect;

  // proteccion
  try
    // Asignar el canvas
    MCanvas.Control := Self;

    // Pintar
    MCanvas.Brush.Color := Self.Color;
    MCanvas.Font := Self.FInsideHelpFont;
    // texto
    MCanvas.TextOut(2,2, Self.FInsideHelpText);

  finally
    MCanvas.Free;
  end;

end;



end.

