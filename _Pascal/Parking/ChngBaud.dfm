object frmChngBaud: TfrmChngBaud
  Left = 102
  Top = 117
  HelpContext = 203
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1594#1610#1610#1585' '#1587#1585#1593#1578' '#1575#1585#1578#1576#1575#1591
  ClientHeight = 149
  ClientWidth = 316
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
  object Label1: TLabel
    Left = 101
    Top = 0
    Width = 63
    Height = 15
    Caption = '&'#1587#1585#1593#1578'  '#1575#1585#1578#1576#1575#1591
    FocusControl = lstBaud
  end
  object Label2: TLabel
    Left = 228
    Top = 0
    Width = 42
    Height = 15
    Caption = '&'#1606#1575#1605' '#1583#1587#1578#1711#1575#1607
    FocusControl = lstReader
  end
  object lblMsg: TLabel
    Left = 7
    Top = 127
    Width = 304
    Height = 15
    AutoSize = False
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cmdOK: TBitBtn
    Left = 7
    Top = 14
    Width = 79
    Height = 22
    Caption = '&'#1578#1571#1610#1610#1583
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
  object cmdExit: TBitBtn
    Left = 7
    Top = 99
    Width = 79
    Height = 22
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 4
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 7
    Top = 71
    Width = 79
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 3
    Kind = bkHelp
  end
  object lstReader: TListBox
    Left = 191
    Top = 14
    Width = 120
    Height = 107
    ItemHeight = 15
    TabOrder = 0
    OnClick = lstReaderClick
    OnKeyPress = lstReaderKeyPress
  end
  object lstBaud: TListBox
    Left = 92
    Top = 14
    Width = 92
    Height = 107
    BiDiMode = bdLeftToRight
    ItemHeight = 15
    ParentBiDiMode = False
    TabOrder = 1
    OnClick = lstBaudClick
    OnKeyPress = lstBaudKeyPress
  end
end
