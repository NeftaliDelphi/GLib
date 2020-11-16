object Form1: TForm1
  Left = 214
  Top = 144
  Caption = 'Demo del componente CustomizeGrid'
  ClientHeight = 436
  ClientWidth = 804
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
    804
    436)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 180
    Width = 804
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
        FieldName = 'JOB_CODE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JOB_GRADE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JOB_COUNTRY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JOB_TITLE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MIN_SALARY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAX_SALARY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JOB_REQUIREMENT'
        Width = 149
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 17
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
    object cbMemoAsText: TCheckBox
      Left = 24
      Top = 66
      Width = 489
      Height = 17
      Caption = 'Pintar los memos como texto'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = cbMemoAsTextClick
    end
  end
  object DataSource1: TDataSource
    DataSet = IBTable1
    Left = 696
    Top = 16
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
    Top = 16
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\test.mdb;Persist ' +
      'Security Info=False'
    CursorType = ctStatic
    TableName = 'biolife'
    Left = 664
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = 
      'D:\Archivos de programa\Firebird\Firebird_1_5\examples\EMPLOYEE.' +
      'FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    Left = 632
    Top = 40
  end
  object IBTable1: TIBTable
    Database = IBDatabase1
    Transaction = IBTransaction1
    Active = True
    FieldDefs = <
      item
        Name = 'JOB_CODE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 5
      end
      item
        Name = 'JOB_GRADE'
        Attributes = [faRequired]
        DataType = ftSmallint
      end
      item
        Name = 'JOB_COUNTRY'
        Attributes = [faRequired]
        DataType = ftString
        Size = 15
      end
      item
        Name = 'JOB_TITLE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 25
      end
      item
        Name = 'MIN_SALARY'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'MAX_SALARY'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'JOB_REQUIREMENT'
        DataType = ftMemo
        Size = 8
      end>
    IndexDefs = <
      item
        Name = 'RDB$PRIMARY2'
        Fields = 'JOB_CODE;JOB_GRADE;JOB_COUNTRY'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'RDB$FOREIGN3'
        Fields = 'JOB_COUNTRY'
      end
      item
        Name = 'MINSALX'
        Fields = 'JOB_COUNTRY;MIN_SALARY'
      end
      item
        Name = 'MAXSALX'
        DescFields = 'JOB_COUNTRY;MAX_SALARY'
        Fields = 'JOB_COUNTRY;MAX_SALARY'
        Options = [ixDescending]
      end>
    StoreDefs = True
    TableName = 'JOB'
    Left = 664
    Top = 32
  end
  object IBTransaction1: TIBTransaction
    Active = True
    Left = 664
    Top = 64
  end
end
