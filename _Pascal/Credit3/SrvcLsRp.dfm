object frmServiceRpt: TfrmServiceRpt
  Left = 234
  Top = 161
  HelpContext = 303
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = 'ê“«—‘ ·Ì”  Œœ„« '
  ClientHeight = 281
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 225
    Top = 7
    Width = 28
    Height = 15
    Caption = 'Œœ&„« '
    FocusControl = cmbServices
  end
  object lbl4: TLabel
    Left = 226
    Top = 219
    Width = 33
    Height = 15
    Caption = ' Ê&÷ÌÕ'
    FocusControl = txtDescribe
  end
  object lbl2: TLabel
    Left = 226
    Top = 35
    Width = 27
    Height = 15
    Caption = '&ﬂ„Ì '
    FocusControl = cmbUnits
  end
  object lbl3: TLabel
    Left = 232
    Top = 64
    Width = 20
    Height = 15
    Caption = '„»&·€'
  end
  object cmbServices: TComboBox
    Left = 7
    Top = 7
    Width = 213
    Height = 23
    ItemHeight = 15
    TabOrder = 0
  end
  object grpPrintType: TGroupBox
    Left = 7
    Top = 92
    Width = 121
    Height = 114
    Caption = 'Ê÷⁄Ì  ç«Å'
    TabOrder = 5
    object rdoScreen: TRadioButton
      Left = 42
      Top = 27
      Width = 72
      Height = 15
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&’›ÕÂ ‰„«Ì‘'
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 78
      Top = 56
      Width = 36
      Height = 15
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&ç«Åê—'
      ParentBiDiMode = False
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 14
      Top = 92
      Width = 100
      Height = 15
      Caption = 'ç«Å «„&÷«¡ ﬂ‰‰œê«‰'
      TabOrder = 2
    end
  end
  object cmdPrint: TBitBtn
    Left = 176
    Top = 254
    Width = 79
    Height = 22
    Caption = '&ê“«—‘'
    TabOrder = 7
    OnClick = cmdPrintClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000CE0E0000D80E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      88888800000000000888808888888880808800000000000008080888888BBB88
      0008088888877788080800000000000008800888888888808080800000000008
      0800880FFFFFFFF080808880F00000F000088880FFFFFFFF088888880F00000F
      088888880FFFFFFFF08888888000000000888888888888888888}
  end
  object cmdHelp: TBitBtn
    Left = 92
    Top = 254
    Width = 78
    Height = 22
    Caption = '—«&Â‰„«'
    TabOrder = 8
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 7
    Top = 254
    Width = 79
    Height = 22
    Caption = '&Œ—ÊÃ'
    TabOrder = 9
    Kind = bkClose
  end
  object txtDescribe: TEdit
    Left = 7
    Top = 219
    Width = 220
    Height = 23
    TabOrder = 6
  end
  object rdoSort: TRadioGroup
    Left = 134
    Top = 92
    Width = 121
    Height = 114
    Caption = '„— » ”«“Ì'
    ItemIndex = 0
    Items.Strings = (
      'ﬂœ Œœ„« '
      '⁄‰Ê«‰ Œœ„« '
      'Ê«Õœ'
      'ﬁÌ„ ')
    TabOrder = 4
  end
  object cmbUnits: TComboBox
    Left = 7
    Top = 35
    Width = 213
    Height = 23
    ItemHeight = 15
    TabOrder = 1
  end
  object cmbPrice: TComboBox
    Left = 120
    Top = 64
    Width = 100
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    ItemIndex = 1
    TabOrder = 2
    Text = '»—«»— »«'
    Items.Strings = (
      'ﬂ„ — «“ '
      '»—«»— »«'
      '»Ì‘ — «“')
  end
  object txtPrice: TEdit
    Left = 7
    Top = 64
    Width = 107
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 3
    OnKeyPress = txtPriceKeyPress
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 120
  end
end
