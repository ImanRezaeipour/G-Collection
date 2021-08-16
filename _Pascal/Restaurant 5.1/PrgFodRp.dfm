object frmProgFoodRpt: TfrmProgFoodRpt
  Left = 169
  Top = 108
  HelpContext = 304
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = 'ê“«—‘ »—‰«„Â €–«ÌÌ Â› Â'
  ClientHeight = 159
  ClientWidth = 239
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
  object Label2: TLabel
    Left = 166
    Top = 8
    Width = 28
    Height = 15
    Caption = '& «—ÌŒ'
  end
  object grpPrintType: TGroupBox
    Left = 104
    Top = 40
    Width = 129
    Height = 113
    Caption = 'Ê÷⁄Ì  ç«Å'
    TabOrder = 1
    object rdoScreen: TRadioButton
      Left = 40
      Top = 24
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&’›ÕÂ ‰„«Ì‘'
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoScreenKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 80
      Top = 56
      Width = 41
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&ç«Åê—'
      ParentBiDiMode = False
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 8
      Top = 88
      Width = 113
      Height = 17
      Caption = 'ç«Å «„&÷«¡ ﬂ‰‰œê«‰'
      TabOrder = 2
      OnKeyPress = chkSignKeyPress
    end
  end
  object cmdPrint: TBitBtn
    Left = 8
    Top = 48
    Width = 89
    Height = 25
    Caption = '&ê“«—‘'
    TabOrder = 2
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
    Left = 8
    Top = 88
    Width = 89
    Height = 25
    Caption = '—«&Â‰„«'
    TabOrder = 3
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 128
    Width = 89
    Height = 25
    Caption = '&Œ—ÊÃ'
    TabOrder = 4
    Kind = bkClose
  end
  object txtDate: TEdit
    Left = 56
    Top = 8
    Width = 105
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtDateExit
    OnKeyPress = txtDateKeyPress
  end
end
