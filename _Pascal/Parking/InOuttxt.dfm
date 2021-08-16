object frmInOuttxt: TfrmInOuttxt
  Left = 149
  Top = 7
  HelpContext = 501
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1605#1578#1606#1610' '#1575#1586' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575
  ClientHeight = 348
  ClientWidth = 358
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
  object Label2: TLabel
    Left = 319
    Top = 11
    Width = 35
    Height = 15
    Alignment = taRightJustify
    Caption = #1575#1586' &'#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label3: TLabel
    Left = 319
    Top = 39
    Width = 32
    Height = 15
    Alignment = taRightJustify
    Caption = #1578#1575' '#1578'&'#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object Label4: TLabel
    Left = 311
    Top = 67
    Width = 43
    Height = 15
    Alignment = taRightJustify
    Caption = #1606#1575#1605' '#1582'&'#1608#1583#1585#1608
    FocusControl = cmbCarName
  end
  object Label5: TLabel
    Left = 120
    Top = 67
    Width = 58
    Height = 15
    Alignment = taRightJustify
    Caption = #1588#1605#1575'&'#1585#1607' '#1582#1608#1583#1585#1608
    FocusControl = txtNumber
  end
  object Label6: TLabel
    Left = 304
    Top = 95
    Width = 51
    Height = 15
    Alignment = taRightJustify
    Caption = '&'#1588#1607#1585' '#1582#1608#1583#1585#1608
    FocusControl = cmbCity
  end
  object Label7: TLabel
    Left = 120
    Top = 95
    Width = 59
    Height = 15
    Alignment = taRightJustify
    Caption = '&'#1587#1585#1610#1575#1604' '#1582#1608#1583#1585#1608
    FocusControl = txtSerial
  end
  object Label8: TLabel
    Left = 308
    Top = 152
    Width = 49
    Height = 15
    Alignment = taRightJustify
    Caption = #1583#1585'&'#1576' '#1582#1585#1608#1580
    FocusControl = cmbODoor
  end
  object Label9: TLabel
    Left = 313
    Top = 124
    Width = 45
    Height = 15
    Alignment = taRightJustify
    Caption = '&'#1583#1585#1576' '#1608#1585#1608#1583
    FocusControl = cmbIDoor
  end
  object Label10: TLabel
    Left = 123
    Top = 124
    Width = 57
    Height = 15
    Alignment = taRightJustify
    Caption = #1605#1578#1589#1583'&'#1610' '#1608#1585#1608#1583
    FocusControl = cmbIPerson
  end
  object Label11: TLabel
    Left = 117
    Top = 152
    Width = 61
    Height = 15
    Alignment = taRightJustify
    Caption = '&'#1605#1578#1589#1583#1610' '#1582#1585#1608#1580
    FocusControl = cmbOPerson
  end
  object Label13: TLabel
    Left = 140
    Top = 11
    Width = 39
    Height = 15
    Alignment = taRightJustify
    Caption = #1575#1586' &'#1587#1575#1593#1578
    FocusControl = txtFromTime
  end
  object Label14: TLabel
    Left = 140
    Top = 39
    Width = 36
    Height = 15
    Alignment = taRightJustify
    Caption = #1578#1575' '#1587#1575'&'#1593#1578
    FocusControl = txtToTime
  end
  object label12: TLabel
    Left = 318
    Top = 180
    Width = 30
    Height = 15
    Alignment = taRightJustify
    Caption = #1606#1575#1605' '#1601#1575#1610#1604
    FocusControl = txtfilename
  end
  object txtFromDate: TEdit
    Left = 191
    Top = 7
    Width = 106
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 191
    Top = 35
    Width = 106
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtNumber: TEdit
    Left = 7
    Top = 64
    Width = 107
    Height = 23
    MaxLength = 6
    TabOrder = 5
    OnKeyPress = txtNumberKeyPress
  end
  object txtSerial: TEdit
    Left = 64
    Top = 92
    Width = 50
    Height = 23
    MaxLength = 2
    TabOrder = 7
  end
  object cmbCarName: TComboBox
    Left = 191
    Top = 64
    Width = 106
    Height = 23
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 4
    OnEnter = cmbCarNameEnter
    OnKeyPress = cmbCarNameKeyPress
  end
  object cmbCity: TComboBox
    Left = 191
    Top = 92
    Width = 106
    Height = 23
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 6
    OnEnter = cmbCarNameEnter
    OnKeyPress = cmbCityKeyPress
  end
  object txtFromTime: TEdit
    Left = 56
    Top = 7
    Width = 58
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtFromTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object txtToTime: TEdit
    Left = 56
    Top = 35
    Width = 58
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
    Top = 318
    Width = 107
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 17
    Kind = bkClose
  end
  object cmdPrint: TBitBtn
    Left = 247
    Top = 318
    Width = 107
    Height = 22
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
  object cmdHelp: TBitBtn
    Left = 127
    Top = 318
    Width = 107
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 16
    Kind = bkHelp
  end
  object cmbIDoor: TComboBox
    Left = 191
    Top = 120
    Width = 106
    Height = 23
    ItemHeight = 15
    TabOrder = 8
  end
  object cmbODoor: TComboBox
    Left = 191
    Top = 148
    Width = 106
    Height = 23
    ItemHeight = 15
    TabOrder = 10
  end
  object cmbIPerson: TComboBox
    Left = 7
    Top = 120
    Width = 107
    Height = 23
    ItemHeight = 15
    TabOrder = 9
  end
  object cmbOPerson: TComboBox
    Left = 7
    Top = 148
    Width = 107
    Height = 23
    ItemHeight = 15
    TabOrder = 11
  end
  object grpType: TGroupBox
    Left = 191
    Top = 212
    Width = 163
    Height = 92
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    TabOrder = 13
    object rdoBoth: TRadioButton
      Left = 42
      Top = 21
      Width = 107
      Height = 15
      Caption = #1711'&'#1586#1575#1585#1588' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoArival: TRadioButton
      Left = 7
      Top = 42
      Width = 142
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1582'&'#1608#1583#1585#1608#1607#1575#1610' '#1662#1575#1585#1603' '#1588#1583#1607
      TabOrder = 1
    end
    object rdoExit: TRadioButton
      Left = 7
      Top = 64
      Width = 142
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1582#1575#1585'&'#1580' '#1588#1583#1607
      TabOrder = 2
    end
  end
  object rdoSort: TRadioGroup
    Left = 7
    Top = 184
    Width = 170
    Height = 120
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    ItemIndex = 0
    Items.Strings = (
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1608#1585#1608#1585#1583
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1582#1585#1608#1580
      #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      #1606#1575#1605' '#1582#1608#1583#1585#1608)
    TabOrder = 14
  end
  object txtfilename: TEdit
    Left = 191
    Top = 176
    Width = 106
    Height = 22
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    MaxLength = 40
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 12
    Text = 'out_log.txt'
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 32
    Top = 32
  end
  object qryMachines: TADOQuery
    Parameters = <>
    Left = 16
    Top = 200
  end
end
