unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, CustomizeGrid, StdCtrls, ExtCtrls,
  ImgList, Spin;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    pnlDerecha: TPanel;
    splVertical1: TSplitter;
    pnlCentral: TPanel;
    pnlGrid: TPanel;
    pnlInferior: TPanel;
    splHorizontal: TSplitter;
    cdbg1: TCustomizeGrid;
    chkActivar: TCheckBox;
    mmoCode: TMemo;
    rgEventos: TRadioGroup;
    ilFlags: TImageList;
    nbCodigos: TNotebook;
    mmcodigo0: TMemo;
    mmcodigo1: TMemo;
    mmcodigo2: TMemo;
    mmcodigo3: TMemo;
    mmcodigo4: TMemo;
    mmcodigo5: TMemo;
    mmcodigo6: TMemo;
    cbbTema: TComboBox;
    lblFlatStile: TLabel;
    chkAlternative: TCheckBox;
    qry2: TADOQuery;
    tblCustomers: TADOTable;
    tblVendors: TADOTable;
    dbgrd1: TDBGrid;
    cd1: TColorDialog;
    cd2: TColorDialog;
    lblColores: TLabel;
    edColor1: TPanel;
    edColor2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure CustomizeGrid1PaintCell(FieldName: String; Field: TField;
      var CellColor: TColor; var ChangeColor: Boolean);
    procedure chkActivarClick(Sender: TObject);
    procedure rgEventosClick(Sender: TObject);
    procedure cdbg1PaintCell(FieldName: String; Field: TField;
      var CellColor: TColor; var ChangeColor: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cdbg1PaintColumn(FieldName: String; Field: TField;
      DataCol: Integer; Column: TColumn; var ColColor: TColor;
      var ChangeColor: Boolean);
    procedure dbgrdDatosTitleClick(Column: TColumn);
    procedure cdbg1PaintRow(DS: TDataSet; var RowColor: TColor;
      var ChangeColor: Boolean);
    procedure cdbg1PaintCellImage(FieldName: String; Field: TField;
      var Bitmap: TBitmap; var Change: Boolean);
    procedure cbbTemaChange(Sender: TObject);
    procedure chkAlternativeClick(Sender: TObject);
    procedure seFixedColsChange(Sender: TObject);
    procedure edColor1Click(Sender: TObject);
    procedure edColor2Click(Sender: TObject);
  private
    FEvento: Integer;
    FClickedColumn:TColumn;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CustomizeGrid1PaintCell(FieldName: String; Field: TField;
  var CellColor: TColor; var ChangeColor: Boolean);
begin

  //
  if (FieldName = 'State') and (Field.AsString = 'OR') then begin
    CellColor := clRed;
    ChangeColor := True;
  end;

end;

procedure TForm1.chkActivarClick(Sender: TObject);
begin
//  cdbg1.FlatStyle.FlatTheme := TGridTheme(cbbTema.ItemIndex);
//  cdbg1.FlatStyle.Active := (TStyleGrid(cbbEstilo.ItemIndex) = sgFlat);
  cdbg1.Active := not cdbg1.Active;
end;


procedure TForm1.rgEventosClick(Sender: TObject);
var
  mm:TComponent;
begin

  // Segun el que esté activado...
  FEvento := rgEventos.ItemIndex;
  // 0 ==> Pintar celda
  // 1 ==> Pintar columna;
  // 2 ==> Pintar columna pulsada (título)
  // 3 ==> Pintar filas por colores (segun campo)
  // 4 ==> Pintar imagenes en celdas - LoadFromFile
  // 5 ==> Pintar imagenes en celdas - Imagelist
  // 6 ==> Pintar imagenes en celdas - Recursos

  // Repintar
  dbgrd1.Repaint;

  // Buscar
  mm := FindComponent('mmCodigo' + IntToStr(FEvento));
  //  Asignado(Encontrado?
  if Assigned(mm) then begin
    // Es un memo?
    if (mm is Tmemo) then begin
      mmoCode.Clear;
      mmoCode.Lines.AddStrings(TMemo(mm).Lines);
    end;
  end;
end;

procedure TForm1.cdbg1PaintCell(FieldName: String; Field: TField;
  var CellColor: TColor; var ChangeColor: Boolean);
begin

  if (FEvento <> 0) then begin
    Exit;
  end;

  // Pintar
  if (FieldName = 'VendorName') and (not (Field.IsNull)) then begin
    if (Field.AsString[1] = 'C') then begin
      ChangeColor := True;
      CellColor := clRed;
    end;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // inicializaciones
  FClickedColumn := nil;
  FEvento := -1;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ADOConnection1.Connected := True;
  tblVendors.Open;
  tblCustomers.Open;
end;

procedure TForm1.cdbg1PaintColumn(FieldName: String; Field: TField;
  DataCol: Integer; Column: TColumn; var ColColor: TColor;
  var ChangeColor: Boolean);
begin

  if (FEvento = 1) then begin
    // Para la columna 1
    if DataCol = 1 then begin
      ChangeColor := True;
      ColColor := clSkyBlue;
    end;
  end;

  if (FEvento = 2) then begin
    // Para la columna pulsada
    if (Column = FClickedColumn) then begin
      ChangeColor := True;
      ColColor := clTeal;
    end;
  end;


end;

procedure TForm1.dbgrdDatosTitleClick(Column: TColumn);
begin
  // Guardamos la que ha sido pulsada
  FClickedColumn := Column;
//  dbgrdDatos.Repaint;
end;

procedure TForm1.cdbg1PaintRow(DS: TDataSet; var RowColor: TColor;
  var ChangeColor: Boolean);
begin

  if (FEvento = 3) then begin
    // Filas con CustNo par, en rojo, las impares en azul
    if (Odd(DS.FieldByName('VendorNo').AsInteger)) then begin
      ChangeColor := True;
      RowColor := clBlue;
    end
    else begin
      ChangeColor := True;
      RowColor := clRed;
    end;
  end;

end;

procedure TForm1.cdbg1PaintCellImage(FieldName: String; Field: TField;
  var Bitmap: TBitmap; var Change: Boolean);
begin

  if (FEvento = 4) then begin
    // Para la columna pulsada
    if (FieldName = 'Country') then begin
      // Es una de los "conocidos"
      if AnsiCompareText(Field.AsString, 'Canada') = 0 then begin
        Bitmap.LoadFromFile('.\Flags\Canada.bmp');
        Change := True;
      end
      else if AnsiCompareText(Field.AsString, 'Bahamas') = 0 then begin
        Bitmap.LoadFromFile('.\Flags\Bahamas.bmp');
        Change := True;
      end
      else if AnsiCompareText(Field.AsString, 'U.S.A.') = 0 then begin
        Bitmap.LoadFromFile('.\Flags\US.bmp');
        Change := True;
      end;
    end;
  end;

  if (FEvento = 5) then begin
    // Para la columna pulsada
    if (FieldName = 'Country') then begin
      // Es una de los "conocidos"
      if AnsiCompareText(Field.AsString, 'Canada') = 0 then begin
        ilFlags.GetBitmap(0, Bitmap);
        Change := True;
      end
      else if AnsiCompareText(Field.AsString, 'Bahamas') = 0 then begin
        ilFlags.GetBitmap(1, Bitmap);
        Change := True;
      end
      else if AnsiCompareText(Field.AsString, 'U.S.A.') = 0 then begin
        ilFlags.GetBitmap(2, Bitmap);
        Change := True;
      end;
    end;
  end;

  if (FEvento = 6) then begin
    // Para la columna pulsada
    if (FieldName = 'Country') then begin
      // proteccion
      try
        // Cargar el recurso
        Bitmap.LoadFromResourceName(HInstance, Field.AsString);
        Change := True;
      except
        // si no encuentra el recurso no hacemos nada, no pintará la imagen
      end;
    end;
  end;

end;

procedure TForm1.cbbTemaChange(Sender: TObject);
begin
  // Estandard, Desert, Gray, Sky
  cdbg1.AlternateRows.Style := TAlternativeStyles(cbbTema.ItemIndex);

  // Colores personalizados
  lblColores.Visible := (cdbg1.AlternateRows.Style = asStandard);
  edColor1.Visible := (cdbg1.AlternateRows.Style = asStandard);
  edColor2.Visible := (cdbg1.AlternateRows.Style = asStandard);
  edColor1.Color := cdbg1.AlternateRows.Color1;
  edColor2.Color := cdbg1.AlternateRows.Color2;

end;

procedure TForm1.chkAlternativeClick(Sender: TObject);
begin
  // Alternativas?
  Self.cdbg1.OnPaintRow := nil;
  cdbg1.AlternateRows.Active := chkAlternative.Checked;
  cdbg1.Grid.Repaint;

  // Activado?
  if (chkAlternative.Checked) then begin
    Self.cbbTemaChange(Sender);
  end;
end;

procedure TForm1.seFixedColsChange(Sender: TObject);
begin

  // Columnas fijas
//+G PENDIENTES   cdbg1.FixedCols := seFixedCols.Value;

end;

procedure TForm1.edColor1Click(Sender: TObject);
begin
  if (cd1.Execute) then begin
    edColor1.Color := cd1.Color;
    cdbg1.AlternateRows.Color1 := cd1.Color;
  end;

end;

procedure TForm1.edColor2Click(Sender: TObject);
begin
  if (cd2.Execute) then begin
    edColor2.Color := cd2.Color;
    cdbg1.AlternateRows.Color2 := cd2.Color;
  end;

end;

end.
