object frmAdmin: TfrmAdmin
  Left = 105
  Top = 40
  HelpContext = 601
  BiDiMode = bdRightToLeft
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1578#1593#1585#1610#1601' '#1603#1575#1585#1576#1585#1575#1606' '#1608' '#1587#1591#1608#1581' '#1583#1587#1578#1585#1587#1610' '#1570#1606#1607#1575
  ClientHeight = 356
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pnlUsers: TPanel
    Left = 0
    Top = 0
    Width = 356
    Height = 149
    Align = alTop
    TabOrder = 0
    object dbgUsers: TDBGrid
      Left = 113
      Top = 7
      Width = 234
      Height = 128
      BiDiMode = bdLeftToRight
      DataSource = dtaUsers
      ParentBiDiMode = False
      TabOrder = 0
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      OnKeyDown = dbgUsersKeyDown
      OnKeyPress = dbgUsersKeyPress
    end
    object cmdAdd: TBitBtn
      Left = 7
      Top = 7
      Width = 93
      Height = 22
      Caption = #1603#1575#1585#1576#1585' &'#1580#1583#1610#1583
      TabOrder = 1
      OnClick = cmdAddClick
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
      Left = 7
      Top = 35
      Width = 93
      Height = 22
      Caption = #1575'&'#1589#1604#1575#1581' '#1603#1575#1585#1576#1585
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
      Left = 7
      Top = 64
      Width = 93
      Height = 22
      Caption = '&'#1581#1584#1601' '#1603#1575#1585#1576#1585
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
    object cmdExit: TBitBtn
      Left = 7
      Top = 118
      Width = 93
      Height = 22
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 5
      Kind = bkClose
    end
    object cmdHelp: TBitBtn
      Left = 7
      Top = 92
      Width = 93
      Height = 22
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 4
      Kind = bkHelp
    end
  end
  object pnlChecks: TPanel
    Left = 0
    Top = 149
    Width = 356
    Height = 207
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 175
    DesignSize = (
      356
      207)
    object Label1: TLabel
      Left = 310
      Top = 7
      Width = 37
      Height = 15
      Caption = '&'#1606#1575#1605' '#1603#1575#1585#1576#1585
      FocusControl = txtUserName
    end
    object Label2: TLabel
      Left = 102
      Top = 7
      Width = 44
      Height = 15
      Caption = #1603#1604#1605#1607' &'#1593#1576#1608#1585
      FocusControl = txtUserPassword
    end
    object Bevel2: TBevel
      Left = 0
      Top = 36
      Width = 356
      Height = 6
      Shape = bsBottomLine
    end
    object Bevel1: TBevel
      Left = 0
      Top = 98
      Width = 356
      Height = 4
      Shape = bsBottomLine
    end
    object Label3: TLabel
      Left = 118
      Top = 35
      Width = 130
      Height = 15
      Caption = #1587#1591#1581' '#1583#1587#1578#1585#1587#1610' '#1576#1607' '#1586#1610#1585' '#1576#1585#1606#1575#1605#1607#8204#1607#1575
    end
    object Label18: TLabel
      Left = 162
      Top = 111
      Width = 56
      Height = 15
      Caption = #1605#1581#1604' '#1582#1583#1605#1578' :'
    end
    object lbl4: TLabel
      Left = 239
      Top = 153
      Width = 108
      Height = 15
      Caption = #1583#1587#1578#1711#1575#1607' '#1601#1593#1575#1604' '#1576#1585#1575#1610' '#1576#1575#1604#1575#1576#1585' :'
      FocusControl = cmbActiveRdrOpenDoor
    end
    object cmdSave: TBitBtn
      Left = 261
      Top = 179
      Width = 86
      Height = 22
      Caption = '&'#1579#1576#1578
      TabOrder = 13
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
      Top = 179
      Width = 86
      Height = 22
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 14
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
    object chkBase: TCheckBox
      Left = 242
      Top = 56
      Width = 105
      Height = 15
      Caption = #1575#1591#1604#1575#1593#1575#1578' &'#1662#1575#1610#1607
      TabOrder = 2
      OnClick = chkBaseClick
    end
    object chkTransfer: TCheckBox
      Left = 7
      Top = 56
      Width = 105
      Height = 15
      Caption = #1593#1605#1604#1610#1575#1578' &'#1578#1585#1583#1583
      TabOrder = 4
      OnClick = chkTransferClick
    end
    object chkReport: TCheckBox
      Left = 129
      Top = 77
      Width = 105
      Height = 15
      Caption = '&'#1711#1586#1575#1585#1588#8204#1711#1610#1585#1610
      TabOrder = 6
      OnClick = chkReportClick
    end
    object chkTools: TCheckBox
      Left = 7
      Top = 77
      Width = 105
      Height = 15
      Caption = #1593#1605#1604#1610#1575#1578' &'#1580#1575#1606#1576#1610
      TabOrder = 7
      OnClick = chkToolsClick
    end
    object txtUserName: TEdit
      Left = 205
      Top = 7
      Width = 99
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 15
      ParentBiDiMode = False
      TabOrder = 0
    end
    object txtUserPassword: TEdit
      Left = 7
      Top = 7
      Width = 93
      Height = 23
      BiDiMode = bdLeftToRight
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 15
      ParentBiDiMode = False
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
    end
    object chkEntery: TCheckBox
      Left = 240
      Top = 108
      Width = 107
      Height = 15
      Caption = #1575#1580#1575#1586#1607' '#1608#1585#1608#1583' '#1576#1607' &'#1587#1610#1587#1578#1605
      TabOrder = 8
    end
    object chkPrint: TCheckBox
      Left = 240
      Top = 129
      Width = 107
      Height = 15
      Caption = #1575#1580#1575#1586#1607' &'#1670#1575#1662' '#1711#1586#1575#1585#1588#1575#1578
      TabOrder = 9
    end
    object chkRelation: TCheckBox
      Left = 129
      Top = 56
      Width = 105
      Height = 15
      Caption = #1575#1585#1578#1576#1575#1591' '#1576#1575' &'#1583#1587#1578#1711#1575#1607#1607#1575
      TabOrder = 3
      OnClick = chkRelationClick
    end
    object chkSpecial: TCheckBox
      Left = 242
      Top = 77
      Width = 105
      Height = 15
      Caption = #1593#1605#1604#1610#1575#1578' &'#1608#1610#1688#1607
      TabOrder = 5
      OnClick = chkSpecialClick
    end
    object cmbDepartment: TComboBox
      Left = 7
      Top = 108
      Width = 149
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 10
      OnChange = cmbDepartmentChange
    end
    object cmbDepartmentCode: TComboBox
      Left = 36
      Top = 113
      Width = 38
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      Visible = False
    end
    object cmbActiveRdrOpenDoorCode: TComboBox
      Left = 177
      Top = 150
      Width = 56
      Height = 23
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 15
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnChange = cmbActiveRdrOpenDoorCodeChange
    end
    object cmbActiveRdrOpenDoor: TComboBox
      Left = 7
      Top = 150
      Width = 164
      Height = 23
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 12
      OnChange = cmbActiveRdrOpenDoorChange
    end
  end
  object tblUsers: TADOTable
    CursorType = ctStatic
    TableName = 'Security'
    Left = 272
    Top = 64
    object tblUsersUserName: TStringField
      DisplayLabel = '                           '#1603#1575#1585#1576#1585#1575#1606
      DisplayWidth = 33
      FieldName = 'UserName'
      Size = 15
    end
    object tblUsersUserPassword: TStringField
      FieldName = 'UserPassword'
      Visible = False
      Size = 15
    end
    object tblUsersEntery: TBooleanField
      FieldName = 'Entery'
      Visible = False
    end
    object tblUsersMenuBar: TSmallintField
      FieldName = 'MenuBar'
      Visible = False
    end
    object tblUsersBaseMenu: TIntegerField
      FieldName = 'BaseMenu'
      Visible = False
    end
    object tblUsersRelationMenu: TIntegerField
      FieldName = 'RelationMenu'
      Visible = False
    end
    object tblUsersTransferMenu: TIntegerField
      FieldName = 'TransferMenu'
      Visible = False
    end
    object tblUsersSpecialMenu: TIntegerField
      FieldName = 'SpecialMenu'
      Visible = False
    end
    object tblUsersReportMenu: TIntegerField
      FieldName = 'ReportMenu'
      Visible = False
    end
    object tblUsersToolsMenu: TIntegerField
      FieldName = 'ToolsMenu'
      Visible = False
    end
    object tblUsersAccessPrint: TBooleanField
      FieldName = 'AccessPrint'
      Visible = False
    end
    object tblUsersDepartment: TIntegerField
      FieldName = 'Department'
      Visible = False
    end
    object tblUsersActiveRdrCode: TSmallintField
      FieldName = 'ActiveRdrCode'
    end
  end
  object dtaUsers: TDataSource
    DataSet = tblUsers
    Left = 328
    Top = 64
  end
  object qry: TADOQuery
    Parameters = <>
    Left = 192
    Top = 161
  end
end
