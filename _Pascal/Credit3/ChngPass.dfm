object frmChangePassword: TfrmChangePassword
  Left = 181
  Top = 120
  HelpContext = 82
  ActiveControl = txtBeforePassword
  BiDiMode = bdRightToLeft
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = ' €ÌÌ— ﬂ·„Â ⁄»Ê—'
  ClientHeight = 125
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 235
    Top = 7
    Width = 48
    Height = 15
    Caption = '‰«„ ﬂ«—»—'
  end
  object lbl2: TLabel
    Left = 231
    Top = 42
    Width = 79
    Height = 15
    Caption = 'ﬂ·„Â ⁄»Ê— ﬁ»·Ì'
  end
  object lbl3: TLabel
    Left = 226
    Top = 71
    Width = 85
    Height = 15
    Caption = 'ﬂ·„Â ⁄»Ê— ÃœÌœ'
  end
  object lbl4: TLabel
    Left = 208
    Top = 99
    Width = 126
    Height = 15
    Caption = ' ﬂ—«— ﬂ·„Â ⁄»Ê— ÃœÌœ'
  end
  object cmdOK: TBitBtn
    Left = 7
    Top = 42
    Width = 86
    Height = 22
    Caption = '& √ÌÌœ'
    Default = True
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
  object txtUserName: TEdit
    Left = 99
    Top = 7
    Width = 142
    Height = 23
    MaxLength = 15
    ReadOnly = True
    TabOrder = 0
  end
  object txtBeforePassword: TEdit
    Left = 99
    Top = 42
    Width = 142
    Height = 25
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 15
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object cmdCancel: TBitBtn
    Left = 7
    Top = 99
    Width = 86
    Height = 22
    Caption = '&«‰’—«›'
    TabOrder = 6
    Kind = bkCancel
  end
  object txtNewPassword: TEdit
    Left = 99
    Top = 71
    Width = 142
    Height = 25
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 15
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 2
  end
  object txtRepeatPassword: TEdit
    Left = 99
    Top = 99
    Width = 142
    Height = 25
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 15
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 3
  end
  object cmdHelp: TBitBtn
    Left = 7
    Top = 71
    Width = 86
    Height = 22
    Caption = '—«&Â‰„«'
    TabOrder = 5
    Kind = bkHelp
  end
end
