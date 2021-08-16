object frmMnuItemList: TfrmMnuItemList
  Left = 13
  Top = 147
  BiDiMode = bdRightToLeft
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 176
  ClientWidth = 534
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
  PixelsPerInch = 96
  TextHeight = 15
  object pnlCheckBox: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 142
    Align = alTop
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 360
      Top = 14
      Width = 166
      Height = 15
      Caption = 'CheckBox1'
      TabOrder = 0
      Visible = False
    end
    object CheckBox2: TCheckBox
      Left = 360
      Top = 35
      Width = 166
      Height = 15
      Caption = 'CheckBox2'
      TabOrder = 1
      Visible = False
    end
    object CheckBox3: TCheckBox
      Left = 360
      Top = 56
      Width = 166
      Height = 15
      Caption = 'CheckBox3'
      TabOrder = 2
      Visible = False
    end
    object CheckBox4: TCheckBox
      Left = 360
      Top = 78
      Width = 166
      Height = 15
      Caption = 'CheckBox4'
      TabOrder = 3
      Visible = False
    end
    object CheckBox5: TCheckBox
      Left = 360
      Top = 99
      Width = 166
      Height = 15
      Caption = 'CheckBox5'
      TabOrder = 4
      Visible = False
    end
    object CheckBox6: TCheckBox
      Left = 360
      Top = 120
      Width = 166
      Height = 15
      Caption = 'CheckBox6'
      TabOrder = 5
      Visible = False
    end
    object CheckBox7: TCheckBox
      Left = 184
      Top = 14
      Width = 165
      Height = 15
      Caption = 'CheckBox7'
      TabOrder = 6
      Visible = False
    end
    object CheckBox8: TCheckBox
      Left = 184
      Top = 35
      Width = 165
      Height = 15
      Caption = 'CheckBox8'
      TabOrder = 7
      Visible = False
    end
    object CheckBox9: TCheckBox
      Left = 184
      Top = 56
      Width = 165
      Height = 15
      Caption = 'CheckBox9'
      TabOrder = 8
      Visible = False
    end
    object CheckBox10: TCheckBox
      Left = 184
      Top = 78
      Width = 165
      Height = 15
      Caption = 'CheckBox10'
      TabOrder = 9
      Visible = False
    end
    object CheckBox11: TCheckBox
      Left = 184
      Top = 99
      Width = 165
      Height = 15
      Caption = 'CheckBox11'
      TabOrder = 10
      Visible = False
    end
    object CheckBox12: TCheckBox
      Left = 184
      Top = 120
      Width = 165
      Height = 15
      Caption = 'CheckBox12'
      TabOrder = 11
      Visible = False
    end
    object CheckBox13: TCheckBox
      Left = 7
      Top = 14
      Width = 166
      Height = 15
      Caption = 'CheckBox13'
      TabOrder = 12
      Visible = False
    end
    object CheckBox14: TCheckBox
      Left = 7
      Top = 35
      Width = 166
      Height = 15
      Caption = 'CheckBox14'
      TabOrder = 13
      Visible = False
    end
    object CheckBox15: TCheckBox
      Left = 7
      Top = 56
      Width = 166
      Height = 15
      Caption = 'CheckBox15'
      TabOrder = 14
      Visible = False
    end
    object CheckBox16: TCheckBox
      Left = 7
      Top = 78
      Width = 166
      Height = 15
      Caption = 'CheckBox16'
      TabOrder = 15
      Visible = False
    end
    object CheckBox17: TCheckBox
      Left = 7
      Top = 99
      Width = 166
      Height = 15
      Caption = 'CheckBox17'
      TabOrder = 16
      Visible = False
    end
    object CheckBox18: TCheckBox
      Left = 7
      Top = 120
      Width = 166
      Height = 15
      Caption = 'CheckBox18'
      TabOrder = 17
      Visible = False
    end
  end
  object pnlButton: TPanel
    Left = 0
    Top = 142
    Width = 534
    Height = 35
    Align = alTop
    TabOrder = 1
    object cmdCancel: TBitBtn
      Left = 7
      Top = 7
      Width = 93
      Height = 22
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      ModalResult = 2
      TabOrder = 4
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
      Left = 205
      Top = 7
      Width = 92
      Height = 22
      Caption = '&'#1579#1576#1578
      ModalResult = 1
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
    object cmdAll: TBitBtn
      Left = 431
      Top = 7
      Width = 92
      Height = 22
      Caption = #1607'&'#1605#1607
      TabOrder = 0
      OnClick = cmdAllClick
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
    object cmdNone: TBitBtn
      Left = 332
      Top = 7
      Width = 92
      Height = 22
      Cancel = True
      Caption = '&'#1607#1610#1670#1603#1583#1575#1605
      TabOrder = 2
      OnClick = cmdNoneClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333FFFFF333333000033333388888833333333333F888888FFF333
        000033338811111188333333338833FFF388FF33000033381119999111833333
        38F338888F338FF30000339119933331111833338F388333383338F300003391
        13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
        33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
        33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
        000039183811193333918338F8F833F83333838F000039118111933339118338
        F3833F83333833830000339111193333391833338F33F8333FF838F300003391
        11833338111833338F338FFFF883F83300003339111888811183333338FF3888
        83FF83330000333399111111993333333388FFFFFF8833330000333333999999
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object cmdHelp: TBitBtn
      Left = 106
      Top = 6
      Width = 93
      Height = 22
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 3
      Kind = bkHelp
    end
  end
end
