object frmDayFoodRpt: TfrmDayFoodRpt
  Left = 126
  Top = 65
  HelpContext = 306
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1604#1610#1587#1578' '#1605#1589#1585#1601' '#1605#1608#1575#1583' '#1594#1584#1575#1610#1610
  ClientHeight = 245
  ClientWidth = 382
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
    Left = 339
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label2: TLabel
    Left = 118
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 160
    Width = 369
    Height = 49
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 3
    object rdoScreen: TRadioButton
      Left = 272
      Top = 24
      Width = 89
      Height = 17
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoScreenKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 192
      Top = 24
      Width = 49
      Height = 17
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
      OnKeyPress = rdoScreenKeyPress
    end
    object chkSign: TCheckBox
      Left = 16
      Top = 24
      Width = 121
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
      OnKeyPress = chkSignKeyPress
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 216
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 144
    Top = 216
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdPrint: TBitBtn
    Left = 272
    Top = 216
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
    Left = 232
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
    Left = 136
    Top = 40
    Width = 241
    Height = 113
    TabOrder = 2
    object chkNahar: TCheckBox
      Left = 160
      Top = 48
      Width = 73
      Height = 17
      Caption = '&'#1606#1575#1607#1575#1585'/'#1588#1575#1605
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkSobh: TCheckBox
      Left = 176
      Top = 16
      Width = 57
      Height = 17
      Caption = #1589#1576'&'#1581#1575#1606#1607
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkMokhalafat: TCheckBox
      Left = 176
      Top = 80
      Width = 57
      Height = 17
      Caption = '&'#1605#1582#1604#1601#1575#1578
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object cmbSobh: TComboBox
      Left = 8
      Top = 16
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 1
      OnKeyDown = cmbSobhKeyDown
    end
    object cmbNahar: TComboBox
      Left = 8
      Top = 48
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 3
      OnKeyDown = cmbNaharKeyDown
    end
    object cmbMokhalafat: TComboBox
      Left = 8
      Top = 80
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 5
      OnKeyDown = cmbMokhalafatKeyDown
    end
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
    OnKeyPress = txtToDateKeyPress
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 121
    Height = 113
    Caption = #1578#1601#1603#1610#1603' '#1576#1585' '#1575#1587#1575#1587
    TabOrder = 7
    object chkPart: TCheckBox
      Left = 64
      Top = 24
      Width = 49
      Height = 17
      Caption = #1576#1582#1588
      TabOrder = 0
      OnClick = chkPartClick
    end
    object chkJob: TCheckBox
      Left = 24
      Top = 56
      Width = 89
      Height = 17
      Caption = #1606#1608#1593' '#1575#1587#1578#1582#1583#1575#1605
      TabOrder = 1
      OnClick = chkJobClick
    end
    object chkGroup: TCheckBox
      Left = 16
      Top = 88
      Width = 97
      Height = 17
      Caption = #1576#1583#1608#1606' '#1578#1601#1603#1610#1603
      TabOrder = 2
      OnClick = chkGroupClick
    end
  end
end
