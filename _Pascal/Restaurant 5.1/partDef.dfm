object frmPartDef: TfrmPartDef
  Left = 290
  Top = 297
  ActiveControl = txtCode
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1576#1582#1588' '#1580#1583#1610#1583
  ClientHeight = 145
  ClientWidth = 337
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
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 287
    Top = 45
    Width = 43
    Height = 15
    Caption = #1606#1575#1605' '#1576#1582#1588' :'
  end
  object Label2: TLabel
    Left = 288
    Top = 16
    Width = 42
    Height = 15
    Caption = #1705#1583' '#1576#1582#1588' :'
  end
  object Bevel1: TBevel
    Left = 3
    Top = 102
    Width = 330
    Height = 7
    Shape = bsTopLine
  end
  object txtCode: TEdit
    Left = 144
    Top = 12
    Width = 123
    Height = 23
    TabOrder = 3
    OnKeyPress = txtCodeKeyPress
  end
  object txtName: TEdit
    Left = 8
    Top = 40
    Width = 259
    Height = 23
    TabOrder = 0
    Text = #1586#1610#1585#1576#1582#1588
  end
  object cmdSave: TBitBtn
    Left = 222
    Top = 113
    Width = 110
    Height = 25
    Caption = '&'#1579#1576#1578
    TabOrder = 1
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
  object BitBtn2: TBitBtn
    Left = 7
    Top = 113
    Width = 110
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    ModalResult = 2
    TabOrder = 2
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object DosMove1: TDosMove
    Active = True
    Left = 64
    Top = 72
  end
end