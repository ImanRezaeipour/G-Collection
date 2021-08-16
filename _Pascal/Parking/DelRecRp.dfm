object frmDeleRecRpt: TfrmDeleRecRpt
  Left = 200
  Top = 108
  HelpContext = 507
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1604#1610#1587#1578' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1581#1584#1601' '#1588#1583#1607
  ClientHeight = 407
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    267
    407)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 212
    Top = 11
    Width = 47
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575#1585#1610#1582' '#1581#1584#1601
    ExplicitLeft = 208
  end
  object Label2: TLabel
    Left = 192
    Top = 11
    Width = 9
    Height = 15
    Caption = #1575#1586
  end
  object Label3: TLabel
    Left = 93
    Top = 11
    Width = 6
    Height = 15
    Caption = #1578#1575
  end
  object Label4: TLabel
    Left = 213
    Top = 40
    Width = 46
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1586#1605#1575#1606' '#1581#1584#1601
    ExplicitLeft = 209
  end
  object Label5: TLabel
    Left = 192
    Top = 40
    Width = 9
    Height = 15
    Caption = #1575#1586
  end
  object Label6: TLabel
    Left = 93
    Top = 40
    Width = 6
    Height = 15
    Caption = #1578#1575
  end
  object Label7: TLabel
    Left = 211
    Top = 76
    Width = 48
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583
  end
  object Label8: TLabel
    Left = 192
    Top = 76
    Width = 9
    Height = 15
    Caption = #1575#1586
  end
  object Label9: TLabel
    Left = 93
    Top = 76
    Width = 6
    Height = 15
    Caption = #1578#1575
  end
  object Label10: TLabel
    Left = 93
    Top = 105
    Width = 6
    Height = 15
    Caption = #1578#1575
  end
  object Label11: TLabel
    Left = 192
    Top = 105
    Width = 9
    Height = 15
    Caption = #1575#1586
  end
  object Label12: TLabel
    Left = 212
    Top = 105
    Width = 47
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1586#1605#1575#1606' '#1608#1585#1608#1583
  end
  object Label13: TLabel
    Left = 207
    Top = 141
    Width = 52
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580
  end
  object Label14: TLabel
    Left = 192
    Top = 141
    Width = 9
    Height = 15
    Caption = #1575#1586
  end
  object Label15: TLabel
    Left = 93
    Top = 141
    Width = 6
    Height = 15
    Caption = #1578#1575
  end
  object Label16: TLabel
    Left = 93
    Top = 170
    Width = 6
    Height = 15
    Caption = #1578#1575
  end
  object Label17: TLabel
    Left = 192
    Top = 170
    Width = 9
    Height = 15
    Caption = #1575#1586
  end
  object Label18: TLabel
    Left = 208
    Top = 170
    Width = 51
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1586#1605#1575#1606' '#1582#1585#1608#1580
  end
  object txtFromDateD: TEdit
    Left = 108
    Top = 8
    Width = 78
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    OnChange = txtFromDateDChange
    OnEnter = txtFromDateDEnter
    OnExit = txtFromDateDExit
    OnKeyPress = txtFromDateDKeyPress
  end
  object txtToDateD: TEdit
    Left = 8
    Top = 8
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    OnChange = txtFromDateDChange
    OnEnter = txtFromDateDEnter
    OnExit = txtToDateDExit
    OnKeyPress = txtFromDateDKeyPress
  end
  object txtFromTimeD: TEdit
    Left = 108
    Top = 37
    Width = 78
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnChange = txtFromDateDChange
    OnEnter = txtFromDateDEnter
    OnExit = txtFromTimeDExit
    OnKeyPress = txtFromTimeDKeyPress
  end
  object txtToTimeD: TEdit
    Left = 8
    Top = 37
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 3
    OnChange = txtFromDateDChange
    OnEnter = txtFromDateDEnter
    OnExit = txtToTimeDExit
    OnKeyPress = txtFromTimeDKeyPress
  end
  object grpDel: TGroupBox
    Left = 116
    Top = 288
    Width = 143
    Height = 85
    Anchors = [akRight, akBottom]
    Caption = #1606#1608#1593' '#1585#1603#1608#1585#1583' '#1581#1584#1601' '#1588#1583#1607
    TabOrder = 13
    object rdoBoth: TRadioButton
      Left = 5
      Top = 21
      Width = 134
      Height = 15
      Caption = #1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoArival: TRadioButton
      Left = 5
      Top = 42
      Width = 134
      Height = 15
      Caption = #1608#1585#1608#1583' '#1582#1608#1583#1585#1608
      TabOrder = 1
    end
    object rdoExit: TRadioButton
      Left = 5
      Top = 63
      Width = 134
      Height = 15
      Caption = #1582#1585#1608#1580' '#1582#1608#1583#1585#1608
      TabOrder = 2
    end
  end
  object cmdPrint: TBitBtn
    Left = 180
    Top = 379
    Width = 79
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 15
    OnClick = cmdPrintClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000CE0E0000D80E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      88888800000000000888808888888880808800000000000008080888888BBB88
      0008088888877788080800000000000008800888888888808080800000000008
      0800880FFFFFFFF080808880F00000F000088880FFFFFFFF088888880F00000F
      088888880FFFFFFFF08888888000000000888888888888888888}
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 379
    Width = 79
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 17
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 93
    Top = 379
    Width = 81
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 16
    Kind = bkHelp
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 288
    Width = 106
    Height = 85
    Anchors = [akRight, akBottom]
    Caption = #1606#1608#1593' '#1670#1575#1662
    TabOrder = 14
    object rdoScreen: TRadioButton
      Left = 4
      Top = 28
      Width = 97
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 4
      Top = 56
      Width = 97
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object txtFromDateI: TEdit
    Left = 108
    Top = 73
    Width = 78
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 4
    OnChange = txtFromDateIChange
    OnEnter = txtFromDateIEnter
    OnExit = txtFromDateIExit
    OnKeyPress = txtFromDateIKeyPress
  end
  object txtToDateI: TEdit
    Left = 8
    Top = 73
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 5
    OnChange = txtFromDateIChange
    OnEnter = txtFromDateIEnter
    OnExit = txtToDateIExit
    OnKeyPress = txtToDateIKeyPress
  end
  object txtToTimeI: TEdit
    Left = 8
    Top = 102
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 7
    OnChange = txtFromDateIChange
    OnEnter = txtFromDateIEnter
    OnExit = txtToTimeIExit
    OnKeyPress = txtToTimeIKeyPress
  end
  object txtFromTimeI: TEdit
    Left = 108
    Top = 102
    Width = 78
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 6
    OnChange = txtFromDateIChange
    OnEnter = txtFromDateIEnter
    OnExit = txtFromTimeIExit
    OnKeyPress = txtFromTimeIKeyPress
  end
  object txtFromDateO: TEdit
    Left = 108
    Top = 138
    Width = 78
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 8
    OnChange = txtFromDateOChange
    OnEnter = txtFromDateOEnter
    OnExit = txtFromDateOExit
    OnKeyPress = txtFromDateOKeyPress
  end
  object txtToDateO: TEdit
    Left = 8
    Top = 138
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 9
    OnChange = txtFromDateOChange
    OnEnter = txtFromDateOEnter
    OnExit = txtToDateOExit
    OnKeyPress = txtToDateOKeyPress
  end
  object txtToTimeO: TEdit
    Left = 8
    Top = 167
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 11
    OnChange = txtFromDateOChange
    OnEnter = txtFromDateOEnter
    OnExit = txtToTimeOExit
    OnKeyPress = txtToTimeOKeyPress
  end
  object txtFromTimeO: TEdit
    Left = 108
    Top = 167
    Width = 78
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 10
    OnChange = txtFromDateOChange
    OnEnter = txtFromDateOEnter
    OnExit = txtFromTimeOExit
    OnKeyPress = txtFromTimeOKeyPress
  end
  object GroupBox1: TGroupBox
    Left = 39
    Top = 196
    Width = 220
    Height = 88
    Anchors = [akTop, akRight]
    Caption = #1605#1585#1606#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    TabOrder = 12
    DesignSize = (
      220
      88)
    object rdoDTDelete: TRadioButton
      Left = 5
      Top = 21
      Width = 211
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      Caption = #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1581#1584#1601' - '#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoDTArival: TRadioButton
      Left = 5
      Top = 42
      Width = 211
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      Caption = #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1608#1585#1608#1583' - '#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      TabOrder = 1
    end
    object rdoDTExit: TRadioButton
      Left = 5
      Top = 63
      Width = 211
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      Caption = #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1582#1585#1608#1580' - '#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      TabOrder = 2
    end
  end
  object cmdCancelFilter: TBitBtn
    Left = 8
    Top = 202
    Width = 25
    Height = 23
    Hint = #1581#1584#1601' '#1578#1605#1575#1605#1610' '#1601#1610#1604#1578#1585#1607#1575
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
    TabStop = False
    OnClick = cmdCancelFilterClick
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
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 65528
  end
end
