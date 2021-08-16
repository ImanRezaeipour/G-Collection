object frmChangePassword: TfrmChangePassword
  Left = 181
  Top = 120
  HelpContext = 82
  ActiveControl = txtBeforePassword
  BiDiMode = bdRightToLeft
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1578#1594#1610#1610#1585' '#1603#1604#1605#1607' '#1593#1576#1608#1585
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
    Left = 246
    Top = 7
    Width = 37
    Height = 15
    Caption = #1606#1575#1605' '#1603#1575#1585#1576#1585
  end
  object lbl2: TLabel
    Left = 245
    Top = 42
    Width = 65
    Height = 15
    Caption = #1603#1604#1605#1607' '#1593#1576#1608#1585' '#1602#1576#1604#1610
  end
  object lbl3: TLabel
    Left = 245
    Top = 71
    Width = 66
    Height = 15
    Caption = #1603#1604#1605#1607' '#1593#1576#1608#1585' '#1580#1583#1610#1583
  end
  object lbl4: TLabel
    Left = 241
    Top = 99
    Width = 93
    Height = 15
    Caption = #1578#1603#1585#1575#1585' '#1603#1604#1605#1607' '#1593#1576#1608#1585' '#1580#1583#1610#1583
  end
  object cmdOK: TBitBtn
    Left = 7
    Top = 42
    Width = 86
    Height = 22
    Caption = '&'#1578#1571#1610#1610#1583
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
    Height = 24
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
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 6
    Kind = bkCancel
  end
  object txtNewPassword: TEdit
    Left = 99
    Top = 71
    Width = 142
    Height = 24
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
    Height = 24
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
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
end
