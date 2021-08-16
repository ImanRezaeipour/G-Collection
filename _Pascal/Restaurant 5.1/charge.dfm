object frmcharge: Tfrmcharge
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 344
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 538
    Height = 129
    Align = alTop
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 536
      Height = 127
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1605#1588#1582#1589#1575#1578' '#1588#1575#1585#1688
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label2: TLabel
          Left = 442
          Top = 18
          Width = 50
          Height = 14
          Caption = #1578#1575#1585#1610#1582' '#1588#1575#1585#1688
        end
        object Label1: TLabel
          Left = 442
          Top = 45
          Width = 50
          Height = 14
          Caption = #1586#1605#1575#1606' '#1588#1575#1585#1688
        end
        object Label3: TLabel
          Left = 170
          Top = 33
          Width = 55
          Height = 14
          Caption = #1602#1610#1605#1578' '#1588#1575#1585#1688
        end
        object Label4: TLabel
          Left = 19
          Top = 33
          Width = 19
          Height = 14
          Caption = #1585#1610#1575#1604
        end
        object txt_time: TEdit
          Left = 315
          Top = 42
          Width = 121
          Height = 22
          TabOrder = 2
          OnExit = txt_timeExit
          OnKeyPress = txt_timeKeyPress
        end
        object txt_date: TEdit
          Left = 315
          Top = 15
          Width = 121
          Height = 22
          TabOrder = 1
          OnExit = txt_dateExit
          OnKeyPress = txt_dateKeyPress
        end
        object txt_price: TEdit
          Left = 43
          Top = 30
          Width = 121
          Height = 22
          TabOrder = 0
          OnKeyPress = txt_priceKeyPress
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 304
    Width = 538
    Height = 40
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 310
    object btnOK: TBitBtn
      Left = 419
      Top = 7
      Width = 113
      Height = 25
      Caption = #1575#1606#1580#1575#1605' '#1593#1605#1604' '#1588#1575#1585#1688
      TabOrder = 0
      OnClick = btnOKClick
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
    object btnCancel: TBitBtn
      Left = 5
      Top = 8
      Width = 105
      Height = 25
      Caption = #1575#1606#1589#1585#1575#1601
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 129
    Width = 538
    Height = 175
    Align = alClient
    TabOrder = 2
    ExplicitHeight = 181
    object PageControl2: TPageControl
      Left = 1
      Top = 1
      Width = 536
      Height = 173
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 179
      object TabSheet2: TTabSheet
        Caption = #1575#1606#1578#1582#1575#1576' '#1605#1581#1583#1608#1583#1607
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 150
        DesignSize = (
          528
          144)
        object lbl1: TLabel
          Left = 442
          Top = 138
          Width = 33
          Height = 14
          Caption = #1662#1585#1587#1606#1604
          Visible = False
        end
        object lblParts: TLabel
          Left = 471
          Top = 110
          Width = 27
          Height = 14
          Anchors = [akTop, akRight]
          Caption = '&'#1576#1582#1588
        end
        object lblBarCode: TLabel
          Left = 421
          Top = 82
          Width = 77
          Height = 14
          Caption = '&'#1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
        end
        object lblFamily: TLabel
          Left = 207
          Top = 82
          Width = 91
          Height = 14
          Caption = #1606#1575#1605' &'#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605
        end
        object cmbCardType: TRadioGroup
          Left = 3
          Top = 3
          Width = 522
          Height = 62
          BiDiMode = bdRightToLeft
          Caption = #1605#1581#1583#1608#1583#1607' '#1588#1575#1585#1688
          Columns = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            #1578#1605#1575#1605' '#1662#1585#1587#1606#1604
            #13#1601#1585#1583' '#1582#1575#1589
            #1576#1582#1588' '#1582#1575#1589)
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 0
          OnClick = cmbCardTypeClick
        end
        object cmbEmplCode: TDBLookupComboBox
          Left = 304
          Top = 135
          Width = 132
          Height = 22
          BiDiMode = bdLeftToRight
          DataField = 'P_BarCode'
          DataSource = DataSource1
          KeyField = 'p_BarCode'
          ListField = 'p_BarCode'
          ListSource = DataSource2
          ParentBiDiMode = False
          TabOrder = 1
          Visible = False
        end
        object cmbEmplName: TDBLookupComboBox
          Left = 91
          Top = 135
          Width = 207
          Height = 22
          DataField = 'P_BarCode'
          DataSource = DataSource1
          KeyField = 'P_BarCode'
          ListField = 'te'
          ListSource = DataSource2
          TabOrder = 2
          Visible = False
        end
        object txtParts: TEdit
          Left = 119
          Top = 107
          Width = 346
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          BiDiMode = bdRightToLeft
          MaxLength = 15
          ParentBiDiMode = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 3
        end
        object BitBtnParts: TBitBtn
          Left = 122
          Top = 109
          Width = 19
          Height = 19
          Font.Charset = ARABIC_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arabic Transparent'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = BitBtnPartsClick
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
        object cmbPCode: TComboBox
          Left = 304
          Top = 79
          Width = 111
          Height = 22
          BiDiMode = bdRightToLeft
          ItemHeight = 0
          ParentBiDiMode = False
          TabOrder = 5
          OnClick = cmbPCodeClick
          OnExit = cmbPCodeExit
          OnKeyPress = cmbPCodeKeyPress
        end
        object cmbFamilyName: TComboBox
          Left = 9
          Top = 79
          Width = 192
          Height = 22
          BiDiMode = bdRightToLeft
          ItemHeight = 0
          ParentBiDiMode = False
          TabOrder = 6
          OnClick = cmbFamilyNameClick
          OnExit = cmbFamilyNameExit
          OnKeyPress = cmbFamilyNameKeyPress
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 51
    Top = 176
  end
  object DataSource2: TDataSource
    DataSet = ADOTable2
    Left = 19
    Top = 176
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 8
    Top = 88
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Rest_SaderatGaz;Data Source=.'
    CursorType = ctStatic
    OnCalcFields = ADOTable1CalcFields
    TableName = 'persons'
    Left = 48
    Top = 147
    object ADOTable1P_BarCode: TWideStringField
      FieldName = 'P_BarCode'
      Size = 8
    end
    object ADOTable1P_Proxi: TWideStringField
      FieldName = 'P_Proxi'
      Size = 15
    end
    object ADOTable1P_Name: TWideStringField
      FieldName = 'P_Name'
      Size = 40
    end
    object ADOTable1P_Family: TWideStringField
      FieldName = 'P_Family'
      Size = 40
    end
    object ADOTable1P_Parts: TWideStringField
      FieldName = 'P_Parts'
      Size = 255
    end
    object ADOTable1P_JobCode: TSmallintField
      FieldName = 'P_JobCode'
    end
    object ADOTable1P_IsValid: TBooleanField
      FieldName = 'P_IsValid'
    end
    object ADOTable1P_ValidTest: TBooleanField
      FieldName = 'P_ValidTest'
    end
    object ADOTable1P_Pricable: TBooleanField
      FieldName = 'P_Pricable'
    end
    object ADOTable1P_Sobhaneh: TBooleanField
      FieldName = 'P_Sobhaneh'
    end
    object ADOTable1P_Nahar: TBooleanField
      FieldName = 'P_Nahar'
    end
    object ADOTable1P_Sham: TBooleanField
      FieldName = 'P_Sham'
    end
    object ADOTable1P_Rejim: TBooleanField
      FieldName = 'P_Rejim'
    end
    object ADOTable1P_IsGuest: TBooleanField
      FieldName = 'P_IsGuest'
    end
    object ADOTable1P_Special: TSmallintField
      FieldName = 'P_Special'
    end
    object ADOTable1P_ManyFish: TSmallintField
      FieldName = 'P_ManyFish'
    end
    object ADOTable1P_EtebarFish: TWideStringField
      FieldName = 'P_EtebarFish'
      Size = 10
    end
    object ADOTable1P_DblFood: TBooleanField
      FieldName = 'P_DblFood'
    end
    object ADOTable1P_CashType: TSmallintField
      FieldName = 'P_CashType'
    end
    object ADOTable1P_DeserNoFood: TBooleanField
      FieldName = 'P_DeserNoFood'
    end
    object ADOTable1P_Building: TSmallintField
      FieldName = 'P_Building'
    end
    object ADOTable1P_Sex: TSmallintField
      FieldName = 'P_Sex'
    end
    object ADOTable1p_prepaid: TBooleanField
      FieldName = 'p_prepaid'
    end
    object ADOTable1te: TStringField
      FieldKind = fkCalculated
      FieldName = 'te'
      Size = 30
      Calculated = True
    end
    object ADOTable1P_ShiftGroup: TSmallintField
      FieldName = 'P_ShiftGroup'
    end
    object ADOTable1P_Credit: TBCDField
      FieldName = 'P_Credit'
      Precision = 19
    end
  end
  object ADOTable2: TADOTable
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Rest_SaderatGaz;Data Source=.'
    CursorType = ctStatic
    OnCalcFields = ADOTable2CalcFields
    TableName = 'persons'
    Left = 17
    Top = 146
    object ADOTable2P_BarCode: TWideStringField
      FieldName = 'P_BarCode'
      Size = 8
    end
    object ADOTable2P_Proxi: TWideStringField
      FieldName = 'P_Proxi'
      Size = 15
    end
    object ADOTable2P_Name: TWideStringField
      FieldName = 'P_Name'
      Size = 40
    end
    object ADOTable2P_Family: TWideStringField
      FieldName = 'P_Family'
      Size = 40
    end
    object ADOTable2P_Parts: TWideStringField
      FieldName = 'P_Parts'
      Size = 255
    end
    object ADOTable2P_JobCode: TSmallintField
      FieldName = 'P_JobCode'
    end
    object ADOTable2P_shiftGroup: TSmallintField
      FieldName = 'P_ShiftGroup'
    end
    object ADOTable2P_IsValid: TBooleanField
      FieldName = 'P_IsValid'
    end
    object ADOTable2P_ValidTest: TBooleanField
      FieldName = 'P_ValidTest'
    end
    object ADOTable2P_Pricable: TBooleanField
      FieldName = 'P_Pricable'
    end
    object ADOTable2P_Sobhaneh: TBooleanField
      FieldName = 'P_Sobhaneh'
    end
    object ADOTable2P_Nahar: TBooleanField
      FieldName = 'P_Nahar'
    end
    object ADOTable2P_Sham: TBooleanField
      FieldName = 'P_Sham'
    end
    object ADOTable2P_Rejim: TBooleanField
      FieldName = 'P_Rejim'
    end
    object ADOTable2P_IsGuest: TBooleanField
      FieldName = 'P_IsGuest'
    end
    object ADOTable2P_Special: TSmallintField
      FieldName = 'P_Special'
    end
    object ADOTable2P_ManyFish: TSmallintField
      FieldName = 'P_ManyFish'
    end
    object ADOTable2P_EtebarFish: TWideStringField
      FieldName = 'P_EtebarFish'
      Size = 10
    end
    object ADOTable2P_DblFood: TBooleanField
      FieldName = 'P_DblFood'
    end
    object ADOTable2P_CashType: TSmallintField
      FieldName = 'P_CashType'
    end
    object ADOTable2P_DeserNoFood: TBooleanField
      FieldName = 'P_DeserNoFood'
    end
    object ADOTable2P_Building: TSmallintField
      FieldName = 'P_Building'
    end
    object ADOTable2P_Sex: TSmallintField
      FieldName = 'P_Sex'
    end
    object ADOTable2p_prepaid: TBooleanField
      FieldName = 'p_prepaid'
    end
    object ADOTable2te: TStringField
      FieldKind = fkCalculated
      FieldName = 'te'
      Size = 30
      Calculated = True
    end
    object ADOTable2P_Credit: TBCDField
      FieldName = 'P_Credit'
      Precision = 19
    end
  end
end
