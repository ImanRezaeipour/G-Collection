object frmBarcodeRpt: TfrmBarcodeRpt
  Left = 401
  Top = 233
  HelpContext = 36
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1670#1575#1662' '#1576#1575#1585#1603#1583
  ClientHeight = 163
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 441
    Top = 8
    Width = 59
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
  end
  object lbl2: TLabel
    Left = 489
    Top = 40
    Width = 10
    Height = 15
    Caption = #1606'&'#1575#1605
  end
  object lbl3: TLabel
    Left = 217
    Top = 40
    Width = 53
    Height = 15
    Caption = #1606#1575#1605' '#1582#1575#1606'&'#1608#1575#1583#1711#1610
  end
  object SpeedButton1: TSpeedButton
    Left = 419
    Top = 5
    Width = 21
    Height = 25
    Cursor = crHandPoint
    Flat = True
    Glyph.Data = {
      F6040000424DF604000000000000360000002800000015000000130000000100
      180000000000C004000000000000000000000000000000000000F39866D0D6EE
      2844B50D2BA61130AC1231AB1432A91230A91332AC1332AD1031AE0D30B10A2E
      B2082DB4062AB10328B10127B40024AE1F3CACCFD4EAFFFFFF00FDEDE52849CD
      1338CC1B3ECC2144CF2547CF2647CF2446CF2347D02146D11E45D21B45D51642
      D51340D60E3DD50939D60435D50130D1002AC21F3CABFFFFFF00FFFFFF0E37D8
      1C43DB284CDD2F52DE3355DF3457E03155E03156E02E56E12A55E22553E41F50
      E4194CE51348E50D43E5073EE40238E0002FD10023AAFFFFFF00FFFFFF143CDD
      254BE03154E1395BE33D5EE43D5FE43B5EE4395EE5375EE5325DE62C5BE72557
      E81F54E91950E9114AE90B44E8053DE40233D60126AFFFFFFF00FFFFFF1840DE
      2E51E13A5CE34262E4B5C1F5FFFFFF4365E64165E63D64E63862E73260E82A5C
      E92459EAFFFFFFA1B8F70E48E90940E50536D70227B0FFFFFF00FFFFFF1E45DF
      3658E24262E44967E5FFFFFFFFFFFFFFFFFF4568E64167E73B64E73562E82D5E
      EAFFFFFFFFFFFFFFFFFF114AE90D44E60B3BD7062BB1FFFFFF00FFFFFF254BE0
      3D5EE34867E54E6CE6506DE6FFFFFFFFFFFFFFFFFF4268E73C65E73662E8FFFF
      FFFFFFFFFFFFFF1950E9164CE81347E4103FD80A2DB1FFFFFF00FFFFFF2B4FE1
      4463E44E6BE6526FE7536FE7516EE6FFFFFFFFFFFFFFFFFF3D65E7FFFFFFFFFF
      FFF1F5FE2154E81B50E8184DE7184AE41642D70F31B2FFFFFF00FFFFFF3254E2
      4B69E55470E75671E75570E8526FE74D6CE6FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF2655E72152E71C4EE61C4DE61C4CE31C46D61233B0FFFFFF00FFFFFF3759E3
      516DE75772E85973E85771E7526EE64D6AE64767E5FFFFFFFFFFFFFFFFFF2C57
      E52653E52250E51E4DE51F4DE5214EE22149D61635AFFFFFFF00FFFFFF3C5DE3
      5974E85D77E85D76E85972E7536FE64E6BE5FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF2751E4234FE4204CE3224DE3254FE1254AD51937AFFFFFFF00FFFFFF4665E5
      607AE8627CE8607AE85B74E8546EE7FFFFFFFFFFFFFFFFFF3A5CE3FFFFFFFFFF
      FFFFFFFF244DE2224BE2254DE22950E0294CD41B39AEFFFFFF00FFFFFF4665E5
      6881E96A83EA657EE95E77E8FFFFFFFFFFFFFFFFFF4361E43D5DE43658E3FFFF
      FFFFFFFFFFFFFF274EE22A50E22C51E02A4DD31C39ADFFFFFF00FFFFFF4D6AE6
      6E87EB708AEB6A83EAFFFFFFFFFFFFFFFFFF4D68E54764E4405FE43A5BE33456
      E2FFFFFFFFFFFFFFFFFF2D52E22E52DF2C4DD31D3AADFFFFFF00FFFFFF526FE7
      7991EC7C93EC718AEBC2CCF7FFFFFF5972E7536DE74D68E54664E4415FE43A5B
      E33859E3FFFFFFADBBF33155E23053DF2C4ED31D3AADFFFFFF00FFFFFF5874E8
      899DEE8DA1EF7F95ED718AEB6A83EA647DE95E78E85973E7546FE7516DE64B68
      E54A68E54463E43F60E43A5CE33456E02A4CD21836ACFFFFFF00FFFFFF657FE9
      97A9F09AACF1899DEE7A91EC728BEB6D85EA6881E9657EE8627CE9617BE95D77
      E85974E8526FE64C6AE54363E43759E1284AD21533AAFFFFFF00FFFFFF768DEC
      90A3EF94A6F0859AEE758DEB6E87EA6881EA667FE9627CE95F79E85E79E85975
      E85672E7506EE64968E53F60E43255E02346D0304BB6FFFFFF00EB9766DCE1FA
      738BEB607BE95571E74D6AE64866E54261E44463E43E5FE43E5FE43B5CE33B5C
      E33356E23356E23053E2284DE01F45DC3453D0D2D8EFFFFFFF00}
    OnClick = SpeedButton1Click
  end
  object grpPrintType: TGroupBox
    Left = 376
    Top = 72
    Width = 121
    Height = 81
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 0
    object rdoScreen: TRadioButton
      Left = 32
      Top = 28
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 73
      Top = 49
      Width = 40
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1670#1575#1662#1711#1585
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 128
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 3
    Kind = bkClose
  end
  object cmdPrint: TBitBtn
    Left = 248
    Top = 128
    Width = 105
    Height = 25
    Caption = '&'#1670#1575#1662
    TabOrder = 2
    OnClick = cmdPrintClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000CE0E0000D80E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      88888800000000000888808888888880808800000000000008080888888BBB88
      0008088888877788080800000000000008800888888888808080800000000008
      0800880FFFFFFFF080808880F00000F000088880FFFFFFFF088888880F00000F
      088888880FFFFFFFF08888888000000000888888888888888888}
  end
  object cmdSelect: TBitBtn
    Left = 8
    Top = 8
    Width = 193
    Height = 25
    Caption = '&'#1575#1606#1578#1582#1575#1576' '#1662#1585#1587#1606#1604
    TabOrder = 1
    OnClick = cmdSelectClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555555555555555555555555555555555555555FF55555555555559055555
      55555555577FF5555555555599905555555555557777F5555555555599905555
      555555557777FF5555555559999905555555555777777F555555559999990555
      5555557777777FF5555557990599905555555777757777F55555790555599055
      55557775555777FF5555555555599905555555555557777F5555555555559905
      555555555555777FF5555555555559905555555555555777FF55555555555579
      05555555555555777FF5555555555557905555555555555777FF555555555555
      5990555555555555577755555555555555555555555555555555}
    NumGlyphs = 2
  end
  object cmbName: TDBLookupComboBox
    Left = 280
    Top = 39
    Width = 197
    Height = 23
    BiDiMode = bdRightToLeft
    DataField = 'Empl_No'
    DataSource = DataSource1
    KeyField = 'Empl_No'
    ListField = 'Empl_Name'
    ListSource = DataSource2
    ParentBiDiMode = False
    TabOrder = 4
  end
  object cmbFamily: TDBLookupComboBox
    Left = 24
    Top = 39
    Width = 187
    Height = 23
    DataField = 'Empl_No'
    DataSource = DataSource1
    KeyField = 'Empl_No'
    ListField = 'Empl_Family'
    ListSource = DataSource2
    TabOrder = 5
  end
  object cmbBarCode: TDBLookupComboBox
    Left = 254
    Top = 6
    Width = 165
    Height = 23
    BiDiMode = bdLeftToRight
    DataField = 'Empl_No'
    DataSource = DataSource1
    KeyField = 'Empl_No'
    ListField = 'Empl_No'
    ListSource = DataSource2
    ParentBiDiMode = False
    TabOrder = 6
    OnMouseDown = cmbBarCodeMouseDown
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable1CalcFields
    TableName = 'Employee'
    Left = 393
    Top = 63
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
  object ADOTable2: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable1CalcFields
    TableName = 'Employee'
    Left = 361
    Top = 63
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
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 393
    Top = 95
  end
  object DataSource2: TDataSource
    DataSet = ADOTable2
    Left = 361
    Top = 95
  end
end
