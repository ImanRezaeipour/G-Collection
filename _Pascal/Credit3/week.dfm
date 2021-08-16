object frmWeek: TfrmWeek
  Left = 28
  Top = 5
  HelpContext = 8
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1576#1585#1606#1575#1605#1607' '#1607#1575#1610' '#1607#1601#1578#1711#1610
  ClientHeight = 574
  ClientWidth = 604
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 604
    Height = 273
    Align = alTop
    TabOrder = 0
    object lbl1: TLabel
      Left = 561
      Top = 16
      Width = 30
      Height = 15
      Caption = #1580'&'#1587#1578#1580#1608
      FocusControl = txtSearch
    end
    object dbgWeek: TDBGrid
      Left = 111
      Top = 50
      Width = 480
      Height = 217
      DataSource = dtaWeek
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = cmdEditClick
      OnKeyDown = dbgWeekKeyDown
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'W_Code'
          Title.Alignment = taCenter
          Title.Caption = #1603#1583
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'W_Name'
          Title.Alignment = taCenter
          Title.Caption = #1593#1606#1608#1575#1606
          Width = 374
          Visible = True
        end>
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 80
      Width = 97
      Height = 25
      Caption = '&'#1580#1583#1610#1583
      TabOrder = 2
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
      Left = 8
      Top = 112
      Width = 97
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581
      TabOrder = 3
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
      Left = 8
      Top = 144
      Width = 97
      Height = 25
      Caption = '&'#1581#1584#1601
      TabOrder = 4
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
      Left = 8
      Top = 208
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 5
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 240
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 6
      Kind = bkClose
    end
    object txtSearch: TEdit
      Left = 360
      Top = 16
      Width = 193
      Height = 23
      TabOrder = 0
      OnChange = txtSearchChange
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = 273
    Width = 604
    Height = 288
    Align = alTop
    TabOrder = 1
    object lbl3: TLabel
      Left = 429
      Top = 19
      Width = 26
      Height = 15
      Caption = '&'#1593#1606#1608#1575#1606
      FocusControl = txtName
    end
    object lbl2: TLabel
      Left = 574
      Top = 20
      Width = 9
      Height = 15
      Caption = '&'#1603#1583
      FocusControl = txtCode
    end
    object lbl25: TLabel
      Left = 98
      Top = 19
      Width = 29
      Height = 15
      Alignment = taRightJustify
      Caption = #1580#1606#1587#1610#1578
      FocusControl = cmbSex
      ParentShowHint = False
      ShowHint = True
    end
    object txtName: TEdit
      Left = 152
      Top = 16
      Width = 270
      Height = 23
      MaxLength = 20
      TabOrder = 1
      OnKeyPress = txtNameKeyPress
    end
    object cmdCancel: TBitBtn
      Left = 8
      Top = 248
      Width = 97
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 4
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
    object cmdSave: TBitBtn
      Left = 8
      Top = 216
      Width = 97
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 3
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
    object txtCode: TEdit
      Left = 472
      Top = 16
      Width = 89
      Height = 23
      MaxLength = 20
      TabOrder = 0
      OnKeyPress = txtCodeKeyPress
    end
    object grdWeek: TXStringGrid
      Left = 111
      Top = 55
      Width = 450
      Height = 218
      ColCount = 9
      RowCount = 8
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goEditing, goAlwaysShowEditor]
      TabOrder = 5
      FixedLineColor = clBlack
      Columns = <
        item
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1585#1608#1586' '#1607#1601#1578#1607
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Alignment = taRightJustify
        end
        item
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1588#1585#1608#1593
          Width = 41
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Alignment = taRightJustify
          Editor = MaskEditCellEditor1
        end
        item
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1662#1575#1610#1575#1606
          Width = 44
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Editor = MaskEditCellEditor1
        end
        item
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1588#1585#1608#1593
          Width = 45
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Editor = MaskEditCellEditor1
        end
        item
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1662#1575#1610#1575#1606
          Width = 44
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Editor = MaskEditCellEditor1
        end
        item
          HeaderFont.Charset = ARABIC_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1588#1585#1608#1593
          Width = 44
          Font.Charset = ARABIC_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Editor = MaskEditCellEditor1
        end
        item
          HeaderFont.Charset = ARABIC_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1662#1575#1610#1575#1606
          Width = 44
          Font.Charset = ARABIC_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Editor = MaskEditCellEditor1
        end
        item
          HeaderFont.Charset = ARABIC_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1588#1585#1608#1593
          Width = 44
          Font.Charset = ARABIC_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Editor = MaskEditCellEditor1
        end
        item
          HeaderFont.Charset = ARABIC_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          HeaderAlignment = taCenter
          Caption = #1662#1575#1610#1575#1606
          Width = 44
          Font.Charset = ARABIC_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Editor = MaskEditCellEditor1
        end>
      MultiLine = False
      ImmediateEditMode = True
      ColWidths = (
        64
        41
        44
        45
        44
        44
        44
        44
        44)
      RowHeights = (
        24
        24
        24
        24
        24
        24
        24
        24)
    end
    object cmbSex: TComboBox
      Left = 20
      Top = 16
      Width = 72
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Items.Strings = (
        #1605#1585#1583
        #1586#1606)
    end
  end
  object dtaWeek: TDataSource
    DataSet = atblWeek
    Left = 344
    Top = 120
  end
  object atblWeek: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Credit;Data Source=KOMEIL'
    CursorType = ctStatic
    TableName = 'Weeks'
    Left = 272
    Top = 120
    object atblWeekW_Code: TIntegerField
      FieldName = 'W_Code'
    end
    object atblWeekW_Name: TWideStringField
      FieldName = 'W_Name'
      Size = 40
    end
    object atblWeekW_prgDay1: TWideStringField
      FieldName = 'W_prgDay1'
      Size = 60
    end
    object atblWeekW_prgDay2: TWideStringField
      FieldName = 'W_prgDay2'
      Size = 60
    end
    object atblWeekW_prgDay3: TWideStringField
      FieldName = 'W_prgDay3'
      Size = 60
    end
    object atblWeekW_prgDay4: TWideStringField
      FieldName = 'W_prgDay4'
      Size = 60
    end
    object atblWeekW_prgDay5: TWideStringField
      FieldName = 'W_prgDay5'
      Size = 60
    end
    object atblWeekW_prgDay6: TWideStringField
      FieldName = 'W_prgDay6'
      Size = 60
    end
    object atblWeekW_prgDay7: TWideStringField
      FieldName = 'W_prgDay7'
      Size = 60
    end
    object atblWeekW_Sex: TSmallintField
      FieldName = 'W_Sex'
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 56
    Top = 24
  end
  object MaskEditCellEditor1: TMaskEditCellEditor
    DefaultText = '00:00'
    EditMask = '!90:00;1;_'
    Left = 568
    Top = 400
  end
end
