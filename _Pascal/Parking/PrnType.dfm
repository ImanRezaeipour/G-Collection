object frmPrnType: TfrmPrnType
  Left = 155
  Top = 139
  BorderStyle = bsDialog
  Caption = ' ⁄ÌÌ‰ ‰Ê⁄ ç«Å'
  ClientHeight = 88
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object grpPrintType: TGroupBox
    Left = 7
    Top = 7
    Width = 220
    Height = 43
    Caption = 'Ê÷⁄Ì  ç«Å'
    TabOrder = 0
    object rdoScreen: TRadioButton
      Left = 141
      Top = 21
      Width = 72
      Height = 15
      Alignment = taLeftJustify
      Caption = '&’›ÕÂ ‰„«Ì‘'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoScreenKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 14
      Top = 21
      Width = 36
      Height = 15
      Alignment = taLeftJustify
      Caption = '&ç«Åê—'
      TabOrder = 1
      OnKeyPress = rdoScreenKeyPress
    end
  end
  object cmdPrint: TBitBtn
    Left = 7
    Top = 64
    Width = 80
    Height = 22
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
  object chkCoName: TCheckBox
    Left = 141
    Top = 64
    Width = 86
    Height = 15
    Alignment = taLeftJustify
    Caption = 'ç«Å ‰«„ „ƒ&””Â'
    TabOrder = 1
    OnKeyPress = chkCoNameKeyPress
  end
end
