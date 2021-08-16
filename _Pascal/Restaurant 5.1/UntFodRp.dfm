object frmUnitFishRpt: TfrmUnitFishRpt
  Left = 174
  Top = 46
  HelpContext = 308
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1601#1610#1588#1607#1575' '#1608' '#1605#1608#1575#1583' '#1605#1589#1585#1601#1610' '#1608#1575#1581#1583#1607#1575#1610' '#1578#1575#1576#1593#1607
  ClientHeight = 363
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 283
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label7: TLabel
    Left = 118
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label2: TLabel
    Left = 275
    Top = 40
    Width = 43
    Height = 15
    Caption = '&'#1608#1575#1581#1583' '#1578#1575#1576#1593#1607
    FocusControl = cmbUnits
  end
  object grpPrintType: TGroupBox
    Left = 200
    Top = 256
    Width = 121
    Height = 105
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 5
    object rdoScreen: TRadioButton
      Left = 27
      Top = 21
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
      OnKeyPress = cmbUnitsKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 67
      Top = 48
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
      OnKeyPress = cmbUnitsKeyPress
    end
    object chkSign: TCheckBox
      Left = 3
      Top = 82
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
      OnKeyPress = cmbUnitsKeyPress
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 336
    Width = 97
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 9
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 8
    Top = 304
    Width = 97
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 8
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 264
    Width = 97
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 7
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
    Left = 176
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
  object grpType: TGroupBox
    Left = 232
    Top = 80
    Width = 89
    Height = 169
    Caption = #1608#1593#1583#1607' '#1594#1584#1575#1610#1610
    TabOrder = 3
    object chkSham: TCheckBox
      Left = 40
      Top = 136
      Width = 41
      Height = 17
      Caption = #1588#1575'&'#1605
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnKeyPress = cmbUnitsKeyPress
    end
    object chkNahar: TCheckBox
      Left = 32
      Top = 80
      Width = 49
      Height = 17
      Caption = #1606#1575#1607#1575'&'#1585
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnKeyPress = cmbUnitsKeyPress
    end
    object chkSobh: TCheckBox
      Left = 24
      Top = 32
      Width = 57
      Height = 17
      Caption = #1589#1576'&'#1581#1575#1606#1607
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnKeyPress = cmbUnitsKeyPress
    end
  end
  object rdoSort: TRadioGroup
    Left = 8
    Top = 80
    Width = 217
    Height = 169
    BiDiMode = bdRightToLeft
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    ItemIndex = 0
    Items.Strings = (
      #1711#1586#1575#1585#1588' '#1578#1601#1589#1610'&'#1604#1610' '#1601#1610#1588#1607#1575' '#1576#1607' '#1578#1601#1603#1610#1603' '#1608#1575#1581#1583
      #1711#1586#1575#1585#1588' '#1578#1601'&'#1589#1610#1604#1610' '#1576#1607' '#1578#1601#1603#1610#1603' '#1578#1575#1585#1610#1582' '#1608' '#1608#1593#1583#1607
      #1711#1586#1575#1585#1588' &'#1603#1604#1610
      #1711#1586#1575'&'#1585#1588' '#1603#1604#1610' '#1605#1575#1607#1575#1606#1607
      #1711#1586#1575#1585#1588' '#1603#1604#1610' '#1578'&'#1593#1583#1575#1583#1610' '#1605#1575#1607#1575#1606#1607
      #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' &'#1605#1608#1575#1583' '#1594#1584#1575#1610#1610)
    ParentBiDiMode = False
    TabOrder = 4
    OnClick = rdoSortClick
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
  object cmbUnits: TComboBox
    Left = 96
    Top = 40
    Width = 169
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 2
    OnKeyDown = cmbUnitsKeyDown
    OnKeyPress = cmbUnitsKeyPress
  end
  object rdoPaper: TRadioGroup
    Left = 112
    Top = 256
    Width = 81
    Height = 105
    Caption = #1606#1608#1593' '#1670#1575#1662
    ItemIndex = 0
    Items.Strings = (
      #1575#1601#1602#1610
      #1593#1605#1608#1583#1610)
    TabOrder = 6
  end
end
