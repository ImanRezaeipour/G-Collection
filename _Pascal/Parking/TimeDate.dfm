object frmDateTime: TfrmDateTime
  Left = 143
  Top = 147
  HelpContext = 605
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = ' ‰ŸÌ„  «—ÌŒ Ê “„«‰ ”Ì” „'
  ClientHeight = 62
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 200
    Top = 7
    Width = 28
    Height = 15
    Caption = '& «—ÌŒ'
  end
  object lbl2: TLabel
    Left = 204
    Top = 35
    Width = 21
    Height = 15
    Caption = '&“„«‰'
  end
  object txtDate: TEdit
    Left = 120
    Top = 7
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnKeyDown = txtDateKeyDown
    OnKeyPress = txtDateKeyPress
  end
  object txtTime: TEdit
    Left = 120
    Top = 35
    Width = 79
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 5
    ParentBiDiMode = False
    TabOrder = 1
    OnKeyDown = txtTimeKeyDown
    OnKeyPress = txtTimeKeyPress
  end
  object cmdOK: TBitBtn
    Left = 7
    Top = 7
    Width = 79
    Height = 22
    Caption = '& √ÌÌœ'
    ModalResult = 1
    TabOrder = 2
    OnClick = cmdOKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cmdCancel: TBitBtn
    Left = 7
    Top = 35
    Width = 79
    Height = 22
    Caption = '&«‰’—«›'
    TabOrder = 3
    Kind = bkCancel
  end
  object tmrTime: TTimer
    OnTimer = tmrTimeTimer
    Left = 104
    Top = 16
  end
end
