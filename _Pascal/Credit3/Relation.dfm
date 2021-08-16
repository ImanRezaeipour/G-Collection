object frmRelations: TfrmRelations
  Left = 14
  Top = 32
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1585#1578#1576#1575#1591' '#1576#1575' '#1583#1587#1578#1711#1575#1607' '#1603#1575#1585#1578#1582#1608#1575#1606
  ClientHeight = 366
  ClientWidth = 609
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object grdRdrs: TStringGrid
    Left = 0
    Top = 0
    Width = 609
    Height = 226
    ColCount = 4
    FixedCols = 0
    TabOrder = 0
    OnDblClick = grdRdrsDblClick
    ColWidths = (
      64
      64
      68
      64)
  end
  object grpSendGetDT: TGroupBox
    Left = 32
    Top = 165
    Width = 553
    Height = 58
    Caption = #1575#1585#1587#1575#1604' '#1608' '#1583#1585#1610#1575#1601#1578' '#1578#1575#1585#1610#1582
    TabOrder = 1
    Visible = False
    object lblDate: TLabel
      Left = 316
      Top = 24
      Width = 22
      Height = 15
      Caption = '&'#1578#1575#1585#1610#1582
      FocusControl = txtDate
    end
    object lblTime: TLabel
      Left = 171
      Top = 24
      Width = 21
      Height = 15
      Caption = '&'#1586#1605#1575#1606
    end
    object txtDate: TEdit
      Left = 199
      Top = 24
      Width = 106
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtDateKeyPress
    end
    object cmbDT: TComboBox
      Left = 400
      Top = 24
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
    end
    object txtTime: TEdit
      Left = 96
      Top = 24
      Width = 65
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = txtTimeKeyPress
    end
  end
  object grpLimit: TGroupBox
    Left = 32
    Top = 181
    Width = 553
    Height = 57
    Caption = #1575#1585#1587#1575#1604' '#1605#1581#1583#1608#1583#1607' '#1586#1605#1575#1606#1610
    TabOrder = 2
    Visible = False
    object lbl1: TLabel
      Left = 421
      Top = 24
      Width = 9
      Height = 15
      Caption = #1575#1586
    end
    object lbl2: TLabel
      Left = 356
      Top = 24
      Width = 6
      Height = 15
      Caption = #1578#1575
    end
    object lbl4: TLabel
      Left = 210
      Top = 24
      Width = 6
      Height = 15
      Caption = #1578#1575
    end
    object lbl3: TLabel
      Left = 272
      Top = 24
      Width = 9
      Height = 15
      Caption = #1575#1586
    end
    object lbl6: TLabel
      Left = 67
      Top = 24
      Width = 6
      Height = 15
      Caption = #1578#1575
    end
    object lbl5: TLabel
      Left = 128
      Top = 24
      Width = 9
      Height = 15
      Caption = #1575#1586
    end
    object txtFromT1: TEdit
      Left = 368
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
      OnExit = txtFromT1Exit
      OnKeyPress = txtFromT1KeyPress
    end
    object txtToT1: TEdit
      Left = 304
      Top = 24
      Width = 48
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = txtToT1Exit
      OnKeyPress = txtToT1KeyPress
    end
    object txtToT2: TEdit
      Left = 160
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 4
      OnExit = txtToT2Exit
      OnKeyPress = txtToT2KeyPress
    end
    object txtFromT2: TEdit
      Left = 224
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 3
      OnExit = txtFromT2Exit
      OnKeyPress = txtFromT2KeyPress
    end
    object txtToT3: TEdit
      Left = 16
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 6
      OnExit = txtToT3Exit
      OnKeyPress = txtToT3KeyPress
    end
    object txtFromT3: TEdit
      Left = 80
      Top = 24
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 5
      OnExit = txtFromT3Exit
      OnKeyPress = txtFromT3KeyPress
    end
    object cmbLimit: TComboBox
      Left = 440
      Top = 24
      Width = 105
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 0
    end
  end
  object grpBtns: TGroupBox
    Left = 0
    Top = 313
    Width = 609
    Height = 42
    TabOrder = 4
    object cmdTic: TBitBtn
      Left = 509
      Top = 14
      Width = 97
      Height = 25
      Caption = #1575'&'#1606#1578#1582#1575#1576
      TabOrder = 0
      OnClick = cmdTicClick
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
      Top = 12
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 4
      Kind = bkClose
    end
    object cmdRun: TBitBtn
      Left = 249
      Top = 14
      Width = 121
      Height = 25
      Caption = #1578#1587#1578' '#1575#1585#1578#1576#1575#1591
      TabOrder = 2
      OnClick = cmdRunClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000333300
        0000377777F3337777770FFFF099990FFFF07FFFF7FFFF7FFFF7000000999900
        00007777777777777777307703399330770337FF7F37F337FF7F300003399330
        000337777337F337777333333339933333333FFFFFF7F33FFFFF000000399300
        0000777777F7F37777770FFFF099990FFFF07FFFF7F7FF7FFFF7000000999900
        00007777777777777777307703399330770337FF7F37F337FF7F300003399330
        0003377773F7FFF77773333330000003333333333777777F3333333330FFFF03
        3333333337FFFF7F333333333000000333333333377777733333333333077033
        33333333337FF7F3333333333300003333333333337777333333}
      NumGlyphs = 2
    end
    object cmdHelp: TBitBtn
      Left = 112
      Top = 12
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 3
      Kind = bkHelp
    end
    object cmdInvert: TBitBtn
      Left = 400
      Top = 12
      Width = 97
      Height = 25
      Caption = '&'#1605#1593#1603#1608#1587
      TabOrder = 1
      OnClick = cmdInvertClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object grpChangeBaud: TGroupBox
    Left = 32
    Top = 197
    Width = 553
    Height = 49
    Caption = #1578#1594#1610#1610#1585' '#1587#1585#1593#1578' '#1575#1585#1578#1576#1575#1591
    TabOrder = 3
    Visible = False
    object lbl7: TLabel
      Left = 365
      Top = 16
      Width = 81
      Height = 15
      Caption = #1587#1585#1593#1578' '#1575#1585#1578#1576#1575#1591' '#1580#1583#1610#1583
    end
    object cmbBaud: TComboBox
      Left = 208
      Top = 16
      Width = 145
      Height = 23
      Style = csDropDownList
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 0
    end
  end
  object grpAuthority: TGroupBox
    Left = 32
    Top = 34
    Width = 553
    Height = 69
    Caption = #1575#1585#1587#1575#1604' '#1608' '#1583#1585#1610#1575#1601#1578' '#1580#1583#1608#1604' '#1588#1575#1585#1688
    TabOrder = 5
    Visible = False
    DesignSize = (
      553
      69)
    object Label1: TLabel
      Left = 497
      Top = 25
      Width = 47
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1608#1593' '#1593#1605#1604' :'
    end
    object Label3: TLabel
      Left = 290
      Top = 25
      Width = 60
      Height = 15
      Caption = #1605#1581#1604' '#1582#1583#1605#1578' : '
      Visible = False
    end
    object Label4: TLabel
      Left = 319
      Top = 25
      Width = 26
      Height = 15
      Caption = #1662#1585#1587#1606#1604
      Visible = False
    end
    object cmbEmplCode: TDBLookupComboBox
      Left = 181
      Top = 22
      Width = 132
      Height = 23
      BiDiMode = bdLeftToRight
      DataField = 'Empl_No'
      DataSource = DataSource1
      KeyField = 'Empl_No'
      ListField = 'Empl_No'
      ListSource = DataSource2
      ParentBiDiMode = False
      TabOrder = 2
      Visible = False
    end
    object cmbEmplName: TDBLookupComboBox
      Left = 4
      Top = 22
      Width = 173
      Height = 23
      DataField = 'Empl_No'
      DataSource = DataSource1
      KeyField = 'Empl_No'
      ListField = 'te'
      ListSource = DataSource2
      TabOrder = 3
      Visible = False
    end
    object cmbOperate: TComboBox
      Left = 356
      Top = 22
      Width = 141
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 15
      TabOrder = 0
      OnChange = cmbOperateChange
      Items.Strings = (
        #1575#1585#1587#1575#1604' '#1580#1583#1608#1604' '#1588#1575#1585#1688#1705#1604#1610#1607' '#1575#1601#1585#1575#1583
        #1575#1585#1587#1575#1604' '#1580#1583#1608#1604' '#1588#1575#1585#1688' '#1605#1581#1604' '#1582#1583#1605#1578' '#1582#1575#1589
        #1575#1601#1586#1608#1583#1606' '#1610#1705' '#1606#1601#1585
        #1581#1584#1601' '#1610#1705' '#1606#1601#1585
        #1582#1575#1604#1610' '#1705#1585#1583#1606' '#1580#1583#1608#1604' '#1588#1575#1585#1688
        #13#1583#1585#1610#1575#1601#1578' '#1578#1593#1583#1575#1583)
    end
    object cmbParts: TComboBox
      Left = 40
      Top = 22
      Width = 244
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 1
      Visible = False
    end
    object btn_select: TBitBtn
      Left = 6
      Top = 22
      Width = 32
      Height = 23
      Caption = '....'
      TabOrder = 4
      Visible = False
      OnClick = btn_selectClick
    end
  end
  object grpRecovery: TGroupBox
    Left = 32
    Top = 229
    Width = 553
    Height = 57
    Caption = #1576#1575#1586#1610#1575#1576#1610' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1587#1575#1593#1578
    TabOrder = 6
    Visible = False
    object lblRecovery: TLabel
      Left = 315
      Top = 24
      Width = 35
      Height = 15
      Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
      FocusControl = txtRecoveryFDate
    end
    object Label2: TLabel
      Left = 493
      Top = 24
      Width = 49
      Height = 15
      Caption = '&'#1606#1608#1593' '#1576#1575#1586#1610#1575#1576#1610
      FocusControl = cmbRecovery
    end
    object lbl8: TLabel
      Left = 166
      Top = 24
      Width = 32
      Height = 15
      Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
      FocusControl = txtRecoveryTDate
    end
    object txtRecoveryFDate: TEdit
      Left = 209
      Top = 24
      Width = 96
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 1
    end
    object cmbRecovery: TComboBox
      Left = 368
      Top = 24
      Width = 113
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      ItemIndex = 0
      TabOrder = 0
      Text = #1578#1605#1575#1605#1610' '#1585#1603#1608#1585#1583#1607#1575
      Items.Strings = (
        #1578#1605#1575#1605#1610' '#1585#1603#1608#1585#1583#1607#1575
        #1585#1603#1608#1585#1583#1607#1575#1610' '#1580#1583#1610#1583)
    end
    object txtRecoveryTDate: TEdit
      Left = 56
      Top = 24
      Width = 97
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 2
    end
  end
  object grpLostCard: TGroupBox
    Left = 32
    Top = 252
    Width = 553
    Height = 69
    Caption = #1575#1585#1587#1575#1604' '#1608' '#1583#1585#1610#1575#1601#1578' '#1580#1583#1608#1604'  '#1705#1575#1585#1578#1607#1575#1610' '#1605#1601#1602#1608#1583#1610' '#1608' '#1575#1601#1585#1575#1583' '#1594#1610#1585' '#1605#1580#1575#1586
    TabOrder = 7
    Visible = False
    DesignSize = (
      553
      69)
    object Label5: TLabel
      Left = 462
      Top = 29
      Width = 47
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1608#1593' '#1593#1605#1604' :'
    end
    object cmbLostOperate: TComboBox
      Left = 217
      Top = 26
      Width = 241
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 15
      ItemIndex = 0
      TabOrder = 0
      Text = #13#1575#1585#1587#1575#1604' '#1580#1583#1608#1604
      OnChange = cmbOperateChange
      Items.Strings = (
        #13#1575#1585#1587#1575#1604' '#1580#1583#1608#1604
        #1582#1575#1604#1610' '#1705#1585#1583#1606' '#1580#1583#1608#1604
        #1583#1585#1610#1575#1601#1578' '#1578#1593#1583#1575#1583)
    end
  end
  object grpWeeks: TGroupBox
    Left = 32
    Top = 76
    Width = 553
    Height = 69
    Caption = #1575#1585#1587#1575#1604' '#1580#1583#1608#1604' '#1576#1585#1606#1575#1605#1607' '#1607#1601#1578#1711#1610
    TabOrder = 8
    Visible = False
    DesignSize = (
      553
      69)
    object Label6: TLabel
      Left = 462
      Top = 29
      Width = 47
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1608#1593' '#1593#1605#1604' :'
    end
    object cmbWeeks: TComboBox
      Left = 217
      Top = 26
      Width = 241
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 15
      TabOrder = 0
      OnChange = cmbOperateChange
      Items.Strings = (
        #13#1575#1585#1587#1575#1604' '#1580#1583#1608#1604
        #1582#1575#1604#1610' '#1705#1585#1583#1606' '#1580#1583#1608#1604)
    end
  end
  object grpCoPosts: TGroupBox
    Left = 32
    Top = 56
    Width = 553
    Height = 69
    Caption = #1575#1585#1587#1575#1604' '#1580#1583#1608#1604' '#1580#1575#1610#1711#1575#1607' '#1607#1575' '
    TabOrder = 9
    Visible = False
    DesignSize = (
      553
      69)
    object Label7: TLabel
      Left = 462
      Top = 29
      Width = 47
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1608#1593' '#1593#1605#1604' :'
    end
    object cmbCoPosts: TComboBox
      Left = 217
      Top = 26
      Width = 241
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 15
      TabOrder = 0
      OnChange = cmbOperateChange
      Items.Strings = (
        #13#1575#1585#1587#1575#1604' '#1580#1583#1608#1604
        #1582#1575#1604#1610' '#1705#1585#1583#1606' '#1580#1583#1608#1604)
    end
  end
  object grpServices: TGroupBox
    Left = 32
    Top = 76
    Width = 553
    Height = 69
    Caption = #1575#1585#1587#1575#1604' '#1580#1583#1608#1604' '#1582#1583#1605#1575#1578
    TabOrder = 10
    Visible = False
    DesignSize = (
      553
      69)
    object Label8: TLabel
      Left = 462
      Top = 29
      Width = 47
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1608#1593' '#1593#1605#1604' :'
    end
    object cmbServices: TComboBox
      Left = 217
      Top = 26
      Width = 241
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 15
      ItemIndex = 0
      TabOrder = 0
      Text = #13#1575#1585#1587#1575#1604' '#1580#1583#1608#1604
      OnChange = cmbOperateChange
      Items.Strings = (
        #13#1575#1585#1587#1575#1604' '#1580#1583#1608#1604
        #1582#1575#1604#1610' '#1705#1585#1583#1606' '#1580#1583#1608#1604
        #1583#1585#1610#1575#1601#1578' '#1578#1593#1583#1575#1583)
    end
  end
  object tmrTime: TTimer
    OnTimer = tmrTimeTimer
    Left = 32
    Top = 48
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 40
  end
  object adoQryPersons: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'Select  p_proxi,p_Barcode from persons order by p_proxi')
    Left = 264
    Top = 64
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable1CalcFields
    TableName = 'Employee'
    Left = 387
    Top = 178
    object ADOTable1te: TStringField
      FieldKind = fkCalculated
      FieldName = 'te'
      Calculated = True
    end
    object ADOTable1Empl_No: TWideStringField
      FieldName = 'Empl_No'
      Size = 8
    end
    object ADOTable1Empl_ID: TWideStringField
      FieldName = 'Empl_ID'
      Size = 15
    end
    object ADOTable1Empl_Name: TWideStringField
      FieldName = 'Empl_Name'
      Size = 15
    end
    object ADOTable1Empl_Family: TWideStringField
      FieldName = 'Empl_Family'
      Size = 25
    end
    object ADOTable1Empl_Active: TBooleanField
      FieldName = 'Empl_Active'
    end
    object ADOTable1Empl_Department: TIntegerField
      FieldName = 'Empl_Department'
    end
    object ADOTable1Empl_CoPost: TIntegerField
      FieldName = 'Empl_CoPost'
    end
    object ADOTable1Empl_Part: TIntegerField
      FieldName = 'Empl_Part'
    end
    object ADOTable1Empl_Dscnt: TIntegerField
      FieldName = 'Empl_Dscnt'
    end
    object ADOTable1Empl_ExpDate: TWideStringField
      FieldName = 'Empl_ExpDate'
      Size = 10
    end
    object ADOTable1Empl_Balance: TBCDField
      FieldName = 'Empl_Balance'
      Precision = 19
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 355
    Top = 210
  end
  object ADOTable2: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable2CalcFields
    TableName = 'Employee'
    Left = 395
    Top = 202
    object ADOTable2te: TStringField
      FieldKind = fkCalculated
      FieldName = 'te'
      Calculated = True
    end
    object ADOTable2Empl_No: TWideStringField
      FieldName = 'Empl_No'
      Size = 8
    end
    object ADOTable2Empl_ID: TWideStringField
      FieldName = 'Empl_ID'
      Size = 15
    end
    object ADOTable2Empl_Name: TWideStringField
      FieldName = 'Empl_Name'
      Size = 15
    end
    object ADOTable2Empl_Family: TWideStringField
      FieldName = 'Empl_Family'
      Size = 25
    end
    object ADOTable2Empl_Active: TBooleanField
      FieldName = 'Empl_Active'
    end
    object ADOTable2Empl_Department: TIntegerField
      FieldName = 'Empl_Department'
    end
    object ADOTable2Empl_CoPost: TIntegerField
      FieldName = 'Empl_CoPost'
    end
    object ADOTable2Empl_Part: TIntegerField
      FieldName = 'Empl_Part'
    end
    object ADOTable2Empl_Dscnt: TIntegerField
      FieldName = 'Empl_Dscnt'
    end
    object ADOTable2Empl_ExpDate: TWideStringField
      FieldName = 'Empl_ExpDate'
      Size = 10
    end
    object ADOTable2Empl_Balance: TBCDField
      FieldName = 'Empl_Balance'
      Precision = 19
    end
  end
  object DataSource2: TDataSource
    DataSet = ADOTable2
    Left = 323
    Top = 210
  end
end
