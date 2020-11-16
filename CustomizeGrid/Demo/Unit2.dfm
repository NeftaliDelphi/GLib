object Form1: TForm1
  Left = 182
  Top = 78
  Width = 803
  Height = 561
  Caption = 'Demo del componente CustomizeGrid...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splVertical1: TSplitter
    Left = 535
    Top = 0
    Width = 5
    Height = 534
    Cursor = crHSplit
    Align = alRight
    Beveled = True
  end
  object pnlDerecha: TPanel
    Left = 540
    Top = 0
    Width = 255
    Height = 534
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      255
      534)
    object lblFlatStile: TLabel
      Left = 24
      Top = 78
      Width = 109
      Height = 13
      Caption = 'Estilo para alternativas:'
    end
    object lblColores: TLabel
      Left = 40
      Top = 108
      Width = 41
      Height = 13
      Caption = 'Colores: '
    end
    object chkActivar: TCheckBox
      Left = 8
      Top = 8
      Width = 169
      Height = 17
      Caption = #191'Activar el componente?'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = chkActivarClick
    end
    object rgEventos: TRadioGroup
      Left = 8
      Top = 200
      Width = 241
      Height = 185
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Eventos del componente  '
      Items.Strings = (
        'Pintar una o varias celdas de color'
        'Pintar una columna de color'
        'Pintar una columna pulsada (t'#237'tulo)'
        'Pintar filas por colores (segun campo)'
        'Imagenes en celdas (campo) - LoadFromFile'
        'Imagenes en celdas (campo) - ImageList'
        'Imagenes en celdas (campo) - Recursos')
      TabOrder = 2
      OnClick = rgEventosClick
    end
    object nbCodigos: TNotebook
      Left = 8
      Top = 392
      Width = 217
      Height = 129
      PageIndex = 5
      TabOrder = 3
      Visible = False
      object TPage
        Left = 0
        Top = 0
        Caption = '0'
        object mmcodigo0: TMemo
          Left = 0
          Top = 0
          Width = 217
          Height = 129
          Align = alClient
          Lines.Strings = (
            
              'procedure TForm1.cdbg1PaintCell(FieldName: String; Field: TField' +
              ';  var CellColor: TColor; var ChangeColor: Boolean);'
            'begin'
            '  // Pintar'
            '  if (FieldName = '#39'Company'#39') and (not (Field.IsNull)) then begin'
            '    if (Field.AsString[1] = '#39'M'#39') then begin'
            '      ChangeColor := True;'
            '      CellColor := clRed;'
            '    end;'
            '  end;'
            'end;')
          TabOrder = 0
          WordWrap = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = '1'
        object mmcodigo1: TMemo
          Left = 0
          Top = 0
          Width = 217
          Height = 129
          Align = alClient
          Lines.Strings = (
            
              'procedure TForm1.cdbg1PaintColumn(FieldName: String; Field: TFie' +
              'ld; DataCol: Integer; Column: TColumn; var ColColor: TColor;'
            '  var ChangeColor: Boolean);'
            'begin'
            '    // Para la columna 1'
            '    if DataCol = 1 then begin'
            '      ChangeColor := True;'
            '      ColColor := clSkyBlue;'
            '    end;'
            'end;')
          TabOrder = 0
          WordWrap = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = '2'
        object mmcodigo2: TMemo
          Left = 0
          Top = 0
          Width = 217
          Height = 129
          Align = alClient
          Lines.Strings = (
            
              'procedure TForm1.cdbg1PaintColumn(FieldName: String; Field: TFie' +
              'ld;  DataCol: Integer; Column: TColumn; var ColColor: TColor;   ' +
              'var ChangeColor: Boolean);'
            'begin'
            '    // Para la columna 1'
            '    if DataCol = 1 then begin'
            '      ChangeColor := True;'
            '      ColColor := clSkyBlue;'
            '    end;'
            'end;')
          TabOrder = 0
          WordWrap = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = '3'
        object mmcodigo3: TMemo
          Left = 0
          Top = 0
          Width = 217
          Height = 129
          Align = alClient
          Lines.Strings = (
            
              'procedure TForm1.cdbg1PaintRow(DS: TDataSet; var RowColor: TColo' +
              'r;  var ChangeColor: Boolean);'
            'begin'
            '    // Filas con CustNo par, en rojo, las impares en azul'
            '    if (Odd(DS.FieldByName('#39'CustNo'#39').AsInteger)) then begin'
            '      ChangeColor := True;'
            '      RowColor := clBlue;'
            '    end'
            '    else begin'
            '      ChangeColor := True;'
            '      RowColor := clRed;'
            '    end;'
            'end;')
          TabOrder = 0
          WordWrap = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = '4'
        object mmcodigo4: TMemo
          Left = 0
          Top = 0
          Width = 217
          Height = 129
          Align = alClient
          Lines.Strings = (
            
              'procedure TForm1.cdbg1PaintCellImage(FieldName: String; Field: T' +
              'Field;'
            '  var Bitmap: TBitmap; var Change: Boolean);'
            'begin'
            '    // Para la columna pulsada'
            '    if (FieldName = '#39'Country'#39') then begin'
            '      // Es una de los "conocidos"'
            
              '      if AnsiCompareText(Field.AsString, '#39'Canada'#39') = 0 then begi' +
              'n'
            
              '        Bitmap.LoadFromFile('#39'C:\Proyectos\Delphi6\Ejemplos GERMA' +
              'N\__COMPONENTES__\Demos\Demo_Grid\Flags\Canada.bmp'#39');'
            '        Change := True;'
            '      end'
            
              '      else if AnsiCompareText(Field.AsString, '#39'Bahamas'#39') = 0 the' +
              'n begin'
            
              '        Bitmap.LoadFromFile('#39'C:\Proyectos\Delphi6\Ejemplos GERMA' +
              'N\__COMPONENTES__\Demos\Demo_Grid\Flags\Bahamas.bmp'#39');'
            '        Change := True;'
            '      end'
            
              '      else if AnsiCompareText(Field.AsString, '#39'U.S.A.'#39') = 0 then' +
              ' begin'
            
              '        Bitmap.LoadFromFile('#39'C:\Proyectos\Delphi6\Ejemplos GERMA' +
              'N\__COMPONENTES__\Demos\Demo_Grid\Flags\US.bmp'#39');'
            '        Change := True;'
            '      end;'
            '    end;'
            'end;')
          TabOrder = 0
          WordWrap = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = '5'
        object mmcodigo5: TMemo
          Left = 0
          Top = 0
          Width = 217
          Height = 129
          Align = alClient
          Lines.Strings = (
            
              'procedure TForm1.cdbg1PaintCellImage(FieldName: String; Field: T' +
              'Field;  var Bitmap: TBitmap; var Change: Boolean);'
            'begin'
            '    // Para la columna pulsada'
            '    if (FieldName = '#39'Country'#39') then begin'
            '      // Es una de los "conocidos"'
            
              '      if AnsiCompareText(Field.AsString, '#39'Canada'#39') = 0 then begi' +
              'n'
            '        ilFlags.GetBitmap(0, Bitmap);'
            '        Change := True;'
            '      end'
            
              '      else if AnsiCompareText(Field.AsString, '#39'Bahamas'#39') = 0 the' +
              'n begin'
            '        ilFlags.GetBitmap(1, Bitmap);'
            '        Change := True;'
            '      end'
            
              '      else if AnsiCompareText(Field.AsString, '#39'U.S.A.'#39') = 0 then' +
              ' begin'
            '        ilFlags.GetBitmap(2, Bitmap);'
            '        Change := True;'
            '      end;'
            '    end;'
            'end;')
          TabOrder = 0
          WordWrap = False
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = '6'
        object mmcodigo6: TMemo
          Left = 0
          Top = 0
          Width = 217
          Height = 129
          Align = alClient
          Lines.Strings = (
            
              'procedure TForm1.cdbg1PaintCellImage(FieldName: String; Field: T' +
              'Field;'
            '      var Bitmap: TBitmap; var Change: Boolean);'
            'begin'
            '    // Para la columna pulsada'
            '    if (FieldName = '#39'Country'#39') then begin'
            '      // proteccion'
            '      try'
            '        // Cargar el recurso'
            '        Bitmap.LoadFromResourceName(HInstance, Field.AsString);'
            '        Change := True;'
            '      except'
            
              '        // si no encuentra el recurso no hacemos nada, no pintar' +
              #225' la imagen'
            '      end;'
            '    end;'
            'end;')
          TabOrder = 0
          WordWrap = False
        end
      end
    end
    object cbbTema: TComboBox
      Left = 136
      Top = 74
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = 'Estandard'
      OnChange = cbbTemaChange
      Items.Strings = (
        'Estandard'
        'Desert'
        'Gray'
        'Sky')
    end
    object chkAlternative: TCheckBox
      Left = 24
      Top = 54
      Width = 97
      Height = 17
      Caption = 'Filas alternativas'
      TabOrder = 1
      OnClick = chkAlternativeClick
    end
    object edColor1: TPanel
      Left = 88
      Top = 102
      Width = 25
      Height = 25
      TabOrder = 5
      OnClick = edColor1Click
    end
    object edColor2: TPanel
      Left = 120
      Top = 102
      Width = 25
      Height = 25
      TabOrder = 6
      OnClick = edColor2Click
    end
  end
  object pnlCentral: TPanel
    Left = 0
    Top = 0
    Width = 535
    Height = 534
    Align = alClient
    Caption = 'pnlCentral'
    TabOrder = 1
    object splHorizontal: TSplitter
      Left = 1
      Top = 363
      Width = 533
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      Beveled = True
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 1
      Width = 533
      Height = 362
      Align = alClient
      Caption = 'pnlGrid'
      TabOrder = 0
      object dbgrd1: TDBGrid
        Left = 1
        Top = 1
        Width = 531
        Height = 360
        Align = alClient
        Ctl3D = False
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'VendorNo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VendorName'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Address1'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Address2'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'City'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'State'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Zip'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Country'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Phone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FAX'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Preferred'
            Visible = True
          end>
      end
    end
    object pnlInferior: TPanel
      Left = 1
      Top = 368
      Width = 533
      Height = 165
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 1
      object mmoCode: TMemo
        Left = 1
        Top = 1
        Width = 531
        Height = 163
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvRaised
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = tblVendors
    Left = 16
    Top = 240
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from customer')
    Left = 16
    Top = 272
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=c:\Archivos de prog' +
      'rama\Archivos comunes\Borland Shared\Data\dbdemos.mdb;Persist Se' +
      'curity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 16
    Top = 304
  end
  object cdbg1: TCustomizeGrid
    Active = True
    Grid = dbgrd1
    AlternateRows.Active = False
    AlternateRows.Color1 = 14737632
    AlternateRows.Color2 = 13553358
    AlternateRows.Style = asStandard
    DataStyles.TextMemos = False
    DataStyles.CheckBox = True
    SortOptions.ChangeCursorOnTitle = False
    OnPaintCell = cdbg1PaintCell
    OnPaintColumn = cdbg1PaintColumn
    OnPaintRow = cdbg1PaintRow
    OnPaintCellImage = cdbg1PaintCellImage
    Left = 16
    Top = 336
  end
  object ilFlags: TImageList
    Left = 16
    Top = 208
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF0000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000FF000000FF000000FF00
      0000FF00000000FFFF00FF000000FF0000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000FF000000FF00000000FF
      FF00FF000000FF00000000FFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000FF000000FF000000FF00
      0000FF00000000FFFF00FF000000FF0000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF00000000FFFF00FF000000FF0000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF00000000FF
      FF00FF000000FF00000000FFFF00FF000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF0000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FF000000FF000000FF00
      0000FF00000000FFFF00FF000000FF0000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF00000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      8001800180010000800180018001000080018001800100008001800180010000
      8001800180010000800180018001000080018001800100008001800180010000
      80018001800100008001800180010000800180018001000080018001FFFF0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object qry2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Vendors')
    Left = 48
    Top = 272
  end
  object tblCustomers: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'customer'
    Left = 80
    Top = 272
  end
  object tblVendors: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'vendors'
    Left = 112
    Top = 272
  end
  object cd1: TColorDialog
    Ctl3D = True
    Left = 24
    Top = 128
  end
  object cd2: TColorDialog
    Ctl3D = True
    Left = 56
    Top = 128
  end
end
