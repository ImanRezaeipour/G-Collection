object frmUserState: TfrmUserState
  Left = 51
  Top = 13
  HelpContext = 503
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1606#1605#1575#1610#1588' '#1601#1593#1575#1604#1610#1578' '#1603#1575#1585#1576#1585#1575#1606
  ClientHeight = 390
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 487
    Top = 8
    Width = 23
    Height = 15
    Caption = '&'#1603#1575#1585#1576#1585
    FocusControl = cmbUsers
  end
  object Label2: TLabel
    Left = 283
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label3: TLabel
    Left = 110
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object cmbUsers: TComboBox
    Left = 336
    Top = 8
    Width = 145
    Height = 23
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 15
    ParentBiDiMode = False
    TabOrder = 0
    OnClick = cmbUsersClick
    OnKeyDown = cmbUsersKeyDown
    OnKeyPress = cmbUsersKeyPress
  end
  object dbgUserStat: TDBGrid
    Left = 8
    Top = 40
    Width = 497
    Height = 313
    DataSource = dtaUserStat
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
  end
  object txtFromDate: TEdit
    Left = 184
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 8
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtToDateExit
    OnKeyPress = txtToDateKeyPress
  end
  object cmdHelp: TBitBtn
    Left = 112
    Top = 360
    Width = 97
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 4
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 360
    Width = 97
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 5
    Kind = bkClose
  end
  object cmdDel: TBitBtn
    Left = 400
    Top = 360
    Width = 107
    Height = 25
    Caption = '&'#1581#1584#1601
    Enabled = False
    TabOrder = 6
    Visible = False
    OnClick = cmdDelClick
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
  object dtaUserStat: TDataSource
    DataSet = tblUserStat
    Left = 240
    Top = 64
  end
  object tblUserStat: TADOTable
    TableName = 'UserStat'
    Left = 312
    Top = 64
    object tblUserStatUser_Name: TStringField
      Alignment = taRightJustify
      DisplayLabel = '       '#1606#1575#1605' '#1603#1575#1585#1576#1585
      FieldName = 'User_Name'
      Size = 15
    end
    object tblUserStatUser_Program: TStringField
      DisplayLabel = '                    '#1606#1575#1605' '#1576#1585#1606#1575#1605#1607
      DisplayWidth = 30
      FieldName = 'User_Program'
      Size = 30
    end
    object tblUserStatUser_Date: TStringField
      DisplayLabel = '   '#1578#1575#1585#1610#1582' '#1575#1580#1585#1575
      DisplayWidth = 10
      FieldName = 'User_Date'
      Size = 10
    end
    object tblUserStatUser_Time: TStringField
      DisplayLabel = ' '#1586#1605#1575#1606' '#1575#1580#1585#1575'  '
      DisplayWidth = 8
      FieldName = 'User_Time'
      Size = 5
    end
  end
end
