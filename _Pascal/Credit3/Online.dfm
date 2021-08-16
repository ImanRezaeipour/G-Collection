object frmOnline: TfrmOnline
  Left = 1
  Top = 29
  Width = 634
  Height = 395
  BiDiMode = bdRightToLeft
  BorderIcons = []
  Caption = #1606#1605#1575#1610#1588' '#1608#1590#1593#1610#1578' '#1603#1575#1585#1578#1582#1608#1575#1606#1607#1575
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ParentBiDiMode = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grd: TXStringGrid
    Left = 0
    Top = 0
    Width = 626
    Height = 291
    Align = alClient
    ColCount = 8
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 0
    FixedLineColor = clBlack
    Columns = <
      item
        HeaderFont.Charset = ARABIC_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -13
        HeaderFont.Name = 'Arabic Transparent'
        HeaderFont.Style = []
        HeaderAlignment = taCenter
        Caption = #1603#1575#1585#1578#1582#1608#1575#1606
        Width = 72
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
        Caption = #1588#1605#1575#1585#1607' '#1601#1585#1583
        Width = 56
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
        Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605
        Width = 101
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
        Caption = #1607#1586#1610#1606#1607' '#1582#1583#1605#1575#1578
        Width = 70
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
        Caption = #1605#1575#1606#1583#1607' '#1575#1593#1578#1576#1575#1585
        Width = 63
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
        Caption = #1586#1605#1575#1606
        Width = 43
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
        Caption = #1578#1608#1590#1610#1581#1575#1578
        Width = 104
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
        Caption = #1587#1585#1608#1610#1587
        Width = 329
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
      72
      56
      101
      70
      63
      43
      104
      329)
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 291
    Width = 626
    Height = 77
    Align = alBottom
    TabOrder = 1
    object lblReader: TLabel
      Left = 580
      Top = 17
      Width = 44
      Height = 15
      Align = alRight
      Caption = #1603#1575#1585#1578#1582#1608#1575#1606':'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object btnCancel: TBitBtn
      Left = 8
      Top = 38
      Width = 105
      Height = 25
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 0
      OnClick = btnCancelClick
      Kind = bkCancel
    end
    object Panel1: TPanel
      Left = 128
      Top = 16
      Width = 297
      Height = 57
      TabOrder = 1
      object lblservice: TLabel
        Left = 205
        Top = 1
        Width = 91
        Height = 15
        Align = alRight
        Anchors = [akLeft, akBottom]
        Caption = '-------------'
        Color = clBtnFace
        Font.Charset = ARABIC_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
      end
    end
  end
end
