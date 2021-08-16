object frmInOutPrcntRpt: TfrmInOutPrcntRpt
  Left = 215
  Top = 151
  HelpContext = 509
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' '#1608' '#1583#1585#1589#1583' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580
  ClientHeight = 146
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
    Left = 214
    Top = 7
    Width = 35
    Height = 15
    Alignment = taRightJustify
    Caption = #1575#1586' &'#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object lbl2: TLabel
    Left = 214
    Top = 35
    Width = 32
    Height = 15
    Alignment = taRightJustify
    Caption = #1578#1575' '#1578'&'#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object lbl3: TLabel
    Left = 70
    Top = 7
    Width = 26
    Height = 15
    Alignment = taRightJustify
    Caption = '&'#1587#1575#1593#1578
    FocusControl = txtFromTime
  end
  object lbl4: TLabel
    Left = 70
    Top = 35
    Width = 26
    Height = 15
    Alignment = taRightJustify
    Caption = #1587#1575'&'#1593#1578
    FocusControl = txtToTime
  end
  object txtFromDate: TEdit
    Left = 106
    Top = 7
    Width = 100
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 106
    Top = 35
    Width = 100
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtFromTime: TEdit
    Left = 7
    Top = 7
    Width = 57
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtFromTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object txtToTime: TEdit
    Left = 7
    Top = 35
    Width = 57
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 3
    OnExit = txtToTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object cmdClose: TBitBtn
    Left = 7
    Top = 120
    Width = 86
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 7
    Kind = bkClose
  end
  object cmdPrint: TBitBtn
    Left = 7
    Top = 64
    Width = 86
    Height = 22
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 5
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
  object cmdHelp: TBitBtn
    Left = 7
    Top = 92
    Width = 86
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 6
    Kind = bkHelp
  end
  object rdoPrintType: TRadioGroup
    Left = 106
    Top = 64
    Width = 142
    Height = 78
    Caption = #1606#1608#1593' '#1670#1575#1662
    ItemIndex = 0
    Items.Strings = (
      #1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      #1670#1575#1662#1711#1585)
    TabOrder = 4
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 144
    Top = 96
  end
end
