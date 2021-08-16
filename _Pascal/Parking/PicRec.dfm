object frmPictureRec: TfrmPictureRec
  Left = 181
  Top = 206
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1580#1605#1593' '#1570#1608#1585#1610' '#1583#1575#1574#1605#1610' '#1608' '#1606#1605#1575#1610#1588' '#1578#1589#1608#1610#1585' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1587#1575#1593#1578
  ClientHeight = 391
  ClientWidth = 621
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
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblRec: TLabel
    Left = 91
    Top = 272
    Width = 35
    Height = 15
    Caption = 'lblRec'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 135
    Top = 272
    Width = 63
    Height = 15
    Caption = #1578#1593#1583#1575#1583' '#1585#1603#1608#1585#1583#1607#1575':'
  end
  object lblConnect: TLabel
    Left = 8
    Top = 312
    Width = 193
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblConnect'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlPicture: TPanel
    Left = 8
    Top = 40
    Width = 198
    Height = 219
    Alignment = taLeftJustify
    BevelInner = bvLowered
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object imgPicture: TImage
      Left = 2
      Top = 2
      Width = 193
      Height = 215
      Stretch = True
    end
    object lblCredit: TLabel
      Left = 14
      Top = 103
      Width = 171
      Height = 34
      Alignment = taCenter
      AutoSize = False
      BiDiMode = bdRightToLeft
      Caption = #1601#1575#1602#1583' '#1575#1593#1578#1576#1575#1585
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      Transparent = True
      Visible = False
    end
  end
  object cmdExit: TBitBtn
    Left = 56
    Top = 360
    Width = 99
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 1
    OnClick = cmdExitClick
    Kind = bkCancel
  end
  object grdRecs: TStringGrid
    Left = 208
    Top = 8
    Width = 409
    Height = 377
    ColCount = 4
    FixedCols = 0
    TabOrder = 2
    ColWidths = (
      64
      64
      68
      64)
  end
  object prgBar: TProgressBar
    Left = 8
    Top = 8
    Width = 193
    Height = 9
    TabOrder = 3
  end
  object mp: TMediaPlayer
    Left = 186
    Top = 363
    Width = 253
    Height = 20
    Visible = False
    TabOrder = 4
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 16
    Top = 56
  end
  object adotblRecs: TADOQuery
    Parameters = <>
    Left = 48
    Top = 56
  end
end
