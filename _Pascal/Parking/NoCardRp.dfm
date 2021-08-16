object frmExitNoCardRpt: TfrmExitNoCardRpt
  Left = 137
  Top = 69
  HelpContext = 508
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '·Ì”  Œ—ÊÃ ŒÊœ—ÊÂ«Ì »œÊ‰ ﬂ«— '
  ClientHeight = 204
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
  object Label2: TLabel
    Left = 244
    Top = 7
    Width = 70
    Height = 15
    Alignment = taRightJustify
    Caption = '&»«—ﬂœ Ê—ÊœÌ'
    FocusControl = txtBarCode
  end
  object Label3: TLabel
    Left = 245
    Top = 35
    Width = 60
    Height = 15
    Alignment = taRightJustify
    Caption = '& «—ÌŒ Œ—ÊÃ'
    FocusControl = txtDate
  end
  object Label4: TLabel
    Left = 254
    Top = 64
    Width = 50
    Height = 15
    Alignment = taRightJustify
    Caption = '‰«„ Œ&Êœ—Ê'
    FocusControl = cmbCarName
  end
  object Label5: TLabel
    Left = 85
    Top = 64
    Width = 71
    Height = 15
    Alignment = taRightJustify
    Caption = '‘„«&—Â ŒÊœ—Ê'
    FocusControl = txtNumber
  end
  object Label6: TLabel
    Left = 248
    Top = 92
    Width = 63
    Height = 15
    Alignment = taRightJustify
    Caption = '&‘Â— ŒÊœ—Ê'
    FocusControl = cmbCity
  end
  object Label7: TLabel
    Left = 85
    Top = 92
    Width = 76
    Height = 15
    Alignment = taRightJustify
    Caption = '&”—Ì«· ŒÊœ—Ê'
    FocusControl = txtSerial
  end
  object Label13: TLabel
    Left = 87
    Top = 35
    Width = 58
    Height = 15
    Alignment = taRightJustify
    Caption = '&”«⁄  Œ—ÊÃ'
    FocusControl = txtTime
  end
  object txtBarCode: TEdit
    Left = 148
    Top = 7
    Width = 93
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnKeyPress = txtBarCodeKeyPress
  end
  object txtDate: TEdit
    Left = 148
    Top = 35
    Width = 93
    Height = 23
    MaxLength = 10
    TabOrder = 1
    OnExit = txtDateExit
    OnKeyPress = txtDateKeyPress
  end
  object txtNumber: TEdit
    Left = 7
    Top = 64
    Width = 72
    Height = 23
    MaxLength = 6
    TabOrder = 4
    OnKeyPress = txtNumberKeyPress
  end
  object txtSerial: TEdit
    Left = 35
    Top = 92
    Width = 44
    Height = 23
    MaxLength = 2
    TabOrder = 6
  end
  object cmbCarName: TComboBox
    Left = 148
    Top = 64
    Width = 93
    Height = 23
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 3
    OnEnter = cmbCarNameEnter
    OnKeyPress = cmbCarNameKeyPress
  end
  object cmbCity: TComboBox
    Left = 148
    Top = 92
    Width = 93
    Height = 23
    ItemHeight = 15
    MaxLength = 15
    TabOrder = 5
    OnEnter = cmbCarNameEnter
    OnKeyPress = cmbCityKeyPress
  end
  object txtTime: TEdit
    Left = 28
    Top = 35
    Width = 51
    Height = 23
    MaxLength = 5
    TabOrder = 2
    OnExit = txtTimeExit
    OnKeyPress = txtTimeKeyPress
  end
  object cmdClose: TBitBtn
    Left = 7
    Top = 176
    Width = 79
    Height = 23
    Caption = '&Œ—ÊÃ'
    TabOrder = 10
    Kind = bkClose
  end
  object cmdPrint: TBitBtn
    Left = 7
    Top = 120
    Width = 79
    Height = 22
    Caption = '&ê“«—‘'
    TabOrder = 8
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
    Left = 7
    Top = 148
    Width = 79
    Height = 22
    Caption = '—«&Â‰„«'
    TabOrder = 9
    Kind = bkHelp
  end
  object grpPrintType: TGroupBox
    Left = 148
    Top = 120
    Width = 149
    Height = 79
    Caption = 'Ê÷⁄Ì  ç«Å'
    TabOrder = 7
    object rdoScreen: TRadioButton
      Left = 64
      Top = 28
      Width = 78
      Height = 15
      Caption = '&’›ÕÂ ‰„«Ì‘'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 99
      Top = 56
      Width = 43
      Height = 15
      Caption = '&ç«Åê—'
      TabOrder = 1
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
  end
end
