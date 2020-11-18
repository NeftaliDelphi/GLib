{: TSortListBox  Component Version 1.4 - Suite GLib
   Copyright (©) 2020,  by Germán Estévez (Neftalí)

  Componente de lista con imágenes de ordenar.
  Componente de lista pensado paa sacar una serie de elementos con posibilidad
  de que a cada elemento se le pueda asignar un estado binario (en este caso
  una ordenación DESCENDENTE/DESCENDENTE).
    Deriva de una lista estandard.
    Funciona con ratón (Click) y con teclado (ENTER).
    Añade la propiedad SORTDESC de tipo indice que devuelve un booleano.

@author   	Germán Estévez
@email		  german_ral@hotmail.com
}
unit CSortListBox;
{=========================================================================

  CSortListBox

  Componente

  Propósito : Componentes Lista con ordenación (extra) en las filas.

========================================================================

  Errores detectados no corregidos

=========================================================================}

//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics;

type
  TSortListBox = class(TListBox)
  private
    { Private declarations }
    // Método de redibujado propio
    procedure _MyDrawItem(Control: TWinControl; Index: Integer; Rect:
                          TRect; State: TOwnerDrawState);
    function GetSortDESC(index: Integer): Boolean;
    procedure SetSortDESC(index: Integer; const Value: Boolean);
  protected
    { Protected declarations }
    procedure KeyPress(var Key: Char); override;
  public
    { Public declarations }
    // Constructor de la clase
    constructor Create(AOwner: TComponent); override;
    //: Propiedad que me permite obtener la ordenación de cada elemento.
    property SortDESC[index:Integer]:Boolean read GetSortDESC write SetSortDESC;
    //: Captura el evento del Click (lo necesitamos publico para simularlo)
    procedure MyClick(Sender: TObject; Button: TMouseButton;
                      Shift: TShiftState; X, Y: Integer);

  published
    { Published declarations }
  end;


procedure Register;

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  Dialogs;


{ TSortListBox }

procedure Register;
begin
  RegisterComponents('GLib', [TSortListBox]);
end;

//: Captura el clik sobre la imagen.
procedure TSortListBox.MyClick(Sender: TObject; Button: TMouseButton;
                                Shift: TShiftState; X, Y: Integer);
var
  Str:String;
  Offset: Integer;
begin

  // Para evitar Conflictos con el docle click
  if (Self.Items.Count = 0) then begin
    Exit;
  end;

  Offset := 12;

  if (X > Offset) then begin
    Exit;
  end;

  Str := Self.Items[ItemIndex];

  // Apuntador dde Object = nil (inicial) ==> DESCendente
  // Si está asignadoo ==> Descendente
  inherited;

  if not Assigned(Self.Items.Objects[ItemIndex]) then begin
    // DESCENDENTE; Object=nil
    Self.Items.Objects[ItemIndex] := Self;
  end
  else begin
    // DESCENDENTE; Object=Self
    Self.Items.Objects[ItemIndex] := nil;
  end;

  // repintar
  Self.Items[ItemIndex] := Self.Items[ItemIndex];

end;

{: Constructor de la clase}
constructor TSortListBox.Create(AOwner: TComponent);
begin
  inherited;

  // Asignar los eventos que voy a capturar desde el componente
  inherited OnDrawItem := _MyDrawItem;
  inherited OnMouseUp := MyClick;
  inherited Style := lbOwnerDrawFixed;

end;

//: Redibujado interno (para los bitmaps de DESC y DESC)  
procedure TSortListBox._MyDrawItem(Control: TWinControl; Index: Integer;
                                   Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  Offset: Integer;
begin

  // Para evitar Conflictos con el docle click
  if (Self.Items.Count = 0) then begin
    Exit;
  end;

  Offset := 12;
  Self.Canvas.FillRect(Rect);
  Bitmap := Graphics.TBitmap.Create();

  // Asignado?n
  if not Assigned(Self.Items.Objects[Index]) then begin
    // DESCENDENTE; Valor = nil
    Bitmap.LoadFromResourceName (HInstance, 'SORT_UP');
  end
  else begin
    // DESCENDENTE; Value = Self
    Bitmap.LoadFromResourceName(HInstance, 'SORT_DOWN');
  end;

  if (Bitmap <> nil) then begin
    Self.Canvas.BrushCopy(
        Bounds(Rect.Left + 4, Rect.Top + 4, Bitmap.Width-1, Bitmap.Height-1),
        Bitmap,
        Bounds(1, 1, Bitmap.Width-1, Bitmap.Height-1),
        clFuchsia);

    Offset := Bitmap.width + 8;
  end;

  Self.Canvas.TextOut(Rect.Left + Offset, Rect.Top, Self.Items[Index]);

end;


function TSortListBox.GetSortDESC(index: Integer): Boolean;
begin
  Result := (Assigned(Self.Items.Objects[Index]));
end;

procedure TSortListBox.SetSortDESC(index: Integer; const Value: Boolean);
begin

  // Asiggnar valor o nil
  if (Value) then begin
    Self.Items.Objects[Index] := Self;
  end
  else begin
    Self.Items.Objects[Index] := nil;
  end;

  // Repintar
  Self.Items[Index] := Self.Items[Index];
  Self.Repaint;

end;

procedure TSortListBox.KeyPress(var Key: Char);
var
  b:Boolean;
begin
  inherited;

  // Se ha pulsado espacio?
  if (key = ' ') then begin
    // Hay alguno activo?
    if (Self.ItemIndex <> -1) then begin
      b := Self.SortDESC[Self.ItemIndex];
      if (b) then begin
        Self.SortDESC[Self.ItemIndex] := False;
      end
      else begin
        Self.SortDESC[Self.ItemIndex] := True;
      end;
    end;
  end;

end;

end.
