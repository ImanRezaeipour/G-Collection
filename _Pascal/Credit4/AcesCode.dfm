object frmAccessCode: TfrmAccessCode
  Left = 148
  Top = 78
  HelpContext = 74
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1603#1583#1607#1575#1610' '#1711#1585#1608#1607' '#1603#1575#1585#1578
  ClientHeight = 246
  ClientWidth = 300
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
    Left = 266
    Top = 8
    Width = 30
    Height = 15
    Caption = '&'#1578#1585#1605#1610#1606#1575#1604
    FocusControl = cmbReaders
  end
  object lbl2: TLabel
    Left = 266
    Top = 40
    Width = 30
    Height = 15
    Caption = '&'#1593#1605#1604#1610#1575#1578
    FocusControl = cmbOperate
  end
  object lbl3: TLabel
    Left = 224
    Top = 88
    Width = 72
    Height = 15
    Caption = #1603#1583' '#1711#1585#1608#1607' '#1603#1575#1585#1578' &1'
    FocusControl = txtAccess1
  end
  object lbl4: TLabel
    Left = 224
    Top = 120
    Width = 72
    Height = 15
    Caption = #1603#1583' '#1711#1585#1608#1607' '#1603#1575#1585#1578' &2'
    FocusControl = txtAccess2
  end
  object lbl5: TLabel
    Left = 224
    Top = 152
    Width = 72
    Height = 15
    Caption = #1603#1583' '#1711#1585#1608#1607' '#1603#1575#1585#1578' &3'
    FocusControl = txtAccess3
  end
  object lbl6: TLabel
    Left = 224
    Top = 184
    Width = 72
    Height = 15
    Caption = #1603#1583' '#1711#1585#1608#1607' '#1603#1575#1585#1578' &4'
    FocusControl = txtAccess4
  end
  object lbl7: TLabel
    Left = 224
    Top = 216
    Width = 72
    Height = 15
    Caption = #1603#1583' '#1711#1585#1608#1607' '#1603#1575#1585#1578' &5'
    FocusControl = txtAccess5
  end
  object cmbReaders: TComboBox
    Left = 8
    Top = 8
    Width = 238
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
    OnKeyPress = cmbReadersKeyPress
  end
  object cmbOperate: TComboBox
    Left = 8
    Top = 40
    Width = 238
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 1
    OnKeyPress = cmbReadersKeyPress
    Items.Strings = (
      #1578#1606#1592#1610#1605' '#1603#1583#1607#1575#1610' '#1711#1585#1608#1607'  '#1603#1575#1585#1578
      #1582#1608#1575#1606#1583#1606' '#1603#1583#1607#1575#1610' '#1711#1585#1608#1607'  '#1603#1575#1585#1578
      #1581#1584#1601' '#1603#1583#1607#1575#1610' '#1711#1585#1608#1607'  '#1603#1575#1585#1578)
  end
  object txtAccess1: TEdit
    Left = 120
    Top = 88
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess2: TEdit
    Left = 120
    Top = 120
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 3
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess3: TEdit
    Left = 120
    Top = 152
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 4
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess4: TEdit
    Left = 120
    Top = 184
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 5
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess5: TEdit
    Left = 120
    Top = 216
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 6
    OnKeyPress = txtAccess1KeyPress
  end
  object cmdOk: TBitBtn
    Left = 8
    Top = 88
    Width = 97
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
    Top = 216
    Width = 97
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 9
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 8
    Top = 184
    Width = 97
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 8
    Kind = bkHelp
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 40
    Top = 124
  end
end
