object frmEditInput: TfrmEditInput
  Left = 12
  Top = 22
  HelpContext = 303
  AutoSize = True
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1589#1604#1575#1581' '#1585#1603#1608#1585#1583' '#1582#1608#1583#1585#1608#1607#1575#1610' '#1608#1585#1608#1583#1610
  ClientHeight = 317
  ClientWidth = 352
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object grpView: TGroupBox
    Left = 0
    Top = 0
    Width = 352
    Height = 206
    Align = alTop
    TabOrder = 0
    object lbl2: TLabel
      Left = 116
      Top = 11
      Width = 59
      Height = 15
      Caption = #1605#1585#1578#1576' '#1587#1575#1586#1610' :'
    end
    object dbgEdit: TDBGrid
      Left = 3
      Top = 31
      Width = 344
      Height = 139
      DataSource = dtaInput2
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDrawColumnCell = dbgEditDrawColumnCell
      OnDblClick = dbgEditDblClick
      OnKeyPress = dbgEditKeyPress
      OnMouseMove = dbgEditMouseMove
      OnTitleClick = dbgEditTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'M_BarCode'
          Title.Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'M_Number'
          Title.Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'M_Serial'
          Title.Caption = #1587#1585#1610#1575#1604
          Width = 31
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'M_IDate'
          Title.Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'M_ITime'
          Title.Caption = #1586#1605#1575#1606' '#1608#1585#1608#1583
          Width = 54
          Visible = True
        end>
    end
    object cmdEdit: TBitBtn
      Left = 205
      Top = 177
      Width = 92
      Height = 23
      Caption = #1575'&'#1589#1604#1575#1581' '#1585#1603#1608#1585#1583
      TabOrder = 1
      OnClick = cmdEditClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object cmdHelp: TBitBtn
      Left = 106
      Top = 176
      Width = 93
      Height = 23
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 2
      Kind = bkHelp
    end
    object cmdExit: TBitBtn
      Left = 7
      Top = 176
      Width = 93
      Height = 23
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 3
      Kind = bkClose
    end
    object cmbBarCode: TComboBox
      Left = 258
      Top = 8
      Width = 76
      Height = 23
      Hint = 
        #1588#1605#1575#1585#1607' '#1576#1575#1585#1705#1583' '#1585#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1576#1575' '#1586#1583#1606' '#1705#1604#1610#1583' Del '#1605#1602#1583#1575#1585' '#1575#1606 +
        #1578#1582#1575#1576' '#1588#1583#1607' '#1585#1575' '#1662#1575#1705' '#1606#1605#1575#1610#1610#1583
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = cmbBarCodeClick
      OnKeyDown = cmbBarCodeKeyDown
      OnKeyPress = cmbBarCodeKeyPress
    end
    object txtSName: TEdit
      Left = 303
      Top = 155
      Width = 79
      Height = 23
      TabOrder = 5
      Visible = False
      OnExit = cmbBarCodeClick
      OnKeyPress = txtSNameKeyPress
    end
    object txtSNumber: TEdit
      Left = 190
      Top = 8
      Width = 68
      Height = 23
      MaxLength = 6
      TabOrder = 6
      OnExit = cmbBarCodeClick
      OnKeyPress = txtSNumberKeyPress
    end
    object txtSCity: TEdit
      Left = 312
      Top = 168
      Width = 78
      Height = 23
      TabOrder = 7
      Visible = False
      OnExit = cmbBarCodeClick
      OnKeyPress = txtSNameKeyPress
    end
    object txtSSerial: TEdit
      Left = 159
      Top = 8
      Width = 31
      Height = 23
      MaxLength = 2
      TabOrder = 8
      OnExit = cmbBarCodeClick
      OnKeyPress = cmbBarCodeKeyPress
    end
    object txtSDate: TEdit
      Left = 84
      Top = 8
      Width = 75
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 9
      OnExit = txtSDateExit
      OnKeyPress = txtIDateKeyPress
    end
    object txtSTime: TEdit
      Left = 29
      Top = 8
      Width = 55
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 6
      ParentBiDiMode = False
      TabOrder = 10
      OnExit = txtSTimeExit
      OnKeyPress = txtITimeKeyPress
    end
    object txtSColor: TEdit
      Left = 303
      Top = 176
      Width = 79
      Height = 23
      TabOrder = 11
      Visible = False
      OnExit = cmbBarCodeClick
      OnKeyPress = txtSNameKeyPress
    end
    object cmdCancelFilter: TBitBtn
      Left = 4
      Top = 8
      Width = 25
      Height = 23
      Hint = #1581#1584#1601' '#1578#1605#1575#1605#1610' '#1601#1610#1604#1578#1585#1607#1575
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      TabStop = False
      OnClick = cmdCancelFilterClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 206
    Width = 352
    Height = 111
    Align = alTop
    TabOrder = 1
    object Label6: TLabel
      Left = 258
      Top = 102
      Width = 59
      Height = 15
      Caption = #1588#1607#1585' '#1582#1608#1583#1585#1608' :'
      Visible = False
    end
    object Label4: TLabel
      Left = 326
      Top = 93
      Width = 62
      Height = 15
      Caption = #1585#1606#1711' '#1582#1608#1583#1585#1608' :'
      Visible = False
    end
    object Label3: TLabel
      Left = 334
      Top = 59
      Width = 51
      Height = 15
      Caption = #1606#1575#1605' '#1582#1608#1583#1585#1608' :'
      Visible = False
    end
    object Label1: TLabel
      Left = 240
      Top = 0
      Width = 60
      Height = 15
      Caption = #1575#1589#1604#1575#1581' '#1585#1705#1608#1585#1583
    end
    object Label5: TLabel
      Left = 276
      Top = 23
      Width = 66
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
    end
    object Label7: TLabel
      Left = 104
      Top = 23
      Width = 63
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '#1587#1585#1610#1575#1604' :'
    end
    object Label8: TLabel
      Left = 286
      Top = 52
      Width = 56
      Height = 15
      Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583' :'
    end
    object Label9: TLabel
      Left = 112
      Top = 52
      Width = 55
      Height = 15
      Caption = #1586#1605#1575#1606' '#1608#1585#1608#1583' :'
    end
    object cmbName: TComboBox
      Left = 276
      Top = 38
      Width = 114
      Height = 23
      ItemHeight = 15
      TabOrder = 6
      Visible = False
      OnEnter = cmbNameEnter
      OnKeyPress = cmbNameKeyPress
    end
    object cmbColor: TComboBox
      Left = 272
      Top = 73
      Width = 113
      Height = 23
      ItemHeight = 15
      TabOrder = 7
      Visible = False
      OnEnter = cmbNameEnter
      OnKeyPress = cmbColorKeyPress
    end
    object cmbCity: TComboBox
      Left = 207
      Top = 78
      Width = 113
      Height = 23
      ItemHeight = 15
      TabOrder = 8
      Visible = False
      OnEnter = cmbNameEnter
      OnKeyPress = cmbCityKeyPress
    end
    object txtNumber: TEdit
      Left = 175
      Top = 20
      Width = 95
      Height = 23
      TabOrder = 0
      OnKeyPress = txtNumberKeyPress
    end
    object txtSerial: TEdit
      Left = 3
      Top = 20
      Width = 95
      Height = 23
      MaxLength = 2
      TabOrder = 1
      OnKeyPress = txtSNameKeyPress
    end
    object txtIDate: TEdit
      Left = 175
      Top = 49
      Width = 95
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = txtIDateExit
      OnKeyDown = txtIDateKeyDown
      OnKeyPress = txtIDateKeyPress
    end
    object txtITime: TEdit
      Left = 3
      Top = 49
      Width = 95
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 5
      ParentBiDiMode = False
      TabOrder = 3
      OnExit = txtITimeExit
      OnKeyDown = txtITimeKeyDown
      OnKeyPress = txtITimeKeyPress
    end
    object cmdSave: TBitBtn
      Left = 106
      Top = 81
      Width = 93
      Height = 22
      Caption = '&'#1579#1576#1578
      TabOrder = 4
      OnClick = cmdSaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
        055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
        305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
        30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
        3055577777555557F7F555000555555999555577755555577755}
      NumGlyphs = 2
    end
    object cmdCancel: TBitBtn
      Left = 7
      Top = 81
      Width = 93
      Height = 22
      Cancel = True
      Caption = #1575#1606'&'#1589#1585#1575#1601
      TabOrder = 5
      OnClick = cmdCancelClick
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
  end
  object dtaInput: TDataSource
    AutoEdit = False
    Left = 200
    Top = 88
  end
  object tblInput: TADOTable
    OnCalcFields = tblInputCalcFields
    TableName = 'InputCar'
    Left = 144
    Top = 88
    object tblInputM_BarCode: TStringField
      Alignment = taRightJustify
      DisplayLabel = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578' '#9660
      DisplayWidth = 10
      FieldName = 'M_BarCode'
      Size = 8
    end
    object tblInputM_CarName: TStringField
      DisplayLabel = #1606#1575#1605' '#1582#1608#1583#1585#1608
      DisplayWidth = 12
      FieldName = 'M_CarName'
      Visible = False
      Size = 15
    end
    object tblInputM_Number: TStringField
      DisplayLabel = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608
      DisplayWidth = 9
      FieldName = 'M_Number'
      Size = 6
    end
    object tblInputM_CityName: TStringField
      DisplayLabel = #1588#1607#1585
      DisplayWidth = 12
      FieldName = 'M_CityName'
      Visible = False
      Size = 15
    end
    object tblInputM_Serial: TStringField
      DisplayLabel = #1587#1585#1610#1575#1604
      FieldName = 'M_Serial'
      Size = 2
    end
    object tblInputM_Color: TStringField
      DisplayLabel = #1585#1606#1711' '#1582#1608#1583#1585#1608
      DisplayWidth = 12
      FieldName = 'M_Color'
      Visible = False
      Size = 15
    end
    object tblInputM_IDate: TStringField
      Alignment = taCenter
      DisplayLabel = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583
      FieldName = 'M_IDate'
      Size = 10
    end
    object tblInputM_ITime: TStringField
      DisplayLabel = #1586#1605#1575#1606
      FieldName = 'M_ITime'
      Size = 5
    end
    object tblInputM_IsPark: TBooleanField
      FieldName = 'M_IsPark'
      Visible = False
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Top = 40
  end
  object qryInput: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM InputCar')
    Left = 40
    Top = 96
  end
  object dtaInput2: TDataSource
    DataSet = qryInput
    Left = 56
    Top = 136
  end
end
