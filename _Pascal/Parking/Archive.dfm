object frmArchive: TfrmArchive
  Left = 137
  Top = 122
  HelpContext = 606
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1576#1575#1610#1711#1575#1606#1610' '#1605#1575#1607#1575#1606#1607' '#1575#1591#1604#1575#1593#1575#1578
  ClientHeight = 91
  ClientWidth = 282
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 193
    Top = 7
    Width = 29
    Height = 15
    Caption = #1578#1575' &'#1662#1575#1610#1575#1606
    FocusControl = cmbMonth
  end
  object Label2: TLabel
    Left = 73
    Top = 7
    Width = 12
    Height = 15
    Caption = '&'#1605#1575#1607
    FocusControl = cmbMonth
  end
  object lblArchive: TLabel
    Left = 182
    Top = 35
    Width = 91
    Height = 14
    Caption = #1582#1608#1583#1585#1608#1607#1575#1610' '#1576#1575#1610#1711#1575#1606#1610' '#1588#1583#1607
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object cmbMonth: TComboBox
    Left = 92
    Top = 7
    Width = 92
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
    OnKeyPress = cmbMonthKeyPress
    Items.Strings = (
      #1601#1585#1608#1585#1583#1610#1606
      #1575#1585#1583#1610#1576#1607#1588#1578
      #1582#1585#1583#1575#1583
      #1578#1610#1585
      #1605#1585#1583#1575#1583
      #1588#1607#1585#1610#1608#1585
      #1605#1607#1585
      #1570#1576#1575#1606
      #1570#1584#1585
      #1583#1610
      #1576#1607#1605#1606
      #1575#1587#1601#1606#1583)
  end
  object cmdOK: TBitBtn
    Left = 191
    Top = 64
    Width = 85
    Height = 22
    Caption = '&'#1578#1571#1610#1610#1583
    Default = True
    TabOrder = 1
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
    Top = 64
    Width = 86
    Height = 22
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 3
    Kind = bkCancel
  end
  object cmdHelp: TBitBtn
    Left = 99
    Top = 64
    Width = 85
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 2
    Kind = bkHelp
  end
end
