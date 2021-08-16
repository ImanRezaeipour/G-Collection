object frmFunctionKeys: TfrmFunctionKeys
  Left = 149
  Top = 64
  HelpContext = 70
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1603#1604#1610#1583#1607#1575#1610' '#1593#1605#1604#1610#1575#1578#1610
  ClientHeight = 295
  ClientWidth = 285
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
    Left = 248
    Top = 8
    Width = 30
    Height = 15
    Caption = '&'#1578#1585#1605#1610#1606#1575#1604
    FocusControl = cmbReaders
    OnClick = cmbOperateClick
  end
  object lbl2: TLabel
    Left = 248
    Top = 40
    Width = 30
    Height = 15
    Caption = '&'#1593#1605#1604#1610#1575#1578
    FocusControl = cmbOperate
  end
  object lbl3: TLabel
    Left = 245
    Top = 88
    Width = 33
    Height = 15
    Caption = #1603#1604#1610#1583' F&1'
    FocusControl = cmbF1
  end
  object lbl4: TLabel
    Left = 245
    Top = 120
    Width = 33
    Height = 15
    Caption = #1603#1604#1610#1583' F&2'
    FocusControl = cmbF2
  end
  object lbl5: TLabel
    Left = 245
    Top = 152
    Width = 33
    Height = 15
    Caption = #1603#1604#1610#1583' F&3'
    FocusControl = cmbF3
  end
  object lbl6: TLabel
    Left = 245
    Top = 184
    Width = 33
    Height = 15
    Caption = #1603#1604#1610#1583' F&4'
    FocusControl = cmbF4
  end
  object cmbReaders: TComboBox
    Left = 8
    Top = 8
    Width = 225
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
    OnKeyPress = cmbReadersKeyPress
  end
  object cmbOperate: TComboBox
    Left = 8
    Top = 40
    Width = 225
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 1
    OnClick = cmbOperateClick
    OnKeyPress = cmbReadersKeyPress
    Items.Strings = (
      #1578#1606#1592#1610#1605' '#1603#1604#1610#1583#1607#1575#1610' '#1601#1575#1606#1603#1588#1606
      #1582#1608#1575#1606#1583#1606' '#1603#1604#1610#1583#1607#1575#1610' '#1601#1575#1606#1603#1588#1606)
  end
  object cmdOk: TBitBtn
    Left = 200
    Top = 264
    Width = 81
    Height = 25
    Caption = #1575'&'#1580#1585#1575
    TabOrder = 7
    OnClick = cmdOkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 264
    Width = 81
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 9
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 104
    Top = 264
    Width = 81
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 8
    Kind = bkHelp
  end
  object cmbF1: TComboBox
    Left = 8
    Top = 88
    Width = 225
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 2
    OnKeyDown = cmbF1KeyDown
    OnKeyPress = cmbReadersKeyPress
  end
  object cmbF2: TComboBox
    Left = 8
    Top = 120
    Width = 225
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 3
    OnKeyDown = cmbF2KeyDown
    OnKeyPress = cmbReadersKeyPress
  end
  object cmbF3: TComboBox
    Left = 8
    Top = 152
    Width = 225
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 4
    OnKeyDown = cmbF3KeyDown
    OnKeyPress = cmbReadersKeyPress
  end
  object cmbF4: TComboBox
    Left = 8
    Top = 184
    Width = 225
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 5
    OnKeyDown = cmbF4KeyDown
    OnKeyPress = cmbReadersKeyPress
  end
  object chkActive: TCheckBox
    Left = 120
    Top = 224
    Width = 161
    Height = 17
    Caption = #1601#1593#1575#1604' '#1606#1605#1608#1583#1606' '#1603#1604#1610#1583#1607#1575#1610' '#1593#1605#1604#1610#1575#1578#1610
    TabOrder = 6
    OnKeyPress = cmbReadersKeyPress
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 76
  end
end
