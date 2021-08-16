object frmDBLogin: TfrmDBLogin
  Left = 297
  Top = 221
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1576#1585#1602#1585#1575#1585#1610' '#1575#1585#1578#1576#1575#1591' '#1576#1575' '#1587#1585#1608#1585#1610#1587' '#1583#1607#1606#1583#1607
  ClientHeight = 235
  ClientWidth = 268
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
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 106
    Top = 139
    Width = 152
    Height = 15
    Caption = #1575#1578#1589#1575#1604' '#1576#1575' '#1587#1585#1608#1610#1587' '#1583#1607#1606#1583#1607' '#1576#1585#1602#1585#1575#1585#1606#1588#1583' .'
  end
  object Label2: TLabel
    Left = 242
    Top = 83
    Width = 4
    Height = 15
  end
  object lbl2: TLabel
    Left = 157
    Top = 155
    Width = 101
    Height = 15
    Caption = #1604#1591#1601#1575' '#1605#1580#1583#1583#1575' '#1587#1593#1610' '#1606#1605#1575#1610#1610#1583' .'
  end
  object grpServer: TGroupBox
    Left = 0
    Top = 1
    Width = 265
    Height = 120
    TabOrder = 0
    object lblServer: TLabel
      Left = 200
      Top = 16
      Width = 58
      Height = 15
      Caption = #1587#1585#1608#1610#1587' '#1583#1607#1606#1583#1607
    end
    object lblSqlUser: TLabel
      Left = 170
      Top = 63
      Width = 88
      Height = 15
      Caption = #1603#1575#1585#1576#1585' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
    end
    object lblSQLPass: TLabel
      Left = 214
      Top = 87
      Width = 44
      Height = 15
      Caption = #1603#1604#1605#1607' '#1593#1576#1608#1585
    end
    object lbldatabase: TLabel
      Left = 183
      Top = 40
      Width = 75
      Height = 15
      Caption = #1606#1575#1605' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
    end
    object txtServer: TEdit
      Left = 9
      Top = 13
      Width = 152
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      OnChange = txtServerChange
    end
    object txtSqlUser: TEdit
      Left = 9
      Top = 60
      Width = 152
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
    end
    object txtSqlPass: TEdit
      Left = 9
      Top = 84
      Width = 152
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object txtdatabase: TEdit
      Left = 9
      Top = 37
      Width = 152
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      ReadOnly = True
      TabOrder = 1
      OnChange = txtdatabaseChange
    end
  end
  object cmdOK: TBitBtn
    Left = 144
    Top = 200
    Width = 122
    Height = 25
    Caption = #1578#1575#1610#1610#1583
    Default = True
    TabOrder = 1
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
    Left = 8
    Top = 200
    Width = 121
    Height = 25
    Caption = #1575#1606#1589#1585#1575#1601
    TabOrder = 2
    OnClick = cmdCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object Animat: TAnimate
    Left = 28
    Top = 138
    Width = 80
    Height = 50
    CommonAVI = aviFindFolder
    StopFrame = 29
    Visible = False
  end
  object adoQryLogin: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=Clock;Data Source=RndServer'
    Parameters = <>
    Left = 8
    Top = 136
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Clock.mdb;Persist S' +
      'ecurity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 8
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    Left = 88
    Top = 8
  end
end
