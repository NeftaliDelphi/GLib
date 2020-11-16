object Form1: TForm1
  Left = 251
  Top = 7
  Width = 525
  Height = 693
  ActiveControl = Button7
  Caption = 'Demo del componente DiskInfo'
  Color = clBtnFace
  Constraints.MaxWidth = 525
  Constraints.MinWidth = 525
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlResult: TPanel
    Left = 0
    Top = 81
    Width = 517
    Height = 521
    Align = alClient
    TabOrder = 0
    DesignSize = (
      517
      521)
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 83
      Height = 13
      Caption = 'Unidades/Drives:'
    end
    object imgDrive: TImage
      Left = 96
      Top = 16
      Width = 33
      Height = 33
    end
    object lblExplorerDisplayName: TLabel
      Left = 136
      Top = 16
      Width = 374
      Height = 16
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDriveTypeName: TLabel
      Left = 136
      Top = 32
      Width = 374
      Height = 16
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 96
      Top = 52
      Width = 414
      Height = 6
      Anchors = [akLeft, akRight, akBottom]
    end
    object lbDriveLetters: TListBox
      Left = 8
      Top = 32
      Width = 81
      Height = 281
      ItemHeight = 13
      TabOrder = 0
      OnClick = lbDriveLettersClick
    end
    object pnlGraph: TPanel
      Left = 8
      Top = 320
      Width = 502
      Height = 193
      Anchors = [akLeft, akRight, akBottom]
      BevelOuter = bvLowered
      TabOrder = 1
      Visible = False
      object Label2: TLabel
        Left = 256
        Top = 24
        Width = 54
        Height = 13
        Caption = 'Capacidad:'
      end
      object Label3: TLabel
        Left = 256
        Top = 72
        Width = 82
        Height = 13
        Caption = 'Espacio utilizado:'
      end
      object Label4: TLabel
        Left = 256
        Top = 104
        Width = 63
        Height = 13
        Caption = 'Espacio libre:'
      end
      object lblCapacidad: TLabel
        Left = 269
        Top = 40
        Width = 230
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblUtilizado: TLabel
        Left = 269
        Top = 120
        Width = 230
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblLibre: TLabel
        Left = 269
        Top = 88
        Width = 230
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Chart1: TChart
        Left = 14
        Top = 8
        Width = 227
        Height = 177
        AllowPanning = pmNone
        AllowZoom = False
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        BackWall.Pen.Visible = False
        Title.Text.Strings = (
          '')
        AxisVisible = False
        Chart3DPercent = 50
        ClipPoints = False
        Frame.Visible = False
        Legend.Alignment = laBottom
        Legend.LegendStyle = lsValues
        Legend.TextStyle = ltsRightPercent
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        View3DWalls = False
        BevelOuter = bvNone
        TabOrder = 0
        object Series1: TPieSeries
          Marks.ArrowLength = 8
          Marks.Style = smsPercent
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'Unidad C'
          OtherSlice.Style = poBelowPercent
          OtherSlice.Text = 'Other'
          PieValues.DateTime = False
          PieValues.Name = 'Pie'
          PieValues.Multiplier = 1
          PieValues.Order = loNone
          RotationAngle = 180
        end
      end
    end
    object mmInfo: TMemo
      Left = 96
      Top = 64
      Width = 414
      Height = 249
      TabStop = False
      Anchors = [akLeft, akRight, akBottom]
      Color = clBtnFace
      Lines.Strings = (
        '(1)  Pulse el bot'#243'n de:     "Unidades / System Drives"'
        '(2)  Seleccione una de las unidades disponibles.'
        ''
        
          '----------------------------------------------------------------' +
          '---------------------'
        ''
        '(1)  Click the button:     "Unidades / System Drives"'
        '(2)  Selecc a system drive from the list.')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 602
    Width = 517
    Height = 64
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      517
      64)
    object spClose: TSpeedButton
      Left = 323
      Top = 33
      Width = 187
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cerrar/&Close'
      OnClick = spCloseClick
    end
    object Label5: TLabel
      Left = 24
      Top = 16
      Width = 167
      Height = 13
      Caption = 'By Neftal'#237' -Germ'#225'n Est'#233'vez-  2005.'
    end
    object Label6: TLabel
      Left = 24
      Top = 31
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
      OnClick = Label6Click
    end
    object Button7: TButton
      Left = 323
      Top = 8
      Width = 187
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Unidades / System Drives'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button7Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 517
    Height = 81
    Align = alTop
    TabOrder = 2
    DesignSize = (
      517
      81)
    object Label7: TLabel
      Left = 64
      Top = 11
      Width = 422
      Height = 26
      Anchors = [akLeft, akRight, akBottom]
      Caption = 
        'Permite obtener todo tipo de informaci'#243'n de los discos instalado' +
        's en el ordenador (Discos duros, diskette, unidad de red,...).'
      WordWrap = True
    end
    object Label8: TLabel
      Left = 64
      Top = 45
      Width = 443
      Height = 26
      Anchors = [akLeft, akRight, akBottom]
      Caption = 
        'It allows to obtain various type of information from Drives inst' +
        'alled in the computer (Hard disks, floppy disk, network drives,.' +
        '..).'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
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
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF0000000000000000000000000000000000
        00000000000000000000000000000000000000000000FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080808080808080808080
        8080808080808080808080808080808080808080808080808080808080800000
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080C0
        C0C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        C0C0C0808080808080000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF808080C0C0C080808080808080808080808080808080808080808080
        8080808080808080C0C0C0808080808080000000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080808080000000FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008000C0C0C08080808080
        80000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF808080808080000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0808080000000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8080808080808080808080808080
        80808080808080808080808080808080808080808080808080FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF80000080000080
        0000800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8000
        00800000800000800000800000800000800000FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF800000800000800000FFFFFFFFFFFF800000800000800000800000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF800000800000800000FFFFFFFFFFFF800000800000
        800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF800000800000800000FFFFFFFF
        FFFF800000800000800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8000008000
        00800000800000800000800000800000800000800000FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF800000800000800000FFFFFFFFFFFF800000800000800000800000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000FF0000FF00FFFF00FFFF0000FF
        0000FF00FFFF00FFFF00FFFF00FF800000800000800000800000800000800000
        800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00
        00FF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF80000080000080
        0000800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000
        FF00FFFF0000FF0000FF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF0000FF00FFFF00FFFF00FFFF00FFFF0000FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF0000FF0000FF0000FF00FFFF0000FF
        00FF}
      Stretch = True
      Transparent = True
    end
  end
  object DiskInfo1: TDiskInfo
    DriveLetter = #0
    Left = 62
    Top = 8
  end
end
