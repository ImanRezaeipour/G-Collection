object frmInOutCoRpt: TfrmInOutCoRpt
  Left = 131
  Top = 39
  HelpContext = 501
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1587#1575#1586#1605#1575#1606#1610
  ClientHeight = 399
  ClientWidth = 330
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
  OnShow = FormShow
  DesignSize = (
    330
    399)
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel
    Left = 279
    Top = 11
    Width = 43
    Height = 15
    Alignment = taRightJustify
    Caption = #1575#1586' '#1578#1575#1585#1610#1582' :'
    FocusControl = txtFromDate
  end
  object Label3: TLabel
    Left = 121
    Top = 11
    Width = 40
    Height = 15
    Alignment = taRightJustify
    Caption = #1578#1575' '#1578#1575#1585#1610#1582' :'
    FocusControl = txtToDate
  end
  object Label4: TLabel
    Left = 271
    Top = 98
    Width = 51
    Height = 15
    Alignment = taRightJustify
    Caption = #1606#1575#1605' '#1582#1608#1583#1585#1608' :'
    FocusControl = cmbCarName
  end
  object Label5: TLabel
    Left = 256
    Top = 69
    Width = 66
    Height = 15
    Alignment = taRightJustify
    Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
    FocusControl = txtNumber
  end
  object Label6: TLabel
    Left = 108
    Top = 333
    Width = 51
    Height = 15
    Alignment = taRightJustify
    Caption = #1588#1607#1585' '#1582#1608#1583#1585#1608
    FocusControl = cmbCity
    Visible = False
  end
  object Label7: TLabel
    Left = 94
    Top = 69
    Width = 67
    Height = 15
    Alignment = taRightJustify
    Caption = #1587#1585#1610#1575#1604' '#1582#1608#1583#1585#1608' :'
    FocusControl = txtSerial
  end
  object Label8: TLabel
    Left = 104
    Top = 127
    Width = 57
    Height = 15
    Alignment = taRightJustify
    Caption = #1583#1585#1576' '#1582#1585#1608#1580' :'
    Enabled = False
    FocusControl = cmbODoor
  end
  object Label9: TLabel
    Left = 269
    Top = 127
    Width = 53
    Height = 15
    Alignment = taRightJustify
    Caption = #1583#1585#1576' '#1608#1585#1608#1583' :'
    Enabled = False
    FocusControl = cmbIDoor
  end
  object Label10: TLabel
    Left = 269
    Top = 336
    Width = 57
    Height = 15
    Alignment = taRightJustify
    Caption = #1605#1578#1589#1583#1610' '#1608#1585#1608#1583
    FocusControl = cmbIPerson
    Visible = False
  end
  object Label11: TLabel
    Left = 263
    Top = 364
    Width = 61
    Height = 15
    Alignment = taRightJustify
    Caption = #1605#1578#1589#1583#1610' '#1582#1585#1608#1580
    FocusControl = cmbOPerson
    Visible = False
  end
  object Label13: TLabel
    Left = 275
    Top = 40
    Width = 47
    Height = 15
    Alignment = taRightJustify
    Caption = #1575#1586' '#1587#1575#1593#1578' :'
    FocusControl = txtFromTime
  end
  object Label14: TLabel
    Left = 117
    Top = 40
    Width = 44
    Height = 15
    Alignment = taRightJustify
    Caption = #1578#1575' '#1587#1575#1593#1578' :'
    FocusControl = txtToTime
  end
  object Label1: TLabel
    Left = 101
    Top = 98
    Width = 60
    Height = 15
    Alignment = taRightJustify
    Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578' :'
    FocusControl = cmbBarCode
  end
  object cmbBarCode: TComboBox
    Left = -22
    Top = 95
    Width = 83
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 8
    Visible = False
    OnKeyPress = cmbBarCodeKeyPress
  end
  object txtFromDate: TEdit
    Left = 167
    Top = 8
    Width = 83
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
    Width = 83
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtNumber: TEdit
    Left = 167
    Top = 66
    Width = 83
    Height = 23
    MaxLength = 6
    TabOrder = 4
    OnKeyPress = txtNumberKeyPress
  end
  object txtSerial: TEdit
    Left = 8
    Top = 66
    Width = 83
    Height = 23
    MaxLength = 2
    TabOrder = 5
    OnKeyPress = txtSerialKeyPress
  end
  object cmbCarName: TComboBox
    Left = 167
    Top = 95
    Width = 83
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 6
    OnEnter = cmbCarNameEnter
    OnKeyPress = cmbCarNameKeyPress
  end
  object cmbCity: TComboBox
    Left = 8
    Top = 333
    Width = 93
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 18
    Visible = False
    OnEnter = cmbCarNameEnter
    OnKeyPress = cmbCityKeyPress
  end
  object txtFromTime: TEdit
    Left = 167
    Top = 37
    Width = 83
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtFromTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object txtToTime: TEdit
    Left = 8
    Top = 37
    Width = 83
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 3
    OnExit = txtToTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 299
    Width = 79
    Height = 22
    Caption = #1582#1585#1608#1580
    TabOrder = 16
    Kind = bkClose
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 243
    Width = 79
    Height = 22
    Caption = #1711#1586#1575#1585#1588
    TabOrder = 14
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
    Left = 8
    Top = 271
    Width = 79
    Height = 22
    Caption = #1585#1575#1607#1606#1605#1575
    TabOrder = 15
    Kind = bkHelp
  end
  object cmbIDoor: TComboBox
    Left = 167
    Top = 124
    Width = 83
    Height = 23
    Style = csDropDownList
    Enabled = False
    ItemHeight = 15
    TabOrder = 9
  end
  object cmbODoor: TComboBox
    Left = 8
    Top = 124
    Width = 83
    Height = 23
    Style = csDropDownList
    Enabled = False
    ItemHeight = 15
    TabOrder = 10
  end
  object cmbIPerson: TComboBox
    Left = 167
    Top = 336
    Width = 93
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 17
    Visible = False
  end
  object cmbOPerson: TComboBox
    Left = 167
    Top = 364
    Width = 93
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 19
    Visible = False
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 153
    Width = 109
    Height = 85
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 12
    object rdoScreen: TRadioButton
      Left = 6
      Top = 28
      Width = 97
      Height = 15
      Caption = #1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 6
      Top = 56
      Width = 97
      Height = 15
      Caption = #1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object grpType: TGroupBox
    Left = 123
    Top = 153
    Width = 199
    Height = 85
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    TabOrder = 11
    object rdoBoth: TRadioButton
      Left = 6
      Top = 21
      Width = 188
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoArival: TRadioButton
      Left = 6
      Top = 42
      Width = 188
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1608#1585#1608#1583' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1587#1575#1586#1605#1575#1606#1610
      TabOrder = 1
    end
    object rdoExit: TRadioButton
      Left = 6
      Top = 63
      Width = 188
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1587#1575#1586#1605#1575#1606#1610
      TabOrder = 2
    end
  end
  object txtBarCode: TEdit
    Left = 8
    Top = 95
    Width = 83
    Height = 23
    MaxLength = 8
    TabOrder = 7
  end
  object rdoSort: TRadioGroup
    Left = 93
    Top = 237
    Width = 229
    Height = 85
    Hint = #1606#1581#1608#1607' '#1605#1585#1578#1576' '#1587#1575#1586#1610' '#1711#1586#1575#1585#1588' '#1585#1575' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' '#1576#1585' '#1575#1587#1575#1587
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1582#1585#1608#1580
      #1578#1575#1585#1610#1582' '#1608' '#1586#1605#1575#1606' '#1608#1585#1608#1583#10
      #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
      #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      #1587#1585#1610#1575#1604' '#1662#1604#1575#1705)
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 200
    Top = 144
  end
end
