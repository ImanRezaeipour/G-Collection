object frmTextFish: TfrmTextFish
  Left = 212
  Top = 15
  HelpContext = 313
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1610#1580#1575#1583' '#1601#1575#1610#1604' '#1605#1578#1606#1610' '#1575#1586' '#1601#1610#1588#1607#1575
  ClientHeight = 403
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 251
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label2: TLabel
    Left = 110
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label3: TLabel
    Left = 219
    Top = 48
    Width = 51
    Height = 15
    Caption = #1606#1608#1593' &'#1711#1586#1575#1585#1588
    FocusControl = cmbRptType
  end
  object Label4: TLabel
    Left = 256
    Top = 288
    Width = 30
    Height = 15
    Caption = '&'#1606#1575#1605' '#1601#1575#1610#1604
    FocusControl = txtFileName
  end
  object Label5: TLabel
    Left = 237
    Top = 320
    Width = 49
    Height = 15
    Caption = '&'#1587#1610#1587#1578#1605' '#1601#1608#1606#1578
    FocusControl = cmbFonts
  end
  object Label6: TLabel
    Left = 222
    Top = 232
    Width = 72
    Height = 15
    Caption = '&'#1603#1583' '#1580#1583#1575#1603#1606#1606#1583#1607' '#1601#1610#1604#1583#1607#1575
    FocusControl = txtCode
  end
  object Label7: TLabel
    Left = 60
    Top = 232
    Width = 82
    Height = 15
    Caption = '&'#1588#1603#1604' '#1580#1583#1575#1603#1606#1606#1583#1607' '#1601#1610#1604#1583#1607#1575
    FocusControl = txtMap
  end
  object Label8: TLabel
    Left = 80
    Top = 48
    Width = 22
    Height = 15
    Caption = '&'#1601#1610#1604#1583#1607#1575
    FocusControl = lstFields
  end
  object txtFromDate: TEdit
    Left = 152
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 8
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object cmbRptType: TComboBox
    Left = 144
    Top = 64
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 2
    OnClick = cmbRptTypeClick
    OnKeyPress = cmbRptTypeKeyPress
    Items.Strings = (
      #1711#1586#1575#1585#1588' '#1603#1604#1610
      #1711#1586#1575#1585#1588' '#1603#1604#1610' '#1576#1607' '#1578#1601#1603#1610#1603' '#1608#1593#1583#1607
      #1711#1586#1575#1585#1588' '#1603#1604#1610' '#1585#1608#1586#1575#1606#1607
      #1711#1586#1575#1585#1588' '#1578#1601#1589#1610#1604#1610
      #1711#1586#1575#1585#1588' '#1603#1604#1610' '#1605#1588#1582#1589#1575#1578' '#1662#1585#1587#1606#1604
      #1570#1605#1575#1585' '#1585#1610#1575#1604#1610' '#1585#1587#1578#1608#1585#1575#1606#1607#1575'('#1587#1585#1580#1605#1593' '#1662#1585#1587#1606#1604')')
  end
  object lstFields: TListBox
    Left = 8
    Top = 64
    Width = 129
    Height = 161
    ItemHeight = 15
    TabOrder = 8
    OnKeyDown = lstFieldsKeyDown
    OnKeyPress = cmbRptTypeKeyPress
  end
  object txtFileName: TEdit
    Left = 8
    Top = 288
    Width = 233
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 9
    Text = 'Fish.Txt'
    OnKeyPress = cmbRptTypeKeyPress
  end
  object cmbFonts: TComboBox
    Left = 8
    Top = 320
    Width = 217
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 10
    OnKeyPress = cmbRptTypeKeyPress
    Items.Strings = (
      #1603#1583#1662#1610#1580' '#1587#1610#1606#1575' ('#1608#1610#1606#1583#1608#1586')'
      #1603#1583#1662#1610#1580' '#1605#1575#1610#1603#1585#1608#1587#1575#1601#1578' ('#1608#1610#1606#1583#1608#1586')'
      #1601#1608#1606#1578' '#1575#1610#1585#1575#1606' '#1587#1610#1587#1578#1605
      #1601#1608#1606#1578' '#1587#1575#1610#1607' '#1588#1585#1603#1578' '#1587#1610#1606#1575
      #1601#1608#1606#1578' '#1662#1585#1608#1585#1588' '#1583#1575#1583#1607' '#1607#1575)
  end
  object txtCode: TEdit
    Left = 168
    Top = 232
    Width = 33
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 3
    ParentBiDiMode = False
    TabOrder = 5
    OnChange = txtCodeChange
    OnKeyPress = txtCodeKeyPress
  end
  object txtMap: TEdit
    Left = 8
    Top = 232
    Width = 33
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 1
    ParentBiDiMode = False
    TabOrder = 6
    OnChange = txtMapChange
    OnKeyPress = cmbRptTypeKeyPress
  end
  object cmdRun: TBitBtn
    Left = 200
    Top = 376
    Width = 91
    Height = 25
    Caption = #1575'&'#1580#1585#1575
    TabOrder = 11
    OnClick = cmdRunClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
      555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
      05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
      FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
      FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
      FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
      05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
      555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
      9055575757575757775505050505055505557575757575557555}
    NumGlyphs = 2
  end
  object cmdHelp: TBitBtn
    Left = 104
    Top = 376
    Width = 91
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 12
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 376
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 13
    Kind = bkClose
  end
  object chkTitle: TCheckBox
    Left = 88
    Top = 264
    Width = 201
    Height = 17
    Caption = '&'#1584#1582#1610#1585#1607' '#1606#1575#1605' '#1601#1610#1604#1583#1607#1575' '#1583#1585' '#1575#1608#1604#1610#1606' '#1585#1603#1608#1585#1583' '#1601#1575#1610#1604
    TabOrder = 7
    OnKeyPress = cmbRptTypeKeyPress
  end
  object cmdAll: TBitBtn
    Left = 168
    Top = 136
    Width = 105
    Height = 25
    Caption = '&'#1578#1605#1575#1605' '#1601#1610#1604#1583#1607#1575
    TabOrder = 3
    OnClick = cmdAllClick
    Glyph.Data = {
      F2010000424DF201000000000000760000002800000024000000130000000100
      0400000000007C01000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
      3333333333388F3333333333000033334224333333333333338338F333333333
      0000333422224333333333333833338F33333333000033422222243333333333
      83333338F3333333000034222A22224333333338F33F33338F33333300003222
      A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
      38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
      2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
      0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
      333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
      33333A2224A2233333333338F338F83300003333333333A2224A333333333333
      8F338F33000033333333333A222433333333333338F338F30000333333333333
      A224333333333333338F38F300003333333333333A223333333333333338F8F3
      000033333333333333A3333333333333333383330000}
    NumGlyphs = 2
  end
  object cmdDel: TBitBtn
    Left = 168
    Top = 176
    Width = 105
    Height = 25
    Caption = '&'#1581#1584#1601' '#1601#1610#1604#1583
    TabOrder = 4
    OnClick = cmdDelClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
      555557777F777555F55500000000555055557777777755F75555005500055055
      555577F5777F57555555005550055555555577FF577F5FF55555500550050055
      5555577FF77577FF555555005050110555555577F757777FF555555505099910
      555555FF75777777FF555005550999910555577F5F77777775F5500505509990
      3055577F75F77777575F55005055090B030555775755777575755555555550B0
      B03055555F555757575755550555550B0B335555755555757555555555555550
      BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
      50BB555555555555575F555555555555550B5555555555555575}
    NumGlyphs = 2
  end
  object prgBar: TProgressBar
    Left = 8
    Top = 352
    Width = 281
    Height = 16
    Smooth = True
    Step = 1
    TabOrder = 14
  end
end