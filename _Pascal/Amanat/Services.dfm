object frmServices: TfrmServices
  Left = 28
  Top = 5
  HelpContext = 8
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '„⁄—›Ì Œœ„«  Ê ﬁÌ„  ê–«—Ì'
  ClientHeight = 383
  ClientWidth = 600
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
    Width = 600
    Height = 273
    Align = alTop
    TabOrder = 0
    object lbl1: TLabel
      Left = 557
      Top = 16
      Width = 34
      Height = 15
      Caption = 'Ã&” ÃÊ'
      FocusControl = txtSearch
    end
    object dbgService: TDBGrid
      Left = 112
      Top = 48
      Width = 481
      Height = 217
      DataSource = dtaService
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = cmdEditClick
      OnKeyDown = dbgServiceKeyDown
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'S_Code'
          Title.Alignment = taCenter
          Title.Caption = 'ﬂœ'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'S_Name'
          Title.Alignment = taCenter
          Title.Caption = '⁄‰Ê«‰'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UnitName'
          Title.Alignment = taCenter
          Title.Caption = 'Ê«Õœ'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'S_Price'
          Title.Alignment = taCenter
          Title.Caption = '„»·€'
          Width = 115
          Visible = True
        end>
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 80
      Width = 97
      Height = 25
      Caption = '&ÃœÌœ'
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
      Caption = '«&’·«Õ'
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
      Caption = '&Õ–›'
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
      Caption = '—«&Â‰„«'
      TabOrder = 5
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 240
      Width = 97
      Height = 25
      Caption = '&Œ—ÊÃ'
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
    Width = 600
    Height = 80
    Align = alTop
    TabOrder = 1
    object lbl3: TLabel
      Left = 303
      Top = 16
      Width = 24
      Height = 15
      Caption = '&⁄‰Ê«‰'
      FocusControl = txtName
    end
    object lbl2: TLabel
      Left = 570
      Top = 16
      Width = 13
      Height = 15
      Caption = '&ﬂœ'
      FocusControl = txtCode
    end
    object lbl4: TLabel
      Left = 570
      Top = 48
      Width = 20
      Height = 15
      Caption = '„»·€'
    end
    object lbl5: TLabel
      Left = 307
      Top = 48
      Width = 19
      Height = 15
      Caption = 'Ê«Õœ'
    end
    object txtName: TEdit
      Left = 112
      Top = 16
      Width = 185
      Height = 23
      MaxLength = 20
      TabOrder = 1
      OnKeyPress = txtNameKeyPress
    end
    object cmdCancel: TBitBtn
      Left = 8
      Top = 48
      Width = 97
      Height = 25
      Cancel = True
      Caption = '&«‰’—«›'
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
    object cmdSave: TBitBtn
      Left = 8
      Top = 16
      Width = 97
      Height = 25
      Caption = '&À» '
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
    object txtCode: TEdit
      Left = 472
      Top = 16
      Width = 89
      Height = 23
      MaxLength = 20
      TabOrder = 0
      OnKeyPress = txtCodeKeyPress
    end
    object txtPrice: TEdit
      Left = 440
      Top = 47
      Width = 121
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = txtCodeKeyPress
    end
    object cmbUnits: TComboBox
      Left = 112
      Top = 48
      Width = 185
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 3
      OnKeyDown = cmbUnitsKeyDown
    end
  end
  object dtaService: TDataSource
    DataSet = atblService
    Left = 344
    Top = 120
  end
  object atblService: TADOTable
    CursorType = ctStatic
    OnCalcFields = atblServiceCalcFields
    IndexFieldNames = 'S_Code'
    TableName = 'Services'
    Left = 272
    Top = 120
    object atblServiceS_Code: TIntegerField
      FieldName = 'S_Code'
    end
    object atblServiceS_Name: TWideStringField
      FieldName = 'S_Name'
      Size = 40
    end
    object atblServiceS_Price: TBCDField
      FieldName = 'S_Price'
      Precision = 19
    end
    object atblServiceS_Unit: TIntegerField
      FieldName = 'S_Unit'
    end
    object atblServiceUnitName: TStringField
      FieldKind = fkCalculated
      FieldName = 'UnitName'
      Size = 30
      Calculated = True
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 16
  end
end
