object frmAllChange: TfrmAllChange
  Left = 348
  Top = 131
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '«’·«Õ«  ﬂ·Ì Å—”‰·'
  ClientHeight = 232
  ClientWidth = 319
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 293
    Top = 7
    Width = 20
    Height = 15
    Caption = '›&⁄«·'
    FocusControl = cmbActive
  end
  object lbl2: TLabel
    Left = 261
    Top = 35
    Width = 52
    Height = 15
    Caption = '&€–«Ì «÷«›Ì'
    FocusControl = cmbFood
  end
  object lbl3: TLabel
    Left = 235
    Top = 64
    Width = 78
    Height = 15
    Caption = 'Å—”‰· —&éÌ„Ì'
    FocusControl = cmbRejim
  end
  object lbl5: TLabel
    Left = 250
    Top = 120
    Width = 63
    Height = 15
    Caption = '”—Ê &’»Õ«‰Â'
    FocusControl = cmbSobh
  end
  object lbl6: TLabel
    Left = 251
    Top = 148
    Width = 62
    Height = 15
    Caption = '”—Ê &‰«Â«—'
    FocusControl = cmbNahar
  end
  object lbl7: TLabel
    Left = 243
    Top = 176
    Width = 70
    Height = 15
    Caption = '”—Ê «&›ÿ«—Ì'
    FocusControl = cmbSham
  end
  object lbl4: TLabel
    Left = 247
    Top = 92
    Width = 65
    Height = 15
    Caption = '”—Ê &”Õ—Ì'
    FocusControl = cmbSahari
  end
  object lbl8: TLabel
    Left = 265
    Top = 205
    Width = 47
    Height = 15
    Caption = '”—Ê &‘«„'
    FocusControl = cmbEftari
  end
  object cmbActive: TComboBox
    Left = 99
    Top = 7
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
  end
  object cmbFood: TComboBox
    Left = 99
    Top = 35
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 1
  end
  object cmbRejim: TComboBox
    Left = 99
    Top = 64
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 2
  end
  object cmbSobh: TComboBox
    Left = 99
    Top = 120
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 4
  end
  object cmbNahar: TComboBox
    Left = 99
    Top = 148
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 5
  end
  object cmbSham: TComboBox
    Left = 99
    Top = 205
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 7
  end
  object cmdChange: TBitBtn
    Left = 7
    Top = 7
    Width = 86
    Height = 22
    Caption = '&À»   €ÌÌ—« '
    TabOrder = 8
    OnClick = cmdChangeClick
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
  object cmdHelp: TBitBtn
    Left = 7
    Top = 176
    Width = 86
    Height = 23
    Caption = '—«&Â‰„«'
    TabOrder = 9
    Kind = bkHelp
  end
  object cmdClose: TBitBtn
    Left = 7
    Top = 205
    Width = 86
    Height = 22
    Caption = '&«‰’—«›'
    TabOrder = 10
    Kind = bkCancel
  end
  object cmbSahari: TComboBox
    Left = 99
    Top = 92
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 3
  end
  object cmbEftari: TComboBox
    Left = 99
    Top = 176
    Width = 142
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 6
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 32
    Top = 48
  end
end
