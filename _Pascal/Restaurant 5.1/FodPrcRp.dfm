object frmFoodPrcRpt: TfrmFoodPrcRpt
  Left = 213
  Top = 113
  HelpContext = 303
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1602#1610#1605#1578' '#1594#1584#1575#1607#1575
  ClientHeight = 239
  ClientWidth = 295
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
    Left = 273
    Top = 48
    Width = 14
    Height = 15
    Caption = '&'#1594#1584#1575
    FocusControl = cmbFoods
  end
  object Label2: TLabel
    Left = 251
    Top = 8
    Width = 35
    Height = 15
    Caption = #1575'&'#1586' '#1578#1575#1585#1610#1582
  end
  object Label3: TLabel
    Left = 110
    Top = 8
    Width = 32
    Height = 15
    Caption = '&'#1578#1575' '#1578#1575#1585#1610#1582
  end
  object cmbFoods: TComboBox
    Left = 8
    Top = 48
    Width = 257
    Height = 23
    ItemHeight = 0
    TabOrder = 2
    OnKeyPress = cmbFoodsKeyPress
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 80
    Width = 129
    Height = 113
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 4
    object rdoScreen: TRadioButton
      Left = 40
      Top = 23
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoScreenKeyPress
    end
    object rdoPrinter: TRadioButton
      Left = 80
      Top = 55
      Width = 41
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1670#1575#1662#1711#1585
      ParentBiDiMode = False
      TabOrder = 1
    end
    object chkSign: TCheckBox
      Left = 8
      Top = 88
      Width = 113
      Height = 17
      Caption = #1670#1575#1662' '#1575#1605'&'#1590#1575#1569' '#1603#1606#1606#1583#1711#1575#1606
      TabOrder = 2
      OnKeyPress = chkSignKeyPress
    end
  end
  object cmdPrint: TBitBtn
    Left = 200
    Top = 208
    Width = 89
    Height = 25
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 5
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
    Left = 104
    Top = 208
    Width = 89
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 6
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 208
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 7
    Kind = bkClose
  end
  object grpGroup: TGroupBox
    Left = 144
    Top = 80
    Width = 145
    Height = 113
    Caption = #1578#1601#1603#1610#1603' '#1576#1585' '#1575#1587#1575#1587' '
    TabOrder = 3
    object rdoDate: TRadioButton
      Left = 32
      Top = 24
      Width = 105
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1578#1575#1585#1610#1582' &'#1602#1610#1605#1578' '#1711#1584#1575#1585#1610
      Checked = True
      ParentBiDiMode = False
      TabOrder = 0
      TabStop = True
      OnKeyPress = rdoDateKeyPress
    end
    object rdoFood: TRadioButton
      Left = 80
      Top = 56
      Width = 57
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = '&'#1606#1608#1593' '#1594#1584#1575
      ParentBiDiMode = False
      TabOrder = 1
    end
    object rdoNon: TRadioButton
      Left = 56
      Top = 88
      Width = 81
      Height = 17
      Caption = #1576#1583#1608#1606' '#1578'&'#1601#1603#1610#1603
      TabOrder = 2
    end
  end
  object txtFromDate: TEdit
    Left = 152
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 0
    OnExit = txtFromDateExit
    OnKeyPress = txtFromDateKeyPress
  end
  object txtToDate: TEdit
    Left = 8
    Top = 8
    Width = 89
    Height = 23
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    TabOrder = 1
    OnExit = txtToDateExit
    OnKeyPress = txtToDateKeyPress
  end
end
