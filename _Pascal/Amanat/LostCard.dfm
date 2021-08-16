object frmLostCard: TfrmLostCard
  Left = 132
  Top = 120
  Hint = #1575#1606#1578#1582#1575#1576' = Double Click'
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1605#1593#1585#1601#1610' '#1705#1575#1585#1578#1607#1575#1610' '#1605#1601#1602#1608#1583#1610' '#1608' '#1575#1601#1585#1575#1583' '#1594#1610#1585' '#1605#1580#1575#1586
  ClientHeight = 502
  ClientWidth = 706
  Color = clBtnFace
  Constraints.MinHeight = 527
  Constraints.MinWidth = 712
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object grd: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 70
    Width = 700
    Height = 307
    Margins.Top = 9
    Align = alClient
    DataSource = dtaLostCard
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = pmnu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    OnDrawColumnCell = grdDrawColumnCell
    OnTitleClick = grdTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'lost_EmplNo'
        Title.Alignment = taCenter
        Title.Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lost_empLId'
        Title.Alignment = taCenter
        Title.Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FamilyName'
        Title.Alignment = taCenter
        Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1606#1583#1711#1610' - '#1606#1575#1605
        Width = 219
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lost_Date'
        Title.Alignment = taCenter
        Title.Caption = #1578#1575#1585#1610#1582' '#1575#1593#1604#1575#1605
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lost_RemoveDate'
        Title.Alignment = taCenter
        Title.Caption = #1578#1575#1585#1610#1582' '#1575#1576#1591#1575#1604
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'lost_Price'
        Title.Alignment = taCenter
        Title.Caption = #1575#1593#1578#1576#1575#1585' '#1705#1575#1585#1578
        Width = 97
        Visible = True
      end>
  end
  object rdoView: TRadioGroup
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 700
    Height = 55
    Align = alTop
    Caption = #1606#1605#1575#1610#1588' '#1604#1610#1587#1578' :'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #1705#1604' '#1705#1575#1585#1578#1607#1575
      #1705#1575#1585#1578#1607#1575#1610' '#1576#1575#1591#1604' '#1606#1588#1583#1607' '
      #1705#1575#1585#1578#1607#1575#1610' '#1576#1575#1591#1604' '#1588#1583#1607' ')
    TabOrder = 0
    OnClick = rdoViewClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 706
    Height = 122
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lblCount: TLabel
      AlignWithMargins = True
      Left = 164
      Top = 3
      Width = 31
      Height = 21
      Margins.Left = 30
      Align = alLeft
      Alignment = taRightJustify
      Caption = #1578#1593#1583#1575#1583' : '
      FocusControl = txtDate
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 30
      Width = 700
      Height = 89
      Align = alBottom
      Caption = #1608#1585#1608#1583' '#1575#1591#1604#1575#1593#1575#1578' '#1705#1575#1585#1578#1607#1575#1610' '#1605#1601#1602#1608#1583#1610' '
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      DesignSize = (
        700
        89)
      object Label6: TLabel
        Left = 625
        Top = 55
        Width = 59
        Height = 15
        Anchors = [akTop, akRight]
        Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      end
      object Label7: TLabel
        Left = 627
        Top = 29
        Width = 55
        Height = 15
        Anchors = [akTop, akRight]
        Caption = #1578#1575#1585#1610#1582' '#1605#1601#1602#1608#1583#1610
        FocusControl = txtDate
      end
      object Label1: TLabel
        Left = 400
        Top = 55
        Width = 82
        Height = 15
        Anchors = [akTop, akRight]
        Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605' '
      end
      object btnSave: TBitBtn
        AlignWithMargins = True
        Left = 8
        Top = 50
        Width = 116
        Height = 28
        Caption = #1579#1576#1578
        TabOrder = 3
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
      object txtDate: TEdit
        Left = 497
        Top = 26
        Width = 122
        Height = 23
        Anchors = [akTop, akRight]
        BiDiMode = bdLeftToRight
        MaxLength = 10
        ParentBiDiMode = False
        TabOrder = 0
        OnExit = txtDateExit
        OnKeyPress = txtDateKeyPress
      end
      object cmbEmplCode: TDBLookupComboBox
        Left = 497
        Top = 53
        Width = 122
        Height = 23
        BiDiMode = bdLeftToRight
        DataField = 'Empl_No'
        DataSource = DataSource1
        KeyField = 'Empl_No'
        ListField = 'Empl_No'
        ListSource = DataSource2
        ParentBiDiMode = False
        TabOrder = 1
      end
      object cmbEmplName: TDBLookupComboBox
        Left = 148
        Top = 53
        Width = 247
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Empl_No'
        DataSource = DataSource1
        KeyField = 'Empl_No'
        ListField = 'te'
        ListSource = DataSource2
        TabOrder = 2
      end
    end
    object btnDelete: TBitBtn
      AlignWithMargins = True
      Left = 4
      Top = 2
      Width = 127
      Height = 25
      Margins.Left = 4
      Margins.Top = 2
      Margins.Bottom = 0
      Align = alLeft
      Caption = #1581#1584#1601
      TabOrder = 1
      OnClick = btnDeleteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
        305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
        B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
        B0557777FF577777F7F500000E055550805577777F7555575755500000555555
        05555777775555557F5555000555555505555577755555557555}
      NumGlyphs = 2
    end
  end
  object dtaLostCard: TDataSource
    DataSet = adoTblLostCard
    Left = 37
    Top = 117
  end
  object adoTblLostCard: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\ghadirco\Credit3' +
      'test\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = adoTblLostCardCalcFields
    TableName = 'lostcard'
    Left = 69
    Top = 117
    object adoTblLostCardFamilyName: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamilyName'
      Size = 60
      Calculated = True
    end
    object adoTblLostCardl_empId: TStringField
      FieldName = 'lost_empLId'
      Size = 8
    end
    object adoTblLostCardl_EmpCode: TStringField
      FieldName = 'lost_EmplNo'
      Size = 8
    end
    object adoTblLostCardl_Date: TStringField
      FieldName = 'lost_Date'
      Size = 10
    end
    object adoTblLostCardl_RemoveDate: TStringField
      FieldName = 'lost_RemoveDate'
      Size = 10
    end
    object adoTblLostCardl_Credit: TCurrencyField
      FieldName = 'lost_Price'
    end
    object adoTblLostCardRemoved: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Removed'
      Calculated = True
    end
    object adoTblLostCardRemoveTime: TStringField
      FieldKind = fkCalculated
      FieldName = 'RemoveTime'
      Calculated = True
    end
    object adoTblLostCardlost_RemoveTime: TWideStringField
      FieldName = 'lost_RemoveTime'
      Size = 5
    end
  end
  object pmnu: TPopupMenu
    Left = 72
    Top = 72
    object N1: TMenuItem
      Caption = #1581#1584#1601
      OnClick = N1Click
    end
  end
  object DosMove1: TDosMove
    Active = True
    Left = 32
    Top = 72
  end
  object DataSource2: TDataSource
    DataSet = ADOTable2
    Left = 283
    Top = 426
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 403
    Top = 426
  end
  object ADOTable2: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable1CalcFields
    TableName = 'Employee'
    Left = 315
    Top = 426
    object ADOTable2te: TStringField
      FieldKind = fkCalculated
      FieldName = 'te'
      Calculated = True
    end
    object ADOTable2Empl_No: TWideStringField
      FieldName = 'Empl_No'
      Size = 8
    end
    object ADOTable2Empl_ID: TWideStringField
      FieldName = 'Empl_ID'
      Size = 15
    end
    object ADOTable2Empl_Name: TWideStringField
      FieldName = 'Empl_Name'
      Size = 15
    end
    object ADOTable2Empl_Family: TWideStringField
      FieldName = 'Empl_Family'
      Size = 25
    end
    object ADOTable2Empl_Active: TBooleanField
      FieldName = 'Empl_Active'
    end
    object ADOTable2Empl_Department: TIntegerField
      FieldName = 'Empl_Department'
    end
    object ADOTable2Empl_CoPost: TIntegerField
      FieldName = 'Empl_CoPost'
    end
    object ADOTable2Empl_Part: TIntegerField
      FieldName = 'Empl_Part'
    end
    object ADOTable2Empl_Dscnt: TIntegerField
      FieldName = 'Empl_Dscnt'
    end
    object ADOTable2Empl_ExpDate: TWideStringField
      FieldName = 'Empl_ExpDate'
      Size = 10
    end
    object ADOTable2Empl_Balance: TBCDField
      FieldName = 'Empl_Balance'
      Precision = 19
    end
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable1CalcFields
    TableName = 'Employee'
    Left = 435
    Top = 426
    object ADOTable1te: TStringField
      FieldKind = fkCalculated
      FieldName = 'te'
      Calculated = True
    end
    object ADOTable1Empl_No: TWideStringField
      FieldName = 'Empl_No'
      Size = 8
    end
    object ADOTable1Empl_ID: TWideStringField
      FieldName = 'Empl_ID'
      Size = 15
    end
    object ADOTable1Empl_Name: TWideStringField
      FieldName = 'Empl_Name'
      Size = 15
    end
    object ADOTable1Empl_Family: TWideStringField
      FieldName = 'Empl_Family'
      Size = 25
    end
    object ADOTable1Empl_Active: TBooleanField
      FieldName = 'Empl_Active'
    end
    object ADOTable1Empl_Department: TIntegerField
      FieldName = 'Empl_Department'
    end
    object ADOTable1Empl_CoPost: TIntegerField
      FieldName = 'Empl_CoPost'
    end
    object ADOTable1Empl_Part: TIntegerField
      FieldName = 'Empl_Part'
    end
    object ADOTable1Empl_Dscnt: TIntegerField
      FieldName = 'Empl_Dscnt'
    end
    object ADOTable1Empl_ExpDate: TWideStringField
      FieldName = 'Empl_ExpDate'
      Size = 10
    end
    object ADOTable1Empl_Balance: TBCDField
      FieldName = 'Empl_Balance'
      Precision = 19
    end
  end
end
