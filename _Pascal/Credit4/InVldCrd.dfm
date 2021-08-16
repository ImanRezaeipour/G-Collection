object frmInvalidCard: TfrmInvalidCard
  Left = 508
  Top = 300
  HelpContext = 72
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1603#1575#1585#1578#1607#1575#1610' '#1594#1610#1585#1605#1580#1575#1586
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
    Left = 244
    Top = 88
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 1'
    FocusControl = txtBarCode1
  end
  object lbl4: TLabel
    Left = 100
    Top = 88
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 2'
    FocusControl = txtBarCode2
  end
  object lbl5: TLabel
    Left = 244
    Top = 120
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 3'
    FocusControl = txtBarCode3
  end
  object lbl6: TLabel
    Left = 100
    Top = 120
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 4'
    FocusControl = txtBarCode4
  end
  object lbl7: TLabel
    Left = 244
    Top = 152
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 5'
    FocusControl = txtBarCode5
  end
  object lbl8: TLabel
    Left = 100
    Top = 152
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 6'
    FocusControl = txtBarCode6
  end
  object lbl9: TLabel
    Left = 244
    Top = 184
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 7'
    FocusControl = txtBarCode7
  end
  object lbl10: TLabel
    Left = 100
    Top = 184
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 8'
    FocusControl = txtBarCode8
  end
  object lbl11: TLabel
    Left = 244
    Top = 216
    Width = 34
    Height = 15
    Caption = #1603#1575#1585#1578' 9'
    FocusControl = txtBarCode9
  end
  object lbl12: TLabel
    Left = 93
    Top = 216
    Width = 41
    Height = 15
    Caption = #1603#1575#1585#1578' 10'
    FocusControl = txtBarCode10
  end
  object cmbReaders: TComboBox
    Left = 8
    Top = 8
    Width = 225
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
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
    OnKeyPress = cmbReadersKeyPress
    Items.Strings = (
      #1578#1606#1592#1610#1605' '#1603#1575#1585#1578#1607#1575#1610' '#1594#1610#1585#1605#1580#1575#1586
      #1582#1608#1575#1606#1583#1606' '#1603#1575#1585#1578#1607#1575#1610' '#1594#1610#1585#1605#1580#1575#1586
      #1581#1584#1601' '#1603#1575#1585#1578#1607#1575#1610' '#1594#1610#1585#1605#1580#1575#1586)
  end
  object txtBarCode1: TEdit
    Left = 152
    Top = 88
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode2: TEdit
    Left = 8
    Top = 88
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 3
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode3: TEdit
    Left = 152
    Top = 120
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 4
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode4: TEdit
    Left = 8
    Top = 120
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 5
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode5: TEdit
    Left = 152
    Top = 152
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 6
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode6: TEdit
    Left = 8
    Top = 152
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 7
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode7: TEdit
    Left = 152
    Top = 184
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 8
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode8: TEdit
    Left = 8
    Top = 184
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 9
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode9: TEdit
    Left = 152
    Top = 216
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 10
    OnKeyPress = txtBarCode1KeyPress
  end
  object txtBarCode10: TEdit
    Left = 8
    Top = 216
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 8
    ParentBiDiMode = False
    TabOrder = 11
    OnKeyPress = txtBarCode1KeyPress
  end
  object cmdOk: TBitBtn
    Left = 200
    Top = 264
    Width = 81
    Height = 25
    Caption = #1575'&'#1580#1585#1575
    TabOrder = 12
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
    TabOrder = 14
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 104
    Top = 264
    Width = 81
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 13
    Kind = bkHelp
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 76
  end
end
