object frmOnlyCard: TfrmOnlyCard
  Left = 132
  Top = 120
  Hint = #1575#1606#1578#1582#1575#1576' = Double Click'
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1662#1585#1587#1606#1604' '#1601#1602#1591' '#1705#1575#1585#1578' '#1583#1585' '#1583#1587#1578#1711#1575#1607#1607#1575#1610' '#1575#1579#1585' '#1575#1606#1711#1588#1578
  ClientHeight = 370
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
  object Label1: TLabel
    Left = 292
    Top = 8
    Width = 67
    Height = 15
    Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' :'
    FocusControl = cmbBarCode
  end
  object Label2: TLabel
    Left = 480
    Top = 9
    Width = 64
    Height = 15
    Caption = '&'#1604#1610#1587#1578' '#1583#1587#1578#1711#1575#1607#1607#1575
    FocusControl = grdRdrs
  end
  object lblCount: TLabel
    Left = 33
    Top = 300
    Width = 27
    Height = 15
    Caption = #1578#1593#1583#1575#1583' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arabic Transparent'
    Font.Style = []
    ParentFont = False
  end
  object grd: TDBGrid
    Left = 6
    Top = 31
    Width = 355
    Height = 265
    DataSource = dtaOnlyCard
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = pmnu
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    OnDrawColumnCell = grdDrawColumnCell
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'BarCode'
        Title.Alignment = taCenter
        Title.Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FamilyName'
        Title.Alignment = taCenter
        Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610'- '#1606#1575#1605' '
        Width = 245
        Visible = True
      end>
  end
  object cmbBarCode: TComboBox
    Left = 96
    Top = 4
    Width = 192
    Height = 23
    ItemHeight = 15
    TabOrder = 0
  end
  object grpBtns: TGroupBox
    Left = 5
    Top = 312
    Width = 583
    Height = 54
    TabOrder = 2
    object lbl2: TLabel
      Left = 410
      Top = 26
      Width = 30
      Height = 15
      Caption = '&'#1593#1605#1604#1610#1575#1578
      FocusControl = cmbOperate
    end
    object lbl14: TLabel
      Left = 410
      Top = 51
      Width = 48
      Height = 15
      Caption = #1578#1575#1582#1610#1585' '#1588#1576#1705#1607
      Visible = False
    end
    object Label3: TLabel
      Left = 257
      Top = 50
      Width = 49
      Height = 15
      Caption = '0 '#1578#1575' 3000'
      Visible = False
    end
    object cmdTic: TBitBtn
      Left = 472
      Top = 21
      Width = 103
      Height = 25
      Caption = #1575'&'#1606#1578#1582#1575#1576' '#1583#1587#1578#1711#1575#1607
      TabOrder = 0
      OnClick = cmdTicClick
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
    object BitBtn1: TBitBtn
      Left = 5
      Top = 21
      Width = 76
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 2
      Kind = bkClose
    end
    object BitBtn2: TBitBtn
      Left = 83
      Top = 21
      Width = 78
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 1
      Kind = bkHelp
    end
    object cmbOperate: TComboBox
      Left = 257
      Top = 22
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      ItemIndex = 0
      TabOrder = 3
      Text = #1575#1585#1587#1575#1604' '#1604#1610#1587#1578
      Items.Strings = (
        #1575#1585#1587#1575#1604' '#1604#1610#1587#1578
        #1583#1585#1610#1575#1601#1578' '#1604#1610#1587#1578
        #1581#1584#1601' '#1604#1610#1587#1578)
    end
    object cmdOk: TBitBtn
      Left = 192
      Top = 22
      Width = 62
      Height = 23
      Caption = #1575'&'#1580#1585#1575
      TabOrder = 4
      OnClick = cmdOkClick
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
    object txtDelay: TEdit
      Left = 314
      Top = 47
      Width = 88
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 5
      Visible = False
    end
  end
  object grdRdrs: TStringGrid
    Left = 376
    Top = 31
    Width = 212
    Height = 265
    ColCount = 3
    DefaultRowHeight = 19
    FixedCols = 0
    RowCount = 15
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = grdRdrsClick
    OnDblClick = grdRdrsDblClick
    ColWidths = (
      13
      50
      113)
  end
  object BitBtn3: TBitBtn
    Left = 7
    Top = 4
    Width = 82
    Height = 23
    Caption = #1575#1606#1578'&'#1582#1575#1576
    TabOrder = 1
    OnClick = BitBtn3Click
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
  object dtaOnlyCard: TDataSource
    DataSet = adoTblOnlyCard
    Left = 14
    Top = 258
  end
  object adoTblOnlyCard: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sa;Persist Security Info=True;User ' +
      'ID=sa;Initial Catalog=Clock;Data Source=KOMEIL'
    CursorType = ctStatic
    OnCalcFields = adoTblOnlyCardCalcFields
    TableName = 'onlycard'
    Left = 46
    Top = 258
    object adoTblOnlyCardBarCode: TWideStringField
      FieldName = 'BarCode'
      Size = 8
    end
    object adoTblOnlyCardRdrCode: TSmallintField
      FieldName = 'RdrCode'
    end
    object adoTblOnlyCardFamilyName: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamilyName'
      Size = 60
      Calculated = True
    end
  end
  object pmnu: TPopupMenu
    Left = 168
    Top = 96
    object N1: TMenuItem
      Caption = #1581#1584#1601
      OnClick = N1Click
    end
  end
  object DosMove1: TDosMove
    Active = True
    Left = 24
    Top = 48
  end
end
