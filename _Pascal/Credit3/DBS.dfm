object frmDBS: TfrmDBS
  Left = 105
  Top = 205
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
  ClientHeight = 144
  ClientWidth = 529
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
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 156
    Top = 16
    Width = 86
    Height = 15
    BiDiMode = bdLeftToRight
    Caption = #1605#1587#1610#1585' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
    ParentBiDiMode = False
  end
  object lbl2: TLabel
    Left = 166
    Top = 48
    Width = 75
    Height = 15
    BiDiMode = bdLeftToRight
    Caption = #1606#1575#1605' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
    ParentBiDiMode = False
  end
  object lblUser: TLabel
    Left = 162
    Top = 80
    Width = 90
    Height = 15
    Caption = #1603#1575#1585#1576#1585' '#1576#1575#1606#1603'  '#1575#1591#1604#1575#1593#1575#1578
  end
  object lblPass: TLabel
    Left = 378
    Top = 80
    Width = 44
    Height = 15
    Caption = #1603#1604#1605#1607' '#1593#1576#1608#1585
  end
  object rdoDBS: TRadioGroup
    Left = 8
    Top = 8
    Width = 145
    Height = 97
    BiDiMode = bdLeftToRight
    Caption = #1606#1608#1593' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
    Items.Strings = (
      'Microsoft Access'
      'SQL server 2000')
    ParentBiDiMode = False
    TabOrder = 0
    OnClick = rdoDBSClick
  end
  object txtPath: TEdit
    Left = 256
    Top = 16
    Width = 241
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
  end
  object txtDBSName: TEdit
    Left = 256
    Top = 51
    Width = 113
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
  end
  object btnPath: TButton
    Left = 496
    Top = 16
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = btnPathClick
  end
  object btnOK: TBitBtn
    Left = 256
    Top = 112
    Width = 99
    Height = 25
    Caption = #1578#1575#1610#1610#1583
    Default = True
    TabOrder = 6
    OnClick = btnOKClick
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
  object btnCancel: TBitBtn
    Left = 152
    Top = 112
    Width = 97
    Height = 25
    Cancel = True
    Caption = #1575#1606#1589#1585#1575#1601
    ModalResult = 7
    TabOrder = 7
    OnClick = btnCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object txtUser: TEdit
    Left = 256
    Top = 80
    Width = 113
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 4
  end
  object txtPass: TEdit
    Left = 424
    Top = 80
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    PasswordChar = '*'
    TabOrder = 5
  end
  object adoConnect: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sa;Persist Security Info=True;User ' +
      'ID=sa;Data Source=RndServer'
    ConnectionTimeout = 30
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 96
  end
  object opnFile: TOpenDialog
    Filter = 'M.S. Access (*.MDB)|*.MDB|All Files (*.*)|*.*'
    Left = 456
    Top = 24
  end
  object adoQryG: TADOQuery
    Connection = adoConnect
    Parameters = <>
    Left = 96
    Top = 104
  end
  object adoTblG: TADOTable
    Connection = adoConnect
    Left = 160
    Top = 104
  end
  object atblReceipt1: TADOTable
    Connection = adoConnect
    TableName = 'Receipt1'
    Left = 424
    Top = 112
  end
  object atblEmployee: TADOTable
    Connection = adoConnect
    TableName = 'Employee'
    Left = 360
    Top = 112
  end
  object atblReceipt2: TADOTable
    Connection = adoConnect
    TableName = 'Receipt2'
    Left = 480
    Top = 112
  end
end
