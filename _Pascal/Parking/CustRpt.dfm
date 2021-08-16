object frmCustomsRpt: TfrmCustomsRpt
  Left = 109
  Top = 73
  HelpContext = 503
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1711#1586#1575#1585#1588' '#1662#1585#1587#1606#1604#1548' '#1605#1588#1578#1585#1603#1610#1606' '#1608' '#1605#1607#1605#1575#1606#1575#1606
  ClientHeight = 367
  ClientWidth = 335
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
  DesignSize = (
    335
    367)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 247
    Top = 11
    Width = 80
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575#1585#1610#1582' '#1575#1588#1578#1585#1575#1705' '#1575#1586' :'
  end
  object Label2: TLabel
    Left = 130
    Top = 11
    Width = 14
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' :'
    FocusControl = txtCuFromDate
  end
  object Label4: TLabel
    Left = 290
    Top = 98
    Width = 37
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1605#1588#1578#1585#1603' :'
    FocusControl = cmbCustCode
    ExplicitLeft = 216
  end
  object Label5: TLabel
    Left = 271
    Top = 214
    Width = 56
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = #1605#1581#1604' '#1582#1583#1605#1578' :'
    ExplicitTop = 127
  end
  object Label6: TLabel
    Left = 267
    Top = 156
    Width = 60
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578' :'
    ExplicitTop = 69
  end
  object Label7: TLabel
    Left = 261
    Top = 185
    Width = 66
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = #1588#1605#1575#1585#1607' '#1582#1608#1583#1585#1608' :'
    ExplicitTop = 98
  end
  object Label8: TLabel
    Left = 98
    Top = 185
    Width = 67
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = #1587#1585#1610#1575#1604' '#1582#1608#1583#1585#1608' :'
    ExplicitTop = 98
  end
  object Label9: TLabel
    Left = 258
    Top = 40
    Width = 69
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575#1585#1610#1582' '#1608#1585#1608#1583' '#1575#1586' :'
  end
  object Label10: TLabel
    Left = 130
    Top = 40
    Width = 14
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' :'
    FocusControl = txtIFromDate
  end
  object Label11: TLabel
    Left = 254
    Top = 69
    Width = 73
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575#1585#1610#1582' '#1582#1585#1608#1580' '#1575#1586' :'
  end
  object Label12: TLabel
    Left = 130
    Top = 69
    Width = 14
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' :'
    FocusControl = txtOFromDate
  end
  object Label3: TLabel
    Left = 244
    Top = 127
    Width = 83
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1588#1605#1575#1585#1607' '#1575#1588#1578#1585#1575#1705' '#1575#1586' :'
  end
  object Label13: TLabel
    Left = 130
    Top = 127
    Width = 14
    Height = 15
    Anchors = [akTop, akRight]
    Caption = #1578#1575' :'
    FocusControl = txtFromCustCode
  end
  object txtCuFromDate: TEdit
    Left = 154
    Top = 8
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1588#1585#1608#1593' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = txtCuFromDateChange
    OnEnter = txtCuFromDateEnter
    OnExit = txtCuFromDateExit
    OnKeyPress = txtCuFromDateKeyPress
  end
  object txtCuToDate: TEdit
    Left = 40
    Top = 8
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnChange = txtCuFromDateChange
    OnEnter = txtCuFromDateEnter
    OnExit = txtCuToDateExit
    OnKeyPress = txtCuFromDateKeyPress
  end
  object cmbCustCode: TComboBox
    Left = 171
    Top = 95
    Width = 84
    Height = 23
    Hint = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' '#1585#1575' '#1608#1575#1585#1583' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnChange = cmbCustCodeChange
    OnClick = cmbCustCodeClick
    OnEnter = cmbCustCodeEnter
    OnKeyDown = cmbCustCodeKeyDown
  end
  object cmbCustName: TComboBox
    Left = 8
    Top = 95
    Width = 157
    Height = 23
    Hint = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' '#1662#1585#1587#1606#1604' '#1585#1575' '#1608#1575#1585#1583' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnChange = cmbCustCodeChange
    OnClick = cmbCustNameClick
    OnEnter = cmbCustCodeEnter
    OnKeyDown = cmbCustCodeKeyDown
  end
  object grpReportType: TGroupBox
    Left = 166
    Top = 238
    Width = 161
    Height = 92
    Anchors = [akRight, akBottom]
    Caption = #1606#1608#1593' '#1711#1586#1575#1585#1588
    TabOrder = 12
    ExplicitTop = 151
    object rdoMojodi: TRadioButton
      Left = 4
      Top = 22
      Width = 154
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1605#1608#1580#1608#1583#1610
      Enabled = False
      TabOrder = 0
      OnClick = rdoMojodiClick
    end
    object rdoCircular: TRadioButton
      Left = 4
      Top = 43
      Width = 154
      Height = 15
      Caption = #1711#1586#1575#1585#1588' '#1711#1585#1583#1588' '#1593#1605#1604#1610#1575#1578' '#1605#1588#1578#1585#1603#1610#1606
      TabOrder = 1
      OnClick = rdoMojodiClick
    end
    object rdoBaseInfo: TRadioButton
      Left = 4
      Top = 64
      Width = 154
      Height = 15
      Caption = #1575#1591#1604#1575#1593#1575#1578' '#1662#1575#1610#1607
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = rdoMojodiClick
    end
  end
  object grpPrintType: TGroupBox
    Left = 8
    Top = 238
    Width = 153
    Height = 92
    Anchors = [akRight, akBottom]
    Caption = #1608#1590#1593#1610#1578' '#1670#1575#1662
    TabOrder = 13
    ExplicitTop = 151
    object rdoScreen: TRadioButton
      Left = 5
      Top = 22
      Width = 143
      Height = 15
      Caption = #1589#1601#1581#1607' '#1606#1605#1575#1610#1588
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rdoPrinter: TRadioButton
      Left = 5
      Top = 64
      Width = 143
      Height = 15
      Caption = #1670#1575#1662#1711#1585
      TabOrder = 1
    end
  end
  object cmdPrint: TBitBtn
    Left = 225
    Top = 336
    Width = 102
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&'#1711#1586#1575#1585#1588
    TabOrder = 14
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
    ExplicitTop = 249
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 336
    Width = 102
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 16
    Kind = bkClose
    ExplicitTop = 249
  end
  object cmdHelp: TBitBtn
    Left = 116
    Top = 336
    Width = 103
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 15
    Kind = bkHelp
    ExplicitTop = 249
  end
  object cmbDepartment: TComboBox
    Left = 8
    Top = 211
    Width = 247
    Height = 23
    Hint = #1605#1581#1604' '#1582#1583#1605#1578' '#1585#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Style = csDropDownList
    Anchors = [akRight, akBottom]
    ItemHeight = 15
    MaxLength = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnChange = cmbDepartmentChange
    OnKeyDown = cmbDepartmentKeyDown
    ExplicitTop = 124
  end
  object cmbDepartmentCode: TComboBox
    Left = 46
    Top = 215
    Width = 39
    Height = 23
    Style = csDropDownList
    Anchors = [akRight, akBottom]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    Visible = False
    ExplicitTop = 128
  end
  object txtNumber: TEdit
    Left = 171
    Top = 182
    Width = 84
    Height = 23
    Hint = #1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1576#1607' '#1588#1705#1604' '#1589#1581#1610#1581' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    BiDiMode = bdRightToLeft
    MaxLength = 6
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnKeyPress = txtNumberKeyPress
    ExplicitTop = 95
  end
  object txtSerial: TEdit
    Left = 8
    Top = 182
    Width = 84
    Height = 23
    Hint = #1587#1585#1610#1575#1604' '#1662#1604#1575#1705' '#1582#1608#1583#1585#1608' '#1585#1575' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akRight, akBottom]
    BiDiMode = bdRightToLeft
    MaxLength = 2
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnKeyPress = txtSerialKeyPress
    ExplicitTop = 95
  end
  object cmdCancelFilter: TBitBtn
    Left = 140
    Top = 153
    Width = 25
    Height = 23
    Hint = #1581#1584#1601' '#1578#1605#1575#1605#1610' '#1601#1610#1604#1578#1585#1607#1575
    Anchors = [akRight, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
    TabStop = False
    OnClick = cmdCancelFilterClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
      555557777F777555F55500000000555055557777777755F75555005500055055
      555577F5777F57555555005550055555555577FF577F5FF55555500550050055
      5555577FF77577FF555555005050110555555577F757777FF555555505099910
      555555FF75777777FF555005550999910555577F5F77777775F5500505509990
      3055577F75F77777575F55005055090B030555775755777575755555555550B0
      B03055555F555757575755550555550B0B335555755555757555555555555550
      BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
      50BB555555555555575F555555555555550B5555555555555575}
    NumGlyphs = 2
    ExplicitTop = 66
  end
  object cmbCardID: TComboBox
    Left = 171
    Top = 153
    Width = 84
    Height = 23
    Hint = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578' '#1585#1575' '#1608#1575#1585#1583' '#1705#1585#1583#1607' '#1608' '#1610#1575' '#1575#1586' '#1604#1610#1587#1578' '#1575#1606#1578#1582#1575#1576' '#1606#1605#1575#1610#1610#1583
    Style = csDropDownList
    Anchors = [akRight, akBottom]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnChange = cmbCustCodeChange
    OnClick = cmbCardIDClick
    OnEnter = cmbCustCodeEnter
    OnKeyDown = cmbCustCodeKeyDown
    ExplicitTop = 66
  end
  object txtIFromDate: TEdit
    Left = 154
    Top = 37
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1588#1585#1608#1593' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnChange = txtIFromDateChange
    OnEnter = txtIFromDateEnter
    OnExit = txtIFromDateExit
    OnKeyPress = txtIFromDateKeyPress
  end
  object txtIToDate: TEdit
    Left = 40
    Top = 37
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnChange = txtIFromDateChange
    OnEnter = txtIFromDateEnter
    OnExit = txtIToDateExit
    OnKeyPress = txtIToDateKeyPress
  end
  object txtOFromDate: TEdit
    Left = 154
    Top = 66
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1588#1585#1608#1593' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnChange = txtOFromDateChange
    OnEnter = txtOFromDateEnter
    OnExit = txtOFromDateExit
    OnKeyPress = txtOFromDateKeyPress
  end
  object txtOToDate: TEdit
    Left = 40
    Top = 66
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnChange = txtOFromDateChange
    OnEnter = txtOFromDateEnter
    OnExit = txtOToDateExit
    OnKeyPress = txtOToDateKeyPress
  end
  object txtFromCustCode: TEdit
    Left = 154
    Top = 124
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1588#1585#1608#1593' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    OnChange = txtFromCustCodeChange
    OnEnter = txtFromCustCodeEnter
    OnKeyPress = txtFromCustCodeKeyPress
  end
  object txtToCustCode: TEdit
    Left = 40
    Top = 124
    Width = 84
    Height = 23
    Hint = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1580#1587#1578#1580#1608' '#1585#1575' '#1583#1585' '#1575#1610#1606' '#1602#1587#1605#1578' '#1608#1575#1585#1583' '#1606#1605#1575#1610#1610#1583
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    MaxLength = 10
    ParentBiDiMode = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    OnChange = txtFromCustCodeChange
    OnEnter = txtFromCustCodeEnter
    OnKeyPress = txtToCustCodeKeyPress
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 8
    Top = 224
  end
end
