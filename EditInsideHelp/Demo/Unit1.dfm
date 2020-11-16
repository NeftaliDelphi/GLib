object Form1: TForm1
  Left = 293
  Top = 125
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Demo para el componente EditInsideHelp'
  ClientHeight = 295
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 146
    Width = 557
    Height = 108
    Align = alBottom
    TabOrder = 0
    object Label5: TLabel
      Left = 32
      Top = 16
      Width = 39
      Height = 13
      Caption = 'C'#243'digo: '
    end
    object Label6: TLabel
      Left = 32
      Top = 42
      Width = 59
      Height = 13
      Caption = 'Descripci'#243'n:'
    end
    object Label7: TLabel
      Left = 32
      Top = 68
      Width = 36
      Height = 13
      Caption = 'Estado:'
    end
    object EditInsideHelp1: TEditInsideHelp
      Left = 112
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 0
      InsideHelpText = 'F1 ayuda...'
      InsideHelpActive = False
      InsideHelpFont.Charset = DEFAULT_CHARSET
      InsideHelpFont.Color = clGray
      InsideHelpFont.Height = -11
      InsideHelpFont.Name = 'Arial'
      InsideHelpFont.Style = []
    end
    object EditInsideHelp2: TEditInsideHelp
      Left = 112
      Top = 38
      Width = 393
      Height = 21
      Color = clBtnFace
      TabOrder = 1
      InsideHelpText = 'F1 ayuda...'
      InsideHelpActive = False
      InsideHelpFont.Charset = DEFAULT_CHARSET
      InsideHelpFont.Color = clGray
      InsideHelpFont.Height = -11
      InsideHelpFont.Name = 'Arial'
      InsideHelpFont.Style = []
    end
    object EditInsideHelp3: TEditInsideHelp
      Left = 112
      Top = 64
      Width = 193
      Height = 21
      MaxLength = 1
      TabOrder = 2
      InsideHelpText = 'Estados posibles: A, B, C o D'
      InsideHelpActive = False
      InsideHelpFont.Charset = DEFAULT_CHARSET
      InsideHelpFont.Color = clGray
      InsideHelpFont.Height = -11
      InsideHelpFont.Name = 'Arial'
      InsideHelpFont.Style = []
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 254
    Width = 557
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      557
      41)
    object spClose: TSpeedButton
      Left = 438
      Top = 8
      Width = 108
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cerrar/&Close'
      OnClick = spCloseClick
    end
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 202
      Height = 13
      Cursor = crHandPoint
      Caption = 'By Neftal'#237' -Germ'#225'n Est'#233'vez-  2005.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = Label2Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 557
    Height = 146
    Align = alClient
    TabOrder = 2
    object Image1: TImage
      Left = 8
      Top = 8
      Width = 48
      Height = 48
      Picture.Data = {
        07544269746D6170F6060000424DF60600000000000036000000280000001800
        0000180000000100180000000000C0060000C40E0000C40E0000000000000000
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF8080800000008080808080808080
        8080808080808080808080808080808080808080808080808080808080808080
        8080808080808080808080808080808080808080FFFFFFFF00FF808080000000
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFFF
        00FF808080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF808080FFFFFFFF00FF808080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF808080FFFFFFFF00FF808080000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFF808080FFFFFFFF00FF808080000000
        FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0FFFFFFFFFF
        FFC0C0C0C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0FFFFFFFFFFFF808080FFFFFFFF
        00FF808080000000FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0FFFFFFC0C0C0C0C0C0
        C0C0C0C0C0C0FFFFFFC0C0C0C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0FFFF
        FF808080FFFFFFFF00FF808080000000FFFFFFC0C0C0C0C0C0C0C0C0FFFFFFFF
        FFFFFFFFFFC0C0C0C0C0C0FFFFFFFFFFFFC0C0C0C0C0C0FFFFFFC0C0C0C0C0C0
        C0C0C0FFFFFFFFFFFF808080FFFFFFFF00FF808080000000FFFFFFC0C0C0C0C0
        C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0C0C0C0FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFFF00FF808080000000
        FFFFFFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFC0C0C0C0C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFFF
        00FF808080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF808080FFFFFFFF00FF808080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF808080FFFFFFFF00FF808080000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080FFFFFFFF00FF808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000000FFFFFFFF
        00FF808080808080808080808080808080808080808080808080808080808080
        8080808080808080808080808080808080808080808080808080808080808080
        80808080808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000FF0000FF00FFFF00FFFF0000FF
        0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00
        00FF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000
        FF00FFFF0000FF0000FF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000FF0000FF0000FF00FFFF0000FF
        00FF}
      Stretch = True
      Transparent = True
    end
    object Label1: TLabel
      Left = 64
      Top = 8
      Width = 463
      Height = 52
      Caption = 
        'Permite definir un texto de ayuda en la parte interna del contro' +
        'l de edici'#243'n. El texto desaparace cuando el control contiene alg' +
        'un texto.'#13#10'The componente allow to define a Help text inside the' +
        ' edit control. The help text disappears when the control as any ' +
        'user text.'
      WordWrap = True
    end
    object Label3: TLabel
      Left = 32
      Top = 99
      Width = 236
      Height = 13
      Caption = 'Texto de ayuda / Text for Help (C'#243'digo): '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 32
      Top = 123
      Width = 240
      Height = 13
      Caption = 'Color del texto de ayuda / Help text color:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbESCSalir: TCheckBox
      Left = 32
      Top = 75
      Width = 441
      Height = 17
      Caption = 'Activar a ayuda en el componente / Active the help on component.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = cbESCSalirClick
    end
    object edtHelp: TEdit
      Left = 272
      Top = 95
      Width = 265
      Height = 21
      TabOrder = 1
      OnChange = edtHelpChange
    end
    object pnlColor: TPanel
      Left = 288
      Top = 121
      Width = 249
      Height = 20
      Cursor = crHandPoint
      TabOrder = 2
      OnClick = pnlColorClick
    end
  end
  object ColorDialog: TColorDialog
    Ctl3D = True
    Left = 504
    Top = 8
  end
end
