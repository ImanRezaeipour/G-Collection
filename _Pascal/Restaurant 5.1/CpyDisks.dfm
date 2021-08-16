object frmCpyAnyDsk: TfrmCpyAnyDsk
  Left = 136
  Top = 149
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = 'ﬂÅÌ ‰„Êœ‰ ›«Ì·Â«'
  ClientHeight = 140
  ClientWidth = 357
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
  object Label1: TLabel
    Left = 7
    Top = 8
    Width = 25
    Height = 15
    Caption = '„»œ√:'
  end
  object Label2: TLabel
    Left = 11
    Top = 32
    Width = 27
    Height = 15
    Caption = '„ﬁ’œ:'
  end
  object Animate1: TAnimate
    Left = 40
    Top = 72
    Width = 272
    Height = 60
    Active = False
    CommonAVI = aviCopyFiles
    StopFrame = 34
  end
  object lblSource: TStaticText
    Left = 32
    Top = 8
    Width = 56
    Height = 19
    Caption = 'lblSource'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object lblTarget: TStaticText
    Left = 40
    Top = 32
    Width = 52
    Height = 19
    Caption = 'lblTarget'
    Font.Charset = ARABIC_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object filList: TFileListBox
    Left = 256
    Top = 8
    Width = 97
    Height = 57
    ItemHeight = 17
    Mask = '*.db;*.px;*.xg?;*.yg?;'
    TabOrder = 3
    Visible = False
  end
end
