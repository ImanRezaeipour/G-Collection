object qrptAmar4: TqrptAmar4
  Left = 0
  Top = 0
  Width = 794
  Height = 1123
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  BeforePrint = QuickRepBeforePrint
  DataSet = qry
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE')
  Functions.DATA = (
    '0'
    '0'
    #39#39)
  Options = [FirstPageHeader, LastPageFooter]
  Page.Columns = 1
  Page.Orientation = poPortrait
  Page.PaperSize = A4
  Page.Values = (
    100.000000000000000000
    2970.000000000000000000
    100.000000000000000000
    2100.000000000000000000
    80.000000000000000000
    80.000000000000000000
    0.000000000000000000)
  PrinterSettings.Copies = 1
  PrinterSettings.OutputBin = Auto
  PrinterSettings.Duplex = False
  PrinterSettings.FirstPage = 0
  PrinterSettings.LastPage = 0
  PrinterSettings.UseStandardprinter = False
  PrinterSettings.UseCustomBinCode = False
  PrinterSettings.CustomBinCode = 0
  PrinterSettings.ExtendedDuplex = 0
  PrinterSettings.UseCustomPaperCode = False
  PrinterSettings.CustomPaperCode = 0
  PrinterSettings.PrintMetaFile = False
  PrinterSettings.PrintQuality = 0
  PrinterSettings.Collate = 0
  PrinterSettings.ColorOption = 0
  PrintIfEmpty = True
  ReportTitle = #1711#1586#1575#1585#1588' '#1603#1604#1610' '#1575#1587#1578#1601#1575#1583#1607' '#1575#1586' '#1582#1583#1605#1575#1578' '#1575#1601#1585#1575#1583
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsMaximized
  PrevInitialZoom = qrZoomToFit
  object bndCoName: TQRBand
    Left = 30
    Top = 38
    Width = 734
    Height = 35
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      92.604166666666670000
      1942.041666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object lblCoName: TQRLabel
      Left = 170
      Top = 4
      Width = 372
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        66.145833333333340000
        449.791666666666700000
        10.583333333333330000
        984.250000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1588#1585#1603#1578' '#1662#1585#1608#1585#1588' '#1583#1575#1583#1607#8204#1607#1575
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 16
    end
  end
  object ChildBand1: TQRChildBand
    Left = 30
    Top = 73
    Width = 734
    Height = 88
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      232.833333333333300000
      1942.041666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = bndCoName
    object lblName: TQRLabel
      Left = 198
      Top = 0
      Width = 324
      Height = 23
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        60.854166666666660000
        523.875000000000000000
        0.000000000000000000
        857.250000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1711#1586#1575#1585#1588' '#1575#1593#1578#1576#1575#1585' '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 14
    end
    object lbl3: TQRLabel
      Left = 88
      Top = 8
      Width = 27
      Height = 18
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        47.625000000000000000
        232.833333333333300000
        21.166666666666670000
        71.437500000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = ':'#1578#1575#1585#1610#1582
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblDate: TQRLabel
      Left = 8
      Top = 8
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.097222222222200000
        22.048611111111100000
        22.048611111111100000
        194.027777777778000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblDate'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRSysData2: TQRSysData
      Left = 8
      Top = 24
      Width = 76
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.097222222222200000
        22.048611111111100000
        63.940972222222200000
        200.642361111111000000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Data = qrsTime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      FontSize = 10
    end
    object lbl4: TQRLabel
      Left = 88
      Top = 24
      Width = 31
      Height = 18
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        47.625000000000000000
        232.833333333333300000
        63.500000000000000000
        82.020833333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = ':'#1587#1575#1593#1578
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbl2: TQRLabel
      Left = 662
      Top = 16
      Width = 31
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1751.541666666667000000
        42.333333333333330000
        82.020833333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = ':'#1589#1601#1581#1607
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRSysData1: TQRSysData
      Left = 623
      Top = 16
      Width = 38
      Height = 18
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        47.625000000000000000
        1648.354166666667000000
        42.333333333333340000
        100.541666666666700000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      Color = clWhite
      Data = qrsPageNumber
      Transparent = False
      FontSize = 10
    end
    object lblRepDate: TQRLabel
      Left = 176
      Top = 35
      Width = 366
      Height = 23
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        60.854166666666670000
        465.666666666666700000
        92.604166666666670000
        968.375000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblRepDate'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblReptime: TQRLabel
      Left = 176
      Top = 59
      Width = 366
      Height = 23
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        60.854166666666670000
        465.666666666666700000
        156.104166666666700000
        968.375000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblReptime'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbltghest: TQRLabel
      Left = 664
      Top = 60
      Width = 42
      Height = 18
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        47.625000000000000000
        1756.833333333333000000
        158.750000000000000000
        111.125000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = #1578#1593#1583#1575#1583' '#1602#1587#1591
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object DetailBand1: TQRBand
    Left = 30
    Top = 194
    Width = 734
    Height = 32
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = False
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    BeforePrint = DetailBand1BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      84.666666666666670000
      1942.041666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object QRShape9: TQRShape
      Left = 90
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        238.125000000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblpardakht: TQRLabel
      Left = 237
      Top = 7
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        627.062500000000000000
        18.520833333333330000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblpardakht'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblmandeh: TQRLabel
      Left = 4
      Top = 7
      Width = 85
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        18.520833333333330000
        224.895833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblmandeh'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape7: TQRShape
      Left = 304
      Top = 2
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        804.333333333333300000
        5.291666666666667000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape8: TQRShape
      Left = 452
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1195.916666666667000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape10: TQRShape
      Left = 622
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1645.708333333333000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape11: TQRShape
      Left = 693
      Top = 1
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1833.562500000000000000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblcharge: TQRLabel
      Left = 311
      Top = 7
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        822.854166666666700000
        18.520833333333330000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblcharge'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblfamilyname: TQRLabel
      Left = 458
      Top = 7
      Width = 91
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1211.791666666667000000
        18.520833333333330000
        240.770833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblfamilyname'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblpno: TQRLabel
      Left = 628
      Top = 7
      Width = 63
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1661.583333333333000000
        18.520833333333330000
        166.687500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lbldate'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblradif: TQRLabel
      Left = 699
      Top = 7
      Width = 30
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1849.437500000000000000
        18.520833333333330000
        79.375000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblradif'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbllastcharge: TQRLabel
      Left = 385
      Top = 7
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1018.645833333333000000
        18.520833333333330000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblcharge'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape12: TQRShape
      Left = 378
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1000.125000000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape14: TQRShape
      Left = 551
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1457.854166666667000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblcardno: TQRLabel
      Left = 558
      Top = 7
      Width = 63
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1476.375000000000000000
        18.520833333333330000
        166.687500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lbldate'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape20: TQRShape
      Left = 157
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        415.395833333333300000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblghest: TQRLabel
      Left = 96
      Top = 7
      Width = 60
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        254.000000000000000000
        18.520833333333330000
        158.750000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblghest'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblDelRemain: TQRLabel
      Left = 164
      Top = 7
      Width = 66
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        433.916666666666700000
        18.520833333333330000
        174.625000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblDelRemain'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape22: TQRShape
      Left = 231
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        611.187500000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object SummaryBand1: TQRBand
    Left = 30
    Top = 258
    Width = 734
    Height = 32
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      84.666666666666670000
      1942.041666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
  end
  object bndSign: TQRChildBand
    Left = 30
    Top = 290
    Width = 734
    Height = 34
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      89.958333333333330000
      1942.041666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = SummaryBand1
    object lblReptSign4: TQRLabel
      Left = 144
      Top = 7
      Width = 140
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        381.000000000000000000
        18.520833333333330000
        370.416666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblReptSign4'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblReptSign3: TQRLabel
      Left = 288
      Top = 7
      Width = 140
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        762.000000000000000000
        18.520833333333330000
        370.416666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblReptSign3'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblReptSign2: TQRLabel
      Left = 432
      Top = 7
      Width = 140
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1143.000000000000000000
        18.520833333333330000
        370.416666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblReptSign2'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblReptSign1: TQRLabel
      Left = 576
      Top = 7
      Width = 140
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1524.000000000000000000
        18.520833333333330000
        370.416666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblReptSign1'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblReptSign5: TQRLabel
      Left = 8
      Top = 7
      Width = 140
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        18.520833333333330000
        370.416666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblReptSign5'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object TitleBand1: TQRBand
    Left = 30
    Top = 161
    Width = 734
    Height = 33
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      87.312500000000000000
      1942.041666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbTitle
    object QRLabel10: TQRLabel
      Left = 164
      Top = 6
      Width = 66
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        433.916666666666700000
        15.875000000000000000
        174.625000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1603#1587#1585' '#1605#1575#1606#1583#1607' '#1583#1608#1585#1607
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel1: TQRLabel
      Left = 237
      Top = 6
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        627.062500000000000000
        15.875000000000000000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1575#1587#1578#1601#1575#1583#1607
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape1: TQRShape
      Left = 157
      Top = 1
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        415.395833333333300000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel3: TQRLabel
      Left = 4
      Top = 6
      Width = 85
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        15.875000000000000000
        224.895833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1605#1575#1606#1583#1607' '#1662#1575#1610#1575#1606#1610
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel2: TQRLabel
      Left = 311
      Top = 6
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        822.854166666666700000
        15.875000000000000000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1588#1575#1585#1688
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape2: TQRShape
      Left = 304
      Top = 1
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        804.333333333333300000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel4: TQRLabel
      Left = 458
      Top = 6
      Width = 91
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1211.791666666667000000
        15.875000000000000000
        240.770833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' '#1608' '#1606#1575#1605
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape3: TQRShape
      Left = 452
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1195.916666666667000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel5: TQRLabel
      Left = 628
      Top = 6
      Width = 63
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1661.583333333333000000
        15.875000000000000000
        166.687500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape4: TQRShape
      Left = 622
      Top = 1
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1645.708333333333000000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel6: TQRLabel
      Left = 699
      Top = 6
      Width = 30
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1849.437500000000000000
        15.875000000000000000
        79.375000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1585#1583#1610#1601
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape6: TQRShape
      Left = 693
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1833.562500000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape5: TQRShape
      Left = 378
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1000.125000000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel7: TQRLabel
      Left = 385
      Top = 6
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1018.645833333333000000
        15.875000000000000000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1605#1575#1606#1583#1607' '#1575#1586' '#1662#1610#1588
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel9: TQRLabel
      Left = 558
      Top = 6
      Width = 63
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1476.375000000000000000
        15.875000000000000000
        166.687500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape13: TQRShape
      Left = 551
      Top = 1
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1457.854166666667000000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel8: TQRLabel
      Left = 96
      Top = 6
      Width = 60
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        254.000000000000000000
        15.875000000000000000
        158.750000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1602#1587#1591
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape19: TQRShape
      Left = 231
      Top = 1
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        611.187500000000000000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape23: TQRShape
      Left = 90
      Top = 1
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        238.125000000000000000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
  end
  object SummaryBand2: TQRBand
    Left = 30
    Top = 226
    Width = 734
    Height = 32
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    Frame.Width = 2
    AfterPrint = SummaryBand2AfterPrint
    AlignToBottom = False
    BeforePrint = SummaryBand2BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      84.666666666666670000
      1942.041666666667000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbSummary
    object lbl11: TQRLabel
      Left = 480
      Top = 6
      Width = 19
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1270.000000000000000000
        15.875000000000000000
        50.270833333333330000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = #1580#1605#1593
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblmandeh1: TQRLabel
      Left = 4
      Top = 6
      Width = 85
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        10.583333333333330000
        15.875000000000000000
        224.895833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblmandeh1'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblpardakht1: TQRLabel
      Left = 237
      Top = 6
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        627.062500000000000000
        15.875000000000000000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblpardakht'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblcharge1: TQRLabel
      Left = 311
      Top = 5
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        822.854166666666700000
        13.229166666666670000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblcharge'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbllastcharge1: TQRLabel
      Left = 385
      Top = 6
      Width = 65
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1018.645833333333000000
        15.875000000000000000
        171.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblcharge'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape15: TQRShape
      Left = 304
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        804.333333333333300000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape16: TQRShape
      Left = 90
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        238.125000000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape17: TQRShape
      Left = 378
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1000.125000000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape18: TQRShape
      Left = 452
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        1195.916666666667000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape21: TQRShape
      Left = 231
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        611.187500000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblghest1: TQRLabel
      Left = 96
      Top = 6
      Width = 60
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        254.000000000000000000
        15.875000000000000000
        158.750000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblghest1'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape24: TQRShape
      Left = 157
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666670000
        415.395833333333300000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblDelRemain1: TQRLabel
      Left = 164
      Top = 6
      Width = 66
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        433.916666666666700000
        15.875000000000000000
        174.625000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblDelRemain'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object qry: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 24
    Top = 8
  end
  object qry2: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 112
  end
end
