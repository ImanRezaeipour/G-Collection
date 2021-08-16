object frmReadFish: TfrmReadFish
  Left = 136
  Top = 106
  HelpContext = 509
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1582#1608#1575#1606#1583#1606' '#1601#1610#1588#1607#1575' '#1575#1586' '#1583#1610#1587#1603
  ClientHeight = 136
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 283
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
  end
  object Label2: TLabel
    Left = 118
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
  end
  object Label3: TLabel
    Left = 9
    Top = 56
    Width = 21
    Height = 15
    Caption = '&'#1605#1587#1610#1585
  end
  object txtFromDate: TEdit
    Left = 176
    Top = 8
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 8
    Top = 8
    Width = 97
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtToDateKeyPress
  end
  object txtPath: TEdit
    Left = 40
    Top = 56
    Width = 257
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    OnKeyPress = txtPathKeyPress
  end
  object cmdOK: TBitBtn
    Left = 232
    Top = 104
    Width = 91
    Height = 25
    Caption = '&'#1578#1575#1610#1610#1583
    TabOrder = 3
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
  object cmdHelp: TBitBtn
    Left = 120
    Top = 104
    Width = 91
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 4
    Kind = bkHelp
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 104
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 5
    Kind = bkClose
  end
  object cmdPath: TButton
    Left = 296
    Top = 56
    Width = 27
    Height = 25
    Caption = '...'
    TabOrder = 6
    OnClick = cmdPathClick
  end
end
