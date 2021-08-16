object frmPeymanPrcntRpt: TfrmPeymanPrcntRpt
  Left = 162
  Top = 93
  HelpContext = 306
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1607#1586#1610#1606#1607' '#1662#1610#1605#1575#1606#1603#1575#1585#1610' '#1576#1607' '#1578#1601#1603#1610#1603' '#1591#1576#1582' '#1608' '#1605#1608#1575#1583' '#1575#1608#1604#1610#1607
  ClientHeight = 334
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 299
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object lbl2: TLabel
    Left = 118
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object lbl3: TLabel
    Left = 320
    Top = 48
    Width = 14
    Height = 15
    Caption = #1594#1584#1575
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 200
    Width = 161
    Height = 89
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 7
    object rdoScreen: TRadioButton
      Left = 64
      Top = 24
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 104
      Top = 40
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 40
      Top = 64
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 304
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 10
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 120
    Top = 304
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 9
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 232
    Top = 304
    Width = 105
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 8
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
    Left = 192
    Top = 8
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
    Left = 8
    Top = 8
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object rdoGroup: TRadioGroup
    Left = 176
    Top = 80
    Width = 161
    Height = 89
    Caption = #1606#1608#1593' '#1578#1601#1603#1610#1603
    ItemIndex = 0
    Items.Strings = (
      #1576#1607' '#1578#1601#1603#1610#1603' '#1662#1585#1587#1606#1604' '#1608' '#1605#1610#1607#1605#1575#1606
      #1608#1575#1581#1583#1607#1575#1610' '#1578#1575#1576#1593#1607
      #1576#1583#1608#1606' '#1578#1601#1603#1610#1603)
    TabOrder = 3
  end
  object cmbFoods: TComboBox
    Left = 8
    Top = 48
    Width = 305
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 2
    OnKeyDown = cmbFoodsKeyDown
  end
  object grpPercent: TGroupBox
    Left = 8
    Top = 80
    Width = 161
    Height = 89
    Caption = #1583#1585#1589#1583' '#1578#1601#1603#1610#1603' '#1605#1576#1575#1604#1594
    TabOrder = 4
    object lbl4: TLabel
      Left = 108
      Top = 24
      Width = 42
      Height = 15
      Caption = #1605#1608#1575#1583' '#1575#1608#1604#1610#1607
    end
    object lbl6: TLabel
      Left = 132
      Top = 56
      Width = 18
      Height = 15
      Caption = #1591#1576#1582
    end
    object lbl5: TLabel
      Left = 5
      Top = 24
      Width = 25
      Height = 15
      Caption = #1583#1585#1589#1583
    end
    object lbl7: TLabel
      Left = 5
      Top = 56
      Width = 25
      Height = 15
      Caption = #1583#1585#1589#1583
    end
    object txtMavad: TEdit
      Left = 40
      Top = 24
      Width = 57
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 0
      OnExit = txtMavadExit
      OnKeyPress = txtMavadKeyPress
    end
    object txtTabkh: TEdit
      Left = 40
      Top = 56
      Width = 57
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtTabkhKeyPress
    end
  end
  object rdoRptType: TRadioGroup
    Left = 176
    Top = 176
    Width = 161
    Height = 113
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    ItemIndex = 0
    Items.Strings = (
      #1711#1586#1575#1585#1588' '#1603#1604#1610
      #1711#1586#1575#1585#1588' '#1605#1608#1575#1583' '#1575#1608#1604#1610#1607
      #1711#1586#1575#1585#1588' '#1591#1576#1582)
    TabOrder = 5
  end
  object chkNewPage: TCheckBox
    Left = 8
    Top = 176
    Width = 161
    Height = 17
    Caption = #1711#1586#1575#1585#1588' '#1589#1601#1581#1607' '#1576#1607' '#1589#1601#1581#1607
    TabOrder = 6
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 40
  end
end
