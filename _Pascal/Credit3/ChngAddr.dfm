object frmChngAddr: TfrmChngAddr
  Left = 121
  Top = 161
  HelpContext = 65
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = ' €ÌÌ— ﬂœ œ” ﬂ«Â'
  ClientHeight = 205
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object cmdOK: TBitBtn
    Left = 424
    Top = 176
    Width = 97
    Height = 25
    Caption = '& €ÌÌ— ﬂœ'
    TabOrder = 0
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
    Left = 8
    Top = 176
    Width = 97
    Height = 25
    Caption = '&Œ—ÊÃ'
    TabOrder = 2
    Kind = bkClose
  end
  object cmdHelp: TBitBtn
    Left = 112
    Top = 176
    Width = 97
    Height = 25
    Caption = '—«&Â‰„«'
    TabOrder = 1
    Kind = bkHelp
  end
  object grdReaders: TXStringGrid
    Left = 8
    Top = 0
    Width = 513
    Height = 169
    ColCount = 4
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 3
    FixedLineColor = clBlack
    Columns = <
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Caption = 'ﬂœ ﬁ»·Ì'
        Width = 53
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        Alignment = taCenter
      end
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Caption = '⁄‰Ê«‰'
        Width = 170
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        Alignment = taRightJustify
      end
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Caption = 'ﬂœ ÃœÌœ'
        Width = 58
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        Alignment = taCenter
        Editor = EditCellEditor1
      end
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Caption = '‰ ÌÃÂ'
        Width = 204
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        Alignment = taRightJustify
      end>
    MultiLine = False
    ImmediateEditMode = False
    ColWidths = (
      53
      170
      58
      204)
  end
  object EditCellEditor1: TEditCellEditor
    hasElipsis = False
    Left = 144
    Top = 56
  end
end
