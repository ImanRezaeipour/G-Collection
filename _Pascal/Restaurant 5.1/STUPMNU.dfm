object frmSetup: TfrmSetup
  Left = 137
  Top = 45
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '»—‰«„Â ‰’» ”Ì” „ —” Ê—«‰'
  ClientHeight = 271
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00887777007700000000000000000000008887
    7770077000000000000000000000F8887777007700000000000000000000FF88
    8777700770000000000000000000FFF88877770077000000000000000000FFFF
    88877770077000000000000000000FFFF88877770077000000000000000000FF
    FF88877770077000000000000000000FFFF88877770077777777777000000000
    FFFF88877770077777777777000000000FFFF888777700000000000770000000
    00FFFF88877777777777777077000000000FFFF8887777777777777707700000
    0000FFFF88877777777777777077000000000FFFF88888888888887777070000
    000000FFFFFFFFFFFFFFFF87777000000000000FFF77770000008FF877700000
    0000000FF8777077000008F8777000000000000FF87770770000008877700000
    0000000FF877707700000008777000000000000FF87770770000000877700000
    0000000FF877707700000008777000000000000FF87770770000000877700000
    0000000FF87770777000000F777000000000000FF877770777777000F8700000
    0000000FF8777770777777000FF000000000000FFF8777770000077000000000
    00000000FFF877777777707700000000000000000FFF87777777770770000000
    0000000000FFF888888887707000000000000000000FFFFFFFFFF87070000000
    0000000000000000000000007000003FFFFF001FFFFF000FFFFF0007FFFF0003
    FFFF0001FFFF0000FFFF80007FFFC000001FE000000FF0000007F8000003FC00
    0001FE000000FF000000FF800000FFC00000FFC00F00FFC00F80FFC00FC0FFC0
    0FC0FFC00FC0FFC00FC0FFC007C0FFC00060FFC00030FFC00018FFE0000FFFF0
    0007FFF80007FFFC0007FFFE0007280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008877070000000000F887
    707000000000FF887707000000000FF887707000000000FF887707777000000F
    F887700007000000FF887777707000000FF88FFF8707000000F70000F8700000
    00F707000F80000000F707000080000000F707700080000000F7707770000000
    000F7700070000000000FFFFF000000000000000000003FF000001FF000000FF
    0000007F000080070000C0030000E0010000F0000000F8000000F8300000F838
    0000F8180000F8040000FC030000FE030000FF030000}
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 229
    Top = 8
    Width = 97
    Height = 15
    Caption = '&‰«„ ‘—ﬂ /„ƒ””Â'
    FocusControl = txtCoName
  end
  object Label2: TLabel
    Left = 299
    Top = 80
    Width = 23
    Height = 15
    Caption = '„&ﬁ’œ'
    FocusControl = txtPath
  end
  object Label3: TLabel
    Left = 302
    Top = 40
    Width = 27
    Height = 15
    Caption = '‘⁄»Â'
    FocusControl = txtShobeh
  end
  object txtCoName: TEdit
    Left = 8
    Top = 8
    Width = 225
    Height = 23
    TabOrder = 0
  end
  object txtPath: TEdit
    Left = 8
    Top = 80
    Width = 257
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
  end
  object cmdPath: TBitBtn
    Left = 264
    Top = 80
    Width = 27
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = cmdPathClick
  end
  object grpSecurit: TGroupBox
    Left = 8
    Top = 112
    Width = 321
    Height = 49
    TabOrder = 4
    object rdoSerial: TRadioButton
      Left = 232
      Top = 16
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&‘„«—Â ”—Ì«·'
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnClick = rdoSerialClick
    end
    object rdoPass: TRadioButton
      Left = 160
      Top = 16
      Width = 33
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '—&„“'
      ParentBiDiMode = False
      TabOrder = 1
      OnClick = rdoSerialClick
    end
    object txtPass: TEdit
      Left = 8
      Top = 16
      Width = 145
      Height = 23
      BiDiMode = bdLeftToRight
      Enabled = False
      ParentBiDiMode = False
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object cmdOK: TBitBtn
    Left = 240
    Top = 240
    Width = 91
    Height = 25
    Caption = '& √ÌÌœ'
    TabOrder = 6
    OnClick = cmdOKClick
    Kind = bkOK
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 240
    Width = 89
    Height = 25
    Caption = '&Œ—ÊÃ'
    TabOrder = 7
    Kind = bkClose
  end
  object txtShobeh: TEdit
    Left = 8
    Top = 40
    Width = 225
    Height = 23
    BiDiMode = bdRightToLeft
    ParentBiDiMode = False
    TabOrder = 1
  end
  object rdoWinType: TRadioGroup
    Left = 8
    Top = 168
    Width = 321
    Height = 57
    BiDiMode = bdLeftToRight
    Caption = 'Windows ‰Ê⁄'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Sina System Code'
      'MicroSoft System Code')
    ParentBiDiMode = False
    TabOrder = 5
  end
end
