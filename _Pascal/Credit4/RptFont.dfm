object frmReportFont: TfrmReportFont
  Left = 198
  Top = 159
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1606#1578#1582#1575#1576' '#1601#1608#1606#1578' '#1711#1586#1575#1585#1588#1575#1578
  ClientHeight = 96
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 3
    Top = 7
    Width = 75
    Height = 15
    Caption = #1601#1608#1606#1578' '#1578#1610#1578#1585' '#1711#1586#1575#1585#1588
  end
  object lbl2: TLabel
    Left = 229
    Top = 7
    Width = 23
    Height = 15
    Caption = #1575#1606#1583#1575#1586#1607
  end
  object lbl3: TLabel
    Left = 3
    Top = 35
    Width = 75
    Height = 15
    Caption = #1601#1608#1606#1578' '#1605#1578#1606' '#1711#1586#1575#1585#1588
  end
  object lbl4: TLabel
    Left = 229
    Top = 35
    Width = 23
    Height = 15
    Caption = #1575#1606#1583#1575#1586#1607
  end
  object txtTitrSize: TEdit
    Left = 261
    Top = 7
    Width = 36
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
    OnKeyPress = txtTitrSizeKeyPress
  end
  object cmdTitrSel: TButton
    Left = 304
    Top = 7
    Width = 22
    Height = 22
    Caption = '...'
    TabOrder = 2
    OnClick = cmdTitrSelClick
  end
  object txtTitleFont: TEdit
    Left = 85
    Top = 7
    Width = 135
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    ReadOnly = True
    TabOrder = 0
  end
  object txtReportSize: TEdit
    Left = 261
    Top = 35
    Width = 36
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 4
    OnKeyPress = txtTitrSizeKeyPress
  end
  object cmdFontSel: TButton
    Left = 304
    Top = 35
    Width = 22
    Height = 22
    Caption = '...'
    TabOrder = 5
    OnClick = cmdFontSelClick
  end
  object txtReportFont: TEdit
    Left = 85
    Top = 35
    Width = 135
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    ReadOnly = True
    TabOrder = 3
  end
  object cmdOK: TBitBtn
    Left = 226
    Top = 71
    Width = 100
    Height = 22
    Caption = '&'#1579#1576#1578
    TabOrder = 6
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
    Top = 71
    Width = 100
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 7
    Kind = bkHelp
  end
  object cmdCancel: TBitBtn
    Left = 14
    Top = 71
    Width = 100
    Height = 22
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 8
    Kind = bkCancel
  end
  object fntSelect: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 176
    Top = 16
  end
end
