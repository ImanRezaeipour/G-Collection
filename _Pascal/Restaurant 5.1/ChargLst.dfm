object frmchargLst: TfrmchargLst
  Left = 256
  Top = 115
  BiDiMode = bdRightToLeft
  BorderStyle = bsSingle
  Caption = #1583#1608#1585#1607' '#1588#1575#1585#1688
  ClientHeight = 408
  ClientWidth = 671
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pan_dbg: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 408
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Align = alClient
    TabOrder = 0
    object d: TDBGrid
      AlignWithMargins = True
      Left = 8
      Top = 64
      Width = 655
      Height = 295
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 7
      Align = alClient
      BiDiMode = bdRightToLeft
      DataSource = dtaCharge
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentBiDiMode = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object pan_con: TPanel
      Left = 1
      Top = 366
      Width = 669
      Height = 41
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        669
        41)
      object btnnewd: TBitBtn
        Left = 557
        Top = 9
        Width = 104
        Height = 25
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #1580#1583#1576#1583
        TabOrder = 0
        OnClick = btnnewdClick
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
      object btn_del: TBitBtn
        Left = 451
        Top = 9
        Width = 100
        Height = 25
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #1581#1584#1601' '
        TabOrder = 1
        OnClick = btn_delClick
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
      object cmdClose: TBitBtn
        Left = 7
        Top = 9
        Width = 97
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '&'#1582#1585#1608#1580
        TabOrder = 2
        Kind = bkClose
      end
    end
    object grpAll: TGroupBox
      Left = 1
      Top = 1
      Width = 669
      Height = 56
      Align = alTop
      Caption = #1580#1587#1578#1580#1608
      TabOrder = 2
      object Label6: TLabel
        Left = 633
        Top = 24
        Width = 21
        Height = 13
        Caption = '&'#1578#1575#1585#1610#1582
        FocusControl = txtSrchDate
      end
      object Label9: TLabel
        Left = 442
        Top = 24
        Width = 71
        Height = 13
        Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
        FocusControl = txtSrchPCode
      end
      object lbl06: TLabel
        Left = 198
        Top = 24
        Width = 55
        Height = 13
        Caption = '&'#1605#1585#1578#1576' '#1587#1575#1586#1610
      end
      object txtSrchDate: TEdit
        Left = 539
        Top = 21
        Width = 85
        Height = 21
        BiDiMode = bdLeftToRight
        MaxLength = 10
        ParentBiDiMode = False
        TabOrder = 0
        OnExit = txtSrchDateExit
        OnKeyPress = txtSrchDateKeyPress
      end
      object txtSrchPCode: TEdit
        Left = 343
        Top = 21
        Width = 93
        Height = 21
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 1
        OnExit = txtSrchDateExit
      end
      object cmbSort: TComboBox
        Left = 71
        Top = 21
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = cmbSortChange
        Items.Strings = (
          #1578#1575#1585#1610#1582'-'#1586#1605#1575#1606
          #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
          #13#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
          #1605#1576#1604#1594' '#1588#1575#1585#1688
          #1575#1662#1585#1575#1578#1608#1585' '#1588#1575#1585#1688#10)
      end
      object cmbSort2: TComboBox
        Left = 7
        Top = 21
        Width = 58
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnChange = cmbSortChange
        Items.Strings = (
          #1589#1593#1608#1583#1610
          #1606#1586#1608#1604#1610)
      end
    end
  end
  object adoQrycharge: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;User ID=sa;Initial Catalog=restest;Data Source=.'
    CursorType = ctStatic
    OnCalcFields = adoQrychargeCalcFields
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Charge.*,FamilyName = persons.p_family + '#39' - '#39' + persons.' +
        'p_name  FROM Charge,persons'
      'where ch_barcode = p_barcode'
      'order by ch_date,ch_Time')
    Left = 56
    Top = 64
    object adoQrychargech_barcode: TWideStringField
      DisplayLabel = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      DisplayWidth = 17
      FieldName = 'ch_barcode'
      Size = 8
    end
    object adoQrychargeFamilyName: TWideStringField
      DisplayLabel = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1740' - '#1606#1575#1605
      FieldName = 'FamilyName'
      ReadOnly = True
      Size = 40
    end
    object adoQrychargech_Price: TBCDField
      DisplayLabel = #1605#1576#1604#1594' '#1588#1575#1585#1688
      DisplayWidth = 21
      FieldName = 'ch_Price'
      Precision = 19
    end
    object adoQrychargech_Date: TWideStringField
      DisplayLabel = #1578#1575#1585#1610#1582
      DisplayWidth = 16
      FieldName = 'ch_Date'
      Size = 10
    end
    object adoQrychargetime: TStringField
      DisplayLabel = #1586#1605#1575#1606
      DisplayWidth = 9
      FieldKind = fkCalculated
      FieldName = 'time'
      Calculated = True
    end
    object adoQrychargech_User: TWideStringField
      DisplayLabel = #1575#1662#1585#1575#1578#1608#1585' '#1588#1575#1585#1688
      DisplayWidth = 15
      FieldName = 'ch_User'
    end
    object adoQrychargech_time: TIntegerField
      DisplayLabel = #1586#1605#1575#1606
      DisplayWidth = 11
      FieldName = 'ch_time'
      Visible = False
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 64
  end
  object dtaCharge: TDataSource
    DataSet = adoQrycharge
    Left = 56
    Top = 96
  end
end
