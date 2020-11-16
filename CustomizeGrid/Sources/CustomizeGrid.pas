{
TCustomizeGrid  Component Version 1.3 - Suite GLib
Copyright (©) 2005-2006,  by Germán Estévez (Neftalí)

  Permite modificar algunos aspectos en la visualización de un Grid estandard. No
deriva del Grid, si no que funciona como complemento al componente estandard de
Delphi.
  Permite dibujar las columnas de tipo Memo y de Tipo Boolean como texto y 
  como checkbox respectivamente sin ningun código.
  La propiedad Flat permite modificar el aspecto del DBGrid.
  Además provee eventos para modificar colores del DBGrid:
  	* OnPaintCell: Para pintar xeldas de un determinado color.
  	* OnPaintCellExt: BIS del anterior con más parámetros.
  	* OnPaintColumn: Permite pintar una columna de color.
    	* OnPaintRow: Permite pintar una file de color.
    	* OnPaintCellImage: Permite pintar imágenes en una celda.
    	* OnChangeTitleCell: Modificar las celdas de título.

  Éstos eventos son independientes y compatibles con los que tiene definidos el
DBGrid.
  Basta con soltar el control en el formulario, asignarle el Grid y activarlo.
  
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
unit CustomizeGrid;
{
=========================================================================

  CustomizeGrid.pas

  Componente

  Propósito : Componente que permita realizar de forma sencilla (utilizando
  eventos específicos) cambios en el aspecto del Grid (los más comunes) referentes
  a colores de celdas, filas y columnas.
  IMPORATENTE: Funciona con el DBGrid estandard.

========================================================================
  Historia de las Versiones
------------------------------------------------------------------------

  21/06/2005  Germán Estévez

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
  Windows, Messages, SysUtils, Classes, DBGrids, Grids, DB, Graphics,
  {$IFDEF VER140}
  StrUtils,
  {$ENDIF}
  Controls;

type
  //: Permite acceder a prop. del componente (DBGrid) no accesibles normalmente.
  TCrackDBGrid = class(TDBGrid);

  {: Estilos para el "pintado" del Grid.
    @enum sgStandard    Lo pinta de la forma estandard (delphi).
    @enum sgFlat        Lo pinta en modo Flat (plano).}
  TStyleGrid = (sgStandard, sgFlat);

  {:Define diferentes tipos de estilos para el Grid.
    @enum tmDefault     Tonos por defecto.
    @enum tmGray        Tonos Grises.}
  TGridTheme = (tmDefault, tmGray);

  //: Tipo para definir el evento de modificar una celda de título
  TOnChangeTitleCell = procedure (FieldName:String; Field:TField;
                                  DataCol: Integer; Column: TColumn;
                                  var CellColor:TColor;
                                  var TitleFont:TFont;
                                  var Change:Boolean) of object;

  //: Tipo para definir el evento de pintado de una imagen en una celda.
  TOnPaintCellImage = procedure (FieldName:String; Field:TField;
                                 var Bitmap:TBitmap;
                                 var Change:Boolean) of object;
  //: Tipo para definir el evento de pintado de una celda.
  TOnPaintCell = procedure (FieldName:String; Field:TField;
                            var CellColor:TColor;
                            var ChangeColor:Boolean) of object;
  //: Tipo para definir el evento de pintado de una fila.
  TOnPaintRow = procedure (DS:TDataset;
                           var RowColor:TColor;
                           var ChangeColor:Boolean) of object;
  //: Tipo para definir el evento de pintado de una columna.
  TOnPaintColumn = procedure (FieldName:String; Field:TField;
                              DataCol: Integer; Column: TColumn;
                              var ColColor:TColor;
                              var ChangeColor:Boolean) of object;
  //: Tipo para definir el evento de pintado de una celda (extendido).
  TOnPaintCellExt = procedure (Sender: TObject; const Rect: TRect;
                               DataCol: Integer; Column: TColumn;
                               State: TGridDrawState;
                               FieldName:String; Field:TField;
                               var CellColor:TColor;
                               var ChangeColor:Boolean) of object;

  //??????
  TStateSort = (asNone, asAsc, asDesc);

  // Definicion por avanzado
  TCustomizeGrid = class;

  {: Clase para los diferentes estilos del Grid. }
  TDataStyles = class(TPersistent)
  private
    FCheckBox: Boolean;
    FTextMemos: Boolean;
    FOwner:TCustomizeGrid;
    
    procedure SetCheckBox(const Value: Boolean);
    procedure SetTextMemos(const Value: Boolean);

  public
    // Constructor redefinido
    constructor Create(Owner:TCustomizeGrid);
  published
    //: Si se pinta el texto de los memos.
    property TextMemos:Boolean read FTextMemos write SetTextMemos;
    //: Si se pintan los Check box en lugar del texto.
    property CheckBox:Boolean read FCheckBox write SetCheckBox;
  end;

  {: Clase que agrupa las opciones de ordenacion del Grid.}
  TSortOptions = class(TPersistent)
  private
    FOwner:TCustomizeGrid;
    FChangeCursorOnTitle: Boolean;

    procedure SetChangeCursorOnTitle(const Value: Boolean);

  public
    // Constructor redefinido
    constructor Create(Owner:TCustomizeGrid);
  published
    //: Si se ambia el cursor al pasar por el título.
    property ChangeCursorOnTitle:Boolean read FChangeCursorOnTitle write SetChangeCursorOnTitle;
  end;



  {:Clase Para definir la estructura para la propiedad FlatStyle.}
  TFlatStyle = class(TPersistent)
  private
    FActive: Boolean;
    FFlatTheme: TGridTheme;
    FOwner:TCustomizeGrid;
    // Métodos privados de las propiedades
    procedure SetActive(const Value: Boolean);
    procedure SetTheme(const Value: TGridTheme);
  public
    // Constructor redefinido
    constructor Create(Owner:TCustomizeGrid);
  published
    //: Si se activa el estilo Flat.
    property Active:Boolean read FActive write SetActive;
    //: Propiedad que indica el tema de coloreado...
    property FlatTheme: TGridTheme read FFlatTheme write FFlatTheme;
  end;

  {: Algunos estilos predefinidos.
    @enum asStandard        Coloracion predefinda.}
  TAlternativeStyles = (asStandard, asDesert, asSky, asGray, asOxid, asDarkSky,
                        asTeal, asSunny, asQuantum);

  {:Clase Para definir la estructura para la prop. AlternativeColors.}
  TAlternativeColors = class(TPersistent)
  private
    FActive: Boolean;
    FColor1: TColor;
    FColor2: TColor;
    FOwner:TCustomizeGrid;
    FStyle: TAlternativeStyles;
    // Métodos privados de las propiedades
    procedure SetActive(const Value: Boolean);
    procedure SetColor1(const Value: TColor);
    procedure SetColor2(const Value: TColor);
    procedure SetStyle(const Value: TAlternativeStyles);
  public
    // Constructor redefinido
    constructor Create(Owner:TCustomizeGrid);
  published
    //: Si se activa el coloreado alternativo.
    property Active:Boolean read FActive write SetActive;
    //: Propiedad que indica el primer color del coloreado alternativo.
    property Color1: TColor read FColor1 write SetColor1;
    //: Propiedad que indica el segundo color del coloreado alternativo.
    property Color2: TColor read FColor2 write SetColor2;
    //: Algunos estilos predefinidos.
    property Style:TAlternativeStyles read FStyle write SetStyle;
  end;

  {:Clase para el componente TCustomizeGrid.
    El componente se utiliza para modificar propiedades del DBGrid que no
    existen en el estandard de Delphi, y para publicar eventos de pintado y
    formato que no existen en el copmponente estandard de Delphi.
    @seealso clase TDBGrid : <see class="TDBGrid">
  }
  TCustomizeGrid = class(TComponent)
  private
    // eventos que capturamops del Grid
    _OLDDrawColumnCell:TDrawColumnCellEvent;
    _OLDMouseMove: TMouseMoveEvent;
    _OLDTitleClick: TDBGridClickEvent;
    _OldAfterScroll: TDataSetNotifyEvent;

    FGrid: TDBGrid;
    FActive: Boolean;
    FStyleGrid: TStyleGrid;
//    FFlatStyle: TFlatStyle;
    FAlternateRows:TAlternativeColors;

    FOnPaintCell: TOnPaintCell;             // pintar una celda
    FOnPaintCellExt: TOnPaintCellExt;       // pintar una celda extendido
    FOnPaintColumn: TOnPaintColumn;         // pintar un columna
    FOnPaintRow: TOnPaintRow;               // pintar una fila
    FOnPaintCellImage: TOnPaintCellImage;   // Añadir imagen a una celda
    FOnChangeTitleCell: TOnChangeTitleCell;
    FDataStyles: TDataStyles; // Modificar fuente y color de celdas de título.
    FSortOptions: TSortOptions; // Opciones de ordenacion
    FSortStates:TStringList;

//+G PENDIENTE    Pendiente    FFixedCols: Integer;

    procedure SetGrid(const Value: TDBGrid);
    procedure SetStyleGrid(const Value: TStyleGrid);
    procedure SetActive(const Value: Boolean);
//+G PENDIENTE    procedure SetFixedCols(const Value: Integer);

    // procedimiento para pintar una celda.
    procedure MyDrawColumnCell(Sender: TObject; const Rect: TRect;
                               DataCol: Integer; Column: TColumn;
                               State: TGridDrawState);
    // procedimiento para capturar movimiento del ratón
    procedure MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    // Procedimiento para capturar el evento de click en la fila de titulos
    procedure MyTitleClick(Column: TColumn);
    // captura el AfterScroll del dataset.
    procedure MyAfterScroll (DataSet: TDataSet);


    procedure _PaintArrowUp(Canvas: TCanvas; var Rect: TRect);
    procedure _PaintArrowDown(Canvas: TCanvas; var Rect: TRect);

    // Ordenacion para una determinada columna.
    function _AppliedSort(AColumn:TColumn):TStateSort;
    procedure _ApplySort(AColumn:TColumn; SortState:TStateSort);

  protected
    { Protected declarations }
  public
    // Redefnimos el constructor.
    constructor Create(AOwner: TComponent); override;
    // Redefnimos el destructor.
    destructor Destroy; override;
    // Refresca el Grid (Paint)
    procedure RefreshGrid();

  published

    //: Si el control está funcionando o desactivado
    property Active:Boolean read FActive write SetActive;
    //: Apuntador al Grid que se quiere modificar.
    property Grid:TDBGrid read FGrid write SetGrid;
//    //: Modifica aspecto del Grid (FLAT)
//    property FlatStyle:TFlatStyle read FFlatStyle write FFlatStyle;
    //: Propiedad que permite pitar con colores alternativos.
    property AlternateRows:TAlternativeColors read FAlternateRows write FAlternateRows;
    //: Modificadores del estilo de los datos.
    property DataStyles:TDataStyles read FDataStyles write FDataStyles;
    //: Opciones de ordenacion el Grid
    property SortOptions: TSortOptions read FSortOptions write FSortOptions;

//+G PENDIENTE    property FixedCols:Integer read FFixedCols write SetFixedCols;


    // Eventos de pintado del Grid...
    //=============================================================
    //: Pintar de color una celda del Grid a partir del valor de un campo.
    property OnPaintCell:TOnPaintCell read FOnPaintCell write FOnPaintCell;
    //: Pintar de color una celda del Grid apartir del valor de un campo(modo extendido).
    property OnPaintCellExt:TOnPaintCellExt read FOnPaintCellExt write FOnPaintCellExt;
    //: Pintar de color toda la columna del Grid
    property OnPaintColumn:TOnPaintColumn read FOnPaintColumn write FOnPaintColumn;
    //: Pintar de color toda la fila del Grid
    property OnPaintRow:TOnPaintRow read FOnPaintRow write FOnPaintRow;
    //: Pintar una celda del Grid con una imagen a partir del valor de un campo.
    property OnPaintCellImage:TOnPaintCellImage read FOnPaintCellImage write FOnPaintCellImage;
    //: Modificar una celda de títulos
    property OnChangeTitleCell:TOnChangeTitleCell read FOnChangeTitleCell write FOnChangeTitleCell;
  end;

// constantes
const
  //: Constante para definir la cadena vacía.
  STR_EMPTY = '';
  // Constante para el cursor nuevo de ordenación
  CRMYCURSOR = 99;
  CURSORSORT = 'CURSORSORT';

// procedimiento de registro del componente.
procedure Register;

//=========================================================================
//
// I M P L E M E N T A T I O N
//
//=========================================================================
implementation

uses
  Dialogs,
  {$IFDEF VER140}
  Types,
  {$ENDIF}
  FlatSB, CommCtrl, MAth, Forms;

{:Permite registrar el componente en la paleta de componentes.
  @param  Sin parametros.
}
procedure Register();
begin
  RegisterComponents('GLib', [TCustomizeGrid]);
end;

//: Redefinimos el constructor de la clase.
constructor TCustomizeGrid.Create(AOwner: TComponent);
begin
  inherited;
  // Crear privadas
//  Self.FFlatStyle := TFlatStyle.Create(Self);
  Self.FAlternateRows := TAlternativeColors.Create(Self);
  Self.FDataStyles := TDataStyles.Create(Self);
  Self.FSortOptions := TSortOptions.Create(Self);
//+G PENDIENTE  Self.FFixedCols := 0;

  FSortStates := TStringList.Create();
  FSortStates.Duplicates := dupIgnore;
  FSortStates.Sorted := True;

  // Cursor de ordenacion
  Screen.Cursors[CRMYCURSOR] := LoadCursor(HInstance, CURSORSORT);


end;


destructor TCustomizeGrid.Destroy;
begin

//  // Asignado?
//  if Assigned(FFlatStyle) then begin
//    FreeAndNil(FFlatStyle);
//  end;
  if Assigned(FAlternateRows) then begin
    FreeAndNil(FAlternateRows);
  end;
  if Assigned(FDataStyles) then begin
    FreeAndNil(FDataStyles);
  end;
  if Assigned(FSortOptions) then begin
    FreeAndNil(FSortOptions);
  end;
  if Assigned(FSortStates) then begin
    FreeAndNil(FSortStates);
  end;

  inherited;
end;


// captura el AfterScroll del dataset.
procedure TCustomizeGrid.MyAfterScroll(DataSet: TDataSet);
begin

  // Lanzamos el evento programado anteriormente
  if Assigned(_OldAfterScroll) then begin
    _OldAfterScroll(DataSet);
  end;

  // Repintar
  Self.FGrid.Invalidate;

end;

{:Procedimiento propio de dibujado de las celdas del Grid.}
procedure TCustomizeGrid.MyDrawColumnCell(Sender: TObject; const Rect: TRect;
                                          DataCol: Integer; Column: TColumn;
                                          State: TGridDrawState);
const
  CHECKMARK_WIDTH  = 13;        // Anchura para la marca de booleanos
  CHECKMARK_HEIGHT = 13;        // Altura para la marca de booleanos
  SCROLLBAR_WIDTH  = 24;        // Anchura del scroll bar

var
  _NewColor:TColor;
  _MustPaint, _MustPaintBitmap, _MustPaintText:Boolean;
  _Bitmap:TBitmap;
  _CellRect:TRect;
  _point:TPoint;


  //············································································
  procedure __DrawMemoCell(ACanvas: TCanvas; const Rect: TRect; Value:String; AColor:TColor);
  const
     DX = 5;
     DY = 2;
     CHAR_SPACE = ' ';
   var
     Str:String;
   begin
     // Es un Blob?
     if(Column.Field is TMemoField) then begin
       Str := TMemoField(Column.Field).AsString;
       // Cambiar los saltos de carro por espacios
       {$IFDEF VER140}
       Str := AnsiReplaceStr(Str, #10#13, CHAR_SPACE);
       Str := AnsiReplaceStr(Str, #13#10, CHAR_SPACE);
       {$ELSE}
       Str := StringReplace(Str, #10#13, CHAR_SPACE, [rfReplaceAll]);
       Str := StringReplace(Str, #13#10, CHAR_SPACE, [rfReplaceAll]);       
       {$ENDIF}
       ACanvas.Brush.Color := AColor;
       ACanvas.TextRect(Rect, Rect.Left + DX, Rect.Top + DY, Str);
     end;
  end;
  //············································································
  procedure __DrawBooleanCell(ACanvas: TCanvas; const Rect: TRect; Value:Boolean; AColor:TColor);
  var
    DrawState : Integer;
    DrawRect : TRect;
    ActualPenColor : TColor;

  begin

  if (Value) then begin
    DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
  end
  else begin
    DrawState := DFCS_BUTTONCHECK;
//    end
//    else begin
//      DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
//    end;
  end;


//    aaaaaaaaaaaaaa
//    FALTA al Editar

    // Calcular el área de pintado (Lo centraremos en la celda)
    DrawRect.Left := Rect.Left + (Rect.Right - Rect.Left - CHECKMARK_WIDTH) div 2;
    DrawRect.Top := Rect.Top + (Rect.Bottom - Rect.Top - CHECKMARK_HEIGHT) div 2;
    DrawRect.Right := DrawRect.Left + CHECKMARK_WIDTH;
    DrawRect.Bottom := DrawRect.Top + CHECKMARK_HEIGHT;

    // Guardamos el color actual
    ActualPenColor := ACanvas.Pen.Color;
    // Definir el color de pintado
    ACanvas.Pen.Color := clBtnShadow;
    // Definir el fondo
    ACanvas.Brush.Color := AColor;
    // Pintado del fondo
    ACanvas.FillRect(Rect);
    // Dibuja el recuadro
    ACanvas.Rectangle(DrawRect);

    // Dibujamos la marca del Check
    DrawFrameControl(ACanvas.Handle, DrawRect,
                    DFC_BUTTON, DrawState or DFCS_FLAT);

    // Restaurar el color que había nates
    ACanvas.Pen.Color := ActualPenColor;

  end;
  //············································································
  procedure __DrawCellImage(Rect: TRect; Bitmap:TBitmap);
  var
    X,Y:Integer;
    ColHeight, ColWidth:Integer;
    DestRect:TRect;
  begin

    // Borrar el cuadro...
    if (gdSelected in State) then begin
      FGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end
    else begin
      FGrid.Canvas.FillRect(Rect);
      FGrid.Canvas.Brush.Color := FGrid.Color;
    end;

    // Pintar
    if Assigned(Bitmap) then begin
      // Hay algo?
      if not (Bitmap.Empty) then begin

        // Dimensiones de columna
        ColHeight := Rect.Bottom - Rect.Top;
        ColWidth := Rect.Right - Rect.Left;

        // posicion
        X := Rect.Left + (Rect.Right - Rect.Left - Min(Bitmap.Width, ColWidth)) div 2;
        Y := Rect.Top + (Rect.Bottom - Rect.Top - Min(Bitmap.Height, ColHeight)) div 2;
        // Pintar
        DestRect := Bounds(X, Y , Min(Bitmap.Width, ColWidth),
                           Min(Bitmap.Height, ColHeight));
        // Coiar el bitmap
        FGrid.Canvas.BrushCopy(DestRect, Bitmap, Bitmap.Canvas.ClipRect, Bitmap.Canvas.Pixels[0,0]);
      end;
    end;
  end;
  //············································································
  // Repinta el Grid para darle estilo FLAT.
  procedure __DrawGridFlatStyle();
  const
    INITIAL_FIXED_COLOR = clBtnFace;  // {$00464646}
    INITIAL_SELECTED_COLOR = clHighLight{clGrayText};
  var
    TitRect, IndRect, CellRect:TRect;
    _fixedColor, _SelColor, _TitleColor:TColor;
  begin

//    // Segun el tema...
//    if (Self.FFlatStyle.FlatTheme = tmDefault) then begin
//      _fixedColor := FGrid.FixedColor;
//      _SelColor := clHighLight;
//      _TitleColor := clBlack;
//    end
//    else begin
//      _fixedColor := $00464646;
//      _SelColor := clGrayText;
//      _TitleColor := clWhite;
//    end;

//+G PENDIENTE
//      if (DataCol < FixedCols) then begin
//
//        FGrid.FixedColor := _fixedColor;
//
//        // Rectangulo para la columna de selección
//        CellRect.Left := Rect.Left;
//        CellRect.Right := Rect.Right;
//        CellRect.Top := Rect.Top;
//        CellRect.Bottom := Rect.Bottom;
//        // Color
//        FGrid.Canvas.Pen.Color := clLtGray;
//        FGrid.Canvas.Brush.Color := _fixedColor;
//        // Rectangulo de seleccion
//        FGrid.Canvas.Rectangle(CellRect);
//
//        FGrid.Canvas.Pen.Color := clBlack;
//        _point.X := Rect.Left + 1;
//        _point.Y := Rect.Bottom;
//        FGrid.Canvas.PenPos := _point;
//        FGrid.Canvas.LineTo(Rect.Right, Rect.Bottom + 1);
//        // Vertical
//        _point.X := Rect.Right;
//        _point.Y := Rect.Top + 1;
//        FGrid.Canvas.PenPos := _point;
//        FGrid.Canvas.LineTo(Rect.Right, Rect.Bottom + 1);
//      end;


    // ============================  TITULO  ================================
    // Rectangulo para las celdas de títulos
    TitRect.Left := Rect.Left;
    TitRect.Right := Rect.Right;
    TitRect.Top := 0;
    TitRect.Bottom := 17;
    // Color por defecto para Flat
    FGrid.Canvas.Pen.Color := clLtGray;
    FGrid.Canvas.Brush.Color := _fixedColor;
    // Rectágulo para celda de títulos
    FGrid.Canvas.Rectangle(TitRect);

    // Color de fuente
    FGrid.Canvas.Font.Size := FGrid.TitleFont.Size;
    FGrid.Canvas.Font.Color := _TitleColor;
    FGrid.Canvas.TextRect(
      Bounds(TitRect.Left + 1, TitRect.Top + 1, TitRect.Right - TitRect.Left - 2,
             TitRect.Bottom - TitRect.Top - 2), TitRect.Left + 2, TitRect.Top + 2,
             Column.FieldName);
    FGrid.Canvas.Font.Size := FGrid.Font.Size;

    // ======================= CUADRO SELECCION   =============================
    // Está el cuadro de seleccion
    if (dgIndicator in FGrid.Options) and (DataCol = 0) then begin
      // Rectangulo para la columna de selección
      IndRect.Left := 0;
      IndRect.Right := 11;
      IndRect.Top := Rect.Top;
      IndRect.Bottom := Rect.Bottom;
      // Color
      FGrid.Canvas.Brush.Color := _fixedColor;
      // Rectangulo de seleccion
      FGrid.Canvas.Rectangle(IndRect);

      // ======================= RECTANGULO DE MENU   ==========================
      IndRect.Left := 0;
      IndRect.Right := 11;
      IndRect.Top := 0;
      IndRect.Bottom := 17;
      // Color
      FGrid.Canvas.Brush.Color := _fixedColor;
      // Pitado
      FGrid.Canvas.Rectangle(IndRect);
    end;

    // Seleccionado
    if (gdSelected in State) then begin
      FGrid.Canvas.Brush.Color := _SelColor;
      TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
  //············································································

begin

  // Lanzamos el evento programado anteriormente
  if Assigned(_OLDDrawColumnCell) then begin
    _OLDDrawColumnCell(Sender, Rect, DataCol, Column, State);
  end;

  // No está activo ?
  if not (Self.FActive) then begin
    Exit;
  end;

  // No asignado el Grid?
  if not Assigned(FGrid) then begin
    Exit;
  end;

  // No asignado el DatsSource?
  if not Assigned(FGrid.DataSource) then begin
    Exit;
  end;

  // No asinado el DatsSet?
  if not Assigned(FGrid.DataSource.DataSet) then begin
    Exit;
  end;

  // No asignada la columna?
  if not Assigned(Column) then begin
    Exit;
  end;

  // No asignado el Campo?
  if not Assigned(Column.Field) then begin
    Exit;
  end;

//  // Está activo el modo Flat?
//  if (Self.FFlatStyle.Active) then begin
//    // Dibujar en modo flat
//    __DrawGridFlatStyle();
//  end;


//+G PENDIENTE
//    // Columnas fijas...
//    if (not (dgIndicator in FGrid.Options)) and (DataCol < FFixedCols) and
//       (not (Self.FFlatStyle.Active))    then begin
//
//       Exit;
//        ///     aaaaaaaaaaaaa
//      // Rectangulo para las celdas  fijas
//      _CellRect.Left := Rect.Left;
//      _CellRect.Right := Rect.Right;
//      _CellRect.Top := Rect.Top;
//      _CellRect.Bottom := Rect.Bottom;
//      // Color por defecto para Flat
//      _NewColor := FGrid.FixedColor;
//      // Rectágulo para celda de títulos
//      TDBGrid(Sender).Canvas.Brush.Color := FGrid.FixedColor;
//      TDBGrid(Sender).Canvas.Rectangle(_CellRect);
//
//      _MustPaint := True;
//      Exit;
//    end;


  // Iniclaizar parametros
  _NewColor := FGrid.Color;
  _MustPaint := False;
  _Bitmap := TBitmap.Create();
  _MustPaintBitmap := False;
  _MustPaintText := True;

  // proteccion para liberar
  try

    // Lanzar el evento de pintado de las celdas con Imagenes
    if Assigned(Self.FOnChangeTitleCell) then begin

      Self.FOnPaintCellImage(Column.FieldName, Column.Field, _Bitmap, _MustPaintBitmap);
      // Se debe pintar la imagen
      if (_MustPaintBitmap) then begin
        //... ointar imagen en la celda
        __DrawCellImage(Rect, _Bitmap);
        _MustPaintText := False;
      end;
    end;

    // Lanzar el evento de pintado de las celdas con Imagenes
    if Assigned(Self.FOnPaintCellImage) then begin
      Self.FOnPaintCellImage(Column.FieldName, Column.Field, _Bitmap, _MustPaintBitmap);
      // Se debe pintar la imagen
      if (_MustPaintBitmap) then begin
        //...
        __DrawCellImage(Rect, _Bitmap);
        _MustPaintText := False;
      end;
    end;

    // No seleccionada la fila?
    if not (gdSelected in State) or
       ((gdSelected in State) and (csDesigning in ComponentState)) then begin
      // Asignado el DataSource?
      if Assigned(FGrid.DataSource) then begin
        // Asignado el DataSet?
        if Assigned(FGrid.DataSource.DataSet) then begin
          // Lanzar el evento de pintado de las filas
          if Assigned(Self.FOnPaintRow) then begin
            Self.FOnPaintRow(FGrid.DataSource.DataSet, _NewColor, _MustPaint);
          end
          else begin
            // Sólo lo tenemos en cuenta si no se asigna el evento de pintar líneas

            // Está activo el modo de "Lieneas alternativas"?
            if (Self.FAlternateRows.Active) then begin
              // Se debe pintar con el 1 o con el 2?
              if ((Rect.Top div (Rect.Bottom - Rect.Top + 1)) mod 2) = 0 then begin
                _NewColor := Self.FAlternateRows.Color1;
              end
              else begin
                _NewColor := Self.FAlternateRows.Color2;
              end;
              _MustPaint := True;
            end;

          end;
        end;
      end;
    end;

    // Pintar celdas con ChekBox?
    if (Self.DataStyles.CheckBox) then begin
      // Campo Boleano?
      if (Column.Field is TBooleanField) then begin
        __DrawBooleanCell(FGrid.Canvas, Rect, Column.Field.AsBoolean, _NewColor);
        Exit;
      end;
    end;

    // Pintar celdas De memos?
    if (Self.DataStyles.TextMemos) then begin
      // Campo Memo?
      if (Column.Field is TMemoField) then begin
        __DrawMemoCell(FGrid.Canvas, Rect, Column.Field.AsString, _NewColor);
        Exit;
      end;
    end;

    // Lanzar el evento de pintado de las columnas
    if Assigned(Self.FOnPaintColumn) then begin
      Self.FOnPaintColumn(Column.FieldName, Column.Field, DataCol, Column, _NewColor, _MustPaint);
    end;

    // Lanzar el evento de pintado de las celdas
    if Assigned(Self.FOnPaintCell) then begin
      Self.FOnPaintCell(Column.FieldName, Column.Field, _NewColor, _MustPaint);
    end;

    // Lanzar el evento de pintado de las celdas (modo Extendido)
    if Assigned(Self.FOnPaintCellExt) then begin
      Self.FOnPaintCellExt(Sender, Rect, DataCol, Column, State,
                          Column.FieldName, Column.Field, _NewColor, _MustPaint);
    end;

    // Se debe pintar?
    if (_MustPaint) then begin
      // Elegir Color
      FGrid.Canvas.Brush.Color := _NewColor;
      // Pintar el texto?
      if (_MustPaintText) then begin
        // Pintar CELDA Seleccionada
        TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      end;
    end;
  // liberar
  finally
    FreeAndNil(_Bitmap);
  end;

end;

//: procedimiento para capturar movimiento del ratón
procedure TCustomizeGrid.MyMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  pt: TGridCoord;
begin

  // Lanzamos el evento programado anteriormente
  if Assigned(_OLDMouseMove) then begin
    _OLDMouseMove(Sender, Shift, X, Y);
  end;

  // Se debe pintar?
  if (Self.FSortOptions.ChangeCursorOnTitle) and (Self.Active) then begin

    // Obtener las coordenadas en el Grid
    pt:= Self.FGrid.MouseCoord(x, y);

    // Es la fila de títulos?  ==> Cambiar el cursor
    if (pt.y = 0) then begin
      Self.FGrid.Cursor := crSizeNS;
    end
    else begin
      Self.FGrid.Cursor := crDefault;
    end;
  end;
end;

//: Procedimiento para capturar el evento de click en la fila de titulos.
procedure TCustomizeGrid.MyTitleClick(Column: TColumn);
var
  cRect:TRect;
begin

  // Lanzamos el evento programado anteriormente
  if Assigned(_OLDTitleClick) then begin
    _OLDTitleClick(Column);
  end;

  Exit;

  // A partir de aquí está a medias...

  ///  PRUEBASSSSSSSSS
  if (_AppliedSort(Column) = asNone) then begin
    // Limpiar la lista
    Self.FSortStates.Clear;
    _ApplySort(Column, asAsc);
  end
  else begin
    if (_AppliedSort(Column) = asAsc) then begin
      _ApplySort(Column, asDesc);
    end
    else begin
      if (_AppliedSort(Column) = asDesc) then begin
        _ApplySort(Column, asAsc);
      end;
    end;
  end;

  // Pintar la celda?
  if (_AppliedSort(Column) <> asNone) then begin
    // Limpiar la lista
    cRect := Rect(10, 2, 30, 18);
    _PaintArrowUp(FGrid.Canvas, cRect);
  end;


end;

//: Refresca el Grid (Paint).
procedure TCustomizeGrid.RefreshGrid();
begin
  // Asignado?
  if Assigned(Self.FGrid) then begin
    Self.FGrid.Repaint;
  end;
end;


//: Procedimiento de acceso a lectura para la prop. Active.
procedure TCustomizeGrid.SetActive(const Value: Boolean);
begin

  // Asignar.
  Self.FActive := Value;

  // Repintar.
  Self.RefreshGrid;

  // Activando?
  if (Self.FActive) then begin
    // Capturar el DataSet
    if Assigned(Self.FGrid) then begin
      // Asignado el DataSet
      if Assigned(FGrid.DataSource.DataSet) then begin

        // Asignado ya el evento del Grid?  (AfterScroll)
        if Assigned(FGrid.DataSource.DataSet.AfterScroll) then begin
          // Capturar el evento
          _OldAfterScroll := FGrid.DataSource.DataSet.AfterScroll;
        end;

        // Lo "Capturamos" para realizar nuestras cosas
        FGrid.DataSource.DataSet.AfterScroll := MyAfterScroll;

      end;
    end;
  end;

end;

//+G PENDIENTE
////: Procedimiento de acceso a lectura para la prop. Grid.
//procedure TCustomizeGrid.SetFixedCols(const Value: Integer);
//begin
//  FFixedCols := Value;
//
//  // No asignado? ==> Salimos
//  if not Assigned(FGrid) then begin
//    Exit;
//  end;
//
//  TCrackDBGrid(FGrid).FixedCols := Value + 1;
//  // Repintar.
//  Self.RefreshGrid;
//end;

procedure TCustomizeGrid.SetGrid(const Value: TDBGrid);
begin

  // Ha cambiado?
  if (FGrid <> Value) then begin
    FGrid := Value;
  end;

  // No asignado? ==> Salimos
  if not Assigned(Value) then begin
    Exit;
  end;

  // Asignado ya el evento del Grid?  (OnDrawColumnCell)
  if Assigned(FGrid.OnDrawColumnCell) then begin
    // Lo redireccionamos
    _OLDDrawColumnCell := FGrid.OnDrawColumnCell;
  end;
  // "Capturamos" para realizar nuestras cosas
  FGrid.OnDrawColumnCell := MyDrawColumnCell;

  // Asignado ya el evento del Grid?  (OnMouseMove)
  if Assigned(FGrid.OnMouseMove) then begin
    // Lo redireccionamos
    _OLDMouseMove := FGrid.OnMouseMove;
  end;
  // Lo "Capturamos" para realizar nuestras cosas
  FGrid.OnMouseMove := MyMouseMove;

  // Asignado ya el evento del Grid?  (OnTitleClick)
  if Assigned(FGrid.OnTitleClick) then begin
    // Lo redireccionamos
    _OLDTitleClick := FGrid.OnTitleClick;
  end;
  // Lo "Capturamos" para realizar nuestras cosas
  FGrid.OnTitleClick := MyTitleClick;


  // Plano en el estilo?
//  Self.FGrid.Ctl3D := (not FFlatStyle.Active) and (not Self.FActive);

end;

//: Procedimiento de acceso a lectura para la prop. StyleGrid.
procedure TCustomizeGrid.SetStyleGrid(const Value: TStyleGrid);
begin

  // Ha cambiado?
  Self.FStyleGrid := Value;

  // No asignado el Grid?
  if not Assigned(FGrid) then begin
    Exit;
  end
  else begin
    // Activo?
    if (Self.FActive) then begin
      RefreshGrid;
    end;
  end;

  // Plano en el Stilo?
  Self.FGrid.Ctl3D := (FStyleGrid <> sgFlat) and (not Self.Active);

end;


{ TFlatStyle ==============================================================}

//: Constructor redefinido de la clase.
constructor TFlatStyle.Create(Owner:TCustomizeGrid);
begin
  inherited Create;

  // Inicializaciones
  Self.FActive := False;
  Self.FFlatTheme := tmGray;
  Self.FOwner := Owner;
end;


//: Método de acceso a la propiedad Active.
procedure TFlatStyle.SetActive(const Value: Boolean);
begin
  // Asignar
  FActive := Value;

  // Cambiar
  if (Value) and (FOwner.Active) then begin
    Self.FOwner.SetStyleGrid(sgFlat);
  end
  else begin
    Self.FOwner.SetStyleGrid(sgStandard);
  end;
end;

//: Método de acceso a la propiedad FlatTheme.
procedure TFlatStyle.SetTheme(const Value: TGridTheme);
begin
  // Asignar el valor
  Self.FFlatTheme := Value;
  // Asignado el Grid?
  if Assigned(Self.FOwner.Grid) then begin
    // Activo el componnte?
    if (Self.FOwner.Active) then begin
      FOwner.Grid.Refresh;
    end;
  end;
end;


{ TAlternativeColors ==========================================================}

// Redefinimos el constructor.
constructor TAlternativeColors.Create(Owner: TCustomizeGrid);
begin
  inherited Create;

  // Inicializaciones
  Self.FActive := False;
  Self.FOwner := Owner;
  Self.FStyle := asStandard;

end;


procedure TAlternativeColors.SetActive(const Value: Boolean);
begin

  // No ha cambiado el valor?
  if (Self.FActive = VAlue) then begin
    Exit;
  end;

  // Valor yrepintado
  Self.FActive := Value;
  Self.FOwner.RefreshGrid;

end;

//: Método de acceso a la propiedad Color1.
procedure TAlternativeColors.SetColor1(const Value: TColor);
begin
  // Ha cambiado?
  if (Self.FColor1 <> Value) then begin
    Self.FColor1 := Value;
    FOwner.RefreshGrid;
  end;
end;

//: Método de acceso a la propiedad Color2.
procedure TAlternativeColors.SetColor2(const Value: TColor);
begin
  // Ha cambiado?
  if (Self.FColor2 <> Value) then begin
    Self.FColor2 := Value;
    FOwner.RefreshGrid;
  end;
end;

//: Método de acceso a la propiedad Style.
procedure TAlternativeColors.SetStyle(const Value: TAlternativeStyles);
begin

  // No ha cambiado?
  if (Self.FStyle = Value) then begin
    Exit;
  end;

  // Valor.
  Self.FStyle := Value;

  // Casos posibles...
  case FStyle of
    asStandard:   begin Self.FColor1 := $00E0E0E0; Self.FColor2 := $00CECECE; end;
    asDesert:     begin Self.FColor1 := $00B6B6DA; Self.FColor2 := $00DFFFFF; end;
    asSky:        begin Self.FColor1 := $00FFFAF0; Self.FColor2 := $00FFEFCA; end;
    asGray:       begin Self.FColor1 := $00DCDCDC; Self.FColor2 := clWhite; end;
    asOxid:       begin Self.FColor1 := $00009F9F; Self.FColor2 := $00AAFFFF; end;
    asDarkSky:    begin Self.FColor1 := $00FDAB00; Self.FColor2 := $00FFDA84; end;
    asTeal:       begin Self.FColor1 := $00FFFF40; Self.FColor2 := $00C1C100; end;
    asQuantum:    begin Self.FColor1 := $00C66931; Self.FColor2 := $00F7EBDE; end;
    asSunny:      begin Self.FColor1 := $0042D7FF; Self.FColor2 := $00E7FFFF; end;
  end;

  // refrescar
  FOwner.RefreshGrid;

end;


{ TDataStyles ==============================================================}

//: Constructor redefinido de la clase.
constructor TDataStyles.Create(Owner: TCustomizeGrid);
begin

  inherited Create;

  // Inicializaciones
  Self.FOwner := Owner;
end;

procedure TDataStyles.SetCheckBox(const Value: Boolean);
begin
  // Ha cambiado?
  if (Self.FCheckBox <> Value) then begin
    Self.FCheckBox := Value;
    FOwner.RefreshGrid;
  end;
end;

procedure TDataStyles.SetTextMemos(const Value: Boolean);
begin
  // Ha cambiado?
  if (Self.FTextMemos <> Value) then begin
    Self.FTextMemos := Value;
    FOwner.RefreshGrid;
  end;
end;

{ TSortOptions }

constructor TSortOptions.Create(Owner: TCustomizeGrid);
begin
  inherited Create;
  // Inicializaciones
  Self.FOwner := Owner;
end;

procedure TSortOptions.SetChangeCursorOnTitle(const Value: Boolean);
begin

  // Ha cambiado?
  if (Self.FChangeCursorOnTitle <> Value) then begin
    Self.FChangeCursorOnTitle := Value;
  end;

end;

//: Ordenacion para una determinada columna.
function TCustomizeGrid._AppliedSort(AColumn: TColumn): TStateSort;
var
  StrValue:String;
begin

  // Está en la lista esa columna?
  StrValue := FSortStates.Values[AColumn.FieldName];
  // No está ?
  if (StrValue = STR_EMPTY) then begin
    Result := asNone;
    Exit;
  end
  else begin
    // Valor?
    if (StrValue = IntToStr(Ord(asAsc))) then begin
      Result := asAsc;
    end
    else begin
      Result := asDesc;
    end;
  end;

end;

procedure TCustomizeGrid._ApplySort(AColumn: TColumn;SortState: TStateSort);
var
  StrValue:String;
  Index:Integer;
begin
  // Está en la lista esa columna?
  StrValue := FSortStates.Values[AColumn.FieldName];
  // Encontrado ?
  if (StrValue <> STR_EMPTY) then begin
    // Cambiar el Valor
    Index := FSortStates.IndexOfName(AColumn.FieldName);
    FSortStates.Delete(Index);
  end;

  // Añadirlo
  FSortStates.Add(AColumn.FieldName + '=' + IntToStr(Ord(SortState)));

end;

procedure TCustomizeGrid._PaintArrowDown(Canvas: TCanvas; var Rect: TRect);
var
  APolyLine: Array[0..2] of TPoint;
  SaveCol, BrushCol : TColor;
begin

  // Utilizamos el canvas pasado como parámetro
  with FGrid.Canvas do begin
    // Guardar los valores actuales
    SaveCol := Pen.Color;
    BrushCol := Brush.Color;

    // Activar los nuevos valores depintado
    Brush.Style := bsSolid;
    Pen.Color := Self.FGrid.FixedColor;
    Brush.Color := Self.FGrid.FixedColor;

    // Dibujar un rectágulo debajo para tapar el título
    Rectangle(Rect.Right-13, Rect.Top+3, Rect.Right-1, Rect.Top+15);

    // Dibujamos la flecha
    Pen.Color := clGray{clBlack};
    APolyLine[0]:=Point(Rect.Right-4, Rect.Top+5);
    APolyLine[1]:=Point(Rect.Right-11, Rect.Top+5);
    APolyLine[2]:=Point(Rect.Right-8, Rect.Top+11);
    PolyLine(APolyLine);
    Pen.Color := clWhite;
    MoveTo(Rect.Right-7, Rect.Top+11);
    LineTo(Rect.Right-4, Rect.Top+5);

    // Restaurar valores guardados
    Brush.Color := BrushCol;
    Pen.Color := SaveCol;
  end;
end;

procedure TCustomizeGrid._PaintArrowUp(Canvas: TCanvas; var Rect: TRect);
var
  SaveCol, BrushCol : TColor;
begin

  // Utilizamos el canvas pasado por parámetro.
  with FGrid.Canvas do begin
    // Guardar los valores de los colores
    SaveCol := Pen.Color;
    BrushCol := Brush.Color;

    // Nuevo estilo de pintado.
    Brush.Style := bsSolid;
    Pen.Color := Self.FGrid.FixedColor;
    Brush.Color := Self.FGrid.FixedColor;

    // Rectangulo por debajo para tapar el título
    Rectangle(Rect.Right-13, Rect.Top+3, Rect.Right-1, Rect.Top+15);

    // Dibujar la flacha
    Pen.Color := clGray{clBlack};
    MoveTo(Rect.Right-11, Rect.Top+11);
    LineTo(Rect.Right-8, Rect.Top+5);
    LineTo(Rect.Right-7, Rect.Top+5);
    Pen.Color:=clWhite;
    MoveTo(Rect.Right-7, Rect.Top+5);
    LineTo(Rect.Right-4, Rect.Top+11);
    LineTo(Rect.Right-11, Rect.Top+11);

    //Restaurar los colores
    Brush.Color := BrushCol;
    Pen.Color := SaveCol;
  end;
end;

end.

