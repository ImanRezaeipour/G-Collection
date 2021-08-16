object frmBackupRestore: TfrmBackupRestore
  Left = 157
  Top = 113
  BiDiMode = bdRightToLeft
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1662#1588#1578#1610#1576#1575#1606' '#1711#1610#1585#1610
  ClientHeight = 246
  ClientWidth = 294
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblPath: TLabel
    Left = 227
    Top = 0
    Width = 54
    Height = 15
    Caption = '&'#1605#1587#1610#1585' '#1662#1588#1578#1610#1576#1575#1606
    FocusControl = lstDirectory
  end
  object Label1: TLabel
    Left = 253
    Top = 184
    Width = 31
    Height = 15
    Caption = '&'#1583#1585#1575#1610#1608#1607#1575
    FocusControl = cmbDrive
  end
  object lblType: TLabel
    Left = 8
    Top = 184
    Width = 40
    Height = 15
    Caption = 'lblType'
    Visible = False
  end
  object Label2: TLabel
    Left = 230
    Top = 56
    Width = 49
    Height = 15
    Caption = #1601#1590#1575#1610' '#1570#1586#1575#1583':'
  end
  object lblFreeSpace: TLabel
    Left = 160
    Top = 80
    Width = 73
    Height = 15
    Caption = 'lblFreeSpace'
  end
  object Label3: TLabel
    Left = 207
    Top = 120
    Width = 73
    Height = 15
    Caption = #1601#1590#1575#1610' '#1605#1608#1585#1583' '#1606#1610#1575#1586':'
  end
  object lblRequiredSpace: TLabel
    Left = 160
    Top = 144
    Width = 98
    Height = 15
    Caption = 'lblRequiredSpace'
  end
  object lstDirectory: TDirectoryListBox
    Left = 8
    Top = 48
    Width = 145
    Height = 129
    ItemHeight = 17
    TabOrder = 0
    OnChange = lstDirectoryChange
  end
  object cmbDrive: TDriveComboBox
    Left = 104
    Top = 184
    Width = 137
    Height = 21
    TabOrder = 1
    TextCase = tcUpperCase
    OnChange = cmbDriveChange
  end
  object cmdBackup: TBitBtn
    Left = 200
    Top = 216
    Width = 89
    Height = 25
    Caption = '&'#1662#1588#1578#1610#1576#1575#1606
    TabOrder = 2
    OnClick = cmdBackupClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330B7FFF
      FFB0333333777F3333773333330B7FFFFFB0333333777F3333773333330B7FFF
      FFB0333333777F3333773333330B7FFFFFB03FFFFF777FFFFF77000000000077
      007077777777777777770FFFFFFFF00077B07F33333337FFFF770FFFFFFFF000
      7BB07F3FF3FFF77FF7770F00F000F00090077F77377737777F770FFFFFFFF039
      99337F3FFFF3F7F777FF0F0000F0F09999937F7777373777777F0FFFFFFFF999
      99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
      99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
      93337FFFF7737777733300000033333333337777773333333333}
    NumGlyphs = 2
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 216
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 5
    Kind = bkClose
  end
  object cmdRestore: TBitBtn
    Left = 200
    Top = 200
    Width = 89
    Height = 25
    Caption = '&'#1576#1575#1586#1610#1575#1576#1610
    TabOrder = 3
    OnClick = cmdRestoreClick
  end
  object txtPath: TEdit
    Left = 8
    Top = 24
    Width = 273
    Height = 23
    TabStop = False
    BiDiMode = bdLeftToRight
    Color = clMenu
    ParentBiDiMode = False
    TabOrder = 6
  end
  object lstFiles: TFileListBox
    Left = 8
    Top = 160
    Width = 145
    Height = 17
    ItemHeight = 17
    Mask = '*.db;*.px;*.xg?;*.yg?;'
    TabOrder = 7
    Visible = False
  end
  object cmdHelp: TBitBtn
    Left = 104
    Top = 216
    Width = 89
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 4
    Kind = bkHelp
  end
  object cmdDelDir: TBitBtn
    Left = 8
    Top = 184
    Width = 89
    Height = 25
    Caption = '&'#1581#1584#1601' '#1588#1575#1582#1607
    TabOrder = 8
    OnClick = cmdDelDirClick
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
  object flstDel: TFileListBox
    Left = 8
    Top = 200
    Width = 89
    Height = 17
    ItemHeight = 17
    TabOrder = 9
    Visible = False
  end
end
