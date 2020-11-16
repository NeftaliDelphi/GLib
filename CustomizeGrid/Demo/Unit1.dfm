object Form1: TForm1
  Left = 214
  Top = 144
  Width = 828
  Height = 463
  Caption = 'Demo del componente CustomizeGrid'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    820
    436)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 180
    Width = 820
    Height = 256
    Cursor = 99
    Align = alBottom
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Species No'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Category'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Common_Name'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Species Name'
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Length (cm)'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Length_In'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Notes'
        Width = 181
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Catalog'
        Width = 45
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 16
    Width = 829
    Height = 157
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cbActive: TCheckBox
      Left = 8
      Top = 0
      Width = 289
      Height = 17
      Caption = 'Activar el componente/Active the component'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = cbActiveClick
    end
    object cbTitle: TCheckBox
      Left = 24
      Top = 32
      Width = 345
      Height = 17
      Caption = 
        'Cambiar el cursor al pasar por el t'#237'tulo/Change cursor on title ' +
        'move.'
      TabOrder = 1
      OnClick = cbTitleClick
    end
    object cbPaintImage: TCheckBox
      Left = 24
      Top = 50
      Width = 489
      Height = 17
      Caption = 
        'Pintar imagen en campo booleano (evento PaintCelImage) -> Column' +
        'a Catalog'
      TabOrder = 2
      OnClick = cbTitleClick
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 696
  end
  object CustomizeGrid1: TCustomizeGrid
    Active = True
    Grid = DBGrid1
    AlternateRows.Active = True
    AlternateRows.Color1 = 11974362
    AlternateRows.Color2 = 14680063
    AlternateRows.Style = asDesert
    DataStyles.TextMemos = True
    DataStyles.CheckBox = True
    SortOptions.ChangeCursorOnTitle = False
    OnPaintCellImage = CustomizeGrid1PaintCellImage
    Left = 728
  end
  object ADOTable1: TADOTable
    Active = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\test.mdb;Persist ' +
      'Security Info=False'
    CursorType = ctStatic
    TableName = 'biolife'
    Left = 664
  end
end
