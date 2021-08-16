object frmBackup: TfrmBackup
  Left = 225
  Top = 449
  HelpContext = 88
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1610#1580#1575#1583' '#1601#1575#1610#1604' '#1662#1588#1578#1610#1576#1575#1606
  ClientHeight = 295
  ClientWidth = 425
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblDBS: TLabel
    Left = 212
    Top = 85
    Width = 196
    Height = 15
    AutoSize = False
  end
  object cmdHelp: TBitBtn
    Left = 92
    Top = 264
    Width = 70
    Height = 26
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 0
    Visible = False
    Kind = bkHelp
  end
  object cmdClose: TBitBtn
    Left = 8
    Top = 264
    Width = 79
    Height = 26
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 1
    Kind = bkClose
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 425
    Height = 129
    Align = alTop
    Caption = #1575#1610#1580#1575#1583' '#1601#1575#1610#1604' '#1662#1588#1578#1610#1576#1575#1606
    TabOrder = 2
    object lbl1: TLabel
      Left = 326
      Top = 28
      Width = 88
      Height = 15
      Caption = #1605'&'#1587#1610#1585' '#1662#1588#1578#1610#1576#1575#1606' '#1711#1610#1585#1610' :'
    end
    object txtPath: TEdit
      Left = 33
      Top = 25
      Width = 287
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnPath: TButton
      Left = 8
      Top = 25
      Width = 22
      Height = 23
      Caption = '...'
      TabOrder = 1
      OnClick = btnPathClick
    end
    object cmBackup: TBitBtn
      Left = 8
      Top = 65
      Width = 109
      Height = 26
      Caption = #1575#1610#1580#1575#1583' '#1662'&'#1588#1578#1610#1576#1575#1606
      TabOrder = 2
      OnClick = cmBackupClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 129
    Width = 425
    Height = 129
    Align = alTop
    Caption = #1576#1575#1586#1610#1575#1576#1610' '#1575#1585' '#1601#1575#1610#1604' '#1662#1588#1578#1610#1576#1575#1606
    TabOrder = 3
    ExplicitTop = 8
    object Label1: TLabel
      Left = 326
      Top = 28
      Width = 57
      Height = 15
      Caption = #1601#1575#1610#1604' '#1662#1588#1578#1610#1576#1575#1606' :'
    end
    object txtPathRestore: TEdit
      Left = 33
      Top = 25
      Width = 287
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnPath2: TButton
      Left = 8
      Top = 25
      Width = 22
      Height = 23
      Caption = '...'
      TabOrder = 1
      OnClick = btnPath2Click
    end
    object cmdRestore: TBitBtn
      Left = 3
      Top = 65
      Width = 109
      Height = 26
      Caption = #1576#1575#1586#1610#1575#1576#1610' '#1575#1586' '#1662'&'#1588#1578#1610#1576#1575#1606
      TabOrder = 2
      OnClick = cmdRestoreClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
        7700333333337777777733333333008088003333333377F73377333333330088
        88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
        000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
        FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
        99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
        99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
        99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
        93337FFFF7737777733300000033333333337777773333333333}
      NumGlyphs = 2
    end
  end
  object aqryData: TADOQuery
    Parameters = <>
    Left = 232
    Top = 261
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 264
    Top = 261
  end
  object tblData: TTable
    Left = 200
    Top = 261
  end
  object dlgRestore: TOpenDialog
    Left = 56
    Top = 152
  end
end
