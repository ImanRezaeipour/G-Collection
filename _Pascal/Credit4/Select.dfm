object frmSelect: TfrmSelect
  Left = 221
  Top = 127
  ActiveControl = cmbFromNo
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1606#1578#1582#1575#1576' '#1662#1585#1587#1606#1604
  ClientHeight = 291
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 427
    Height = 291
    Align = alClient
    TabOrder = 0
    object lbl1: TLabel
      Left = 383
      Top = 13
      Width = 38
      Height = 15
      Caption = #1575#1586' '#1588#1605#1575#1585#1607
    end
    object lbl2: TLabel
      Left = 193
      Top = 13
      Width = 53
      Height = 15
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
    end
    object lbl3: TLabel
      Left = 386
      Top = 45
      Width = 35
      Height = 15
      Caption = #1578#1575' '#1588#1605#1575#1585#1607
    end
    object lbl4: TLabel
      Left = 193
      Top = 45
      Width = 53
      Height = 15
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
    end
    object cmbFromNo: TComboBox
      Left = 252
      Top = 13
      Width = 121
      Height = 23
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = cmbFromNoExit
      OnExit = cmbFromNoExit
      OnKeyPress = cmbFromNoKeyPress
    end
    object cmbFromFamily: TComboBox
      Left = 3
      Top = 13
      Width = 181
      Height = 23
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      MaxLength = 25
      ParentBiDiMode = False
      TabOrder = 1
      OnClick = cmbFromFamilyExit
      OnExit = cmbFromFamilyExit
      OnKeyPress = cmbFromFamilyKeyPress
    end
    object cmbToNo: TComboBox
      Left = 252
      Top = 48
      Width = 121
      Height = 23
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 2
      OnClick = cmbToNoExit
      OnExit = cmbToNoExit
      OnKeyPress = cmbToNoKeyPress
    end
    object cmbToFamily: TComboBox
      Left = 3
      Top = 45
      Width = 180
      Height = 23
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      MaxLength = 25
      ParentBiDiMode = False
      TabOrder = 3
      OnClick = cmbToFamilyExit
      OnExit = cmbToFamilyExit
      OnKeyPress = cmbToFamilyKeyPress
    end
    object cmdSelect: TBitBtn
      Left = 320
      Top = 77
      Width = 90
      Height = 25
      Caption = '&'#1575#1606#1578#1582#1575#1576
      TabOrder = 4
      OnClick = cmdSelectClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555FFFFF5555555555000005555555555F777775FF555555008877700
        55555557755FFF775F55550887000777055555755F777FFF75F550880FBFBF07
        705557F57755577FF7F55080F00000F07055575755777557F75F087F00B3300F
        77057F5757555757FF7F080B0B3B330B07057F757F5555757F7F0F0F0BBBB30F
        07057F757F5555757F7F0F0B0FBB3B0B08057F757FF55575757F0F7F00FFB00F
        780575F757FFF757F5755080F00000F0805557F75577755757F550F80FBFBF08
        8055575F775557755755550F8700078805555575FF77755F755555500FFF8800
        5555555775FFFF77555555555000005555555555577777555555}
      NumGlyphs = 2
    end
    object cmdDelete: TBitBtn
      Left = 176
      Top = 77
      Width = 90
      Height = 25
      Caption = '&'#1581#1584#1601
      TabOrder = 5
      OnClick = cmdDeleteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555FFFFF5555555555000005555555555F777775FF555555008877700
        55555557755FFF775F55550887000777055555755F777FFF75F5508800000007
        705557F57777777FF7F55080000000007055575777777777F75F087000333000
        77057F5777555777FF7F08000333330007057F777F5555777F7F0F0003333300
        07057F777F5555777F7F0F000833330008057F777FF55577757F0F7000883000
        780575F777FFF777F575508000000000805557F77777777757F550F800000008
        8055575F777777755755550F8700078805555575FF77755F755555500FFF8800
        5555555775FFFF77555555555000005555555555577777555555}
      NumGlyphs = 2
    end
    object cmdDeleteAll: TBitBtn
      Left = 16
      Top = 77
      Width = 90
      Height = 25
      Caption = #1581#1584#1601' &'#1607#1605#1607
      TabOrder = 6
      OnClick = cmdDeleteAllClick
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
    object lstSelect: TListBox
      Left = 8
      Top = 109
      Width = 409
      Height = 145
      ItemHeight = 15
      MultiSelect = True
      TabOrder = 7
      OnKeyPress = lstSelectKeyPress
    end
    object cmdSave: TBitBtn
      Left = 328
      Top = 261
      Width = 90
      Height = 25
      Caption = '&'#1578#1575#1610#1610#1583
      ModalResult = 1
      TabOrder = 8
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object cmdHelp: TBitBtn
      Left = 176
      Top = 260
      Width = 90
      Height = 25
      Caption = '&'#1585#1575#1607#1606#1605#1575
      TabOrder = 9
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 261
      Width = 90
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 10
      Kind = bkClose
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 76
  end
end
