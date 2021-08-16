object frmMonthBackup: TfrmMonthBackup
  Left = 160
  Top = 120
  HelpContext = 507
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = 'Å‘ Ì»«‰êÌ—Ì „«Â«‰Â'
  ClientHeight = 158
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 213
    Top = 8
    Width = 73
    Height = 15
    Caption = 'Å‘ Ì»«‰ êÌ—Ì'
    FocusControl = cmbMonth
  end
  object lbl2: TLabel
    Left = 94
    Top = 8
    Width = 16
    Height = 15
    Caption = '„«Â'
  end
  object cmbMonth: TComboBox
    Left = 112
    Top = 8
    Width = 105
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
    OnKeyPress = cmbMonthKeyPress
    Items.Strings = (
      '›—Ê—œÌ‰'
      '«—œÌ»Â‘ '
      'Œ—œ«œ'
      ' Ì—'
      '„—œ«œ'
      '‘Â—ÌÊ—'
      '„Â—'
      '¬»«‰'
      '¬–—'
      'œÌ'
      '»Â„‰'
      '«”›‰œ')
  end
  object cmdOK: TBitBtn
    Left = 204
    Top = 128
    Width = 84
    Height = 25
    Caption = '& «ÌÌœ'
    TabOrder = 4
    OnClick = cmdOKClick
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
  object cmdHelp: TBitBtn
    Left = 106
    Top = 128
    Width = 84
    Height = 25
    Caption = '—«&Â‰„«'
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 128
    Width = 84
    Height = 25
    Caption = '&Œ—ÊÃ'
    TabOrder = 6
    Kind = bkClose
  end
  object txtYear: TEdit
    Left = 8
    Top = 8
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 4
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtYearExit
    OnKeyPress = txtYearKeyPress
  end
  object rdoFishes: TRadioGroup
    Left = 159
    Top = 40
    Width = 130
    Height = 74
    ItemIndex = 0
    Items.Strings = (
      '›ﬁÿ ›Ì‘Â«Ì ’«œ—Â'
      'ﬂ·ÌÂ «ÿ·«⁄« ')
    TabOrder = 2
  end
  object chkDisk: TCheckBox
    Left = 24
    Top = 57
    Width = 129
    Height = 16
    Caption = '«‰ ﬁ«· »— —ÊÌ œÌ”ﬂ '
    TabOrder = 3
    Visible = False
    OnKeyPress = cmbMonthKeyPress
  end
  object chkDelFish: TCheckBox
    Left = 15
    Top = 96
    Width = 138
    Height = 17
    Caption = 'Õ–› ›Ì‘Â« Å” «“ «‰ ﬁ«·'
    TabOrder = 7
    OnKeyPress = cmbMonthKeyPress
  end
end
