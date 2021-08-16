object frmInitCard: TfrmInitCard
  Left = 0
  Top = 0
  BiDiMode = bdRightToLeft
  Caption = #1589#1583#1608#1585' '#1705#1575#1585#1578' '
  ClientHeight = 420
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 632
    Height = 345
    Align = alTop
    Caption = #1580#1587#1578#1580#1608
    TabOrder = 1
    object Bevel1: TBevel
      Left = 1
      Top = 52
      Width = 629
      Height = 5
      Shape = bsTopLine
    end
    object Label1: TLabel
      Left = 547
      Top = 22
      Width = 71
      Height = 13
      Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FocusControl = txtSearchCode
    end
    object lbl2: TLabel
      Left = 312
      Top = 22
      Width = 58
      Height = 13
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583'&'#1711#1610
      FocusControl = txtSearchFamily
    end
    object lblRecNo: TLabel
      Left = 48
      Top = 124
      Width = 39
      Height = 15
      Caption = #1578#1593#1583#1575#1583' : 0'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInfo: TLabel
      Left = 8
      Top = 252
      Width = 113
      Height = 15
      Alignment = taCenter
      AutoSize = False
      Caption = #1705#1575#1585#1578' '#1576#1575' '#1605#1608#1601#1602#1610#1578' '#1705#1583' '#1588#1583' .'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnCharge: TBitBtn
      Left = 8
      Top = 191
      Width = 111
      Height = 25
      Caption = #1588#1575#1585#1688' '#1705#1575#1585#1578
      TabOrder = 3
      OnClick = btnChargeClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      NumGlyphs = 2
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 311
      Width = 111
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 4
      TabStop = False
      Kind = bkClose
    end
    object cmdHelp: TBitBtn
      Left = 8
      Top = 283
      Width = 111
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 5
      TabStop = False
      Kind = bkHelp
    end
    object cmdDelete: TBitBtn
      Left = 8
      Top = 89
      Width = 111
      Height = 25
      Caption = #1581#1584#1601
      TabOrder = 6
      TabStop = False
      OnClick = cmdDeleteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
        305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
        B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
        B0557777FF577777F7F500000E055550805577777F7555575755500000555555
        05555777775555557F5555000555555505555577755555557555}
      NumGlyphs = 2
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 61
      Width = 111
      Height = 25
      Caption = #1575#1601#1586#1608#1583#1606
      TabOrder = 7
      TabStop = False
      OnClick = cmdNewClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
    end
    object txtSearchCode: TEdit
      Left = 408
      Top = 21
      Width = 137
      Height = 21
      BiDiMode = bdLeftToRight
      MaxLength = 13
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = txtSearchCodeKeyPress
    end
    object txtSearchFamily: TEdit
      Left = 160
      Top = 21
      Width = 145
      Height = 21
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      TabOrder = 1
    end
    object dbgPersons: TDBGrid
      Left = 125
      Top = 60
      Width = 499
      Height = 277
      TabStop = False
      DataSource = dtaSrc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnTitleClick = dbgPersonsTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Empl_No'
          Title.Alignment = taCenter
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Empl_ID'
          Title.Alignment = taCenter
          Width = 83
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Empl_Name'
          Title.Alignment = taCenter
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Empl_Family'
          Title.Alignment = taCenter
          Width = 139
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status'
          Title.Alignment = taCenter
          Width = 86
          Visible = True
        end>
    end
  end
  object grpCom: TGroupBox
    Left = 0
    Top = 345
    Width = 632
    Height = 57
    Align = alTop
    Caption = ' '#1578#1606#1592#1610#1605#1575#1578' '#1575#1585#1578#1576#1575#1591' '#1576#1575' '#1583#1587#1578#1711#1575#1607' '
    TabOrder = 0
    object lbl1: TLabel
      Left = 589
      Top = 27
      Width = 32
      Height = 13
      Caption = '&'#1578#1585#1605#1610#1606#1575#1604
      FocusControl = cmbReaders
    end
    object btnTestLink: TBitBtn
      Left = 305
      Top = 21
      Width = 121
      Height = 25
      Caption = #1578#1587#1578' '#1575#1585#1578#1576#1575#1591
      TabOrder = 0
      TabStop = False
      OnClick = btnTestLinkClick
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
    object cmbReaders: TComboBox
      Left = 432
      Top = 23
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 1
      TabStop = False
    end
    object chkPrint: TCheckBox
      Left = 92
      Top = 10
      Width = 192
      Height = 17
      TabStop = False
      Caption = #1670#1575#1662' '#1605#1588#1582#1589#1575#1578'  '#1608' '#1585#1605#1586' '#1593#1576#1608#1585
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkPass: TCheckBox
      Left = 39
      Top = 33
      Width = 245
      Height = 17
      TabStop = False
      Caption = #1585#1605#1586#1593#1576#1608#1585' = '#1670#1607#1575#1585' '#1585#1602#1605' '#1587#1605#1578' '#1585#1575#1587#1578' '#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' '
      TabOrder = 3
    end
  end
  object BTNcANCEL: TBitBtn
    Left = 8
    Top = 219
    Width = 111
    Height = 26
    Caption = #1575#1606#1589#1585#1575#1601
    TabOrder = 2
    TabStop = False
    OnClick = BTNcANCELClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
      33333337777FF377FF3333993370739993333377FF373F377FF3399993000339
      993337777F777F3377F3393999707333993337F77737333337FF993399933333
      399377F3777FF333377F993339903333399377F33737FF33377F993333707333
      399377F333377FF3377F993333101933399377F333777FFF377F993333000993
      399377FF3377737FF7733993330009993933373FF3777377F7F3399933000399
      99333773FF777F777733339993707339933333773FF7FFF77333333999999999
      3333333777333777333333333999993333333333377777333333}
    NumGlyphs = 2
  end
  object prgrs: TProgressBar
    Left = 0
    Top = 402
    Width = 632
    Height = 18
    Align = alClient
    Max = 10
    TabOrder = 3
  end
  object adoQry: TADOQuery
    CursorType = ctStatic
    OnCalcFields = adoQryCalcFields
    OnFilterRecord = adoQryFilterRecord
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM EMPLOYEE WHERE EMPL_ID <> '#39#39' AND EMPL_ACTIVE = 1')
    Left = 384
    Top = 136
    object adoQryEmpl_No: TWideStringField
      Alignment = taCenter
      DisplayLabel = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      DisplayWidth = 14
      FieldName = 'Empl_No'
      Size = 8
    end
    object adoQryEmpl_ID: TWideStringField
      Alignment = taRightJustify
      DisplayLabel = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578' '
      DisplayWidth = 17
      FieldName = 'Empl_ID'
      Size = 15
    end
    object adoQryEmpl_Name: TWideStringField
      DisplayLabel = #1606#1575#1605' '
      DisplayWidth = 16
      FieldName = 'Empl_Name'
      Size = 15
    end
    object adoQryEmpl_Family: TWideStringField
      DisplayLabel = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
      DisplayWidth = 27
      FieldName = 'Empl_Family'
      Size = 25
    end
    object adoQrystatus: TStringField
      DisplayLabel = #1608#1590#1593#1610#1578
      FieldKind = fkCalculated
      FieldName = 'status'
      Calculated = True
    end
    object adoQryEmpl_Active: TBooleanField
      FieldName = 'Empl_Active'
      Visible = False
    end
    object adoQryEmpl_Department: TIntegerField
      FieldName = 'Empl_Department'
      Visible = False
    end
    object adoQryEmpl_CoPost: TIntegerField
      FieldName = 'Empl_CoPost'
      Visible = False
    end
    object adoQryEmpl_Part: TIntegerField
      FieldName = 'Empl_Part'
      Visible = False
    end
    object adoQryEmpl_Dscnt: TIntegerField
      FieldName = 'Empl_Dscnt'
      Visible = False
    end
    object adoQryEmpl_ExpDate: TWideStringField
      FieldName = 'Empl_ExpDate'
      Visible = False
      Size = 10
    end
    object adoQryEmpl_Balance: TBCDField
      FieldName = 'Empl_Balance'
      Visible = False
      Precision = 19
    end
  end
  object dtaSrc: TDataSource
    DataSet = adoQry
    Left = 424
    Top = 136
  end
  object tmrReadCard: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrReadCardTimer
    Left = 8
    Top = 136
  end
end
