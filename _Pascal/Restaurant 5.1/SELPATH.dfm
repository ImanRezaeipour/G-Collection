object frmSelPath: TfrmSelPath
  Left = 166
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Select Path'
  ClientHeight = 248
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 50
    Height = 13
    Caption = '&Directories'
    FocusControl = dirList
  end
  object Label2: TLabel
    Left = 8
    Top = 208
    Width = 30
    Height = 13
    Caption = 'Dri&ves'
    FocusControl = drvList
  end
  object dirList: TDirectoryListBox
    Left = 8
    Top = 48
    Width = 169
    Height = 153
    ItemHeight = 16
    TabOrder = 0
    OnChange = dirListChange
  end
  object drvList: TDriveComboBox
    Left = 8
    Top = 224
    Width = 169
    Height = 19
    TabOrder = 1
    OnChange = drvListChange
  end
  object lblPath: TStaticText
    Left = 8
    Top = 8
    Width = 257
    Height = 17
    AutoSize = False
    BorderStyle = sbsSunken
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object cmdOK: TBitBtn
    Left = 184
    Top = 48
    Width = 81
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
  object cmdCancel: TBitBtn
    Left = 184
    Top = 216
    Width = 83
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
end
