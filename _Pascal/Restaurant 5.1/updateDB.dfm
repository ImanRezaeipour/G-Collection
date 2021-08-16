object frmUpdateDB: TfrmUpdateDB
  Left = 268
  Top = 221
  HelpContext = 506
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1576#1585#1608#1586' '#1585#1587#1575#1606#1610' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610' '#1575#1586' '#1606#1585#1605' '#1575#1601#1586#1575#1585' '#1581#1590#1608#1585#1608#1594#1610#1575#1576
  ClientHeight = 246
  ClientWidth = 470
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblPersons: TLabel
    Left = 283
    Top = 22
    Width = 62
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblPersons'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object lblParts: TLabel
    Left = 283
    Top = 49
    Width = 62
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblParts'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object lblJobType: TLabel
    Left = 283
    Top = 76
    Width = 62
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblJobType'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 6
    Top = 161
    Width = 459
    Height = 9
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 7
    Top = 196
    Width = 459
    Height = 9
    Shape = bsTopLine
  end
  object lblreserve7: TLabel
    Left = 283
    Top = 104
    Width = 62
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblreserve7'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object cmdDel: TBitBtn
    Left = 360
    Top = 214
    Width = 105
    Height = 25
    Caption = #1576#1585#1608#1586' '#1585#1587#1575#1606#1610' '
    TabOrder = 3
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
  object cmdHelp: TBitBtn
    Left = 144
    Top = 214
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 4
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 214
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 5
    Kind = bkClose
  end
  object chkPersons: TCheckBox
    Left = 386
    Top = 22
    Width = 81
    Height = 17
    Caption = #1576#1575#1606#1705' '#1662#1585#1587#1606#1604
    TabOrder = 0
    OnKeyPress = chkFishKeyPress
  end
  object chkParts: TCheckBox
    Left = 386
    Top = 49
    Width = 81
    Height = 17
    Caption = #1576#1575#1606#1705' '#1576#1582#1588#1607#1575
    TabOrder = 1
    OnKeyPress = chkFishKeyPress
  end
  object chkJobType: TCheckBox
    Left = 354
    Top = 76
    Width = 113
    Height = 17
    Caption = #1576#1575#1606#1705' '#1575#1606#1608#1575#1593' '#1575#1587#1578#1582#1583#1575#1605
    TabOrder = 2
    OnKeyPress = chkFishKeyPress
  end
  object GroupBox1: TGroupBox
    Left = 5
    Top = 15
    Width = 236
    Height = 140
    Caption = #1605#1588#1582#1589#1575#1578' '#1576#1575#1606#1705' '#1575#1591#1604#1575#1593#1575#1578#1610' '#1606#1585#1605' '#1575#1601#1586#1575#1585' '#1581#1590#1608#1585#1608#1594#1610#1575#1576
    TabOrder = 6
    object lblSQLPass: TLabel
      Left = 149
      Top = 110
      Width = 44
      Height = 15
      Caption = #1603#1604#1605#1607' '#1593#1576#1608#1585
    end
    object lblSqlUser: TLabel
      Left = 149
      Top = 83
      Width = 41
      Height = 15
      Caption = #1606#1575#1605' '#1705#1575#1585#1576#1585' '
    end
    object lblServer: TLabel
      Left = 150
      Top = 32
      Width = 72
      Height = 15
      Caption = #1606#1575#1605' '#1587#1585#1608#1610#1587' '#1583#1607#1606#1583#1607
    end
    object Label1: TLabel
      Left = 147
      Top = 58
      Width = 79
      Height = 15
      Caption = #1606#1575#1605' '#1576#1575#1606#1705' '#1575#1591#1604#1575#1593#1575#1578#1610
    end
    object txtSqlPass: TEdit
      Left = 21
      Top = 106
      Width = 124
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object txtSqlUser: TEdit
      Left = 21
      Top = 80
      Width = 124
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 2
    end
    object txtServer: TEdit
      Left = 22
      Top = 28
      Width = 123
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
    end
    object txtdatabasename: TEdit
      Left = 22
      Top = 54
      Width = 123
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object chkAdd: TCheckBox
    Left = 228
    Top = 172
    Width = 239
    Height = 17
    Caption = #1575#1601#1586#1608#1583#1606' '#1662#1585#1587#1606#1604' '#1580#1583#1610#1583' '#1575#1586' '#1606#1585#1605' '#1575#1601#1586#1575#1585' '#1581#1590#1608#1585#1608#1594#1610#1575#1576
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object chkDelete: TCheckBox
    Left = 7
    Top = 171
    Width = 222
    Height = 17
    Caption = #1581#1584#1601' '#1662#1585#1587#1606#1604#1610' '#1705#1607' '#1583#1585' '#1581#1590#1608#1585#1594#1610#1575#1576' '#1581#1584#1601' '#1588#1583#1607' '#1575#1606#1583'.'
    TabOrder = 8
  end
  object chkreserve7: TCheckBox
    Left = 354
    Top = 104
    Width = 113
    Height = 17
    Caption = #1576#1575#1606#1705' '#1605#1585#1705#1586' '#1607#1586#1610#1606#1607
    TabOrder = 9
    OnKeyPress = chkFishKeyPress
  end
end
