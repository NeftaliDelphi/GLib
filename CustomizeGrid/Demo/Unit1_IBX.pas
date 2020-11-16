unit Unit1_IBX;

//=========================================================================
//
// I N T E R F A C E
//
//=========================================================================
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, CustomizeGrid, StdCtrls, IBDatabase,
  IBCustomDataSet, IBTable;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    CustomizeGrid1: TCustomizeGrid;
    ADOTable1: TADOTable;
    GroupBox1: TGroupBox;
    cbActive: TCheckBox;
    cbTitle: TCheckBox;
    cbPaintImage: TCheckBox;
    IBDatabase1: TIBDatabase;
    IBTable1: TIBTable;
    IBTransaction1: TIBTransaction;
    cbMemoAsText: TCheckBox;
    procedure cbMemoAsTextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbActiveClick(Sender: TObject);
    procedure cbTitleClick(Sender: TObject);
    procedure CustomizeGrid1PaintCellImage(FieldName: String;
      Field: TField; var Bitmap: TBitmap; var Change: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin

  // Valores Iniciales
  cbActive.Checked := CustomizeGrid1.Active;
  cbTitle.Checked := CustomizeGrid1.SortOptions.ChangeCursorOnTitle;
  cbMemoAsText.Checked := CustomizeGrid1.DataStyles.TextMemos;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ADOTable1.Open;
end;

procedure TForm1.cbActiveClick(Sender: TObject);
begin
  // Modificar
  CustomizeGrid1.Active := cbActive.Checked;
end;

procedure TForm1.cbMemoAsTextClick(Sender: TObject);
begin
  CustomizeGrid1.DataStyles.TextMemos := cbMemoAsText.Checked;
end;

procedure TForm1.cbTitleClick(Sender: TObject);
begin
  CustomizeGrid1.SortOptions.ChangeCursorOnTitle := cbTitle.Checked;
end;

procedure TForm1.CustomizeGrid1PaintCellImage(FieldName: String;
  Field: TField; var Bitmap: TBitmap; var Change: Boolean);
begin


  // Se ha marcado el Checkbox?
  if not (cbPaintImage.Checked) then begin
    Exit;
  end;

  CustomizeGrid1.AlternateRows.Active := False;
  CustomizeGrid1.DataStyles.CheckBox := False;


  // Para la columna pulsada
  if (FieldName = 'Catalog') then begin
    // proteccion
    try
      // Es verdadero
      if (Field.AsBoolean) then begin
        // Cargar el recurso
        Bitmap.LoadFromFile('.\Points\ball_green.bmp');
      end
      else begin
        Bitmap.LoadFromFile('.\Points\ball_red.bmp');
      end;

      Change := True;
    except
      // si no encuentra el recurso no hacemos nada, no pintará la imagen
    end;
  end;
end;

end.
