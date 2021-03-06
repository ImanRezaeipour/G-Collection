object qrptBarcode: TqrptBarcode
  Left = 0
  Top = 0
  Width = 1123
  Height = 794
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  DataSet = adoQryPersons
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
  Page.Columns = 4
  Page.Orientation = poLandscape
  Page.PaperSize = A4
  Page.Values = (
    100.000000000000000000
    2100.000000000000000000
    50.000000000000000000
    2970.000000000000000000
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
  ReportTitle = #1670#1575#1662' '#1576#1575#1585#1603#1583
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevInitialZoom = qrZoomToFit
  object DetailBand1: TQRBand
    Left = 38
    Top = 19
    Width = 261
    Height = 102
    Frame.Color = clSilver
    Frame.DrawTop = False
    Frame.DrawBottom = True
    Frame.DrawLeft = False
    Frame.DrawRight = False
    Frame.Style = psDashDot
    AlignToBottom = False
    BeforePrint = DetailBand1BeforePrint
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      269.875000000000000000
      690.562500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
    object lblBarcode: TQRLabel
      Left = 6
      Top = 3
      Width = 250
      Height = 17
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        44.979166666666700000
        15.875000000000000000
        7.937500000000000000
        661.458333333333000000)
      Alignment = taCenter
      AlignToBand = False
      AutoSize = False
      AutoStretch = False
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      Caption = 'lblBarcode'
      Color = clWhite
      Transparent = False
      WordWrap = True
      FontSize = 10
    end
    object QRImagebarcode: TQRImage
      Left = 7
      Top = 24
      Width = 250
      Height = 73
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      Size.Values = (
        193.145833333333000000
        18.520833333333300000
        63.500000000000000000
        661.458333333333000000)
      Picture.Data = {
        07544269746D6170DE0F0000424DDE0F0000000000003E000000280000002C01
        0000640000000100010000000000A00F0000C40E0000C40E0000020000000000
        000000000000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFE0FF83FF87FE0FF83FE0FE0FF003F83E0
        03F03FE1FE0FF003FE1FFFFFFFFFFFF00000FFFFFFFFFFF863E18FE31F8C7E31
        F8C7863FE1FE31E003C79F8C7863FE1FFE1FFFFFFFFFFFF00000FFFFFFFFFFF8
        F1E3C7E78F1E3C78F1E38F1FE1FC78F001CFCF9E38F1FE1FFE1FFFFFFFFFFFF0
        0000FFFFFFFFFFF9F1E7C3C78F1E1C7871E19F0FE1FC7879F98FC71E39F1FE1F
        FE1FFFFFFFFFFFF00000FFFFFFFFFFFFF0FFC3C78E1E187861E1FF0FE1F8787C
        FD8FC71E3FF0FE1FFE1FFFFFFFFFFFF00000FFFFFFFFFFFFF0FFC387861E1878
        61E1FF0FE1F8787E7F8F861E1FF0FE1F8007FFFFFFFFFFF00000FFFFFFFFFFFF
        F0FF8387861E187861E1FE0FE1F8787F3FC7061E1FF0FE1F8007FFFFFFFFFFF0
        0000FFFFFFFFFFFFE0FF8387861E187861E1FE0FE1F8787F9FE40E1E1FE0FE1F
        DE1FFFFFFFFFFFF00000FFFFFFFFFFFF81F00787860C3830E0C3C01FE1F830FF
        8FF01E1E1F81FE1FEE1FFFFFFFFFFFF00000FFFFFFFFFFFFC3F00F8786107841
        E107C03FE1F841FFC7E07E1E1FC3FE1FF61FFFFFFFFFFFF00000FFFFFFFFFFFF
        E7F03F87871FFC7FF1FFC0FFE1FC7FFFC3C19E1E1FE7FE1FFA1FFFFFFFFFFFF0
        0000FFFFFFFFFFFFF1F7FF87870FFC3FF0FFDFFFE1FC3FFFC387CE1E1FF1FE1F
        F81FFFFFFFFFFFF00000FFFFFFFFFFFFF0F7FFC78F8FFE3FF8FFDFFF61FE3FEF
        C38FC71E3FF0F61FFC1FFFFFFFFFFFF00000FFFFFFFFFFFBF0F7FFC78FC7FF1F
        FC7FDFFFA1FF1FE7C38FC71E3BF0FA1FFE1FFFFFFFFFFFF00000FFFFFFFFFFFC
        E0F007E79FE3FF8FFE3FC01FC1FF8FF387CFC79E7CE0FC1FFF1FFFFFFFFFFFF0
        0000FFFFFFFFFFFE01F007E31FF1FFC7FF1FC01FF1FFC7F807C78F8C7E01FF1F
        FF9FFFFFFFFFFFF00000FFFFFFFFFFFF03F007F87FFC7FF1FFC7C01FF9FFF1FC
        1FF03FE1FF03FF9FFFDFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFF7FFFFFFFFFF
        FFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E
        3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DBDF6E793B9DB9E77D
        B7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF9206DF93B9DF6E77DB
        DF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF00000FFFFFFFFFF92
        06DF93B9DF6E77DBDF6E793B9DB9E77DB7CEFB93C9DC624E3B604FFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF00000}
      Stretch = True
    end
  end
  object adoQryPersons: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P_BarCode, P_Name, P_Family, P_MainPart, P_DetailPart, P_' +
        'JobCode,'
      '               P_CoPosts'
      'FROM Persons'
      'ORDER BY P_MainPart, P_DetailPart'
      '')
    Left = 32
    Top = 48
  end
end
