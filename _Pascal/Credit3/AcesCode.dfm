object frmAccessCode: TfrmAccessCode
  Left = 148
  Top = 78
  HelpContext = 74
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '„⁄—›Ì ﬂœÂ«Ì ê—ÊÂ ﬂ«— '
  ClientHeight = 217
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 223
    Top = 7
    Width = 38
    Height = 15
    Caption = '& —„Ì‰«·'
    FocusControl = cmbReaders
  end
  object lbl2: TLabel
    Left = 227
    Top = 35
    Width = 34
    Height = 15
    Caption = '&⁄„·Ì« '
    FocusControl = cmbOperate
  end
  object lbl3: TLabel
    Left = 174
    Top = 78
    Width = 87
    Height = 15
    Caption = 'ﬂœ ê—ÊÂ ﬂ«—  &1'
    FocusControl = txtAccess1
  end
  object lbl4: TLabel
    Left = 174
    Top = 106
    Width = 87
    Height = 15
    Caption = 'ﬂœ ê—ÊÂ ﬂ«—  &2'
    FocusControl = txtAccess2
  end
  object lbl5: TLabel
    Left = 174
    Top = 134
    Width = 87
    Height = 15
    Caption = 'ﬂœ ê—ÊÂ ﬂ«—  &3'
    FocusControl = txtAccess3
  end
  object lbl6: TLabel
    Left = 174
    Top = 162
    Width = 87
    Height = 15
    Caption = 'ﬂœ ê—ÊÂ ﬂ«—  &4'
    FocusControl = txtAccess4
  end
  object lbl7: TLabel
    Left = 174
    Top = 191
    Width = 87
    Height = 15
    Caption = 'ﬂœ ê—ÊÂ ﬂ«—  &5'
    FocusControl = txtAccess5
  end
  object cmbReaders: TComboBox
    Left = 7
    Top = 7
    Width = 210
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
    OnKeyPress = cmbReadersKeyPress
  end
  object cmbOperate: TComboBox
    Left = 7
    Top = 35
    Width = 210
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 1
    OnKeyPress = cmbReadersKeyPress
    Items.Strings = (
      ' ‰ŸÌ„ ﬂœÂ«Ì ê—ÊÂ  ﬂ«— '
      'ŒÊ«‰œ‰ ﬂœÂ«Ì ê—ÊÂ  ﬂ«— '
      'Õ–› ﬂœÂ«Ì ê—ÊÂ  ﬂ«— ')
  end
  object txtAccess1: TEdit
    Left = 106
    Top = 78
    Width = 71
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess2: TEdit
    Left = 106
    Top = 106
    Width = 71
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 3
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess3: TEdit
    Left = 106
    Top = 134
    Width = 71
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 4
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess4: TEdit
    Left = 106
    Top = 162
    Width = 71
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 5
    OnKeyPress = txtAccess1KeyPress
  end
  object txtAccess5: TEdit
    Left = 106
    Top = 191
    Width = 71
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 6
    OnKeyPress = txtAccess1KeyPress
  end
  object cmdOk: TBitBtn
    Left = 7
    Top = 78
    Width = 86
    Height = 22
    Caption = '«&Ã—«'
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
    Left = 7
    Top = 191
    Width = 86
    Height = 22
    Caption = '&Œ—ÊÃ'
    TabOrder = 9
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 7
    Top = 162
    Width = 86
    Height = 22
    Caption = '—«&Â‰„«'
    TabOrder = 8
    Kind = bkHelp
  end
end
