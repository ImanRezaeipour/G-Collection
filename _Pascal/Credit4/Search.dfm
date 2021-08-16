object frmSearch: TfrmSearch
  Left = 114
  Top = 39
  ActiveControl = txtProxi
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1580#1587#1578#1580#1608
  ClientHeight = 347
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 401
    Height = 345
    TabOrder = 0
    object lbl1: TLabel
      Left = 338
      Top = 16
      Width = 52
      Height = 15
      Caption = #1588#1605#1575#1585#1607' &'#1603#1575#1585#1578
      FocusControl = txtProxi
    end
    object lbl2: TLabel
      Left = 124
      Top = 16
      Width = 69
      Height = 15
      Caption = #1588#1605#1575#1585#1607' '#1575#1587#1578'&'#1582#1583#1575#1605#1610
      FocusControl = txtEstekhdami
    end
    object lbl3: TLabel
      Left = 325
      Top = 48
      Width = 65
      Height = 15
      Caption = #1588#1605#1575'&'#1585#1607' '#1588#1606#1575#1587#1606#1575#1605#1607
    end
    object lbl4: TLabel
      Left = 166
      Top = 48
      Width = 27
      Height = 15
      Caption = #1606#1575#1605' &'#1662#1583#1585
    end
    object lbl5: TLabel
      Left = 348
      Top = 80
      Width = 42
      Height = 15
      Caption = '&'#1578#1575#1585#1610#1582' '#1578#1608#1604#1583
    end
    object lbl6: TLabel
      Left = 154
      Top = 80
      Width = 39
      Height = 15
      Caption = '&'#1605#1581#1604' '#1578#1608#1604#1583
    end
    object lbl7: TLabel
      Left = 328
      Top = 112
      Width = 62
      Height = 15
      Caption = #1605#1583#1585#1603' '#1578#1581#1589#1610#1604#1610
    end
    object lbl8: TLabel
      Left = 172
      Top = 112
      Width = 21
      Height = 15
      Caption = '&'#1585#1588#1578#1607
    end
    object Bevel1: TBevel
      Left = 0
      Top = 144
      Width = 400
      Height = 2
      Shape = bsTopLine
    end
    object lbl9: TLabel
      Left = 341
      Top = 161
      Width = 51
      Height = 15
      Caption = #1606#1608#1593' '#1575'&'#1587#1578#1582#1583#1575#1605
      FocusControl = cmbJob
    end
    object lbl11: TLabel
      Left = 335
      Top = 193
      Width = 57
      Height = 15
      Caption = '&'#1578#1575#1585#1610#1582' '#1575#1587#1578#1582#1583#1575#1605
      FocusControl = txtJobDate
    end
    object lbl12: TLabel
      Left = 137
      Top = 191
      Width = 54
      Height = 15
      Caption = '&'#1662#1575#1610#1575#1606' '#1575#1587#1578#1582#1583#1575#1605
      FocusControl = txtEndJobDate
    end
    object lbl10: TLabel
      Left = 133
      Top = 159
      Width = 58
      Height = 15
      Caption = #1662#1587#1578' '#1587#1575#1586'&'#1605#1575#1606#1610
      FocusControl = cmbCoPosts
    end
    object lbl13: TLabel
      Left = 345
      Top = 223
      Width = 47
      Height = 15
      Caption = '&'#1711#1585#1608#1607' '#1603#1575#1585#1610
      FocusControl = cmbGroups
    end
    object lbl14: TLabel
      Left = 141
      Top = 223
      Width = 50
      Height = 15
      Caption = #1711#1585#1608#1607' &'#1602#1608#1575#1606#1610#1606
      FocusControl = cmbRule
    end
    object lbl15: TLabel
      Left = 319
      Top = 280
      Width = 62
      Height = 15
      Caption = #1711#1585#1608#1607' '#1605'&'#1571#1605#1608#1585#1610#1578
      FocusControl = cmbMam
      Visible = False
    end
    object Label1: TLabel
      Left = 369
      Top = 254
      Width = 21
      Height = 15
      Alignment = taRightJustify
      Caption = #1576#1582#1588
      FocusControl = txtParts
    end
    object txtProxi: TEdit
      Left = 199
      Top = 15
      Width = 130
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 15
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = txtProxiKeyPress
    end
    object txtEstekhdami: TEdit
      Left = 8
      Top = 16
      Width = 105
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 12
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object txtIDNO: TEdit
      Left = 199
      Top = 48
      Width = 114
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 20
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object txtFather: TEdit
      Left = 8
      Top = 48
      Width = 129
      Height = 23
      MaxLength = 15
      TabOrder = 3
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object txtBirthDate: TEdit
      Left = 199
      Top = 80
      Width = 114
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 4
      OnExit = txtBirthDateExit
      OnKeyPress = txtJobDateKeyPress
    end
    object cmbBirthPlace: TComboBox
      Left = 8
      Top = 80
      Width = 129
      Height = 23
      ItemHeight = 15
      MaxLength = 20
      TabOrder = 5
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object cmbMadrak: TComboBox
      Left = 199
      Top = 112
      Width = 122
      Height = 23
      ItemHeight = 15
      MaxLength = 20
      TabOrder = 6
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object cmbCurse: TComboBox
      Left = 8
      Top = 112
      Width = 129
      Height = 23
      ItemHeight = 15
      MaxLength = 20
      TabOrder = 7
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object cmbJob: TComboBox
      Left = 199
      Top = 159
      Width = 122
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 8
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object txtJobDate: TEdit
      Left = 199
      Top = 189
      Width = 122
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 10
      OnExit = txtJobDateExit
      OnKeyPress = txtJobDateKeyPress
    end
    object txtEndJobDate: TEdit
      Left = 8
      Top = 189
      Width = 121
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 10
      ParentBiDiMode = False
      TabOrder = 11
      OnExit = txtEndJobDateExit
      OnKeyPress = txtJobDateKeyPress
    end
    object cmbCoPosts: TComboBox
      Left = 8
      Top = 159
      Width = 121
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 9
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object cmbGroups: TComboBox
      Left = 199
      Top = 220
      Width = 122
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 12
      OnKeyDown = cmbGroupsKeyDown
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object cmbRule: TComboBox
      Left = 8
      Top = 220
      Width = 121
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 13
      OnKeyDown = cmbRuleKeyDown
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object cmbMam: TComboBox
      Left = 191
      Top = 275
      Width = 122
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 14
      Visible = False
      OnKeyDown = cmbMamKeyDown
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object chkActive: TCheckBox
      Left = 16
      Top = 254
      Width = 49
      Height = 17
      Caption = '&'#1601#1593#1575#1604
      Checked = True
      State = cbChecked
      TabOrder = 16
      OnKeyPress = txtEstekhdamiKeyPress
    end
    object cmdSave: TBitBtn
      Left = 233
      Top = 308
      Width = 130
      Height = 25
      Caption = '&'#1578#1575#1610#1610#1583
      ModalResult = 1
      TabOrder = 18
      OnClick = cmdSaveClick
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
      Left = 26
      Top = 306
      Width = 130
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      ModalResult = 2
      TabOrder = 19
      OnClick = cmdCancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object txtParts: TEdit
      Left = 104
      Top = 251
      Width = 217
      Height = 23
      MaxLength = 15
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 15
    end
    object cmdParts: TBitBtn
      Left = 86
      Top = 253
      Width = 19
      Height = 20
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
        8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
        F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
        F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
        0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
        3333333777333777333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 76
  end
end
