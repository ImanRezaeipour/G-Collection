object frmIntelligentFile: TfrmIntelligentFile
  Left = 202
  Top = 207
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1582#1608#1575#1606#1583#1606' '#1575#1591#1604#1575#1593#1575#1578' Intelligent '#1575#1586' '#1601#1575#1610#1604
  ClientHeight = 116
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 11
    Top = 7
    Width = 30
    Height = 15
    Caption = #1606#1575#1605' '#1601#1575#1610#1604
  end
  object lbl2: TLabel
    Left = 260
    Top = 42
    Width = 35
    Height = 15
    Caption = #1575#1586' '#1578#1575#1585#1610#1582
  end
  object lbl3: TLabel
    Left = 107
    Top = 42
    Width = 32
    Height = 15
    Caption = #1578#1575' '#1578#1575#1585#1610#1582
  end
  object lblCount: TLabel
    Left = 7
    Top = 71
    Width = 57
    Height = 15
    AutoSize = False
    BiDiMode = bdLeftToRight
    Caption = 'lblCount'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object txtFileName: TEdit
    Left = 49
    Top = 7
    Width = 227
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
  end
  object btnOpenFile: TButton
    Left = 275
    Top = 7
    Width = 22
    Height = 22
    Caption = '...'
    TabOrder = 1
    OnClick = btnOpenFileClick
  end
  object txtFromDate: TEdit
    Left = 162
    Top = 42
    Width = 93
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 7
    Top = 42
    Width = 93
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 3
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object cmdRun: TBitBtn
    Left = 219
    Top = 92
    Width = 80
    Height = 22
    Caption = #1575'&'#1580#1585#1575
    TabOrder = 4
    OnClick = cmdRunClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
      555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
      05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
      FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
      FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
      FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
      05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
      555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
      9055575757575757775505050505055505557575757575557555}
    NumGlyphs = 2
  end
  object cmdHelp: TBitBtn
    Left = 113
    Top = 92
    Width = 80
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 5
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 7
    Top = 92
    Width = 79
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 6
    Kind = bkClose
  end
  object opnFile: TOpenDialog
    Left = 152
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 72
    Top = 32
  end
end
