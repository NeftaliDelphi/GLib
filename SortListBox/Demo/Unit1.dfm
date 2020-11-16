object Form1: TForm1
  Left = 235
  Top = 107
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'Demo para el componente SortListbox'
  ClientHeight = 474
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SortListBox1: TSortListBox
    Left = 8
    Top = 16
    Width = 233
    Height = 209
    Style = lbOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 296
    Top = 114
    Width = 201
    Height = 21
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 0
    Top = 240
    Width = 556
    Height = 193
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button5: TButton
    Left = 296
    Top = 185
    Width = 200
    Height = 25
    Caption = 'Asignar / Set           3 ASC, 4 DESC'
    TabOrder = 2
    OnClick = Button5Click
  end
  object Panel2: TPanel
    Left = 0
    Top = 433
    Width = 556
    Height = 41
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      556
      41)
    object spClose: TSpeedButton
      Left = 437
      Top = 8
      Width = 108
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cerrar / Close'
    end
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 167
      Height = 13
      Caption = 'By Neftal'#237' -Germ'#225'n Est'#233'vez-  2005.'
    end
    object Label5: TLabel
      Left = 184
      Top = 15
      Width = 169
      Height = 13
      Cursor = crHandPoint
      Caption = 'http://neftali.clubdelphi.com/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = Label5Click
    end
  end
  object Button1: TButton
    Left = 296
    Top = 23
    Width = 200
    Height = 25
    Caption = '&A'#241'adir elementos / Add elements'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 296
    Top = 48
    Width = 200
    Height = 25
    Caption = '&Borrar seleccionado / Delete selected'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 296
    Top = 88
    Width = 200
    Height = 25
    Caption = 'A'#241'adir &nuevo / Add new element'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button2: TButton
    Left = 296
    Top = 160
    Width = 200
    Height = 25
    Caption = 'Con&sultar elementos / Show elements'
    TabOrder = 8
    OnClick = Button2Click
  end
end
