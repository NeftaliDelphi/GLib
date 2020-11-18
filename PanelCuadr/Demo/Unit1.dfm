object Form1: TForm1
  Left = 536
  Top = 211
  Width = 479
  Height = 417
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    471
    386)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 105
    Height = 13
    Caption = 'Tama'#241'o para el Grid'
  end
  object Label2: TLabel
    Left = 24
    Top = 76
    Width = 69
    Height = 13
    Caption = 'Color del Grid: '
  end
  object gridPanel: TPanelCuad
    Left = 24
    Top = 112
    Width = 425
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Pruebas para GridPanel'
    Color = clWhite
    TabOrder = 0
    GridColor = clRed
    GridVisible = True
    GridSize = 5
  end
  object chkVisualizar: TCheckBox
    Left = 24
    Top = 24
    Width = 161
    Height = 17
    Caption = 'Visualizar Grid en el panel'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = chkVisualizarClick
  end
  object spTamanyo: TSpinEdit
    Left = 185
    Top = 45
    Width = 63
    Height = 22
    MaxValue = 20
    MinValue = 3
    TabOrder = 2
    Value = 5
    OnChange = spTamanyoChange
  end
  object cbColor: TColorBox
    Left = 104
    Top = 72
    Width = 145
    Height = 22
    Selected = clRed
    DropDownCount = 16
    ItemHeight = 16
    TabOrder = 3
    OnChange = cbColorChange
  end
end
