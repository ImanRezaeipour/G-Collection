object frmInOutAmarRpt: TfrmInOutAmarRpt
  Left = 127
  Top = 10
  HelpContext = 509
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575
  ClientHeight = 233
  ClientWidth = 359
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
  DesignSize = (
    359
    233)
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel
    Left = 294
    Top = 11
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1575#1586' &'#1578#1575#1585#1610#1582' :'
    FocusControl = txtFromDate
    ExplicitLeft = 285
  end
  object Label3: TLabel
    Left = 294
    Top = 40
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' '#1578'&'#1575#1585#1610#1582' :'
    FocusControl = txtToDate
    ExplicitLeft = 285
  end
  object Label8: TLabel
    Left = 294
    Top = 98
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1583#1585'&'#1576' '#1582#1585#1608#1580' :'
    FocusControl = cmbODoor
    ExplicitLeft = 285
  end
  object Label9: TLabel
    Left = 294
    Top = 69
    Width = 57
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1583#1585#1576' '#1608#1585#1608#1583' :'
    FocusControl = cmbIDoor
    ExplicitLeft = 285
  end
  object Label10: TLabel
    Left = 114
    Top = 69
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1578#1589#1583'&'#1610' '#1608#1585#1608#1583' :'
    FocusControl = cmbIPerson
    ExplicitLeft = 111
  end
  object Label11: TLabel
    Left = 114
    Top = 98
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = '&'#1605#1578#1589#1583#1610' '#1582#1585#1608#1580' :'
    FocusControl = cmbOPerson
    ExplicitLeft = 111
  end
  object Label13: TLabel
    Left = 114
    Top = 11
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1575#1586' &'#1587#1575#1593#1578' :'
    FocusControl = txtFromTime
    ExplicitLeft = 111
  end
  object Label14: TLabel
    Left = 114
    Top = 40
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' '#1587#1575'&'#1593#1578' :'
    FocusControl = txtToTime
    ExplicitLeft = 111
  end
  object txtFromDate: TEdit
    Left = 189
    Top = 8
    Width = 99
    Height = 23
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
    ExplicitLeft = 180
  end
  object txtToDate: TEdit
    Left = 189
    Top = 37
    Width = 99
    Height = 23
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
    ExplicitLeft = 180
  end
  object txtFromTime: TEdit
    Left = 8
    Top = 8
    Width = 100
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtFromTimeExit
    OnKeyPress = txtFromTimeKeyPress
  end
  object txtToTime: TEdit
    Left = 8
    Top = 37
    Width = 100
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
    Top = 203
    Width = 79
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 12
    Kind = bkClose
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 131
    Width = 79
    Height = 22
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 10
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
    Top = 167
    Width = 79
    Height = 23
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 11
    Kind = bkHelp
  end
  object cmbIDoor: TComboBox
    Left = 189
    Top = 66
    Width = 99
    Height = 23
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 4
    ExplicitLeft = 180
  end
  object cmbODoor: TComboBox
    Left = 189
    Top = 95
    Width = 99
    Height = 23
    Anchors = [akTop, akRight]
    ItemHeight = 15
    TabOrder = 6
    ExplicitLeft = 180
  end
  object cmbIPerson: TComboBox
    Left = 8
    Top = 66
    Width = 100
    Height = 23
    ItemHeight = 15
    TabOrder = 5
  end
  object cmbOPerson: TComboBox
    Left = 8
    Top = 95
    Width = 100
    Height = 23
    ItemHeight = 15
    TabOrder = 7
  end
  object grpPrintType: TGroupBox
    Left = 93
    Top = 125
    Width = 99
    Height = 100
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 9
    object rdoScreen: TRadioButton
      Left = 14
      Top = 32
      Width = 79
      Height = 15
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 49
      Top = 68
      Width = 44
      Height = 15
      Caption = '&'#1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object grpType: TGroupBox
    Left = 198
    Top = 125
    Width = 153
    Height = 100
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    TabOrder = 8
    object rdoEnter: TRadioButton
      Left = 2
      Top = 21
      Width = 148
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' &'#1608#1585#1608#1583' '#1582#1608#1583#1585#1608#1607#1575
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoExit: TRadioButton
      Left = 2
      Top = 49
      Width = 148
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1570#1605#1575#1585' '#1582'&'#1585#1608#1580' '#1582#1608#1583#1585#1608#1607#1575
      TabOrder = 1
    end
    object rdoEnterExit: TRadioButton
      Left = 2
      Top = 78
      Width = 148
      Height = 15
      Caption = #1711#1586#1575#1585#1588' &'#1570#1605#1575#1585#1610' '#1608#1585#1608#1583' '#1608' '#1582#1585#1608#1580
      TabOrder = 2
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 8
  end
end
