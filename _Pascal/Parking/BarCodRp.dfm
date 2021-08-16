object frmBarCodeRpt: TfrmBarCodeRpt
  Left = 163
  Top = 92
  HelpContext = 504
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1603#1575#1585#1578#1607#1575
  ClientHeight = 196
  ClientWidth = 261
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
  PixelsPerInch = 96
  TextHeight = 15
  object grpList: TGroupBox
    Left = 113
    Top = 49
    Width = 142
    Height = 107
    TabOrder = 1
    object Label1: TLabel
      Left = 96
      Top = 14
      Width = 43
      Height = 15
      Caption = '&'#1606#1608#1593' '#1603#1575#1585#1578
    end
    object rdoInCust: TRadioButton
      Left = 64
      Top = 42
      Width = 71
      Height = 15
      Caption = #1583'&'#1587#1578' '#1605#1588#1578#1585#1610
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoInPark: TRadioButton
      Left = 92
      Top = 64
      Width = 43
      Height = 15
      Caption = #1605#1608'&'#1580#1608#1583
      TabOrder = 1
    end
    object rdoAll: TRadioButton
      Left = 99
      Top = 85
      Width = 36
      Height = 15
      Caption = #1607'&'#1605#1607
      TabOrder = 2
    end
    object cmbCardType: TComboBox
      Left = 7
      Top = 14
      Width = 86
      Height = 23
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 3
    end
  end
  object cmdPrint: TBitBtn
    Left = 176
    Top = 169
    Width = 81
    Height = 22
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 3
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
    Left = 7
    Top = 169
    Width = 79
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 92
    Top = 169
    Width = 78
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 0
    Width = 248
    Height = 43
    TabOrder = 0
    object rdoList: TRadioButton
      Left = 141
      Top = 21
      Width = 100
      Height = 15
      Caption = #1711#1586#1575#1585#1588' &'#1604#1610#1587#1578' '#1603#1575#1585#1578#1607#1575
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rdoListClick
    end
    object rdoCircle: TRadioButton
      Left = 7
      Top = 21
      Width = 107
      Height = 15
      Caption = #1711#1586#1575#1585#1588' &'#1711#1585#1583#1588' '#1603#1575#1585#1578#1607#1575
      TabOrder = 1
      OnClick = rdoListClick
    end
  end
  object grpPrintType: TGroupBox
    Left = 7
    Top = 49
    Width = 100
    Height = 107
    TabOrder = 4
    object rdoScreen: TRadioButton
      Left = 14
      Top = 28
      Width = 79
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 49
      Top = 71
      Width = 44
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object grpCircle: TGroupBox
    Left = 113
    Top = 49
    Width = 142
    Height = 107
    TabOrder = 2
    Visible = False
    object Label2: TLabel
      Left = 104
      Top = 21
      Width = 9
      Height = 15
      Caption = '&'#1575#1586
    end
    object Label3: TLabel
      Left = 100
      Top = 49
      Width = 6
      Height = 15
      Caption = '&'#1578#1575
    end
    object Label4: TLabel
      Left = 114
      Top = 35
      Width = 22
      Height = 15
      Caption = #1578#1575#1585#1610#1582
    end
    object Label5: TLabel
      Left = 114
      Top = 85
      Width = 25
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607
    end
    object txtFromDate: TEdit
      Left = 7
      Top = 14
      Width = 86
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      OnExit = txtFromDateExit
      OnKeyPress = txtFromDateKeyPress
    end
    object txtToDate: TEdit
      Left = 7
      Top = 42
      Width = 86
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
      OnExit = txtToDateExit
    end
    object cmbCards: TComboBox
      Left = 7
      Top = 78
      Width = 86
      Height = 23
      ItemHeight = 0
      TabOrder = 2
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 48
  end
end
