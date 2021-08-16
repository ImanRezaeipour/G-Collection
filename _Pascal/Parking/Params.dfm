object frmParams: TfrmParams
  Left = 106
  Top = 57
  HelpContext = 111
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1606#1592#1610#1605' '#1662#1575#1585#1575#1605#1578#1585#1607#1575
  ClientHeight = 326
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    367
    326)
  PixelsPerInch = 96
  TextHeight = 15
  object lbl4: TLabel
    Left = 251
    Top = 11
    Width = 108
    Height = 15
    Caption = #1583#1587#1578#1711#1575#1607' '#1601#1593#1575#1604' '#1576#1585#1575#1610' '#1576#1575#1604#1575#1576#1585' :'
    FocusControl = cmbActiveRdrOpenDoor
  end
  object cmdOK: TBitBtn
    Left = 273
    Top = 44
    Width = 86
    Height = 22
    Caption = '&'#1578#1571#1610#1610#1583
    Default = True
    TabOrder = 2
    OnClick = cmdOKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cmdCancel: TBitBtn
    Left = 8
    Top = 44
    Width = 86
    Height = 22
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 4
    Kind = bkCancel
  end
  object cmdHelp: TBitBtn
    Left = 140
    Top = 44
    Width = 86
    Height = 22
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 3
    Kind = bkHelp
  end
  object grpPrint: TGroupBox
    Left = 7
    Top = 75
    Width = 128
    Height = 135
    Caption = #1602#1576#1590' '#1582#1585#1608#1580' '#1582#1608#1583#1585#1608
    TabOrder = 6
    Visible = False
    object rdoAllPrint: TRadioButton
      Left = 35
      Top = 32
      Width = 82
      Height = 15
      Caption = #1670#1575#1662' &'#1603#1604#1610#1607' '#1602#1576#1590#1607#1575
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrcPrint: TRadioButton
      Left = 7
      Top = 67
      Width = 110
      Height = 15
      Caption = #1670#1575#1662' &'#1602#1576#1590#1607#1575#1610' '#1605#1576#1604#1594' '#1583#1575#1585
      TabOrder = 1
    end
    object rdoNoPrint: TRadioButton
      Left = 35
      Top = 102
      Width = 82
      Height = 15
      Caption = '&'#1593#1583#1605' '#1670#1575#1662' '#1602#1576#1590
      TabOrder = 2
    end
  end
  object grpFeature: TGroupBox
    Left = 141
    Top = 75
    Width = 220
    Height = 135
    Caption = #1588#1603#1604' '#1602#1576#1590' '#1582#1585#1608#1580#1610
    TabOrder = 5
    Visible = False
    object txtLine1: TEdit
      Left = 7
      Top = 21
      Width = 206
      Height = 23
      TabOrder = 0
    end
    object txtLine2: TEdit
      Left = 7
      Top = 42
      Width = 206
      Height = 23
      TabOrder = 1
    end
    object txtLine3: TEdit
      Left = 7
      Top = 64
      Width = 206
      Height = 23
      TabOrder = 2
    end
    object txtLine4: TEdit
      Left = 7
      Top = 85
      Width = 206
      Height = 23
      TabOrder = 3
    end
    object txtLine5: TEdit
      Left = 7
      Top = 106
      Width = 206
      Height = 23
      TabOrder = 4
    end
  end
  object grpInput: TGroupBox
    Left = 7
    Top = 216
    Width = 354
    Height = 51
    Caption = #1602#1591#1593' '#1608#1585#1608#1583#1610
    TabOrder = 7
    Visible = False
    object Label4: TLabel
      Left = 81
      Top = 21
      Width = 94
      Height = 15
      Caption = #1605#1583#1578' '#1586#1605#1575#1606' '#1602#1591#1593' '#1575#1585#1578#1576#1575#1591
    end
    object Label5: TLabel
      Left = 16
      Top = 21
      Width = 18
      Height = 15
      Caption = #1583#1602#1610#1602#1607
    end
    object chkInputOff: TCheckBox
      Left = 184
      Top = 21
      Width = 163
      Height = 15
      Caption = #1602#1591#1593' '#1575#1585#1578#1576#1575#1591' '#1576#1575' '#1583#1587#1578#1711#1575#1607#1607#1575#1610' '#1608#1585#1608#1583#1610
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkInputOffClick
    end
    object txtMaxOff: TEdit
      Left = 35
      Top = 21
      Width = 44
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
      Text = '3'
    end
  end
  object chkOffRpt: TCheckBox
    Left = 205
    Top = 280
    Width = 149
    Height = 15
    Caption = #1602#1591#1593' '#1575#1585#1578#1576#1575#1591' '#1607#1606#1711#1575#1605' '#1711#1586#1575#1585#1588' '#1711#1610#1585#1610
    Checked = True
    State = cbChecked
    TabOrder = 8
    Visible = False
  end
  object cmbActiveRdrOpenDoor: TComboBox
    Left = 8
    Top = 8
    Width = 169
    Height = 23
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    ItemHeight = 15
    ParentBiDiMode = False
    TabOrder = 1
    OnChange = cmbActiveRdrOpenDoorChange
  end
  object cmbActiveRdrOpenDoorCode: TComboBox
    Left = 183
    Top = 8
    Width = 62
    Height = 23
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = cmbActiveRdrOpenDoorCodeChange
  end
end
