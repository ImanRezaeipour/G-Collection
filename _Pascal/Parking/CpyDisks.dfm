object frmCpyAnyDsk: TfrmCpyAnyDsk
  Left = 136
  Top = 149
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = 'ﬂÅÌ ‰„Êœ‰ ›«Ì·Â«'
  ClientHeight = 124
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 7
    Top = 7
    Width = 25
    Height = 15
    BiDiMode = bdLeftToRight
    Caption = '„»œ√:'
    ParentBiDiMode = False
  end
  object Label2: TLabel
    Left = 7
    Top = 28
    Width = 27
    Height = 15
    BiDiMode = bdLeftToRight
    Caption = '„ﬁ’œ:'
    ParentBiDiMode = False
  end
  object Animate1: TAnimate
    Left = 35
    Top = 64
    Width = 240
    Height = 52
    Active = False
    CommonAVI = aviCopyFiles
    StopFrame = 34
  end
  object lblSource: TStaticText
    Left = 28
    Top = 7
    Width = 48
    Height = 18
    BiDiMode = bdLeftToRight
    Caption = 'lblSource'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 1
  end
  object lblTarget: TStaticText
    Left = 35
    Top = 28
    Width = 46
    Height = 18
    BiDiMode = bdLeftToRight
    Caption = 'lblTarget'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 2
  end
  object filList: TFileListBox
    Left = 226
    Top = 7
    Width = 85
    Height = 50
    ItemHeight = 17
    TabOrder = 3
    Visible = False
  end
end
