object Form1: TForm1
  Left = 293
  Top = 125
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Demo para el componente KeysOnForm'
  ClientHeight = 413
  ClientWidth = 519
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
    Top = 140
    Width = 519
    Height = 232
    Align = alBottom
    TabOrder = 0
    object Edit1: TEdit
      Left = 40
      Top = 184
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object StringGrid1: TStringGrid
      Left = 16
      Top = 16
      Width = 185
      Height = 137
      TabOrder = 1
    end
    object Memo1: TMemo
      Left = 232
      Top = 72
      Width = 81
      Height = 89
      Lines.Strings = (
        'Memo1')
      TabOrder = 2
    end
    object CheckBox1: TCheckBox
      Left = 336
      Top = 16
      Width = 97
      Height = 17
      Caption = 'CheckBox1'
      TabOrder = 3
    end
    object RadioButton1: TRadioButton
      Left = 336
      Top = 40
      Width = 113
      Height = 17
      Caption = 'RadioButton1'
      TabOrder = 4
    end
    object ListBox1: TListBox
      Left = 336
      Top = 72
      Width = 153
      Height = 97
      ItemHeight = 13
      Items.Strings = (
        'Uno'
        'dos'
        'tres'
        'cuatro'
        'cinco'
        'seis...')
      TabOrder = 5
    end
    object DateTimePicker1: TDateTimePicker
      Left = 216
      Top = 176
      Width = 121
      Height = 19
      Date = 38623.508862476900000000
      Time = 38623.508862476900000000
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 372
    Width = 519
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      519
      41)
    object spClose: TSpeedButton
      Left = 400
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
      Width = 167
      Height = 13
      Caption = 'By Neftal'#237' -Germ'#225'n Est'#233'vez-  2005.'
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 519
    Height = 140
    Align = alClient
    TabOrder = 2
    object Image1: TImage
      Left = 8
      Top = 8
      Width = 48
      Height = 48
      Picture.Data = {
        07544269746D617076060000424D760600000000000036040000280000001800
        000018000000010008000000000040020000C40E0000C40E0000000100000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000C0DCC000F0CAA6000020400000206000002080000020A0000020C0000020
        E00000400000004020000040400000406000004080000040A0000040C0000040
        E00000600000006020000060400000606000006080000060A0000060C0000060
        E00000800000008020000080400000806000008080000080A0000080C0000080
        E00000A0000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0
        E00000C0000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0
        E00000E0000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0
        E00040000000400020004000400040006000400080004000A0004000C0004000
        E00040200000402020004020400040206000402080004020A0004020C0004020
        E00040400000404020004040400040406000404080004040A0004040C0004040
        E00040600000406020004060400040606000406080004060A0004060C0004060
        E00040800000408020004080400040806000408080004080A0004080C0004080
        E00040A0000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0
        E00040C0000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0
        E00040E0000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0
        E00080000000800020008000400080006000800080008000A0008000C0008000
        E00080200000802020008020400080206000802080008020A0008020C0008020
        E00080400000804020008040400080406000804080008040A0008040C0008040
        E00080600000806020008060400080606000806080008060A0008060C0008060
        E00080800000808020008080400080806000808080008080A0008080C0008080
        E00080A0000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0
        E00080C0000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0
        E00080E0000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0
        E000C0000000C0002000C0004000C0006000C0008000C000A000C000C000C000
        E000C0200000C0202000C0204000C0206000C0208000C020A000C020C000C020
        E000C0400000C0402000C0404000C0406000C0408000C040A000C040C000C040
        E000C0600000C0602000C0604000C0606000C0608000C060A000C060C000C060
        E000C0800000C0802000C0804000C0806000C0808000C080A000C080C000C080
        E000C0A00000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0
        E000C0C00000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0
        A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFD0000000000000000000000000000000000FDFDFDFDFDFDA4A4A4A4
        A4A4A4A4A4A4A4A4A4A4A4A4A4A400FDFDFDFDFDA407A4FF0700FF070707FF07
        070700FF00A400FDFDFDFDFDA407A40000000000000000000000000000A400FD
        FDFDFDFDA407A4FF070007FF00FF07FF000700FF00A400FDFDFDFDFDA407A400
        00000000000000000000000000A400FDFDFDFDFDA407A4FF0700FF0700FFFF07
        000700FF00A400FDFDFDFDFDA407A4A4A4A4A4A4A4A4A4A4A4A4A4A4A4A400FD
        FDFDFDFDA4FF07FF070707070707070707070707070700FDFDFDFDFDFDA4A4A4
        A4A4A4A4A4A4A4A4A4A4A4A4A4A4FDFDFDFDFDFDFDFDA4FDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFDFDFDA4FD00FD00FD00FD000000FDFDFDFDFDFDFD
        FDFDFDFDFDFDFDA4FDA4FDA4FDA4FDFDFD00FDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFDFDFDFD03FD00FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD03FB
        00FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD03FDFDFDFDFCFCFDFD
        FCFCFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFCFDFDFCFDFCFDFDFDFDFDFDFD
        FDFDFDFDFDFDFDFDFDFDFDFCFDFCFCFDFCFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
        FDFDFDFCFDFDFDFDFCFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFCFCFCFD
        FCFD}
      Stretch = True
      Transparent = True
    end
    object Label1: TLabel
      Left = 72
      Top = 8
      Width = 402
      Height = 26
      Caption = 
        'Permite definir de forma f'#225'cil y sencilla el comportamiento de a' +
        'lgunas teclas comunes:'#13#10'ESC para cerrar,  ENTER para cambiar de ' +
        'campo,...'
    end
    object cbESCSalir: TCheckBox
      Left = 32
      Top = 64
      Width = 441
      Height = 17
      Caption = 
        'Activar la tecla ESC para cerrar el form. / Activate ESC key to ' +
        'close form.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = cbESCSalirClick
    end
    object cbNext: TCheckBox
      Left = 32
      Top = 96
      Width = 441
      Height = 17
      Caption = 'Siguiente control con ALT+RIGHT / Next control with ALT+RIGHT.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = cbNextClick
    end
    object cbPrevious: TCheckBox
      Left = 32
      Top = 112
      Width = 441
      Height = 17
      Caption = 'Anterior control con ALT+LEFT / Previous control with ZLT+LEFT.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cbPreviousClick
    end
    object cbENTERTAB: TCheckBox
      Left = 32
      Top = 80
      Width = 465
      Height = 17
      Caption = 
        'Activar la tecla ENTER como TAB. / Activate ENTER key to change ' +
        'control.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = cbENTERTABClick
    end
  end
  object KeysOnForm1: TKeysOnForm
    CloseOnEscape = False
    EnterAsTab = False
    PriorControlOnALTLeft = False
    NextControlOnALTRight = False
    Left = 64
    Top = 24
  end
end
