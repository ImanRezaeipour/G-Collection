object frmLogin: TfrmLogin
  Left = 250
  Top = 108
  BiDiMode = bdRightToLeft
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1608#1585#1608#1583' '#1603#1575#1585#1576#1585' '#1576#1607' '#1587#1610#1587#1578#1605' '#1662#1575#1585#1603#1610#1606#1711
  ClientHeight = 139
  ClientWidth = 202
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 154
    Top = 7
    Width = 37
    Height = 15
    Caption = #1606#1575#1605' '#1603#1575#1585#1576#1585
  end
  object Label2: TLabel
    Left = 152
    Top = 35
    Width = 44
    Height = 15
    Caption = #1603#1604#1605#1607' '#1593#1576#1608#1585
  end
  object txtUserName: TEdit
    Left = 7
    Top = 7
    Width = 142
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 15
    ParentBiDiMode = False
    TabOrder = 0
    Text = 'Admin'
  end
  object txtPassword: TEdit
    Left = 7
    Top = 35
    Width = 142
    Height = 24
    BiDiMode = bdLeftToRight
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 15
    ParentBiDiMode = False
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object Animat: TAnimate
    Left = 64
    Top = 64
    Width = 80
    Height = 50
    CommonAVI = aviFindFolder
    StopFrame = 29
    Visible = False
  end
  object cmdOK: TBitBtn
    Left = 106
    Top = 113
    Width = 93
    Height = 22
    Caption = '&'#1578#1571#1610#1610#1583
    Default = True
    TabOrder = 3
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
  object cmdCancel: TBitBtn
    Left = 7
    Top = 113
    Width = 93
    Height = 22
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 4
    OnClick = cmdCancelClick
    Kind = bkCancel
  end
  object qryLogin: TADOQuery
    Parameters = <>
    Left = 16
    Top = 72
  end
end
