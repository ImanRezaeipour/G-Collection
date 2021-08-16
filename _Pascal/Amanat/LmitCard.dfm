object frmLimitCard: TfrmLimitCard
  Left = 164
  Top = 110
  HelpContext = 69
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '„⁄—›Ì „ÕœÊœÂ ›⁄«·Ì  ‘„«—Â ﬂ«— Â«Ì  —„Ì‰«·Â«'
  ClientHeight = 280
  ClientWidth = 400
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
  OnKeyPress = cmbReadersKeyPress
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 357
    Top = 8
    Width = 38
    Height = 15
    Caption = '& —„Ì‰«·'
    FocusControl = cmbReaders
  end
  object lbl2: TLabel
    Left = 132
    Top = 8
    Width = 34
    Height = 15
    Caption = '&⁄„·Ì« '
    FocusControl = cmbOperate
  end
  object cmbReaders: TComboBox
    Left = 176
    Top = 8
    Width = 177
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
    OnKeyPress = cmbReadersKeyPress
  end
  object cmbOperate: TComboBox
    Left = 8
    Top = 8
    Width = 121
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 1
    OnKeyPress = cmbReadersKeyPress
    Items.Strings = (
      ' ‰ŸÌ„ „ÕœÊœÂ ﬂ«— Â«'
      'ŒÊ«‰œ‰ „ÕœÊœÂ ﬂ«— Â«')
  end
  object cmdOk: TBitBtn
    Left = 8
    Top = 184
    Width = 105
    Height = 25
    Caption = '«&Ã—«'
    TabOrder = 3
    OnClick = cmdOkClick
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
    Left = 8
    Top = 248
    Width = 105
    Height = 25
    Caption = '&Œ—ÊÃ'
    TabOrder = 5
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 8
    Top = 216
    Width = 105
    Height = 25
    Caption = '—«&Â‰„«'
    TabOrder = 4
    Kind = bkHelp
  end
  object grdPishCard: TStringGrid
    Left = 120
    Top = 40
    Width = 273
    Height = 233
    BiDiMode = bdLeftToRight
    ColCount = 3
    FixedCols = 0
    RowCount = 9
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentBiDiMode = False
    TabOrder = 2
    OnClick = grdPishCardEnter
    OnEnter = grdPishCardEnter
    OnKeyPress = grdPishCardKeyPress
  end
end
