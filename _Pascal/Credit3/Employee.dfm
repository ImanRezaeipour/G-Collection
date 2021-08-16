object frmEmployee: TfrmEmployee
  Left = 58
  Top = 76
  HelpContext = 10
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1575#1601#1585#1575#1583
  ClientHeight = 374
  ClientWidth = 769
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
  object grpEdit: TGroupBox
    Left = 0
    Top = 145
    Width = 769
    Height = 224
    TabOrder = 1
    object lbl4: TLabel
      Left = 680
      Top = 11
      Width = 9
      Height = 15
      Caption = #1705#1583
      FocusControl = txtNo
    end
    object lbl5: TLabel
      Left = 676
      Top = 35
      Width = 42
      Height = 15
      Caption = '&'#1606#1575#1605' '#1588#1582#1589
      FocusControl = txtName
    end
    object lbl6: TLabel
      Left = 399
      Top = 35
      Width = 53
      Height = 15
      Caption = #1606#1575#1605' &'#1582#1575#1606#1608#1575#1583#1711#1610
      FocusControl = txtFamily
    end
    object lbl9: TLabel
      Left = 399
      Top = 83
      Width = 48
      Height = 15
      Caption = '&'#1605#1581#1604' '#1582#1583#1605#1578
      FocusControl = cmbParts
    end
    object lbl10: TLabel
      Left = 676
      Top = 107
      Width = 27
      Height = 15
      Caption = '&'#1580#1575#1610#1711#1575#1607
      FocusControl = cmbCoPosts
    end
    object lbl11: TLabel
      Left = 399
      Top = 107
      Width = 51
      Height = 15
      Caption = #1711#1585#1608#1607' '#1578'&'#1582#1601#1610#1601
      FocusControl = cmbDiscount
      Visible = False
    end
    object lbl7: TLabel
      Left = 399
      Top = 11
      Width = 52
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578
      FocusControl = txtID
    end
    object lbl8: TLabel
      Left = 676
      Top = 83
      Width = 22
      Height = 15
      Caption = #1605#1585'&'#1603#1586
      FocusControl = cmbDepartment
    end
    object Label1: TLabel
      Left = 676
      Top = 61
      Width = 74
      Height = 15
      Caption = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1575#1593#1578#1576#1575#1585
      FocusControl = txtExpDate
    end
    object Label2: TLabel
      Left = 399
      Top = 107
      Width = 56
      Height = 15
      Caption = #1576#1585#1606#1575#1605#1607' '#1607#1601#1578#1711#1610
      FocusControl = cmbWeek
    end
    object Label3: TLabel
      Left = 399
      Top = 60
      Width = 59
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FocusControl = txtnumber
    end
    object Label4: TLabel
      Left = 676
      Top = 132
      Width = 29
      Height = 15
      Caption = #1705#1583' '#1605#1604#1610
      FocusControl = txtmeli
    end
    object Label5: TLabel
      Left = 399
      Top = 132
      Width = 16
      Height = 15
      Caption = #1578#1604#1601#1606
      FocusControl = txttel
    end
    object Label6: TLabel
      Left = 676
      Top = 157
      Width = 24
      Height = 15
      Caption = #1570#1583#1585#1587
      FocusControl = txtaddress
    end
    object lbl25: TLabel
      Left = 676
      Top = 179
      Width = 29
      Height = 15
      Alignment = taRightJustify
      Caption = #1580#1606#1587#1610#1578
      FocusControl = cmbSex
      ParentShowHint = False
      ShowHint = True
    end
    object Label7: TLabel
      Left = 120
      Top = 11
      Width = 53
      Height = 15
      Caption = #1582#1583#1605#1575#1578' '#1605#1580#1575#1586
      FocusControl = txtID
    end
    object txtNo: TEdit
      Left = 575
      Top = 9
      Width = 89
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
    end
    object cmdCancel: TBitBtn
      Left = 10
      Top = 186
      Width = 105
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 17
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
      Left = 121
      Top = 186
      Width = 105
      Height = 25
      Caption = '&'#1579#1576#1578
      TabOrder = 16
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
      Left = 511
      Top = 33
      Width = 153
      Height = 23
      MaxLength = 15
      TabOrder = 2
      OnKeyPress = txtNameKeyPress
    end
    object txtFamily: TEdit
      Left = 223
      Top = 33
      Width = 153
      Height = 23
      MaxLength = 20
      TabOrder = 3
      OnKeyPress = txtNameKeyPress
    end
    object cmbParts: TComboBox
      Left = 223
      Top = 81
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 7
      OnKeyDown = cmbPartsKeyDown
    end
    object cmbCoPosts: TComboBox
      Left = 511
      Top = 105
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 8
      OnExit = cmbCoPostsExit
      OnKeyDown = cmbCoPostsKeyDown
    end
    object cmbDiscount: TComboBox
      Left = 223
      Top = 105
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 9
      Visible = False
      OnKeyDown = cmbDiscountKeyDown
    end
    object chkActive: TCheckBox
      Left = 319
      Top = 179
      Width = 57
      Height = 17
      Caption = '&'#1601#1593#1575#1604
      TabOrder = 14
    end
    object txtID: TEdit
      Left = 223
      Top = 9
      Width = 153
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 15
      ParentBiDiMode = False
      TabOrder = 1
    end
    object cmbDepartment: TComboBox
      Left = 511
      Top = 81
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 6
      OnKeyDown = cmbDepartmentKeyDown
    end
    object txtExpDate: TEdit
      Left = 511
      Top = 57
      Width = 153
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 4
      OnExit = txtExpDateExit
      OnKeyPress = txtExpDateKeyPress
    end
    object cmbWeek: TComboBox
      Left = 223
      Top = 105
      Width = 153
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 18
      OnKeyDown = cmbCoPostsKeyDown
    end
    object txtnumber: TEdit
      Left = 223
      Top = 57
      Width = 153
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 15
      ParentBiDiMode = False
      TabOrder = 5
    end
    object txtmeli: TEdit
      Left = 511
      Top = 129
      Width = 153
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 12
      ParentBiDiMode = False
      TabOrder = 10
    end
    object txttel: TEdit
      Left = 223
      Top = 129
      Width = 153
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 20
      ParentBiDiMode = False
      TabOrder = 11
    end
    object txtaddress: TEdit
      Left = 223
      Top = 152
      Width = 441
      Height = 23
      BiDiMode = bdRightToLeft
      MaxLength = 80
      ParentBiDiMode = False
      TabOrder = 12
    end
    object cmbSex: TComboBox
      Left = 592
      Top = 176
      Width = 72
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      Items.Strings = (
        #1605#1585#1583
        #1586#1606)
    end
    object clbservice: TCheckListBox
      Left = 11
      Top = 26
      Width = 199
      Height = 149
      Columns = 2
      ItemHeight = 15
      TabOrder = 15
    end
  end
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 769
    Height = 377
    Align = alTop
    Caption = #1580#1587#1578#1580#1608
    TabOrder = 0
    object lbl3: TLabel
      Left = 200
      Top = 19
      Width = 26
      Height = 15
      Caption = '&'#1578#1582#1601#1610#1601
      Visible = False
    end
    object lbl1: TLabel
      Left = 720
      Top = 19
      Width = 13
      Height = 15
      Caption = '&'#1705#1583' '
      FocusControl = txtSearchCode
    end
    object Bevel1: TBevel
      Left = 3
      Top = 42
      Width = 758
      Height = 4
      Shape = bsTopLine
    end
    object lblRecNo: TLabel
      Left = 47
      Top = 223
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
    object lbl2: TLabel
      Left = 448
      Top = 19
      Width = 53
      Height = 15
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583'&'#1711#1610
      FocusControl = txtSearchFamily
    end
    object dbgPersons: TDBGrid
      Left = 112
      Top = 70
      Width = 652
      Height = 300
      DataSource = GRID
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 3
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnDblClick = cmdEditClick
      OnKeyDown = dbgPersonsKeyDown
      OnTitleClick = dbgPersonsTitleClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Empl_No'
          Title.Alignment = taCenter
          Title.Caption = #1705#1583
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Empl_ID'
          Title.Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'familyname'
          Title.Alignment = taCenter
          Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605
          Width = 157
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SumOfGRPPRICE'
          Title.Caption = #1580#1605#1593' '#1588#1575#1585#1688
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SumOfRecit1_TotalPrice'
          Title.Caption = #1580#1605#1593' '#1582#1585#1610#1583
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'balanc'
          Title.Caption = #1605#1575#1606#1583#1607' '#1575#1593#1578#1576#1575#1585
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Empl_Part'
          Title.Caption = #1705#1583' '#1602#1587#1605#1578
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'active'
          Title.Caption = #1608#1590#1593#1610#1578
          Width = 52
          Visible = True
        end>
    end
    object cmdNew: TBitBtn
      Left = 9
      Top = 51
      Width = 97
      Height = 25
      Caption = #1662#1585#1587#1606#1604' &'#1580#1583#1610#1583
      TabOrder = 4
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
      Top = 82
      Width = 97
      Height = 25
      Caption = #1575'&'#1589#1604#1575#1581' '#1662#1585#1587#1606#1604
      TabOrder = 5
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
      Top = 114
      Width = 97
      Height = 25
      Caption = '&'#1581#1584#1601' '#1662#1585#1587#1606#1604
      TabOrder = 6
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
      Top = 313
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 11
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 345
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 12
      Kind = bkClose
    end
    object cmbSearchDscnt: TComboBox
      Left = 8
      Top = 16
      Width = 185
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 2
      Visible = False
      OnClick = txtSearchCodeExit
      OnKeyDown = cmbSearchDscntKeyDown
    end
    object txtSearchCode: TEdit
      Left = 520
      Top = 16
      Width = 145
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
      OnExit = txtSearchCodeExit
    end
    object txtSearchFamily: TEdit
      Left = 272
      Top = 16
      Width = 161
      Height = 23
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      TabOrder = 1
      OnExit = txtSearchCodeExit
    end
    object btnChngAll: TBitBtn
      Left = 9
      Top = 252
      Width = 97
      Height = 25
      Caption = #1578'&'#1594#1610#1610#1585' '#1603#1604#1610
      TabOrder = 9
      Visible = False
      OnClick = btnChngAllClick
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
    end
    object cmdFixPCode: TBitBtn
      Left = 8
      Top = 283
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
    object BitBtn1: TBitBtn
      Left = 9
      Top = 158
      Width = 97
      Height = 25
      Caption = #1608#1610#1585#1575#1610#1588' '#1575#1593#1578#1576#1575#1585
      TabOrder = 7
      OnClick = BitBtn1Click
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
    object BitBtn2: TBitBtn
      Left = 9
      Top = 189
      Width = 97
      Height = 25
      Caption = #1578#1575#1605#1610#1606' '#1575#1593#1578#1576#1575#1585
      TabOrder = 8
      OnClick = BitBtn2Click
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
  end
  object dtaPersons: TDataSource
    DataSet = adotblEmployeee
    Left = 248
    Top = 200
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 384
    Top = 200
  end
  object adotblEmployeee: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Credit;Data Source=.'
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from employee')
    Left = 280
    Top = 169
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 240
    object N1: TMenuItem
      Caption = #1601#1593#1575#1604
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1594#1610#1585' '#1601#1593#1575#1604
      OnClick = N2Click
    end
  end
  object adotblEmployee: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Credit;Data Source=.'
    CursorType = ctStatic
    OnCalcFields = adotblEmployeeCalcFields
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Employee.Empl_No, Employee.Empl_ID,Employee.Empl_Family,E' +
        'mployee.Empl_Name, Employee.Empl_Week, '
      
        ' Employee.Empl_number, Employee.Empl_Address, Employee.Empl_sex,' +
        ' Employee.Empl_meli, Employee.Empl_tel,'
      ''
      
        'Employee.Empl_Family + '#39' - '#39'+Employee.Empl_Name as familyname, E' +
        'mployee.Empl_Active,Employee.Empl_Services,'
      ''
      
        ' Employee.Empl_Department, Employee.Empl_CoPost, Employee.Empl_P' +
        'art, Employee.Empl_Dscnt,'
      ''
      ' Employee.Empl_ExpDate, Employee.Empl_Balance,'
      ''
      
        ' a.SumOfGRPPRICE, Sum(Receipt1.Recit1_TotalPrice) AS SumOfRecit1' +
        '_TotalPrice '
      ''
      ',a.SumOfGRPPRICE - Sum(Receipt1.Recit1_TotalPrice) as balanc'
      ''
      
        'FROM (Employee LEFT JOIN Receipt1 ON Employee.Empl_No = Receipt1' +
        '.Recit1_EmplNo)'
      ''
      
        ' LEFT JOIN (SELECT chargedtl.DTLEMPLNO, Sum(chargegrp.GRPPRICE) ' +
        'AS SumOfGRPPRICE'
      ''
      
        'FROM chargegrp INNER JOIN chargedtl ON chargegrp.GRPCODE = charg' +
        'edtl.DTLCODE'
      ''
      'GROUP BY chargedtl.DTLEMPLNO'
      ''
      ') AS a ON Employee.Empl_No = a.DTLEMPLNO'
      ''
      
        'GROUP BY Employee.Empl_No, Employee.Empl_ID, Employee.Empl_Name,' +
        ' Employee.Empl_Family, Employee.Empl_Active, Employee.Empl_Servi' +
        'ces, '
      ''
      
        'Employee.Empl_Department, Employee.Empl_CoPost, Employee.Empl_Pa' +
        'rt, Employee.Empl_Dscnt, Employee.Empl_ExpDate, '
      ''
      'Employee.Empl_Balance, a.SumOfGRPPRICE, Employee.Empl_Week'
      
        ',Employee.Empl_number, Employee.Empl_Address, Employee.Empl_sex,' +
        ' Employee.Empl_meli, Employee.Empl_tel')
    Left = 280
    Top = 201
    object WideStringField1: TWideStringField
      FieldName = 'Empl_No'
      Size = 8
    end
    object WideStringField2: TWideStringField
      FieldName = 'Empl_ID'
      Size = 15
    end
    object WideStringField3: TWideStringField
      FieldName = 'Empl_Family'
      Size = 25
    end
    object WideStringField4: TWideStringField
      FieldName = 'Empl_Name'
      Size = 15
    end
    object WideStringField5: TWideStringField
      FieldName = 'familyname'
      ReadOnly = True
      Size = 255
    end
    object BooleanField1: TBooleanField
      FieldName = 'Empl_Active'
    end
    object IntegerField1: TIntegerField
      FieldName = 'Empl_Department'
    end
    object IntegerField2: TIntegerField
      FieldName = 'Empl_CoPost'
    end
    object IntegerField3: TIntegerField
      FieldName = 'Empl_Part'
    end
    object IntegerField4: TIntegerField
      FieldName = 'Empl_Dscnt'
    end
    object WideStringField6: TWideStringField
      FieldName = 'Empl_ExpDate'
      Size = 10
    end
    object BCDField1: TBCDField
      FieldName = 'Empl_Balance'
      Precision = 19
    end
    object BCDField2: TBCDField
      FieldName = 'SumOfGRPPRICE'
      Precision = 19
    end
    object BCDField3: TBCDField
      FieldName = 'SumOfRecit1_TotalPrice'
      Precision = 19
    end
    object BCDField4: TBCDField
      FieldName = 'balanc'
      ReadOnly = True
      Precision = 19
    end
    object StringField1: TStringField
      FieldKind = fkCalculated
      FieldName = 'active'
      Size = 5
      Calculated = True
    end
    object adotblEmployeeEmpl_Services: TWideStringField
      FieldName = 'Empl_Services'
      Size = 50
    end
    object adotblEmployeeEmpl_Week: TIntegerField
      FieldName = 'Empl_Week'
    end
    object adotblEmployeeempl_tel: TStringField
      FieldName = 'empl_tel'
      Size = 30
    end
    object adotblEmployeeempl_address: TStringField
      FieldName = 'empl_address'
      Size = 80
    end
    object adotblEmployeeempl_meli: TStringField
      FieldName = 'empl_meli'
      Size = 12
    end
    object adotblEmployeeempl_sex: TSmallintField
      FieldName = 'empl_sex'
    end
    object adotblEmployeeempl_number: TStringField
      FieldName = 'empl_number'
    end
  end
  object GRID: TDataSource
    DataSet = adotblEmployee
    Left = 248
    Top = 168
  end
end
