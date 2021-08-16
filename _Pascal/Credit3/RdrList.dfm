object frmReaders: TfrmReaders
  Left = 153
  Top = 93
  HelpContext = 4
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1578#1585#1605#1610#1606#1575#1604#1607#1575
  ClientHeight = 458
  ClientWidth = 601
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpList: TGroupBox
    Left = 0
    Top = 0
    Width = 601
    Height = 289
    Align = alTop
    TabOrder = 0
    object dbgReaders: TDBGrid
      Left = 8
      Top = 16
      Width = 585
      Height = 233
      Hint = 'Doublle Click = '#1578#1594#1610#1610#1585' '#1608#1590#1593#1610#1578
      DataSource = dtaReaders
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = dbgReadersDblClick
      OnKeyDown = dbgReadersKeyDown
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Rdr_Code'
          Title.Alignment = taCenter
          Title.Caption = #1603#1583
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Rdr_Name'
          Title.Alignment = taCenter
          Title.Caption = #1606#1575#1605' '#1578#1585#1605#1610#1606#1575#1604
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Depart'
          Title.Alignment = taCenter
          Title.Caption = #1605#1585#1603#1586
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Type'
          Title.Alignment = taCenter
          Title.Caption = #1606#1608#1593
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Active'
          Title.Alignment = taCenter
          Title.Caption = #1608#1590#1593#1610#1578
          Width = 60
          Visible = True
        end>
    end
    object cmdNew: TBitBtn
      Left = 504
      Top = 256
      Width = 90
      Height = 25
      Caption = #1583#1587#1578#1711#1575#1607' &'#1580#1583#1610#1583
      TabOrder = 1
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
    object cmdEdit: TBitBtn
      Left = 412
      Top = 256
      Width = 90
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581' '#1583#1587#1578#1711#1575#1607
      TabOrder = 2
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
    object cmdDelete: TBitBtn
      Left = 320
      Top = 256
      Width = 90
      Height = 25
      Caption = '&'#1581#1584#1601' '#1583#1587#1578#1711#1575#1607
      TabOrder = 3
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
    object cmdHelp: TBitBtn
      Left = 92
      Top = 256
      Width = 77
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 4
      Visible = False
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 256
      Width = 84
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 5
      Kind = bkClose
    end
    object btnTestLink: TBitBtn
      Left = 227
      Top = 256
      Width = 88
      Height = 25
      Caption = #1578#1587#1578' '#1575#1585#1578#1576#1575#1591
      TabOrder = 6
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
  end
  object grpInf: TGroupBox
    Left = 0
    Top = 289
    Width = 601
    Height = 166
    Align = alTop
    TabOrder = 1
    object lbl1: TLabel
      Left = 577
      Top = 17
      Width = 9
      Height = 15
      Caption = '&'#1603#1583
      FocusControl = txtCode
    end
    object lbl2: TLabel
      Left = 580
      Top = 49
      Width = 10
      Height = 15
      Caption = '&'#1606#1575#1605
      FocusControl = txtName
    end
    object lbl4: TLabel
      Left = 271
      Top = 19
      Width = 50
      Height = 15
      Caption = '&'#1606#1608#1593' '#1578#1585#1605#1610#1606#1575#1604
      FocusControl = cmbType
    end
    object Label1: TLabel
      Left = 274
      Top = 55
      Width = 117
      Height = 15
      Caption = #1582#1591' '#1578#1604#1601#1606' '#1605#1578#1589#1604' '#1576#1607' '#1583#1587#1578#1711#1575#1607' :'
      FocusControl = txtTel
      OnClick = cmdCancelClick
    end
    object cmdSave: TBitBtn
      Left = 8
      Top = 96
      Width = 73
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 8
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
      Left = 8
      Top = 128
      Width = 73
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 9
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
    object txtCode: TEdit
      Left = 512
      Top = 16
      Width = 58
      Height = 23
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyPress = txtCodeKeyPress
    end
    object txtName: TEdit
      Left = 416
      Top = 48
      Width = 153
      Height = 23
      MaxLength = 40
      TabOrder = 1
      OnKeyPress = txtNameKeyPress
    end
    object cmbType: TComboBox
      Left = 112
      Top = 16
      Width = 154
      Height = 23
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 2
      Items.Strings = (
        #1578#1585#1605#1610#1606#1575#1604' '#1575#1593#1578#1576#1575#1585#1610' 9300'
        #1578#1585#1605#1610#1606#1575#1604' '#1705#1583' '#1711#1584#1575#1585' '#1705#1575#1585#1578)
    end
    object chkActive: TCheckBox
      Left = 24
      Top = 35
      Width = 49
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = #1601#1593#1575#1604
      ParentBiDiMode = False
      TabOrder = 3
    end
    object rdoComLan: TRadioGroup
      Left = 320
      Top = 80
      Width = 105
      Height = 73
      Caption = #1606#1581#1608#1607' '#1575#1585#1578#1576#1575#1591
      ItemIndex = 0
      Items.Strings = (
        #1583#1585#1711#1575#1607' '#1587#1585#1610#1575#1604
        #1603#1575#1585#1578' '#1588#1576#1603#1607)
      TabOrder = 5
      OnClick = rdoComLanClick
    end
    object grpLan: TGroupBox
      Left = 88
      Top = 96
      Width = 225
      Height = 57
      TabOrder = 7
      object lbl6: TLabel
        Left = 10
        Top = 32
        Width = 60
        Height = 15
        Caption = 'IP Address'
      end
      object mskIP: TMaskEdit
        Left = 80
        Top = 24
        Width = 136
        Height = 23
        BiDiMode = bdLeftToRight
        EditMask = '000\.000\.000\.000;1;_'
        MaxLength = 15
        ParentBiDiMode = False
        TabOrder = 0
        Text = '   .   .   .   '
        OnKeyPress = mskIPKeyPress
      end
    end
    object grpDepartment: TGroupBox
      Left = 432
      Top = 79
      Width = 161
      Height = 73
      Caption = #1605#1585#1603#1586
      TabOrder = 4
      object cmbDepartment: TComboBox
        Left = 8
        Top = 32
        Width = 145
        Height = 23
        Style = csDropDownList
        ItemHeight = 15
        TabOrder = 0
        OnKeyDown = cmbDepartmentKeyDown
      end
    end
    object grpCom: TGroupBox
      Left = 88
      Top = 80
      Width = 225
      Height = 73
      TabOrder = 6
      object lbl5: TLabel
        Left = 154
        Top = 17
        Width = 63
        Height = 15
        Caption = #1587#1585#1593#1578'  '#1575#1585#1578#1576#1575#1591
        FocusControl = cmbBaud
      end
      object lbl3: TLabel
        Left = 155
        Top = 40
        Width = 62
        Height = 15
        Caption = '&'#1662#1608#1585#1578' '#1575#1585#1578#1576#1575#1591#1610
        FocusControl = cmbPort
      end
      object cmbBaud: TComboBox
        Left = 8
        Top = 16
        Width = 129
        Height = 23
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemHeight = 15
        MaxLength = 5
        ParentBiDiMode = False
        TabOrder = 0
      end
      object cmbPort: TComboBox
        Left = 8
        Top = 40
        Width = 129
        Height = 23
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemHeight = 15
        ParentBiDiMode = False
        TabOrder = 1
      end
    end
    object txtTel: TEdit
      Left = 113
      Top = 51
      Width = 153
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 40
      ParentBiDiMode = False
      TabOrder = 10
      OnKeyPress = txtTelKeyPress
    end
  end
  object dtaReaders: TDataSource
    DataSet = atblReaders
    Left = 304
    Top = 72
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 48
    Top = 104
  end
  object atblReaders: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = atblReadersCalcFields
    IndexFieldNames = 'Rdr_Code'
    TableName = 'Readers'
    Left = 224
    Top = 72
    object atblReadersRdr_Code: TIntegerField
      FieldName = 'Rdr_Code'
    end
    object atblReadersRdr_Name: TWideStringField
      FieldName = 'Rdr_Name'
      Size = 40
    end
    object atblReadersRdr_DpType: TIntegerField
      FieldName = 'Rdr_DpType'
    end
    object atblReadersRdr_ComPort: TIntegerField
      FieldName = 'Rdr_ComPort'
    end
    object atblReadersRdr_BaudRate: TIntegerField
      FieldName = 'Rdr_BaudRate'
    end
    object atblReadersRdr_IP: TWideStringField
      FieldName = 'Rdr_IP'
      Size = 15
    end
    object atblReadersRdr_IsCom: TBooleanField
      FieldName = 'Rdr_IsCom'
    end
    object atblReadersRdr_Active: TBooleanField
      FieldName = 'Rdr_Active'
    end
    object atblReadersActive: TStringField
      FieldKind = fkCalculated
      FieldName = 'Active'
      Size = 15
      Calculated = True
    end
    object atblReadersType: TStringField
      FieldKind = fkCalculated
      FieldName = 'Type'
      Size = 40
      Calculated = True
    end
    object atblReadersRdr_Department: TIntegerField
      FieldName = 'Rdr_Department'
    end
    object atblReadersDepart: TStringField
      FieldKind = fkCalculated
      FieldName = 'Depart'
      Size = 50
      Calculated = True
    end
    object atblReadersRdr_Tel: TWideStringField
      FieldName = 'Rdr_Tel'
      Size = 40
    end
  end
end
