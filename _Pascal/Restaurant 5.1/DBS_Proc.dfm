object frmDBS: TfrmDBS
  Left = 129
  Top = 173
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
    Left = 156
    Top = 48
    Width = 75
    Height = 15
    BiDiMode = bdLeftToRight
    Caption = #1606#1575#1605' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
    ParentBiDiMode = False
  end
  object lbl3: TLabel
    Left = 161
    Top = 80
    Width = 37
    Height = 15
    Caption = #1606#1575#1605' '#1603#1575#1585#1576#1585
  end
  object lbl4: TLabel
    Left = 354
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
    Top = 48
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
    Left = 280
    Top = 112
    Width = 97
    Height = 25
    Caption = #1578#1575#1610#1610#1583
    Default = True
    TabOrder = 4
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
    Left = 176
    Top = 112
    Width = 97
    Height = 25
    Cancel = True
    Caption = #1575#1606#1589#1585#1575#1601
    ModalResult = 7
    TabOrder = 5
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
    Left = 208
    Top = 80
    Width = 113
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 6
  end
  object txtPass: TEdit
    Left = 408
    Top = 80
    Width = 113
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    PasswordChar = '*'
    TabOrder = 7
  end
  object DBConnection: TADOConnection
    CommandTimeout = 1000
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=DPCred;Persist Security Info=True;U' +
      'ser ID=DPCred;Initial Catalog=CredRest;Data Source=RndServer'
    ConnectionTimeout = 1000
    LoginPrompt = False
    Provider = 'ADsDSOObject'
    Left = 24
  end
  object opnFile: TOpenDialog
    Filter = 'M.S. Access (*.MDB)|*.MDB|All Files (*.*)|*.*'
    Left = 456
    Top = 24
  end
  object adoQryG: TADOQuery
    Connection = DBConnection
    Parameters = <>
    Left = 96
  end
  object adoTblG: TADOTable
    Connection = DBConnection
    Left = 160
  end
  object TblPersons: TADOTable
    Connection = DBConnection
    TableName = 'persons'
    Left = 40
    Top = 104
  end
  object tblPrgPersons: TADOTable
    Connection = DBConnection
    TableName = 'PrgPrs'
    Left = 400
    Top = 72
  end
  object tblFishFood: TADOTable
    Connection = DBConnection
    TableName = 'FishFood'
    Left = 328
    Top = 72
  end
  object tblFish: TADOTable
    Connection = DBConnection
    TableName = 'Fish'
    Left = 256
    Top = 72
  end
  object _tblPrgPersons: TTable
    TableName = 'PrgPrs.db'
    Left = 400
    Top = 32
  end
  object _tblFishFood: TTable
    TableName = 'FishFood.DB'
    Left = 328
    Top = 32
  end
  object _tblFish: TTable
    TableName = 'Fish.DB'
    Left = 256
    Top = 32
  end
  object _tblPersons: TTable
    DatabaseName = 'Resuran'
    FieldDefs = <
      item
        Name = 'P_BarCode'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'P_Proxi'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'P_Name'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'P_Family'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'P_PartCode'
        DataType = ftSmallint
      end
      item
        Name = 'P_JobCode'
        DataType = ftSmallint
      end
      item
        Name = 'P_GroupCode'
        DataType = ftSmallint
      end
      item
        Name = 'P_IsValid'
        DataType = ftBoolean
      end
      item
        Name = 'P_ValidTest'
        DataType = ftBoolean
      end
      item
        Name = 'P_Pricable'
        DataType = ftBoolean
      end
      item
        Name = 'P_Sobhaneh'
        DataType = ftBoolean
      end
      item
        Name = 'P_Nahar'
        DataType = ftBoolean
      end
      item
        Name = 'P_Sham'
        DataType = ftBoolean
      end
      item
        Name = 'P_Rejim'
        DataType = ftBoolean
      end
      item
        Name = 'P_IsGuest'
        DataType = ftBoolean
      end
      item
        Name = 'P_Special'
        DataType = ftSmallint
      end
      item
        Name = 'P_ManyFish'
        DataType = ftSmallint
      end
      item
        Name = 'P_MaxFish'
        DataType = ftSmallint
      end
      item
        Name = 'P_EtebarFish'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <
      item
        Name = 'tblPersonsIndex1'
        Fields = 'P_BarCode;P_Proxi'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'BCodeIdx'
        Fields = 'P_BarCode'
        Options = [ixUnique, ixCaseInsensitive]
      end
      item
        Name = 'ProxiIdx'
        Fields = 'P_Proxi'
        Options = [ixUnique, ixCaseInsensitive]
      end>
    StoreDefs = True
    TableName = 'Persons.DB'
    Left = 80
    Top = 104
  end
end
