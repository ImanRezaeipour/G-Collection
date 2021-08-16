object frmFreeDBase: TfrmFreeDBase
  Left = 139
  Top = 77
  HelpContext = 506
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1582#1575#1604#1610' '#1606#1605#1608#1583#1606' '#1576#1575#1606#1603' '#1575#1591#1604#1575#1593#1575#1578#1610
  ClientHeight = 213
  ClientWidth = 391
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
  object Label1: TLabel
    Left = 235
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575#1586' '#1578#1575#1585#1610#1582
  end
  object Label2: TLabel
    Left = 102
    Top = 8
    Width = 32
    Height = 15
    Caption = #1578#1575' '#1578#1575#1585#1610#1582
  end
  object Label3: TLabel
    Left = 235
    Top = 40
    Width = 35
    Height = 15
    Caption = #1575#1586' '#1578#1575#1585#1610#1582
  end
  object Label4: TLabel
    Left = 102
    Top = 40
    Width = 32
    Height = 15
    Caption = #1578#1575' '#1578#1575#1585#1610#1582
  end
  object Label5: TLabel
    Left = 235
    Top = 72
    Width = 35
    Height = 15
    Caption = #1575#1586' '#1578#1575#1585#1610#1582
  end
  object Label6: TLabel
    Left = 102
    Top = 72
    Width = 32
    Height = 15
    Caption = #1578#1575' '#1578#1575#1585#1610#1582
  end
  object cmdDel: TBitBtn
    Left = 280
    Top = 184
    Width = 105
    Height = 25
    Caption = '&'#1581#1584#1601
    TabOrder = 15
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
    Top = 184
    Width = 105
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 16
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 184
    Width = 105
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 17
    Kind = bkClose
  end
  object chkFish: TCheckBox
    Left = 304
    Top = 8
    Width = 81
    Height = 17
    Caption = #1581#1584#1601' '#1601#1610#1588#1607#1575
    TabOrder = 0
    OnClick = chkFishClick
    OnKeyPress = chkFishKeyPress
  end
  object chkProgram: TCheckBox
    Left = 272
    Top = 40
    Width = 113
    Height = 17
    Caption = #1581#1584#1601' '#1576#1585#1606#1575#1605#1607' '#1607#1601#1578#1711#1610
    TabOrder = 3
    OnClick = chkProgramClick
    OnKeyPress = chkFishKeyPress
  end
  object txtFromFish: TEdit
    Left = 144
    Top = 8
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtFromFishExit
    OnKeyPress = txtFromFishKeyPress
  end
  object txtToFish: TEdit
    Left = 8
    Top = 8
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnExit = txtToFishExit
    OnKeyPress = txtFromFishKeyPress
  end
  object txtFromProg: TEdit
    Left = 144
    Top = 40
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 4
    OnExit = txtFromProgExit
    OnKeyPress = txtFromFishKeyPress
  end
  object txtToProg: TEdit
    Left = 8
    Top = 40
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 5
    OnExit = txtToProgExit
    OnKeyPress = txtFromFishKeyPress
  end
  object chkPricing: TCheckBox
    Left = 280
    Top = 72
    Width = 105
    Height = 17
    Caption = #1581#1584#1601' '#1602#1610#1605#1578' '#1711#1584#1575#1585#1610
    TabOrder = 6
    OnClick = chkPricingClick
    OnKeyPress = chkFishKeyPress
  end
  object chkFoods: TCheckBox
    Left = 272
    Top = 112
    Width = 113
    Height = 17
    Caption = #1581#1584#1601' '#1604#1610#1587#1578' '#1594#1584#1575#1607#1575
    TabOrder = 9
    OnKeyPress = chkFishKeyPress
  end
  object txtFromPrice: TEdit
    Left = 144
    Top = 72
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 7
    OnExit = txtFromPriceExit
    OnKeyPress = txtFromFishKeyPress
  end
  object txtToPrice: TEdit
    Left = 8
    Top = 72
    Width = 81
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 8
    OnExit = txtToPriceExit
    OnKeyPress = txtFromFishKeyPress
  end
  object chkGuest: TCheckBox
    Left = 136
    Top = 112
    Width = 129
    Height = 17
    Caption = #1581#1584#1601' '#1603#1575#1585#1578#1607#1575#1610' '#1605#1610#1607#1605#1575#1606
    TabOrder = 10
    OnKeyPress = chkFishKeyPress
  end
  object chkPersons: TCheckBox
    Left = 40
    Top = 112
    Width = 81
    Height = 17
    Caption = #1581#1584#1601' '#1662#1585#1587#1606#1604
    TabOrder = 11
    OnKeyPress = chkFishKeyPress
  end
  object chkParts: TCheckBox
    Left = 304
    Top = 144
    Width = 81
    Height = 17
    Caption = #1581#1584#1601' '#1576#1582#1588#1607#1575
    TabOrder = 12
    OnKeyPress = chkFishKeyPress
  end
  object chkJobType: TCheckBox
    Left = 152
    Top = 144
    Width = 113
    Height = 17
    Caption = #1581#1584#1601' '#1575#1606#1608#1575#1593' '#1575#1587#1578#1582#1583#1575#1605
    TabOrder = 13
    OnKeyPress = chkFishKeyPress
  end
  object chkUnits: TCheckBox
    Left = 0
    Top = 144
    Width = 121
    Height = 17
    Caption = #1581#1584#1601' '#1608#1575#1581#1583#1607#1575#1610' '#1578#1575#1576#1593#1607
    TabOrder = 14
    OnKeyPress = chkFishKeyPress
  end
end
