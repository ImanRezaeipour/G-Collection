object frmBackupRestore: TfrmBackupRestore
  Left = 157
  Top = 113
  BiDiMode = bdRightToLeft
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Å‘ Ì»«‰ êÌ—Ì'
  ClientHeight = 217
  ClientWidth = 259
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblPath: TLabel
    Left = 166
    Top = 0
    Width = 82
    Height = 15
    Caption = '&„”Ì— Å‘ Ì»«‰'
    FocusControl = lstDirectory
  end
  object lbl3: TLabel
    Left = 127
    Top = 162
    Width = 39
    Height = 15
    Caption = '&œ—«ÌÊÂ«'
    FocusControl = cmbDrive
  end
  object lbl1: TLabel
    Left = 193
    Top = 49
    Width = 53
    Height = 15
    Caption = '›÷«Ì ¬“«œ:'
  end
  object lblFreeSpace: TLabel
    Left = 133
    Top = 71
    Width = 73
    Height = 15
    Caption = 'lblFreeSpace'
  end
  object lbl2: TLabel
    Left = 161
    Top = 106
    Width = 86
    Height = 15
    Caption = '›÷«Ì „Ê—œ ‰Ì«“:'
  end
  object lblRequiredSpace: TLabel
    Left = 130
    Top = 127
    Width = 98
    Height = 15
    Caption = 'lblRequiredSpace'
  end
  object lstDirectory: TDirectoryListBox
    Left = 7
    Top = 42
    Width = 128
    Height = 114
    ItemHeight = 17
    TabOrder = 0
    OnChange = lstDirectoryChange
  end
  object cmbDrive: TDriveComboBox
    Left = 7
    Top = 162
    Width = 121
    Height = 21
    TabOrder = 1
    TextCase = tcUpperCase
    OnChange = cmbDriveChange
  end
  object cmdBackup: TBitBtn
    Left = 176
    Top = 191
    Width = 79
    Height = 22
    Caption = '&Å‘ Ì»«‰'
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
    Left = 7
    Top = 191
    Width = 79
    Height = 22
    Caption = '&Œ—ÊÃ'
    TabOrder = 5
    Kind = bkClose
  end
  object cmdRestore: TBitBtn
    Left = 148
    Top = 191
    Width = 79
    Height = 22
    Caption = '&»«“Ì«»Ì'
    TabOrder = 3
    OnClick = cmdRestoreClick
  end
  object txtPath: TEdit
    Left = 7
    Top = 21
    Width = 241
    Height = 23
    TabStop = False
    BiDiMode = bdLeftToRight
    Color = clMenu
    ParentBiDiMode = False
    TabOrder = 6
  end
  object lstFiles: TFileListBox
    Left = 7
    Top = 141
    Width = 128
    Height = 15
    ItemHeight = 17
    Mask = '*.db;*.px;*.xg?;*.yg?;'
    TabOrder = 7
    Visible = False
  end
  object cmdHelp: TBitBtn
    Left = 92
    Top = 191
    Width = 78
    Height = 22
    Caption = '—«&Â‰„«'
    TabOrder = 4
    Kind = bkHelp
  end
  object cmdDelDir: TBitBtn
    Left = 176
    Top = 162
    Width = 79
    Height = 22
    Caption = '&Õ–› ‘«ŒÂ'
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
    Left = 92
    Top = 176
    Width = 78
    Height = 15
    ItemHeight = 17
    TabOrder = 9
    Visible = False
  end
end
