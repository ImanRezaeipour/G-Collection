object frmReadArchive: TfrmReadArchive
  Left = 160
  Top = 150
  HelpContext = 608
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1576#1575#1586#1582#1608#1575#1606#1610' '#1575#1591#1604#1575#1593#1575#1578' '#1605#1575#1607#1575#1606#1607
  ClientHeight = 79
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 239
    Top = 7
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
    FocusControl = txtFromDate
  end
  object Label2: TLabel
    Left = 100
    Top = 7
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
    FocusControl = txtToDate
  end
  object cmdOK: TBitBtn
    Left = 191
    Top = 49
    Width = 85
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
  object cmdCancel: TBitBtn
    Left = 7
    Top = 49
    Width = 86
    Height = 22
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 3
    Kind = bkCancel
  end
  object cmdHelp: TBitBtn
    Left = 99
    Top = 49
    Width = 85
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 4
    Kind = bkHelp
  end
  object txtFromDate: TEdit
    Left = 148
    Top = 7
    Width = 86
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 7
    Top = 7
    Width = 86
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtFromDateKeyPress
  end
end
