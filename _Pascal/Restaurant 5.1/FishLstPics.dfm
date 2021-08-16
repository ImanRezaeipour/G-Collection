object frmFishLstPics: TfrmFishLstPics
  Left = 249
  Top = 213
  BiDiMode = bdRightToLeft
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1604#1610#1587#1578' '#1601#1610#1588#1607#1575#1610' '#1589#1575#1583#1585#1607' '#1578#1589#1608#1610#1585#1610
  ClientHeight = 646
  ClientWidth = 961
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
  WindowState = wsMaximized
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    961
    646)
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 482
    Top = 0
    Width = 479
    Height = 646
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    object Shape1: TShape
      Left = 16
      Top = 359
      Width = 179
      Height = 230
    end
    object imgPicture1: TImage
      Left = 18
      Top = 361
      Width = 175
      Height = 226
      ParentShowHint = False
      ShowHint = True
      Stretch = True
    end
    object lblRdrCode1: TLabel
      Left = 422
      Top = 14
      Width = 42
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607
      ParentBiDiMode = False
    end
    object lblName1ca: TLabel
      Left = 378
      Top = 374
      Width = 86
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605' :'
      ParentBiDiMode = False
    end
    object lblPNo1ca: TLabel
      Left = 397
      Top = 395
      Width = 67
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' :'
      ParentBiDiMode = False
    end
    object lblName1: TLabel
      Left = 351
      Top = 374
      Width = 21
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = '---'
      ParentBiDiMode = False
    end
    object lblPNo1: TLabel
      Left = 370
      Top = 395
      Width = 21
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = '---'
      ParentBiDiMode = False
    end
    object ShapeRight: TShape
      Left = 201
      Top = 444
      Width = 65
      Height = 65
      Shape = stCircle
    end
    object grdFishLst1: TStringGrid
      Left = 8
      Top = 40
      Width = 481
      Height = 313
      Hint = '+/- '#1578#1594#1610#1610#1585' '#1575#1606#1583#1575#1586#1607' '#1601#1608#1606#1578
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
      OnKeyDown = grdFishLst1KeyDown
      OnKeyPress = grdFishLst1KeyPress
    end
    object cmbRdrCode1: TComboBox
      Left = 192
      Top = 11
      Width = 224
      Height = 23
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 479
    Height = 646
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 1
    object Shape2: TShape
      Left = 15
      Top = 359
      Width = 179
      Height = 230
    end
    object imgPicture2: TImage
      Left = 17
      Top = 361
      Width = 175
      Height = 226
      ParentShowHint = False
      ShowHint = True
      Stretch = True
    end
    object lblRdrCode2: TLabel
      Left = 422
      Top = 14
      Width = 42
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607
      ParentBiDiMode = False
    end
    object lblName2ca: TLabel
      Left = 378
      Top = 374
      Width = 86
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605' :'
      ParentBiDiMode = False
    end
    object lblName2: TLabel
      Left = 351
      Top = 374
      Width = 21
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = '---'
      ParentBiDiMode = False
    end
    object lblPNo2: TLabel
      Left = 370
      Top = 395
      Width = 21
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = '---'
      ParentBiDiMode = False
    end
    object lblPNo2ca: TLabel
      Left = 397
      Top = 395
      Width = 67
      Height = 15
      BiDiMode = bdRightToLeft
      Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' :'
      ParentBiDiMode = False
    end
    object ShapeLeft: TShape
      Left = 200
      Top = 444
      Width = 65
      Height = 65
      Shape = stCircle
    end
    object grdFishLst2: TStringGrid
      Left = 8
      Top = 40
      Width = 481
      Height = 313
      Hint = '+/- '#1578#1594#1610#1610#1585' '#1575#1606#1583#1575#1586#1607' '#1601#1608#1606#1578
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
      OnKeyDown = grdFishLst2KeyDown
      OnKeyPress = grdFishLst2KeyPress
    end
    object cmbRdrCode2: TComboBox
      Left = 192
      Top = 11
      Width = 224
      Height = 23
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 888
    Top = 160
  end
end
