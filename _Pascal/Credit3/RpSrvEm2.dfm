object qrptEmplSrvc2: TqrptEmplSrvc2
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
  DataSet = aqryEmplSrvc
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
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
    100.000000000000000000
    100.000000000000000000
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
  ReportTitle = #1711#1586#1575#1585#1588' '#1585#1608#1586#1575#1606#1607' '#1582#1583#1605#1575#1578' '#1575#1601#1585#1575#1583
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsMaximized
  PrevInitialZoom = qrZoomToFit
  object bndCoName: TQRBand
    Left = 38
    Top = 38
    Width = 718
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
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
    object lblCoName: TQRLabel
      Left = 173
      Top = 5
      Width = 372
      Height = 26
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        68.791666666666660000
        457.729166666666700000
        13.229166666666670000
        984.250000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1588#1585#1603#1578' '#1662#1585#1608#1585#1588' '#1583#1575#1583#1607#8204#1607#1575
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object ChildBand1: TQRChildBand
    Left = 38
    Top = 73
    Width = 718
    Height = 56
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
      148.166666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = bndCoName
    object lblName: TQRLabel
      Left = 198
      Top = 0
      Width = 324
      Height = 24
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        63.500000000000000000
        523.875000000000000000
        0.000000000000000000
        857.250000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1711#1586#1575#1585#1588' '#1585#1608#1586#1575#1606#1607' '#1582#1583#1605#1575#1578' '#1575#1601#1585#1575#1583
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbl3: TQRLabel
      Left = 88
      Top = 8
      Width = 32
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
        84.666666666666670000)
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
      Transparent = False
      FontSize = 10
    end
    object lbl4: TQRLabel
      Left = 88
      Top = 24
      Width = 43
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
        113.770833333333300000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = ':'#1587#1575#1593#1578
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lbl2: TQRLabel
      Left = 662
      Top = 16
      Width = 39
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
        103.187500000000000000)
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
      Left = 177
      Top = 26
      Width = 366
      Height = 23
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        60.854166666666660000
        468.312500000000000000
        68.791666666666660000
        968.375000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblRepDate'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object DetailBand1: TQRBand
    Left = 38
    Top = 293
    Width = 718
    Height = 44
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    BeforePrint = DetailBand1BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      116.416666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object QRShape9: TQRShape
      Left = 571
      Top = 0
      Width = 6
      Height = 42
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        111.125000000000000000
        1510.770833333333000000
        0.000000000000000000
        15.875000000000000000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape11: TQRShape
      Left = 313
      Top = 0
      Width = 5
      Height = 42
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        111.125000000000000000
        828.145833333333200000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblSrvcs: TQRLabel
      Left = 459
      Top = 14
      Width = 113
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1214.437500000000000000
        37.041666666666670000
        298.979166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      Caption = 'lblSrvcs'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRDBText3: TQRDBText
      Left = 630
      Top = 14
      Width = 85
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1666.875000000000000000
        37.041666666666670000
        224.895833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = aqryEmplSrvc
      DataField = '_Date'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape6: TQRShape
      Left = 624
      Top = -1
      Width = 6
      Height = 44
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        116.416666666666700000
        1651.000000000000000000
        -2.645833333333333000
        15.875000000000000000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRDBText5: TQRDBText
      Left = 581
      Top = 14
      Width = 41
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1537.229166666667000000
        37.041666666666670000
        108.479166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = aqryEmplSrvc
      DataField = '_Time'
      OnPrint = QRDBText5Print
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape8: TQRShape
      Left = 109
      Top = 1
      Width = 5
      Height = 42
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        111.125000000000000000
        288.395833333333300000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblRemainDtl: TQRLabel
      Left = 5
      Top = 14
      Width = 103
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        13.229166666666670000
        37.041666666666670000
        272.520833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblSrvcs'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape5: TQRShape
      Left = 213
      Top = 1
      Width = 5
      Height = 42
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        111.125000000000000000
        563.562500000000000000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblBedeh: TQRLabel
      Left = 222
      Top = 14
      Width = 85
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        587.375000000000000000
        37.041666666666670000
        224.895833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblBedeh'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblBestan: TQRLabel
      Left = 114
      Top = 14
      Width = 93
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        301.625000000000000000
        37.041666666666670000
        246.062500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblBestan'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRDBText1: TQRDBText
      Left = 320
      Top = 23
      Width = 131
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        846.666666666666700000
        60.854166666666670000
        346.604166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      DataSet = aqryEmplSrvc
      DataField = '_rec'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape14: TQRShape
      Left = 452
      Top = 0
      Width = 6
      Height = 42
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        111.125000000000000000
        1195.916666666667000000
        0.000000000000000000
        15.875000000000000000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel7: TQRLabel
      Left = 320
      Top = 4
      Width = 131
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        846.666666666666700000
        10.583333333333330000
        346.604166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'QRLabel7'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object grpPub: TQRGroup
    Left = 38
    Top = 261
    Width = 718
    Height = 14
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      37.041666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    ReprintOnNewPage = False
  end
  object bndDescribe: TQRChildBand
    Left = 38
    Top = 129
    Width = 718
    Height = 32
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
      84.666666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = ChildBand1
    object lblDescribe: TQRLabel
      Left = 8
      Top = 8
      Width = 705
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        21.166666666666670000
        21.166666666666670000
        1865.312500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblDescribe'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object clmnGroup: TQRBand
    Left = 38
    Top = 161
    Width = 718
    Height = 32
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
      84.666666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbColumnHeader
    object lblPub: TQRLabel
      Left = 152
      Top = 8
      Width = 35
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        402.166666666666700000
        21.166666666666670000
        92.604166666666670000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = 'lblPub'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object txtGroup: TQRDBText
      Left = 77
      Top = 8
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        203.729166666666700000
        21.166666666666670000
        193.145833333333300000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Color = clWhite
      DataSet = aqryEmplSrvc
      DataField = 'Empl_Family'
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRExpr1: TQRExpr
      Left = 504
      Top = 8
      Width = 200
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1333.500000000000000000
        21.166666666666670000
        529.166666666666800000)
      Alignment = taRightJustify
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Color = clWhite
      ResetAfterPrint = False
      Transparent = False
      WordWrap = True
      Expression = 'aqryEmplSrvc.Empl_Family + '#39'-'#39' + aqryEmplSrvc.Empl_Name'
      FontSize = 10
    end
  end
  object clmnHead: TQRChildBand
    Left = 38
    Top = 193
    Width = 718
    Height = 68
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = False
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    BeforePrint = clmnHeadBeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      179.916666666666700000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = True
    ParentBand = clmnGroup
    object lbl9: TQRLabel
      Left = 224
      Top = 9
      Width = 73
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        592.666666666666800000
        23.812500000000000000
        193.145833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1576#1583#1607#1705#1575#1585
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape2: TQRShape
      Left = 453
      Top = 1
      Width = 5
      Height = 68
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        179.916666666666700000
        1198.562500000000000000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape3: TQRShape
      Left = 572
      Top = 0
      Width = 5
      Height = 68
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        179.916666666666700000
        1513.416666666667000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lbl8: TQRLabel
      Left = 476
      Top = 9
      Width = 74
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1259.416666666667000000
        23.812500000000000000
        195.791666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1593#1606#1608#1575#1606
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel1: TQRLabel
      Left = 630
      Top = 8
      Width = 85
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1666.875000000000000000
        21.166666666666670000
        224.895833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1578#1575#1585#1610#1582
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape4: TQRShape
      Left = 625
      Top = 0
      Width = 5
      Height = 68
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        179.916666666666700000
        1653.645833333333000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel2: TQRLabel
      Left = 578
      Top = 9
      Width = 41
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1529.291666666667000000
        23.812500000000000000
        108.479166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1586#1605#1575#1606
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel3: TQRLabel
      Left = 6
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
        15.875000000000000000
        15.875000000000000000
        240.770833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1605#1575#1606#1583#1607
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape7: TQRShape
      Left = 109
      Top = 0
      Width = 5
      Height = 68
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        179.916666666666700000
        288.395833333333300000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape10: TQRShape
      Left = 1
      Top = 32
      Width = 716
      Height = 6
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        15.875000000000000000
        2.645833333333333000
        84.666666666666680000
        1894.416666666667000000)
      Shape = qrsHorLine
      VertAdjust = 0
    end
    object QRLabel4: TQRLabel
      Left = 581
      Top = 44
      Width = 41
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1537.229166666667000000
        116.416666666666700000
        108.479166666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '-----'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object _lblRemainDate: TQRLabel
      Left = 630
      Top = 44
      Width = 85
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1666.875000000000000000
        116.416666666666700000
        224.895833333333300000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '------------------'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblRemainDate: TQRLabel
      Left = 458
      Top = 44
      Width = 114
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        1211.791666666667000000
        116.416666666666700000
        301.625000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1605#1575#1606#1583#1607' '#1575#1586' '#1602#1576#1604' '
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblRBedeh: TQRLabel
      Left = 224
      Top = 44
      Width = 60
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        592.666666666666800000
        116.416666666666700000
        158.750000000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '0'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblRemain: TQRLabel
      Left = 10
      Top = 44
      Width = 92
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        26.458333333333330000
        116.416666666666700000
        243.416666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1605#1575#1606#1583#1607
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object lblRBestan: TQRLabel
      Left = 114
      Top = 44
      Width = 87
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        301.625000000000000000
        116.416666666666700000
        230.187500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = '0'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRLabel8: TQRLabel
      Left = 120
      Top = 9
      Width = 69
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        317.500000000000000000
        23.812500000000000000
        182.562500000000000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1576#1587#1578#1575#1606#1705#1575#1585
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape1: TQRShape
      Left = 213
      Top = 0
      Width = 5
      Height = 68
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        179.916666666666700000
        563.562500000000000000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRShape13: TQRShape
      Left = 313
      Top = 1
      Width = 5
      Height = 68
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        179.916666666666700000
        828.145833333333200000
        2.645833333333333000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object QRLabel6: TQRLabel
      Left = 344
      Top = 9
      Width = 74
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        910.166666666666600000
        23.812500000000000000
        195.791666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = #1605#1585#1705#1586'/'#1578#1585#1605#1610#1606#1575#1604
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object grpDate: TQRGroup
    Left = 38
    Top = 275
    Width = 718
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      47.625000000000000000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Expression = 'aqryEmplSrvc.EMPL_NO'
    FooterBand = SummaryBand1
    Master = Owner
    ReprintOnNewPage = False
  end
  object SummaryBand1: TQRBand
    Left = 38
    Top = 337
    Width = 718
    Height = 32
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    AlignToBottom = False
    BeforePrint = SummaryBand1BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      84.666666666666670000
      1899.708333333333000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
    object lbl11: TQRLabel
      Left = 128
      Top = 9
      Width = 48
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        338.666666666666700000
        23.812500000000000000
        127.000000000000000000)
      Alignment = taLeftJustify
      AlignToBand = False
      AutoSize = True
      AutoStretch = False
      Caption = #1605#1575#1606#1583#1607' '#1603#1604
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRShape12: TQRShape
      Left = 109
      Top = 0
      Width = 5
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        84.666666666666680000
        288.395833333333400000
        0.000000000000000000
        13.229166666666670000)
      Shape = qrsVertLine
      VertAdjust = 0
    end
    object lblAllRemain: TQRLabel
      Left = 5
      Top = 8
      Width = 92
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666670000
        13.229166666666670000
        21.166666666666670000
        243.416666666666700000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      Caption = 'lblSrvcs'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
  end
  object bndSign: TQRChildBand
    Left = 38
    Top = 369
    Width = 718
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
      1899.708333333333000000)
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
  object aqryEmplSrvc: TADOQuery
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\PrgOut\CredRest\' +
      'CredRest.mdb;Persist Security Info=False'
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Recit1_TotalPrice, Recit1_Date, Recit1_Vadeh, Empl_No, Em' +
        'pl_Family, Empl_Name'
      'FROM Employee, Receipt1 WHERE Empl_No = Recit1_EmplNo'
      'ORDER BY Recit1_Date, Recit1_Vadeh, Empl_No')
    Left = 96
    Top = 8
  end
end
