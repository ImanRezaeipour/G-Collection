object frmamar4rp: Tfrmamar4rp
  Left = 118
  Top = 80
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1705#1604#1610' '#1588#1575#1585#1688' '#1608' '#1575#1587#1578#1601#1575#1583#1607
  ClientHeight = 414
  ClientWidth = 400
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
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 343
    Top = 92
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object lbl2: TLabel
    Left = 122
    Top = 92
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label3: TLabel
    Left = 360
    Top = 51
    Width = 26
    Height = 15
    Caption = #1662#1585#1587#1606#1604
  end
  object lbl4: TLabel
    Left = 336
    Top = 12
    Width = 50
    Height = 15
    Caption = '&'#1580#1575#1610#1711#1575#1607' '#1575#1601#1585#1575#1583
  end
  object Label1: TLabel
    Left = 335
    Top = 132
    Width = 47
    Height = 15
    Caption = #1578#1593#1583#1575#1583' '#1575#1602#1587#1575#1591
    FocusControl = txttedad
  end
  object cmdExit: TBitBtn
    Left = 12
    Top = 368
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 149
    Top = 369
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 281
    Top = 369
    Width = 105
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 4
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
  object txtFromDate: TEdit
    Left = 240
    Top = 88
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 12
    Top = 88
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object grpPrintType: TGroupBox
    Left = 249
    Top = 247
    Width = 137
    Height = 104
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 3
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
      Top = 47
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 8
      Top = 70
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
    end
  end
  object cmbEmplCode: TComboBox
    Left = 240
    Top = 48
    Width = 114
    Height = 23
    ItemHeight = 15
    TabOrder = 7
    OnClick = cmbEmplCodeClick
    OnExit = cmbEmplCodeExit
  end
  object cmbEmplName: TComboBox
    Left = 12
    Top = 48
    Width = 218
    Height = 23
    ItemHeight = 15
    TabOrder = 8
    OnClick = cmbEmplNameClick
    OnExit = cmbEmplNameExit
  end
  object rdoSort: TRadioGroup
    Left = 131
    Top = 247
    Width = 108
    Height = 104
    Caption = #1605#1585#1578#1576' '#1576#1585' '#1575#1587#1575#1587
    ItemIndex = 0
    Items.Strings = (
      #1588#1605#1575#1585#1607
      #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610)
    TabOrder = 9
  end
  object rdokind: TRadioGroup
    Left = 12
    Top = 247
    Width = 108
    Height = 104
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    ItemIndex = 0
    Items.Strings = (
      #1605#1588#1585#1608#1581
      #1605#1580#1605#1608#1593)
    TabOrder = 10
  end
  object cmbcoposts: TCheckedComboBox
    Left = 122
    Top = 8
    Width = 208
    Height = 23
    CapSelectAll = '&Select All'
    CapDeSelectAll = '&DeSelect All'
    NotFocusColor = clWhite
    EmptyValue = '<none>'
    TabOrder = 11
    Version = '1.7'
  end
  object txttedad: TEdit
    Left = 240
    Top = 128
    Width = 57
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 2
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txttedadKeyPress
  end
  object cbdontshowkharid: TCheckBox
    Left = 40
    Top = 165
    Width = 342
    Height = 17
    Caption = #1593#1583#1605' '#1606#1605#1575#1610#1588' '#1705#1587#1575#1606#1610' '#1705#1607' '#1582#1585#1610#1583' '#1606#1583#1575#1588#1578#1607' '#1575#1606#1583
    TabOrder = 12
  end
  object cbdontshowcharge: TCheckBox
    Left = 40
    Top = 188
    Width = 342
    Height = 17
    Caption = #1593#1583#1605' '#1606#1605#1575#1610#1588' '#1705#1587#1575#1606#1610' '#1705#1607' '#1588#1575#1585#1688' '#1606#1583#1575#1588#1578#1607' '#1575#1606#1583
    TabOrder = 13
  end
  object cbdontshowkharidcharge: TCheckBox
    Left = 40
    Top = 211
    Width = 342
    Height = 17
    Caption = #1593#1583#1605' '#1606#1605#1575#1610#1588' '#1705#1587#1575#1606#1610' '#1705#1607' '#1606#1607' '#1588#1575#1585#1688' '#1606#1607' '#1582#1585#1610#1583' '#1583#1575#1588#1578#1607' '#1575#1606#1583
    TabOrder = 14
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 200
    Top = 81
  end
  object qry1: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 24
    Top = 111
  end
  object tbl1: TADOTable
    TableName = 'amar3tbl'
    Left = 88
    Top = 111
  end
end
