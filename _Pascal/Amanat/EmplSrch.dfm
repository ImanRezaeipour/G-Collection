object frmEmplSrch: TfrmEmplSrch
  Left = 28
  Top = 6
  HelpContext = 10
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1580#1587#1578#1580#1608#1610' '#1662#1585#1587#1606#1604
  ClientHeight = 420
  ClientWidth = 610
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
  Scaled = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 610
    Height = 417
    Align = alTop
    Caption = #1580#1587#1578#1580#1608
    TabOrder = 0
    object lbl1: TLabel
      Left = 543
      Top = 16
      Width = 59
      Height = 15
      Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
      FocusControl = txtSearchCode
    end
    object Bevel1: TBevel
      Left = 1
      Top = 48
      Width = 608
      Height = 5
      Shape = bsTopLine
    end
    object lblRecNo: TLabel
      Left = 559
      Top = 392
      Width = 39
      Height = 15
      Caption = #1578#1593#1583#1575#1583' : 0'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 389
      Top = 16
      Width = 53
      Height = 15
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583'&'#1711#1610
      FocusControl = txtSearchFamily
    end
    object lbl3: TLabel
      Left = 163
      Top = 16
      Width = 65
      Height = 15
      Caption = #1588#1605#1575#1585#1607' &'#1593#1590#1608#1610#1578
      FocusControl = txtID
    end
    object dbgPersons: TDBGrid
      Left = 8
      Top = 56
      Width = 593
      Height = 321
      DataSource = dtaPersons
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 3
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Empl_No'
          Title.Alignment = taCenter
          Title.Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FamilyName'
          Title.Alignment = taCenter
          Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605
          Width = 170
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Empl_ID'
          Title.Alignment = taCenter
          Title.Caption = #1588#1605#1575#1585#1607' '#1593#1590#1608#1610#1578
          Width = 105
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Discount'
          Title.Alignment = taCenter
          Title.Caption = #1711#1585#1608#1607' '#1578#1582#1601#1610#1601
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Empl_Balance'
          Title.Alignment = taCenter
          Title.Caption = #1605#1575#1606#1583#1607' '#1575#1593#1578#1576#1575#1585
          Width = 85
          Visible = True
        end>
    end
    object cmdHelp: TBitBtn
      Left = 112
      Top = 384
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 4
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 384
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 5
      Kind = bkClose
    end
    object txtSearchCode: TEdit
      Left = 448
      Top = 16
      Width = 81
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 8
      ParentBiDiMode = False
      TabOrder = 0
      OnExit = txtSearchCodeExit
    end
    object txtSearchFamily: TEdit
      Left = 232
      Top = 16
      Width = 145
      Height = 23
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      TabOrder = 1
      OnExit = txtSearchCodeExit
    end
    object txtID: TEdit
      Left = 8
      Top = 16
      Width = 145
      Height = 23
      BiDiMode = bdLeftToRight
      MaxLength = 15
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = txtSearchCodeExit
    end
  end
  object dtaPersons: TDataSource
    DataSet = adotblEmployee
    Left = 448
    Top = 128
  end
  object adotblEmployee: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\PrgOut\Credit1\C' +
      'redit1.mdb;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = adotblEmployeeCalcFields
    IndexFieldNames = 'Empl_no'
    TableName = 'Employee'
    Left = 360
    Top = 128
    object adotblEmployeeEmpl_No: TWideStringField
      FieldName = 'Empl_No'
      Size = 8
    end
    object adotblEmployeeEmpl_Name: TWideStringField
      FieldName = 'Empl_Name'
      Size = 15
    end
    object adotblEmployeeEmpl_Family: TWideStringField
      FieldName = 'Empl_Family'
      Size = 25
    end
    object adotblEmployeeEmpl_Active: TBooleanField
      FieldName = 'Empl_Active'
    end
    object adotblEmployeeEmpl_CoPost: TIntegerField
      FieldName = 'Empl_CoPost'
    end
    object adotblEmployeeEmpl_Part: TIntegerField
      FieldName = 'Empl_Part'
    end
    object adotblEmployeeEmpl_Dscnt: TIntegerField
      FieldName = 'Empl_Dscnt'
    end
    object adotblEmployeeEmpl_Balance: TBCDField
      FieldName = 'Empl_Balance'
      Precision = 19
    end
    object adotblEmployeeDiscount: TStringField
      FieldKind = fkCalculated
      FieldName = 'Discount'
      Size = 50
      Calculated = True
    end
    object adotblEmployeeFamilyName: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamilyName'
      Size = 50
      Calculated = True
    end
    object adotblEmployeeEmpl_ID: TWideStringField
      FieldName = 'Empl_ID'
      Size = 15
    end
    object adotblEmployeeEmpl_Department: TIntegerField
      FieldName = 'Empl_Department'
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 64
    Top = 8
  end
end
