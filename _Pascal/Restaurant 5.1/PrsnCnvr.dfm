object frmPersonConvert: TfrmPersonConvert
  Left = 56
  Top = 0
  HelpContext = 508
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1576#1575#1586#1610#1575#1576#1610' '#1575#1591#1604#1575#1593#1575#1578' '#1662#1585#1587#1606#1604#1610
  ClientHeight = 406
  ClientWidth = 488
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
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 428
    Top = 10
    Width = 50
    Height = 15
    Caption = '&'#1606#1608#1593' '#1608#1585#1608#1583#1610
    FocusControl = cmbInputFile
  end
  object lbl2: TLabel
    Left = 241
    Top = 8
    Width = 61
    Height = 15
    Caption = '&'#1603#1583#1610#1606#1711' '#1608#1585#1608#1583#1610
    FocusControl = cmbCodePage
  end
  object grpText: TGroupBox
    Left = 8
    Top = 40
    Width = 473
    Height = 329
    TabOrder = 4
    object lbl4: TLabel
      Left = 403
      Top = 56
      Width = 59
      Height = 15
      Caption = '&'#1580#1583#1575#1603#1606#1606#1583#1607' '#1601#1610#1604#1583#1607#1575
      FocusControl = txtChar
    end
    object lbl5: TLabel
      Left = 240
      Top = 56
      Width = 46
      Height = 15
      Caption = #1603'&'#1583' '#1580#1583#1575#1603#1606#1606#1583#1607
      FocusControl = txtCode
    end
    object lbl6: TLabel
      Left = 377
      Top = 80
      Width = 85
      Height = 15
      Caption = #1601#1610#1604#1583#1607#1575#1610' &'#1576#1575#1606#1603' '#1662#1585#1587#1606#1604#1610
      FocusControl = lstDBS
    end
    object lbl7: TLabel
      Left = 133
      Top = 80
      Width = 105
      Height = 15
      Caption = #1601#1610#1604#1583#1607#1575#1610' '#1605#1578#1606#1575'&'#1592#1585' '#1601#1575#1610#1604' '#1605#1578#1606#1610
      FocusControl = lstText
    end
    object lbl8: TLabel
      Left = 7
      Top = 64
      Width = 58
      Height = 33
      AutoSize = False
      Caption = #1588#1605#1575#1585#1607' '#1601#1610#1604#1583' '#1601#1575#1610#1604' &'#1605#1578#1606#1610
      FocusControl = txtFieldNo
      WordWrap = True
    end
    object lblRecNo: TLabel
      Left = 8
      Top = 16
      Width = 49
      Height = 15
      BiDiMode = bdLeftToRight
      Caption = 'lblRecNo'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      Visible = False
    end
    object lbl3: TLabel
      Left = 432
      Top = 16
      Width = 30
      Height = 15
      Caption = #1606#1575#1605' &'#1601#1575#1610#1604
    end
    object txtChar: TEdit
      Left = 336
      Top = 56
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 1
      ParentBiDiMode = False
      TabOrder = 0
      OnChange = txtCharChange
      OnKeyPress = cmbInputFileKeyPress
    end
    object txtCode: TEdit
      Left = 176
      Top = 56
      Width = 49
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 3
      ParentBiDiMode = False
      TabOrder = 1
      OnChange = txtCodeChange
      OnKeyPress = txtCodeKeyPress
    end
    object lstDBS: TListBox
      Left = 296
      Top = 96
      Width = 169
      Height = 225
      ItemHeight = 15
      TabOrder = 2
      OnDblClick = cmdAddClick
      OnKeyPress = lstDBSKeyPress
    end
    object lstText: TListBox
      Left = 72
      Top = 96
      Width = 169
      Height = 225
      ItemHeight = 15
      TabOrder = 9
      OnClick = lstTextClick
      OnDblClick = cmdDelClick
      OnKeyPress = lstTextKeyPress
    end
    object cmdAddAll: TButton
      Left = 248
      Top = 96
      Width = 41
      Height = 25
      Caption = '>>'
      TabOrder = 3
      OnClick = cmdAddAllClick
    end
    object cmdAdd: TButton
      Left = 248
      Top = 128
      Width = 41
      Height = 25
      Caption = '>'
      TabOrder = 4
      OnClick = cmdAddClick
    end
    object cmdDel: TButton
      Left = 248
      Top = 264
      Width = 41
      Height = 25
      Caption = '<'
      TabOrder = 5
      OnClick = cmdDelClick
    end
    object cmdDelAll: TButton
      Left = 248
      Top = 296
      Width = 41
      Height = 25
      Caption = '<<'
      TabOrder = 6
      OnClick = cmdDelAllClick
    end
    object cmdUp: TBitBtn
      Left = 248
      Top = 176
      Width = 41
      Height = 25
      TabOrder = 7
      OnClick = cmdUpClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
        3333333777737777F333333099999990333333373F3333373333333309999903
        333333337F33337F33333333099999033333333373F333733333333330999033
        3333333337F337F3333333333099903333333333373F37333333333333090333
        33333333337F7F33333333333309033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      NumGlyphs = 2
    end
    object cmdDown: TBitBtn
      Left = 248
      Top = 208
      Width = 41
      Height = 25
      TabOrder = 8
      OnClick = cmdDownClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
    end
    object lstFieldNo: TListBox
      Left = 8
      Top = 96
      Width = 65
      Height = 225
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 10
      OnClick = lstFieldNoClick
      OnKeyPress = cmbInputFileKeyPress
    end
    object txtFieldNo: TEdit
      Left = 8
      Top = 96
      Width = 65
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 11
      OnExit = txtFieldNoExit
      OnKeyDown = txtFieldNoKeyDown
      OnKeyPress = txtFieldNoKeyPress
    end
  end
  object grpDBF: TGroupBox
    Left = 8
    Top = 64
    Width = 473
    Height = 329
    TabOrder = 5
    object lbl9: TLabel
      Left = 432
      Top = 16
      Width = 30
      Height = 15
      Caption = #1606#1575#1605' &'#1601#1575#1610#1604
    end
    object lblDBFRec: TLabel
      Left = 8
      Top = 16
      Width = 49
      Height = 15
      BiDiMode = bdLeftToRight
      Caption = 'lblRecNo'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      Visible = False
    end
    object lbl10: TLabel
      Left = 377
      Top = 48
      Width = 85
      Height = 15
      Caption = #1601#1610#1604#1583#1607#1575#1610' &'#1576#1575#1606#1603' '#1662#1585#1587#1606#1604#1610
      FocusControl = lstDBS1
    end
    object lbl11: TLabel
      Left = 225
      Top = 48
      Width = 109
      Height = 15
      Caption = #1601#1610#1604#1583#1607#1575#1610' '#1605#1578#1606#1575'&'#1592#1585' '#1601#1575#1610#1604' DBF'
      FocusControl = lstDBF
    end
    object lbl12: TLabel
      Left = 98
      Top = 48
      Width = 68
      Height = 15
      Caption = #1601#1610#1604#1583#1607#1575#1610' '#1575#1585#1578#1576#1575#1591#1610
      FocusControl = lstDBF
    end
    object lstDBS1: TListBox
      Left = 336
      Top = 64
      Width = 129
      Height = 257
      ItemHeight = 15
      TabOrder = 0
      OnDblClick = cmdAddDBFClick
      OnKeyPress = cmbInputFileKeyPress
    end
    object lstDBF: TListBox
      Left = 208
      Top = 64
      Width = 129
      Height = 257
      ItemHeight = 15
      TabOrder = 1
      OnDblClick = cmdAddDBFClick
      OnKeyPress = cmbInputFileKeyPress
    end
    object cmdAddDBF: TButton
      Left = 176
      Top = 152
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 2
      OnClick = cmdAddDBFClick
    end
    object cmdDelDBF: TButton
      Left = 176
      Top = 192
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 3
      OnClick = cmdDelDBFClick
    end
    object lstDBS_DBF: TListBox
      Left = 8
      Top = 64
      Width = 161
      Height = 257
      ItemHeight = 15
      TabOrder = 4
      OnDblClick = cmdDelDBFClick
      OnKeyPress = cmbInputFileKeyPress
    end
  end
  object cmbInputFile: TComboBox
    Left = 312
    Top = 8
    Width = 113
    Height = 23
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
    OnClick = cmbInputFileClick
    OnKeyPress = cmbInputFileKeyPress
  end
  object cmdRun: TBitBtn
    Left = 392
    Top = 376
    Width = 91
    Height = 25
    Caption = '&'#1576#1575#1586#1610#1575#1576#1610
    TabOrder = 6
    OnClick = cmdRunClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
      33333333333F8888883F33330000324334222222443333388F3833333388F333
      000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
      F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
      223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
      3338888300003AAAAAAA33333333333888888833333333330000333333333333
      333333333333333333FFFFFF000033333333333344444433FFFF333333888888
      00003A444333333A22222438888F333338F3333800003A2243333333A2222438
      F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
      22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
      33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cmdHelp: TBitBtn
    Left = 200
    Top = 376
    Width = 89
    Height = 25
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 7
    Kind = bkHelp
  end
  object cmdExit: TBitBtn
    Left = 8
    Top = 376
    Width = 89
    Height = 25
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 8
    Kind = bkClose
  end
  object txtPath: TEdit
    Left = 80
    Top = 48
    Width = 321
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 3
    OnExit = txtPathExit
    OnKeyPress = cmbInputFileKeyPress
  end
  object cmdPath: TButton
    Left = 400
    Top = 48
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = cmdPathClick
  end
  object cmbCodePage: TComboBox
    Left = 8
    Top = 8
    Width = 225
    Height = 23
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 0
    ParentBiDiMode = False
    TabOrder = 1
    OnKeyPress = cmbInputFileKeyPress
  end
  object opnFile: TOpenDialog
    Left = 120
    Top = 16
  end
  object tblPerson: TADOTable
    TableName = 'Persons'
    Left = 120
    Top = 336
  end
  object tblDBF: TTable
    Left = 168
    Top = 336
  end
end
