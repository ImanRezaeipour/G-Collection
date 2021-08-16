object frmEmployeeServiceRpt2: TfrmEmployeeServiceRpt2
  Left = 118
  Top = 80
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1589#1608#1585#1578#1581#1587#1575#1576' '#1575#1601#1585#1575#1583' '#1576#1607' '#1589#1608#1585#1578' '#1705#1604#1610' '
  ClientHeight = 266
  ClientWidth = 515
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
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 471
    Top = 13
    Width = 20
    Height = 15
    Caption = #1583#1608#1585#1607
  end
  object lbl2: TLabel
    Left = 454
    Top = 40
    Width = 48
    Height = 15
    Caption = #1605#1581#1604' '#1582#1583#1605#1578
    Visible = False
  end
  object lbl3: TLabel
    Left = 452
    Top = 72
    Width = 50
    Height = 15
    Caption = #1605#1585#1603#1586#1582#1583#1605#1575#1578
    Visible = False
  end
  object lbl4: TLabel
    Left = 193
    Top = 45
    Width = 50
    Height = 15
    Caption = #1580#1575#1610#1711#1575#1607' '#1575#1601#1585#1575#1583
    Visible = False
  end
  object lbl8: TLabel
    Left = 464
    Top = 190
    Width = 30
    Height = 15
    Caption = #1578#1608#1590#1610#1581
  end
  object rdoReportType: TRadioGroup
    Left = 0
    Top = 392
    Width = 217
    Height = 169
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    ItemIndex = 1
    Items.Strings = (
      #1711#1586#1575#1585#1588' '#1603#1604#1610' '#1575#1587#1578#1601#1575#1583#1607' '#1575#1586' '#1582#1583#1605#1575#1578' '#1575#1601#1585#1575#1583
      #1711#1586#1575#1585#1588' '#1585#1608#1586#1575#1606#1607' '#1582#1583#1605#1575#1578' '#1575#1601#1585#1575#1583
      #1711#1586#1575#1585#1588' '#1601#1610#1588#1607#1575#1610' '#1575#1601#1585#1575#1583
      #1711#1586#1575#1585#1588' '#1605#1588#1585#1608#1581' '#1575#1587#1578#1601#1575#1583#1607' '#1575#1586' '#1582#1583#1605#1575#1578' '#1575#1601#1585#1575#1583)
    TabOrder = 6
    Visible = False
    OnClick = rdoReportTypeClick
  end
  object cmbEmplCode: TComboBox
    Left = 338
    Top = 8
    Width = 113
    Height = 23
    BiDiMode = bdLeftToRight
    ItemHeight = 15
    ParentBiDiMode = False
    TabOrder = 0
    OnClick = cmbEmplCodeClick
    OnExit = cmbEmplCodeExit
  end
  object cmbEmplName: TComboBox
    Left = 135
    Top = 8
    Width = 201
    Height = 23
    ItemHeight = 15
    TabOrder = 1
    OnClick = cmbEmplNameClick
    OnExit = cmbEmplNameExit
  end
  object btnEmplSel: TBitBtn
    Left = 8
    Top = 8
    Width = 115
    Height = 25
    Caption = #1575#1606#1578#1582#1575#1576' '#1583#1608#1585#1607
    TabOrder = 2
    OnClick = btnEmplSelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00344446333334
      44433333FFFF333333FFFF33000033AAA43333332A4333338833F33333883F33
      00003332A46333332A4333333383F33333383F3300003332A2433336A6633333
      33833F333383F33300003333AA463362A433333333383F333833F33300003333
      6AA4462A46333333333833FF833F33330000333332AA22246333333333338333
      33F3333300003333336AAA22646333333333383333F8FF33000033444466AA43
      6A43333338FFF8833F383F330000336AA246A2436A43333338833F833F383F33
      000033336A24AA442A433333333833F33FF83F330000333333A2AA2AA4333333
      333383333333F3330000333333322AAA4333333333333833333F333300003333
      333322A4333333333333338333F333330000333333344A433333333333333338
      3F333333000033333336A24333333333333333833F333333000033333336AA43
      33333333333333833F3333330000333333336663333333333333333888333333
      0000}
    NumGlyphs = 2
  end
  object cmbParts: TComboBox
    Left = 264
    Top = 40
    Width = 177
    Height = 23
    ItemHeight = 15
    TabOrder = 3
    Visible = False
  end
  object cmbDepartment: TComboBox
    Left = 264
    Top = 72
    Width = 177
    Height = 23
    ItemHeight = 15
    TabOrder = 5
    Visible = False
  end
  object cmbCoPosts: TComboBox
    Left = 8
    Top = 40
    Width = 177
    Height = 23
    ItemHeight = 15
    TabOrder = 4
    Visible = False
  end
  object grpPrintType: TGroupBox
    Left = 3
    Top = 63
    Width = 129
    Height = 105
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 9
    object rdoScreen: TRadioButton
      Left = 32
      Top = 24
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 72
      Top = 48
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 8
      Top = 80
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 222
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 13
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 152
    Top = 222
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 12
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 584
    Top = 296
    Width = 105
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 11
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
  object rdoSort: TRadioGroup
    Left = 136
    Top = 63
    Width = 153
    Height = 107
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    ItemIndex = 0
    Items.Strings = (
      #1588#1605#1575#1585#1607
      #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610)
    TabOrder = 8
  end
  object rdoGroup: TRadioGroup
    Left = 296
    Top = 63
    Width = 201
    Height = 105
    Caption = #1578#1601#1603#1610#1603' '#1576#1585' '#1575#1587#1575#1587
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1576#1583#1608#1606' '#1578#1601#1603#1610#1603
      #1605#1581#1604' '#1582#1583#1605#1578
      #1580#1575#1610#1711#1575#1607' '#1575#1601#1585#1575#1583
      #1711#1585#1608#1607' '#1578#1582#1601#1610#1601
      #1605#1585#1603#1586' '#1582#1583#1605#1575#1578)
    TabOrder = 7
  end
  object txtdescribe: TEdit
    Left = 8
    Top = 190
    Width = 449
    Height = 23
    TabOrder = 10
  end
  object BitBtn1: TBitBtn
    Left = 424
    Top = 222
    Width = 75
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    OnClick = BitBtn1Click
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
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 8
    Top = 65
  end
end
