object frmClockRecFile: TfrmClockRecFile
  Left = 191
  Top = 126
  HelpContext = 414
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1576#1575#1586#1610#1575#1576#1610' '#1575#1591#1604#1575#1593#1575#1578' '#1581#1590#1608#1585' '#1608' '#1594#1610#1575#1576' '#1575#1586' '#1601#1575#1610#1604
  ClientHeight = 164
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 338
    Top = 16
    Width = 70
    Height = 15
    Caption = '&'#1606#1608#1593' '#1601#1575#1610#1604' '#1608#1585#1608#1583#1610
  end
  object lbl2: TLabel
    Left = 12
    Top = 48
    Width = 50
    Height = 15
    Caption = '&'#1601#1575#1610#1604' '#1608#1585#1608#1583#1610
  end
  object lblNo: TLabel
    Left = 85
    Top = 88
    Width = 28
    Height = 15
    BiDiMode = bdLeftToRight
    Caption = 'lblNo'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 14
    Top = 88
    Width = 64
    Height = 15
    Caption = ':'#1578#1593#1583#1575#1583' '#1585#1603#1608#1585#1583#1607#1575
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cmbInType: TComboBox
    Left = 8
    Top = 16
    Width = 321
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
  end
  object txtInFile: TEdit
    Left = 64
    Top = 48
    Width = 321
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 1
  end
  object cmdInFile: TButton
    Left = 384
    Top = 49
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = cmdInFileClick
  end
  object chkEmpty: TCheckBox
    Left = 216
    Top = 80
    Width = 193
    Height = 17
    Caption = '&'#1581#1584#1601' '#1585#1603#1608#1585#1583#1607#1575#1610' '#1581#1590#1608#1585' '#1608' '#1594#1610#1575#1576' '#1602#1576#1604#1610
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object cmdReadFile: TBitBtn
    Left = 320
    Top = 136
    Width = 91
    Height = 25
    Caption = '&'#1576#1575#1586#1610#1575#1576#1610
    TabOrder = 5
    OnClick = cmdReadFileClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
      FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
      00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
      F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
      00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
      F033777777777337F73309999990FFF0033377777777FFF77333099999000000
      3333777777777777333333399033333333333337773333333333333903333333
      3333333773333333333333303333333333333337333333333333}
    NumGlyphs = 2
  end
  object cmdHelp: TBitBtn
    Left = 160
    Top = 136
    Width = 89
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 6
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 136
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 7
    Kind = bkClose
  end
  object chkSaveSetting: TCheckBox
    Left = 288
    Top = 104
    Width = 121
    Height = 17
    Caption = #1579#1576#1578' '#1570#1582#1585#1610#1606' '#1578#1606#1592#1610#1605#1575#1578
    TabOrder = 4
  end
  object tblClock: TADOTable
    Left = 96
    Top = 8
  end
  object opnFile: TOpenDialog
    Left = 184
    Top = 16
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 112
    Top = 112
  end
end
