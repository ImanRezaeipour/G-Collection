object frmInOutCstRpt: TfrmInOutCstRpt
  Left = 203
  Top = 129
  HelpContext = 502
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1578#1585#1583#1583' '#1608' '#1607#1586#1610#1606#1607' '#1582#1608#1583#1585#1608#1607#1575
  ClientHeight = 195
  ClientWidth = 281
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
  object lbl1: TLabel
    Left = 235
    Top = 7
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
  end
  object lbl2: TLabel
    Left = 102
    Top = 7
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object lbl3: TLabel
    Left = 215
    Top = 35
    Width = 58
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
  end
  object lbl4: TLabel
    Left = 221
    Top = 64
    Width = 52
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1603#1575#1585#1578
  end
  object txtFromDate: TEdit
    Left = 148
    Top = 7
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
    Top = 7
    Width = 86
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object grpPrintType: TGroupBox
    Left = 120
    Top = 99
    Width = 156
    Height = 57
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 5
    object rdoScreen: TRadioButton
      Left = 71
      Top = 28
      Width = 78
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 7
      Top = 28
      Width = 43
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object cmdPrint: TBitBtn
    Left = 191
    Top = 169
    Width = 85
    Height = 22
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 6
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
    Width = 86
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 8
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 99
    Top = 169
    Width = 85
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 7
    Kind = bkHelp
  end
  object txtNumber: TEdit
    Left = 120
    Top = 35
    Width = 93
    Height = 23
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtNumberKeyPress
  end
  object rdoSort: TRadioGroup
    Left = 7
    Top = 35
    Width = 107
    Height = 121
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    ItemIndex = 0
    Items.Strings = (
      #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      #1578#1575#1585#1610#1582
      #1607#1586#1610#1606#1607' '#1662#1575#1585#1603)
    TabOrder = 4
  end
  object txtCardCode: TEdit
    Left = 120
    Top = 64
    Width = 93
    Height = 23
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 3
    OnKeyPress = txtCardCodeKeyPress
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 160
    Top = 8
  end
end
