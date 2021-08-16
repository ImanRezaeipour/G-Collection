object frmDBSMonth: TfrmDBSMonth
  Left = 198
  Top = 156
  HelpContext = 507
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '«‰ ﬁ«· «ÿ·«⁄«  „«Â«‰Â'
  ClientHeight = 120
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
  object Label1: TLabel
    Left = 166
    Top = 48
    Width = 120
    Height = 15
    Caption = '«‰ &ﬁ«· ›Ì‘Â«  « Å«Ì«‰ „«Â'
    FocusControl = cmbMonth
  end
  object Label2: TLabel
    Left = 146
    Top = 16
    Width = 148
    Height = 15
    Caption = '¬Œ—Ì‰ ›Ì‘Â«Ì  «‰ ﬁ«· Ì«› Â'
  end
  object cmbMonth: TComboBox
    Left = 8
    Top = 48
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
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
  object pnlArchive: TPanel
    Left = 8
    Top = 8
    Width = 145
    Height = 33
    BevelInner = bvLowered
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object cmdOK: TBitBtn
    Left = 200
    Top = 88
    Width = 91
    Height = 25
    Caption = '& «ÌÌœ'
    TabOrder = 2
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
    Left = 104
    Top = 88
    Width = 89
    Height = 25
    Caption = '—«&Â‰„«'
    TabOrder = 3
    Kind = bkHelp
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 88
    Width = 89
    Height = 25
    Caption = '&Œ—ÊÃ'
    TabOrder = 4
    Kind = bkClose
  end
end
