object frmPrnTest: TfrmPrnTest
  Left = 195
  Top = 105
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '«—”«· »Â ç«Åê—'
  ClientHeight = 125
  ClientWidth = 320
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
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 290
    Top = 8
    Width = 22
    Height = 15
    Caption = 'Œÿ 1'
  end
  object Label2: TLabel
    Left = 290
    Top = 32
    Width = 22
    Height = 15
    Caption = 'Œÿ 2'
  end
  object Label3: TLabel
    Left = 290
    Top = 56
    Width = 22
    Height = 15
    Caption = 'Œÿ 3'
  end
  object txtL1: TEdit
    Left = 160
    Top = 8
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'Œÿ «Ê·'
  end
  object chkW1: TCheckBox
    Left = 64
    Top = 8
    Width = 89
    Height = 17
    Caption = '⁄—÷ œÊ »—«»—'
    TabOrder = 1
  end
  object chkClr1: TCheckBox
    Left = 8
    Top = 8
    Width = 49
    Height = 17
    Caption = '—‰êÌ'
    TabOrder = 2
  end
  object txtL2: TEdit
    Left = 160
    Top = 32
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'Œÿ œÊ„'
  end
  object chkW2: TCheckBox
    Left = 64
    Top = 32
    Width = 89
    Height = 17
    Caption = '⁄—÷ œÊ »—«»—'
    TabOrder = 4
  end
  object chkClr2: TCheckBox
    Left = 8
    Top = 32
    Width = 49
    Height = 17
    Caption = '—‰êÌ'
    TabOrder = 5
  end
  object txtL3: TEdit
    Left = 160
    Top = 56
    Width = 121
    Height = 23
    TabOrder = 6
    Text = 'Œÿ ”Ê„'
  end
  object chkW3: TCheckBox
    Left = 64
    Top = 56
    Width = 89
    Height = 17
    Caption = '⁄—÷ œÊ »—«»—'
    TabOrder = 7
  end
  object chkClr3: TCheckBox
    Left = 8
    Top = 56
    Width = 49
    Height = 17
    Caption = '—‰êÌ'
    TabOrder = 8
  end
  object cmdPrint: TButton
    Left = 8
    Top = 96
    Width = 75
    Height = 25
    Caption = 'ç«Å'
    TabOrder = 9
    OnClick = cmdPrintClick
  end
  object chkCut: TCheckBox
    Left = 216
    Top = 96
    Width = 97
    Height = 17
    Caption = '»—‘ ﬂ«€–'
    TabOrder = 10
  end
end
