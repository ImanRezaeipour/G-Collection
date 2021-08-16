object frmCharge: TfrmCharge
  Left = 227
  Top = 120
  HelpContext = 13
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1575#1605#1610#1606' '#1575#1593#1578#1576#1575#1585' '#1603#1575#1585#1578#1607#1575
  ClientHeight = 448
  ClientWidth = 542
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
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label2: TLabel
    Left = 57
    Top = 173
    Width = 52
    Height = 15
    Caption = 'coderade'
  end
  object grpRight: TGroupBox
    Left = 0
    Top = 0
    Width = 542
    Height = 17
    Align = alTop
    Caption = #1591#1585#1610#1602#1607' '#1588#1575#1585#1688
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    Visible = False
    object rdoTextFile: TRadioButton
      Left = 288
      Top = 29
      Width = 149
      Height = 17
      Caption = #1575#1586' '#1591#1585#1610#1602' '#1601#1575#1610#1604
      TabOrder = 0
      OnClick = rdoTextFileClick
    end
    object rdoScope: TRadioButton
      Left = 48
      Top = 28
      Width = 181
      Height = 17
      Caption = #1575#1586' '#1591#1585#1610#1602' '#1575#1606#1578#1582#1575#1576' '#1605#1581#1583#1608#1583#1607
      TabOrder = 1
      OnClick = rdoTextFileClick
    end
    object rdoChargeType: TRadioGroup
      Left = 14
      Top = 173
      Width = 134
      Height = 100
      Caption = #1606#1608#1593' '#1588#1575#1585#1688
      ItemIndex = 0
      Items.Strings = (
        #1601#1575#1610#1604' '#1605#1578#1606#1610
        #1575#1606#1578#1582#1575#1576' '#1605#1581#1583#1608#1583#1607)
      TabOrder = 2
    end
  end
  object pagcharg: TPageControl
    Left = 0
    Top = 119
    Width = 542
    Height = 328
    ActivePage = TabSheet2
    Align = alTop
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1575#1586' '#1591#1585#1610#1602' '#1601#1575#1610#1604
      object grpFile: TGroupBox
        Left = 0
        Top = 0
        Width = 534
        Height = 294
        Align = alTop
        Caption = #1575#1606#1578#1582#1575#1576' '#1601#1575#1610#1604
        TabOrder = 0
        object lblNo2: TLabel
          Left = 129
          Top = 263
          Width = 281
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'lblNo'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Arabic Transparent'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object lbl9: TLabel
          Left = 487
          Top = 26
          Width = 42
          Height = 16
          Caption = #1606#1575#1605' &'#1601#1575#1610#1604
        end
        object lblRecNo: TLabel
          Left = 481
          Top = 212
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
        object lbl10: TLabel
          Left = 169
          Top = 217
          Width = 34
          Height = 16
          Caption = '&'#1580#1575#1610#1711#1575#1607
          FocusControl = cmbCoPosts
        end
        object DBGrid1: TDBGrid
          Left = 8
          Top = 48
          Width = 521
          Height = 160
          DataSource = DataSource1
          TabOrder = 4
          TitleFont.Charset = ARABIC_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'RowNo'
              Title.Caption = #1585#1583#1610#1601
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EmplNo'
              Title.Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' '
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EmplNameInDB'
              Title.Caption = #1606#1575#1605' '#1583#1585#1608#1606' '#1576#1575#1606#1705' '#1575#1591#1604#1575#1593#1575#1578
              Width = 143
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EmplNameInFile'
              Title.Caption = #1606#1575#1605' '#1583#1585#1608#1606' '#1601#1575#1610#1604
              Width = 147
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'EmplPart'
              Title.Caption = #1605#1581#1604' '#1582#1583#1605#1578
              Width = 70
              Visible = True
            end>
        end
        object BitBtn1: TBitBtn
          Left = 8
          Top = 259
          Width = 113
          Height = 25
          Caption = #1575#1606#1589#1585#1575#1601
          TabOrder = 0
          OnClick = BitBtn1Click
          Kind = bkCancel
        end
        object btnOk2: TBitBtn
          Left = 406
          Top = 261
          Width = 123
          Height = 25
          Caption = #1575#1606#1580#1575#1605' '#1593#1605#1604' '#1588#1575#1585#1688
          TabOrder = 1
          OnClick = btnOk2Click
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
        object txtPath: TEdit
          Left = 40
          Top = 23
          Width = 441
          Height = 24
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 2
        end
        object cmdPath: TButton
          Left = 9
          Top = 23
          Width = 25
          Height = 23
          Caption = '...'
          TabOrder = 3
          OnClick = cmdPathClick
        end
        object cmbCoPosts: TComboBox
          Left = 8
          Top = 214
          Width = 153
          Height = 24
          Style = csDropDownList
          ItemHeight = 16
          TabOrder = 5
          OnKeyDown = cmbCoPostsKeyDown
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1575#1586' '#1591#1585#1610#1602' '#1575#1606#1578#1582#1575#1576' '#1605#1581#1583#1608#1583#1607
      ImageIndex = 1
      object grpScope: TGroupBox
        Left = 0
        Top = 0
        Width = 534
        Height = 294
        Align = alTop
        Caption = #1575#1606#1578#1582#1575#1576' '#1605#1581#1583#1608#1583#1607
        TabOrder = 0
        object lblNo: TLabel
          Left = 115
          Top = 263
          Width = 294
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'lblNo'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Arabic Transparent'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object cmbCode: TComboBox
          Left = 351
          Top = 108
          Width = 167
          Height = 24
          BiDiMode = bdRightToLeft
          ItemHeight = 16
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = cmbCodeClick
          OnExit = cmbCodeExit
        end
        object cmbName: TComboBox
          Left = 8
          Top = 108
          Width = 337
          Height = 24
          ItemHeight = 16
          TabOrder = 1
          OnClick = cmbNameClick
          OnExit = cmbNameExit
        end
        object cbzero: TCheckBox
          Left = 15
          Top = 134
          Width = 129
          Height = 17
          Caption = #1589#1601#1585#1603#1585#1583#1606' '#1575#1593#1578#1576#1575#1585' '#1602#1576#1604#1610
          TabOrder = 2
          Visible = False
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 152
          Width = 513
          Height = 72
          Caption = #1606#1608#1593' '#1575#1593#1578#1576#1575#1585' '#1586#1605#1575#1606#1610
          TabOrder = 3
          Visible = False
          object txtExpireDate: TEdit
            Left = 113
            Top = 18
            Width = 121
            Height = 24
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 0
            OnExit = txtExpireDateExit
            OnKeyPress = txtExpireDateKeyPress
          end
          object rdoNoLimit: TRadioButton
            Left = 231
            Top = 47
            Width = 113
            Height = 17
            Caption = #1606#1575#1605#1581#1583#1608#1583
            TabOrder = 1
            OnClick = rdoExpireDateClick
          end
          object rdoExpireDate: TRadioButton
            Left = 238
            Top = 21
            Width = 105
            Height = 17
            Caption = #1578#1575#1585#1610#1582' '#1662#1575#1610#1575#1606' '#1575#1593#1578#1576#1575#1585' :'
            TabOrder = 2
            OnClick = rdoExpireDateClick
          end
        end
        object cmbCardType: TRadioGroup
          Left = 3
          Top = 31
          Width = 513
          Height = 71
          Caption = #1605#1581#1583#1608#1583#1607' '#1588#1575#1585#1688
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            #1578#1605#1575#1605#1610' '#1603#1575#1585#1578#1607#1575
            #13#1601#1585#1583' '#1582#1575#1589
            #1575#1601#1585#1575#1583' '#1580#1575#1610#1711#1575#1607' '#1582#1575#1589
            #1575#1601#1585#1575#1583' '#1605#1581#1604' '#1582#1583#1605#1578' '#1582#1575#1589)
          TabOrder = 4
          OnClick = cmbCardTypeClick
        end
        object btnOK: TBitBtn
          Left = 406
          Top = 261
          Width = 123
          Height = 25
          Caption = #1575#1606#1580#1575#1605' '#1593#1605#1604' '#1588#1575#1585#1688
          TabOrder = 5
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
          Left = 8
          Top = 259
          Width = 113
          Height = 25
          Caption = #1575#1606#1589#1585#1575#1601
          TabOrder = 6
          OnClick = btnCancelClick
          Kind = bkCancel
        end
      end
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 17
    Width = 542
    Height = 102
    Align = alTop
    TabOrder = 2
    object GroupBox2: TGroupBox
      Left = 4
      Top = 6
      Width = 534
      Height = 82
      Align = alTop
      Caption = #1605#1588#1582#1589#1575#1578' '#1588#1575#1585#1688
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      object lbl1: TLabel
        Left = 443
        Top = 33
        Width = 48
        Height = 15
        Alignment = taRightJustify
        Caption = #1578#1575#1585#1610#1582' '#1588#1575#1585#1688
      end
      object Label5: TLabel
        Left = 208
        Top = 44
        Width = 43
        Height = 15
        Alignment = taRightJustify
        Caption = #1605#1576#1604#1594' '#1588#1575#1585#1688
      end
      object Label6: TLabel
        Left = 56
        Top = 44
        Width = 19
        Height = 15
        Caption = #1585#1610#1575#1604
      end
      object Label1: TLabel
        Left = 443
        Top = 59
        Width = 47
        Height = 15
        Alignment = taRightJustify
        Caption = #1586#1605#1575#1606' '#1588#1575#1585#1688
      end
      object RadioGroup1: TRadioGroup
        Left = 14
        Top = 173
        Width = 134
        Height = 100
        Caption = #1606#1608#1593' '#1588#1575#1585#1688
        ItemIndex = 0
        Items.Strings = (
          #1601#1575#1610#1604' '#1605#1578#1606#1610
          #1575#1606#1578#1582#1575#1576' '#1605#1581#1583#1608#1583#1607)
        TabOrder = 0
      end
      object txtDate: TEdit
        Left = 344
        Top = 30
        Width = 94
        Height = 21
        BiDiMode = bdLeftToRight
        Color = cl3DLight
        Ctl3D = False
        MaxLength = 10
        ParentBiDiMode = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
        OnExit = txtDateExit
        OnKeyPress = txtDateKeyPress
      end
      object txtCharge: TEdit
        Left = 81
        Top = 41
        Width = 121
        Height = 21
        BiDiMode = bdLeftToRight
        Color = cl3DLight
        Ctl3D = False
        ParentBiDiMode = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
        OnKeyPress = txtChargeKeyPress
      end
      object txtTime: TEdit
        Left = 343
        Top = 54
        Width = 94
        Height = 21
        BiDiMode = bdLeftToRight
        Color = cl3DLight
        Ctl3D = False
        MaxLength = 10
        ParentBiDiMode = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 3
        OnExit = txtTimeExit
        OnKeyPress = txtTimeKeyPress
      end
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 32
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 136
    Top = 32
  end
  object Table1: TTable
    AfterScroll = Table1AfterScroll
    OnCalcFields = Table1CalcFields
    TableName = 'kol.txt'
    TableType = ttASCII
    Left = 72
    Top = 56
    object Table1FIELD1: TStringField
      FieldName = 'FIELD1'
      Size = 50
    end
    object Table1EmplNo: TStringField
      FieldKind = fkCalculated
      FieldName = 'EmplNo'
      Size = 8
      Calculated = True
    end
    object Table1EmplName: TStringField
      FieldKind = fkCalculated
      FieldName = 'EmplNameInDB'
      Size = 30
      Calculated = True
    end
    object Table1EmplFamily: TStringField
      FieldKind = fkCalculated
      FieldName = 'EmplNameInFile'
      Size = 30
      Calculated = True
    end
    object Table1EmplPart: TStringField
      FieldKind = fkCalculated
      FieldName = 'EmplPart'
      Size = 8
      Calculated = True
    end
    object Table1RowNo: TStringField
      FieldKind = fkCalculated
      FieldName = 'RowNo'
      Size = 6
      Calculated = True
    end
  end
  object OpenDialog1: TOpenDialog
    Top = 48
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery1
    Left = 280
    Top = 72
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select * from Readers')
    Left = 280
    Top = 40
  end
end
