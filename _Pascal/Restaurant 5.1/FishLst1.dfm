object frmFishLst1: TfrmFishLst1
  Left = 249
  Top = 213
  BiDiMode = bdRightToLeft
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1604#1610#1587#1578' '#1601#1610#1588#1607#1575#1610' '#1589#1575#1583#1585#1607
  ClientHeight = 149
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ParentBiDiMode = False
  Scaled = False
  WindowState = wsMaximized
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grdFishLst: TStringGrid
    Left = 0
    Top = 0
    Width = 625
    Height = 149
    Hint = '+/- '#1578#1594#1610#1610#1585' '#1575#1606#1583#1575#1586#1607' '#1601#1608#1606#1578
    Align = alClient
    ColCount = 7
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnKeyDown = grdFishLstKeyDown
    OnKeyPress = grdFishLstKeyPress
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 24
    Top = 32
  end
end
