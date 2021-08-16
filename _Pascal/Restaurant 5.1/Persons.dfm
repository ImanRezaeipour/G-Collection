object frmPersons: TfrmPersons
  Left = 274
  Top = 172
  HelpContext = 103
  BiDiMode = bdRightToLeft
  BorderIcons = [biSystemMenu]
  Caption = #1605#1593#1585#1601#1610' '#1662#1585#1587#1606#1604
  ClientHeight = 401
  ClientWidth = 632
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
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 632
    Height = 401
    Align = alClient
    TabOrder = 0
    DesignSize = (
      632
      401)
    object Label7: TLabel
      Left = 513
      Top = 52
      Width = 34
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1603#1583' '#1576#1582#1588
      FocusControl = cmbPartCode
      ExplicitLeft = 416
    end
    object Label6: TLabel
      Left = 552
      Top = 20
      Width = 59
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FocusControl = txtSearchCode
      ExplicitLeft = 455
    end
    object Bevel1: TBevel
      Left = 1
      Top = 80
      Width = 627
      Height = 5
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 522
    end
    object Label2: TLabel
      Left = 588
      Top = 1
      Width = 30
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1580#1587#1578#1580#1608
      Font.Charset = ARABIC_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 491
    end
    object Label3: TLabel
      Left = 332
      Top = 52
      Width = 35
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1606#1575#1605' '#1576#1582#1588
      FocusControl = cmbPartName
      ExplicitLeft = 235
    end
    object lblRecNo: TLabel
      Left = 63
      Top = 302
      Width = 39
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = #1578#1593#1583#1575#1583' : 0'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 264
    end
    object Label9: TLabel
      Left = 398
      Top = 20
      Width = 53
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583'&'#1711#1610
      FocusControl = txtSearchFamily
      ExplicitLeft = 301
    end
    object Label12: TLabel
      Left = 207
      Top = 20
      Width = 52
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1588#1605#1575#1585#1607' '#1705#1575#1585#1578
      FocusControl = txtsearchcard
      ExplicitLeft = 110
    end
    object cmdNew: TBitBtn
      Left = 8
      Top = 88
      Width = 97
      Height = 25
      Caption = #1662#1585#1587#1606#1604' &'#1580#1583#1610#1583
      TabOrder = 6
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
      Top = 152
      Width = 97
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581' '#1662#1585#1587#1606#1604
      TabOrder = 8
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
      Top = 184
      Width = 97
      Height = 25
      Caption = '&'#1581#1584#1601' '#1662#1585#1587#1606#1604
      TabOrder = 9
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
      Top = 334
      Width = 97
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 11
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 366
      Width = 97
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 12
      Kind = bkClose
    end
    object cmbPartCode: TComboBox
      Left = 408
      Top = 49
      Width = 97
      Height = 23
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 3
      OnClick = cmbPartCodeClick
      OnExit = cmbPartCodeClick
      OnKeyPress = cmbPartCodeKeyPress
    end
    object cmbPartName: TComboBox
      Left = 177
      Top = 48
      Width = 145
      Height = 23
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 4
      OnClick = cmbPartNameClick
      OnExit = cmbPartNameClick
      OnKeyPress = cmbPartCodeKeyPress
    end
    object txtSearchCode: TEdit
      Left = 457
      Top = 17
      Width = 89
      Height = 23
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
      OnExit = txtSearchCodeExit
      OnKeyPress = txtSearchCodeKeyPress
    end
    object cmdListNew: TBitBtn
      Left = 8
      Top = 120
      Width = 97
      Height = 25
      Caption = #1662#1585#1587#1606#1604' &'#1604#1610#1587#1578#1610
      TabOrder = 7
      OnClick = cmdListNewClick
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
    object cmdFixPCode: TBitBtn
      Left = 8
      Top = 216
      Width = 97
      Height = 25
      Caption = '&'#1576#1575#1586#1582#1608#1575#1606#1610' '#1603#1583#1607#1575
      TabOrder = 10
      OnClick = cmdFixPCodeClick
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
    object txtSearchFamily: TEdit
      Left = 265
      Top = 16
      Width = 129
      Height = 23
      Anchors = [akTop, akRight]
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      TabOrder = 1
      OnExit = txtSearchCodeExit
      OnKeyPress = txtSearchFamilyKeyPress
    end
    object dbgPersons: TDBGrid
      Left = 111
      Top = 93
      Width = 514
      Height = 305
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dtaPersons
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 5
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = cmdEditClick
      OnKeyDown = dbgPersonsKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'P_BarCode'
          Title.Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_Proxi'
          Title.Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_Name'
          Title.Caption = #1606#1575#1605
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'P_Family'
          Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
          Width = 116
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'P_Credit'
          Title.Alignment = taCenter
          Title.Caption = #1605#1575#1606#1583#1607' '#1575#1593#1578#1576#1575#1585
          Width = 119
          Visible = True
        end>
    end
    object txtsearchcard: TEdit
      Left = 105
      Top = 16
      Width = 97
      Height = 23
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = txtSearchCodeExit
      OnKeyPress = txtsearchcardKeyPress
    end
  end
  object grpEdit: TGroupBox
    Left = 0
    Top = -5
    Width = 624
    Height = 398
    TabOrder = 1
    DesignSize = (
      624
      398)
    object lblBarCode: TLabel
      Left = 557
      Top = 19
      Width = 59
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FocusControl = txtBarCode
    end
    object lblName: TLabel
      Left = 606
      Top = 47
      Width = 10
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1606#1575#1605
      FocusControl = txtName
    end
    object lblFamily: TLabel
      Left = 563
      Top = 75
      Width = 53
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1575#1605' &'#1582#1575#1606#1608#1575#1583#1711#1610
      FocusControl = txtFamily
    end
    object Label4: TLabel
      Left = 595
      Top = 103
      Width = 21
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1576#1582#1588
    end
    object Label5: TLabel
      Left = 565
      Top = 156
      Width = 51
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1606#1608#1593' '#1575'&'#1587#1578#1582#1583#1575#1605
      FocusControl = cmbJob
    end
    object Label1: TLabel
      Left = 569
      Top = 183
      Width = 47
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&'#1711#1585#1608#1607' '#1603#1575#1585#1610
      FocusControl = cmbGroups
    end
    object Label8: TLabel
      Left = 190
      Top = 19
      Width = 86
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '#1603#1575#1585#1578' &'#1662#1585#1587#1606#1604#1610
    end
    object Label10: TLabel
      Left = 556
      Top = 210
      Width = 60
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1575#1581#1578#1587#1575#1576' '#1602#1610#1605#1578' '
      FocusControl = cmbGroups
    end
    object Label11: TLabel
      Left = 581
      Top = 129
      Width = 35
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1587#1575#1582#1578#1605#1575#1606
      FocusControl = cmbBuilding
    end
    object Label13: TLabel
      Left = 571
      Top = 237
      Width = 45
      Height = 15
      Anchors = [akTop, akRight]
      Caption = #1605#1585#1705#1586#1607#1586#1610#1606#1607
      FocusControl = cmbGroups
    end
    object Label14: TLabel
      Left = 185
      Top = 45
      Width = 69
      Height = 15
      Alignment = taRightJustify
      Caption = #1575#1606#1578#1582#1575#1576' '#1578#1589#1608#1610#1585' :'
      FocusControl = txtName
    end
    object Shape1: TShape
      Left = 44
      Top = 66
      Width = 179
      Height = 230
    end
    object imgPicture: TImage
      Left = 46
      Top = 68
      Width = 175
      Height = 226
      Hint = 'Double Click = '#1575#1606#1578#1582#1575#1576' '#1578#1589#1608#1610#1585
      ParentShowHint = False
      ShowHint = True
      Stretch = True
      OnDblClick = imgPictureDblClick
    end
    object txtToBarCode: TEdit
      Left = 352
      Top = 44
      Width = 196
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 1
      Visible = False
      OnKeyPress = txtToBarCodeKeyPress
    end
    object txtBarCode: TEdit
      Left = 288
      Top = 16
      Width = 263
      Height = 23
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = txtBarCodeKeyPress
    end
    object cmdCancel: TBitBtn
      Left = 8
      Top = 362
      Width = 105
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 18
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
      Left = 120
      Top = 362
      Width = 105
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&'#1579#1576#1578
      TabOrder = 17
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
    object txtName: TEdit
      Left = 288
      Top = 44
      Width = 263
      Height = 23
      Anchors = [akTop, akRight]
      MaxLength = 15
      TabOrder = 3
      OnKeyPress = txtNameKeyPress
    end
    object txtFamily: TEdit
      Left = 288
      Top = 72
      Width = 263
      Height = 23
      Anchors = [akTop, akRight]
      MaxLength = 30
      TabOrder = 4
      OnKeyPress = txtFamilyKeyPress
    end
    object cmbJob: TComboBox
      Left = 288
      Top = 153
      Width = 263
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 7
      OnKeyDown = cmbJobKeyDown
      OnKeyPress = cmbJobKeyPress
    end
    object chkIsValid: TCheckBox
      Left = 510
      Top = 266
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1605#1580#1575#1586' '#1576#1607' &'#1578#1585#1583#1583
      ParentBiDiMode = False
      TabOrder = 11
      OnKeyPress = chkIsValidKeyPress
    end
    object chkValidTest: TCheckBox
      Left = 494
      Top = 293
      Width = 97
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1578#1587#1578' &'#1603#1606#1578#1585#1604' '#1578#1585#1583#1583
      ParentBiDiMode = False
      TabOrder = 12
      OnKeyPress = chkValidTestKeyPress
    end
    object chkPricable: TCheckBox
      Left = 518
      Top = 320
      Width = 73
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1576#1575' '#1575#1582'&'#1584' '#1608#1580#1607
      ParentBiDiMode = False
      TabOrder = 13
      OnClick = chkPricableClick
      OnKeyPress = chkPricableKeyPress
    end
    object GroupBox1: TGroupBox
      Left = 323
      Top = 266
      Width = 105
      Height = 121
      Caption = #1605#1580#1575#1586' '#1576#1607' '#1575#1587#1578#1601#1575#1583#1607' '#1575#1586
      TabOrder = 16
      object chkSobhaneh: TCheckBox
        Left = 40
        Top = 24
        Width = 57
        Height = 17
        Alignment = taLeftJustify
        BiDiMode = bdRightToLeftNoAlign
        Caption = '&'#1589#1576#1581#1575#1606#1607
        ParentBiDiMode = False
        TabOrder = 0
        OnKeyPress = chkSobhanehKeyPress
      end
      object chkNahar: TCheckBox
        Left = 48
        Top = 56
        Width = 49
        Height = 17
        Alignment = taLeftJustify
        BiDiMode = bdRightToLeftNoAlign
        Caption = #1606#1575'&'#1607#1575#1585
        ParentBiDiMode = False
        TabOrder = 1
        OnKeyPress = chkNaharKeyPress
      end
      object chkSham: TCheckBox
        Left = 56
        Top = 88
        Width = 41
        Height = 17
        Alignment = taLeftJustify
        BiDiMode = bdRightToLeftNoAlign
        Caption = #1588#1575'&'#1605
        ParentBiDiMode = False
        TabOrder = 2
        OnKeyPress = chkShamKeyPress
      end
    end
    object cmbGroups: TComboBox
      Left = 288
      Top = 180
      Width = 263
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 8
      OnKeyDown = cmbGroupsKeyDown
      OnKeyPress = cmbGroupsKeyPress
    end
    object txtProxi: TEdit
      Left = 8
      Top = 16
      Width = 176
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 15
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = txtProxiKeyPress
    end
    object chkDblFood: TCheckBox
      Left = 146
      Top = 307
      Width = 140
      Height = 17
      Caption = #1575#1580#1575#1586#1607' &'#1594#1584#1575#1610' '#1575#1590#1575#1601#1610'     '#1578#1593#1583#1575#1583
      TabOrder = 14
      OnClick = chkDblFoodClick
      OnKeyPress = chkDblFoodKeyPress
    end
    object chkRejim: TCheckBox
      Left = 494
      Top = 374
      Width = 97
      Height = 17
      Caption = #1662#1585#1587#1606#1604' '#1585'&'#1688#1610#1605#1610
      TabOrder = 15
      OnKeyPress = chkRejimKeyPress
    end
    object cmbCashType: TComboBox
      Left = 288
      Top = 207
      Width = 263
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 9
      OnKeyPress = chkSobhanehKeyPress
      Items.Strings = (
        #1576#1585#1575#1587#1575#1587' '#1578#1606#1592#1610#1605#1575#1578' '#1602#1587#1605#1578' '#1578#1606#1592#1610#1605' '#1662#1575#1585#1575#1605#1578#1585#1607#1575
        #1662#1585#1587#1606#1604#1610
        #1662#1610#1605#1575#1606#1603#1575#1585#1610)
    end
    object cmbBuilding: TComboBox
      Left = 288
      Top = 126
      Width = 263
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 6
      OnKeyDown = cmbBuildingKeyDown
      OnKeyPress = cmbBuildingKeyPress
    end
    object txtParts: TEdit
      Left = 288
      Top = 99
      Width = 263
      Height = 23
      Anchors = [akTop, akRight]
      MaxLength = 15
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 5
    end
    object BitBtn2: TBitBtn
      Left = 290
      Top = 102
      Width = 19
      Height = 19
      Anchors = [akTop, akRight]
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      OnClick = BitBtn2Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
        8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
        F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
        F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
        0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
        3333333777333777333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object chkprepaid: TCheckBox
      Left = 518
      Top = 347
      Width = 73
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1705#1587#1585' '#1575#1593#1578#1576#1575#1585
      ParentBiDiMode = False
      TabOrder = 20
      Visible = False
      OnKeyPress = chkPricableKeyPress
    end
    object cmbreserve7: TComboBox
      Left = 288
      Top = 234
      Width = 263
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      TabOrder = 10
      OnKeyPress = cmbreserve7KeyPress
    end
    object txtCount: TEdit
      Left = 72
      Top = 304
      Width = 68
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 3
      ParentBiDiMode = False
      TabOrder = 21
      OnKeyPress = txtCountKeyPress
    end
    object txtMntCount: TEdit
      Left = 72
      Top = 332
      Width = 68
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 3
      ParentBiDiMode = False
      TabOrder = 22
      Visible = False
      OnKeyPress = txtMntCountKeyPress
    end
    object chkMntFood: TCheckBox
      Left = 146
      Top = 335
      Width = 140
      Height = 17
      Caption = #1605#1581#1583#1608#1583#1610#1578' '#1583#1585' '#1605#1575#1607'        '#1578#1593#1583#1575#1583
      TabOrder = 23
      Visible = False
      OnClick = chkMntFoodClick
    end
  end
  object dtaPersons: TDataSource
    DataSet = tblPerson
    Left = 112
  end
  object tblPerson: TADOTable
    CursorType = ctStatic
    OnCalcFields = tblPersonCalcFields
    OnFilterRecord = tblPersonFilterRecord
    IndexFieldNames = 'P_BarCode'
    TableName = 'persons'
    Left = 72
    object tblPersonP_BarCode: TWideStringField
      DisplayWidth = 17
      FieldName = 'P_BarCode'
      Size = 8
    end
    object tblPersonP_Proxi: TWideStringField
      DisplayWidth = 21
      FieldName = 'P_Proxi'
      Size = 15
    end
    object tblPersonP_Name: TWideStringField
      DisplayWidth = 56
      FieldName = 'P_Name'
      Size = 40
    end
    object tblPersonP_Family: TWideStringField
      DisplayWidth = 56
      FieldName = 'P_Family'
      Size = 40
    end
    object tblPersonP_Parts: TWideStringField
      DisplayWidth = 70
      FieldName = 'P_Parts'
      Size = 50
    end
    object tblPersonP_JobCode: TSmallintField
      DisplayWidth = 14
      FieldName = 'P_JobCode'
    end
    object tblPersonP_ShiftGroup: TSmallintField
      DisplayWidth = 16
      FieldName = 'P_ShiftGroup'
    end
    object tblPersonP_IsValid: TBooleanField
      DisplayWidth = 11
      FieldName = 'P_IsValid'
    end
    object tblPersonP_ValidTest: TBooleanField
      DisplayWidth = 13
      FieldName = 'P_ValidTest'
    end
    object tblPersonP_Pricable: TBooleanField
      DisplayWidth = 12
      FieldName = 'P_Pricable'
    end
    object tblPersonP_Sobhaneh: TBooleanField
      DisplayWidth = 15
      FieldName = 'P_Sobhaneh'
    end
    object tblPersonP_Nahar: TBooleanField
      DisplayWidth = 10
      FieldName = 'P_Nahar'
    end
    object tblPersonP_Sham: TBooleanField
      DisplayWidth = 10
      FieldName = 'P_Sham'
    end
    object tblPersonP_Rejim: TBooleanField
      DisplayWidth = 9
      FieldName = 'P_Rejim'
    end
    object tblPersonP_IsGuest: TBooleanField
      DisplayWidth = 11
      FieldName = 'P_IsGuest'
    end
    object tblPersonP_Special: TSmallintField
      DisplayWidth = 14
      FieldName = 'P_Special'
    end
    object tblPersonP_ManyFish: TSmallintField
      DisplayWidth = 14
      FieldName = 'P_ManyFish'
    end
    object tblPersonP_EtebarFish: TWideStringField
      DisplayWidth = 15
      FieldName = 'P_EtebarFish'
      Size = 10
    end
    object tblPersonP_DblFood: TBooleanField
      DisplayWidth = 12
      FieldName = 'P_DblFood'
    end
    object tblPersonP_CashType: TSmallintField
      DisplayWidth = 14
      FieldName = 'P_CashType'
    end
    object tblPersonP_DeserNoFood: TBooleanField
      DisplayWidth = 18
      FieldName = 'P_DeserNoFood'
    end
    object tblPersonP_Building: TSmallintField
      DisplayWidth = 14
      FieldName = 'P_Building'
    end
    object tblPersonpart: TStringField
      DisplayWidth = 28
      FieldKind = fkCalculated
      FieldName = 'part'
      Calculated = True
    end
    object tblPersonpcode: TStringField
      DisplayWidth = 28
      FieldKind = fkCalculated
      FieldName = 'pcode'
      Calculated = True
    end
    object tblPersonp_prepaid: TBooleanField
      FieldName = 'p_prepaid'
    end
    object tblPersonP_Credit: TBCDField
      FieldName = 'P_Credit'
      Precision = 19
    end
    object tblPersonp_reserve7: TStringField
      FieldName = 'p_reserve7'
    end
    object tblPersonP_dblFoodMax: TSmallintField
      FieldName = 'P_dblFoodMax'
    end
    object tblPersonP_MntFoodMax: TSmallintField
      FieldName = 'P_MntFoodMax'
    end
    object tblPersonP_MntFood: TBooleanField
      FieldName = 'P_MntFood'
    end
    object tblPersonP_Picture: TWideStringField
      FieldName = 'P_Picture'
      Size = 255
    end
  end
  object tmrProxi: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrProxiTimer
    Left = 8
    Top = 48
  end
end
