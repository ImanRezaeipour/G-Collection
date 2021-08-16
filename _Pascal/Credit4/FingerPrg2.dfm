object frmFingerPrg2: TfrmFingerPrg2
  Left = 0
  Top = 104
  BiDiMode = bdRightToLeft
  Caption = #1576#1575#1606#1705' '#1575#1579#1585' '#1575#1606#1711#1588#1578' '#1662#1585#1587#1606#1604
  ClientHeight = 455
  ClientWidth = 792
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object grpDB: TGroupBox
    Left = 3
    Top = 5
    Width = 385
    Height = 378
    TabOrder = 2
    Visible = False
    object Shape3: TShape
      Left = 7
      Top = 15
      Width = 371
      Height = 32
      Brush.Color = clTeal
    end
    object Label6: TLabel
      Left = 76
      Top = 20
      Width = 220
      Height = 22
      Caption = #1575#1591#1604#1575#1593#1575#1578' '#1605#1608#1580#1608#1583' '#1583#1585' '#1576#1575#1606#1705' '#1575#1591#1604#1575#1593#1575#1578#1610
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object grpDBSearch: TGroupBox
      Left = 11
      Top = 89
      Width = 363
      Height = 81
      Caption = #1580#1587#1578#1580#1608
      TabOrder = 0
      Visible = False
      object lblSearch: TLabel
        Left = 288
        Top = 24
        Width = 67
        Height = 15
        Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' :'
      end
      object Label1: TLabel
        Left = 288
        Top = 53
        Width = 61
        Height = 15
        Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' :'
      end
      object txtDbCode: TEdit
        Left = 164
        Top = 20
        Width = 121
        Height = 23
        TabOrder = 0
      end
      object txtDbName: TEdit
        Left = 16
        Top = 49
        Width = 269
        Height = 23
        TabOrder = 1
      end
    end
    object DBGrid1: TDBGrid
      Left = 6
      Top = 89
      Width = 369
      Height = 211
      DataSource = dtaFinger
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      TabOrder = 1
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Proxi'
          Title.Alignment = taCenter
          Title.Caption = #1705#1583' '#1705#1575#1585#1578
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BarCode'
          Title.Alignment = taCenter
          Title.Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'master'
          Title.Alignment = taCenter
          Title.Caption = #1605#1583#1610#1585
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Family'
          Title.Alignment = taCenter
          Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
          Width = 122
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Alignment = taCenter
          Title.Caption = #1606#1575#1605' '
          Width = 67
          Visible = True
        end>
    end
    object RadioButton1: TRadioButton
      Left = 260
      Top = 72
      Width = 113
      Height = 17
      Caption = #1705#1604#1610#1607' '#1575#1591#1604#1575#1593#1575#1578' '
      TabOrder = 2
      Visible = False
    end
    object RadioButton2: TRadioButton
      Left = 136
      Top = 72
      Width = 109
      Height = 17
      Caption = #1575#1591#1604#1575#1593#1575#1578' '#1583#1587#1578#1711#1575#1607' : '
      TabOrder = 3
      Visible = False
    end
    object ComboBox1: TComboBox
      Left = 7
      Top = 67
      Width = 137
      Height = 23
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 4
      Visible = False
    end
    object BitBtn1: TBitBtn
      Left = 192
      Top = 348
      Width = 185
      Height = 25
      Caption = '<<'#1575#1606#1578#1602#1575#1604' '#1576#1607' '#1583#1587#1578#1711#1575#1607' '
      TabOrder = 5
      NumGlyphs = 2
    end
  end
  object grpBtns: TGroupBox
    Left = 0
    Top = 419
    Width = 792
    Height = 42
    Align = alTop
    TabOrder = 0
    object lblMsg: TLabel
      Left = 311
      Top = 10
      Width = 456
      Height = 29
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ARABIC_CHARSET
      Font.Color = clTeal
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cmdExit: TBitBtn
      Left = 7
      Top = 12
      Width = 146
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 1
      OnClick = cmdExitClick
      Kind = bkClose
    end
    object cmdHelp: TBitBtn
      Left = 160
      Top = 12
      Width = 145
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 0
      Kind = bkHelp
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 792
    Height = 419
    ActivePage = pgMove
    Align = alTop
    BiDiMode = bdRightToLeft
    MultiLine = True
    ParentBiDiMode = False
    TabOrder = 1
    object TabSheet2: TTabSheet
      Caption = '   '#1606#1605#1575#1610#1588' '#1575#1591#1604#1575#1593#1575#1578'   '
      ImageIndex = 1
      OnEnter = TabSheet2Enter
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 17
        Width = 762
        Height = 361
        TabOrder = 0
        object Label2: TLabel
          Left = 665
          Top = 28
          Width = 50
          Height = 15
          Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607' :'
        end
        object cmbRdrView: TComboBox
          Left = 529
          Top = 23
          Width = 131
          Height = 23
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
        end
        object btnGetAllView: TBitBtn
          Left = 529
          Top = 52
          Width = 189
          Height = 30
          Caption = #1582#1608#1575#1606#1583#1606' '#1575#1579#1585' '#1575#1606#1711#1588#1578#1607#1575#1610' '#1583#1587#1578#1711#1575#1607
          TabOrder = 2
          OnClick = btnGetAllViewClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
            0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
            00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
            00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
            F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
            F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
            FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
            0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
            00337777FFFF77FF7733EEEE0000000003337777777777777333}
          NumGlyphs = 2
        end
        object grdFpView: TStringGrid
          Left = 16
          Top = 26
          Width = 505
          Height = 278
          ColCount = 6
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
          TabOrder = 0
          ColWidths = (
            14
            40
            116
            69
            162
            72)
        end
        object statusView: TStatusBar
          Left = 16
          Top = 307
          Width = 505
          Height = 24
          Align = alNone
          Panels = <
            item
              Text = #1578#1593#1583#1575#1583' '#1705#1604' :'
              Width = 115
            end>
        end
        object chkViewName: TCheckBox
          Left = 360
          Top = 337
          Width = 161
          Height = 17
          Caption = #1606#1605#1575#1610#1588' '#1606#1575#1605' '#1608' '#1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
          TabOrder = 4
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '   '#1581#1584#1601' '#1575#1591#1604#1575#1593#1575#1578'    '
      ImageIndex = 2
      OnEnter = TabSheet3Enter
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox5: TGroupBox
        Left = 8
        Top = 17
        Width = 762
        Height = 361
        TabOrder = 0
        object Label14: TLabel
          Left = 665
          Top = 28
          Width = 50
          Height = 15
          Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607' :'
        end
        object GroupBox6: TGroupBox
          Left = 72
          Top = 120
          Width = 368
          Height = 81
          Caption = #1580#1587#1578#1580#1608
          TabOrder = 3
          Visible = False
          object Label16: TLabel
            Left = 288
            Top = 24
            Width = 67
            Height = 15
            Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' :'
          end
          object Label17: TLabel
            Left = 288
            Top = 53
            Width = 61
            Height = 15
            Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' :'
          end
          object Edit1: TEdit
            Left = 16
            Top = 49
            Width = 269
            Height = 23
            TabOrder = 0
          end
          object Edit2: TEdit
            Left = 164
            Top = 20
            Width = 121
            Height = 23
            TabOrder = 1
          end
        end
        object cmbRdrDelete: TComboBox
          Left = 529
          Top = 23
          Width = 131
          Height = 23
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
        end
        object btnGetAllDelete: TBitBtn
          Left = 529
          Top = 60
          Width = 189
          Height = 30
          Caption = #1582#1608#1575#1606#1583#1606' '#1575#1579#1585' '#1575#1606#1711#1588#1578#1607#1575#1610' '#1583#1587#1578#1711#1575#1607
          TabOrder = 2
          OnClick = btnGetAllDeleteClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
            0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
            00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
            00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
            F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
            F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
            FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
            0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
            00337777FFFF77FF7733EEEE0000000003337777777777777333}
          NumGlyphs = 2
        end
        object grdFpDelete: TStringGrid
          Left = 24
          Top = 26
          Width = 433
          Height = 278
          ColCount = 6
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
          TabOrder = 0
          OnMouseUp = grdFpDeleteMouseUp
          ColWidths = (
            14
            32
            71
            64
            154
            70)
        end
        object btnDeleteAll: TBitBtn
          Left = 529
          Top = 203
          Width = 189
          Height = 31
          Caption = #1581#1584#1601' '#1705#1604#1610#1607' '#1575#1579#1585' '#1575#1606#1711#1588#1578#1607#1575
          TabOrder = 4
          OnClick = btnDeleteAllClick
          OnEnter = btnAllClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
            3333333777777777F3333330F77777703333333733F3F3F73F33330FF0808077
            0333337F37F7F7F37F33330FF0807077033333733737F73F73F330FF77808707
            703337F37F37F37F37F330FF08807807703037F37F37F37F37F700FF08808707
            700377F37337F37F377330FF778078077033373F73F7F3733733330FF0808077
            0333337F37F7F7F37F33330FF08070770333337FF7F7F7FF7F33330000000000
            03333377777777777F33330F888777770333337FFFFFFFFF7F33330000000000
            033333777777777773333333307770333333333337FFF7F33333333330000033
            3333333337777733333333333333333333333333333333333333}
          NumGlyphs = 2
        end
        object btnNone: TBitBtn
          Left = 24
          Top = 309
          Width = 44
          Height = 23
          Caption = #1607#1610#1670#1705#1583#1575#1605
          TabOrder = 5
          OnClick = btnNoneClick
        end
        object btnAll: TBitBtn
          Left = 68
          Top = 309
          Width = 44
          Height = 23
          Caption = #1607#1605#1607
          TabOrder = 6
          OnClick = btnAllClick
        end
        object btnDeleteSelected: TBitBtn
          Left = 529
          Top = 169
          Width = 189
          Height = 31
          Caption = #1581#1584#1601' '#1575#1579#1585' '#1575#1606#1711#1588#1578' '#1575#1606#1578#1582#1575#1576' '#1588#1583#1711#1575#1606
          TabOrder = 7
          OnClick = btnDelSelectedClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
            3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
            33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
            33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
            333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
            03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
            33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
            0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
            3333333337FFF7F3333333333000003333333333377777333333}
          NumGlyphs = 2
        end
        object statusDelete: TStatusBar
          Left = 112
          Top = 307
          Width = 345
          Height = 24
          Align = alNone
          Panels = <
            item
              Text = #1578#1593#1583#1575#1583' '#1705#1604' :'
              Width = 115
            end>
        end
        object GroupBox7: TGroupBox
          Left = 528
          Top = 258
          Width = 190
          Height = 91
          Caption = #1581#1584#1601' '#1576#1575' '#1588#1605#1575#1585#1607'  :'
          TabOrder = 9
          object txtCode: TEdit
            Left = 13
            Top = 26
            Width = 164
            Height = 23
            MaxLength = 8
            TabOrder = 0
            OnKeyPress = txtCodeKeyPress
          end
          object btnDelete: TButton
            Left = 13
            Top = 51
            Width = 75
            Height = 24
            Caption = #1581#1584#1601
            TabOrder = 1
            OnClick = btnDeleteClick
          end
        end
        object chkDeleteName: TCheckBox
          Left = 296
          Top = 337
          Width = 161
          Height = 17
          Caption = #1606#1605#1575#1610#1588' '#1606#1575#1605' '#1608' '#1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610
          TabOrder = 10
        end
      end
    end
    object pgMove: TTabSheet
      Caption = '   '#1575#1606#1578#1602#1575#1604' '#1575#1591#1604#1575#1593#1575#1578'   '
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object btnMoveOne: TBitBtn
        Left = 197
        Top = 263
        Width = 153
        Height = 25
        Caption = #1575#1580#1585#1575
        TabOrder = 3
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          003337777777777777F330FFFFFFFFFFF033373F3F3F3F3F3733330F0F0F0F0F
          03333F7F737373737FFF0000FFFFFFF0000377773FFFFFF7777F0FF800000008
          FF037F3F77777773FF7F0F9FFFFFFFF000037F7333333337777F0FFFFFFFFFFF
          FF0373FFFFFFFFFFFF7330000000000000333777777777777733333000000000
          3333333777777777F3333330FFFFFFF033333337F3FFFFF7F3333330F00000F0
          33333337F77777F7F3333330F0AAE0F033333337F7F337F7F3333330F0DAD0F0
          33333337F7FFF7F7F3333330F00000F033333337F7777737F3333330FFFFFFF0
          33333337FFFFFFF7F33333300000000033333337777777773333}
        NumGlyphs = 2
      end
      object GroupBox8: TGroupBox
        Left = 384
        Top = 145
        Width = 359
        Height = 146
        Caption = #1605#1602#1589#1583' '#1575#1606#1578#1602#1575#1604
        TabOrder = 6
        object rdoToTerminal: TRadioButton
          Left = 208
          Top = 25
          Width = 132
          Height = 17
          Caption = #1576#1607' '#1583#1587#1578#1711#1575#1607' '#1581#1590#1608#1585#1608#1594#1610#1575#1576
          TabOrder = 0
          OnClick = rdoToTerminalClick
        end
        object rdoToFile: TRadioButton
          Left = 288
          Top = 60
          Width = 52
          Height = 17
          Caption = #1576#1607' '#1601#1575#1610#1604
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rdoToFileClick
        end
        object txtToFile: TEdit
          Left = 39
          Top = 55
          Width = 242
          Height = 23
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 2
        end
        object btnToFile: TButton
          Left = 16
          Top = 55
          Width = 22
          Height = 22
          Caption = '...'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arabic Transparent'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = btnToFileClick
        end
        object cmbToMoveAll: TComboBox
          Left = 16
          Top = 19
          Width = 193
          Height = 23
          Style = csDropDownList
          Enabled = False
          ItemHeight = 0
          TabOrder = 4
        end
        object chkUpdate: TCheckBox
          Left = 192
          Top = 117
          Width = 142
          Height = 17
          Caption = #1576#1585#1608#1586' '#1585#1587#1575#1606#1610' '#1605#1602#1589#1583
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = chkUpdateClick
        end
        object chkFormatMoveAll: TCheckBox
          Left = 11
          Top = 117
          Width = 169
          Height = 17
          Caption = #1581#1584#1601' '#1575#1591#1604#1575#1593#1575#1578' '#1602#1576#1604#1610' '#1605#1602#1589#1583
          TabOrder = 6
          OnClick = chkFormatMoveAllClick
        end
      end
      object statusTo: TStatusBar
        Left = 0
        Top = 356
        Width = 784
        Height = 33
        BiDiMode = bdRightToLeft
        Font.Charset = ARABIC_CHARSET
        Font.Color = clPurple
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Panels = <
          item
            Alignment = taCenter
            Bevel = pbRaised
            Width = 100
          end
          item
            Alignment = taCenter
            Width = 250
          end
          item
            Alignment = taCenter
            Width = 50
          end>
        ParentBiDiMode = False
        UseSystemFont = False
      end
      object GroupBox3: TGroupBox
        Left = 384
        Top = 32
        Width = 359
        Height = 109
        Caption = #1605#1576#1583#1575' '#1575#1606#1578#1602#1575#1604
        Font.Charset = ARABIC_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object cmbFromMoveAll: TComboBox
          Left = 16
          Top = 28
          Width = 193
          Height = 23
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
        end
        object rdoFromTerminal: TRadioButton
          Left = 216
          Top = 32
          Width = 125
          Height = 17
          Caption = #1575#1586' '#1583#1587#1578#1711#1575#1607' '#1581#1590#1608#1585#1608#1594#1610#1575#1576
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rdoFromTerminalClick
        end
        object rdoFromFile: TRadioButton
          Left = 288
          Top = 70
          Width = 53
          Height = 17
          Caption = #1575#1586' '#1601#1575#1610#1604
          TabOrder = 2
          OnClick = rdoFromFileClick
        end
        object txtFromFile: TEdit
          Left = 39
          Top = 65
          Width = 242
          Height = 23
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 3
        end
        object btnFromFile: TButton
          Left = 16
          Top = 65
          Width = 22
          Height = 22
          Caption = '...'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arabic Transparent'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = btnFromFileClick
        end
      end
      object btnMove: TBitBtn
        Left = 123
        Top = 262
        Width = 254
        Height = 29
        Caption = #1575#1580#1585#1575
        TabOrder = 1
        OnClick = btnMoveClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          003337777777777777F330FFFFFFFFFFF033373F3F3F3F3F3733330F0F0F0F0F
          03333F7F737373737FFF0000FFFFFFF0000377773FFFFFF7777F0FF800000008
          FF037F3F77777773FF7F0F9FFFFFFFF000037F7333333337777F0FFFFFFFFFFF
          FF0373FFFFFFFFFFFF7330000000000000333777777777777733333000000000
          3333333777777777F3333330FFFFFFF033333337F3FFFFF7F3333330F00000F0
          33333337F77777F7F3333330F0AAE0F033333337F7F337F7F3333330F0DAD0F0
          33333337F7FFF7F7F3333330F00000F033333337F7777737F3333330FFFFFFF0
          33333337FFFFFFF7F33333300000000033333337777777773333}
        NumGlyphs = 2
      end
      object grpSelectScop: TGroupBox
        Left = 40
        Top = 32
        Width = 337
        Height = 223
        Caption = #1575#1606#1578#1582#1575#1576' '#1575#1601#1585#1575#1583
        TabOrder = 2
        object rdoMoveAll: TRadioButton
          Left = 204
          Top = 30
          Width = 113
          Height = 17
          Caption = #1607#1605#1607' '#1575#1601#1585#1575#1583' '
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rdoMoveAllClick
        end
        object rdoMoveOne: TRadioButton
          Left = 204
          Top = 62
          Width = 113
          Height = 17
          Caption = #1610#1705' '#1601#1585#1583' '#1582#1575#1589
          TabOrder = 1
          OnClick = rdoMoveOneClick
        end
        object grpSelectOne: TGroupBox
          Left = 24
          Top = 87
          Width = 293
          Height = 127
          Enabled = False
          TabOrder = 2
          object Label7: TLabel
            Left = 200
            Top = 78
            Width = 78
            Height = 15
            Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610'-'#1606#1575#1605' :'
          end
          object Label12: TLabel
            Left = 199
            Top = 51
            Width = 67
            Height = 15
            Caption = #1588#1605#1575#1585#1607' '#1662#1585#1587#1606#1604#1610' :'
          end
          object Label11: TLabel
            Left = 200
            Top = 21
            Width = 60
            Height = 15
            Caption = #1588#1605#1575#1585#1607' '#1705#1575#1585#1578' :'
          end
          object cmbNameMoveOne: TComboBox
            Left = 16
            Top = 73
            Width = 178
            Height = 23
            ItemHeight = 0
            TabOrder = 0
            OnChange = cmbNameMoveOneChange
          end
          object cmbCodeMoveOne: TComboBox
            Left = 16
            Top = 46
            Width = 178
            Height = 23
            ItemHeight = 0
            TabOrder = 1
            OnChange = cmbCodeMoveOneChange
          end
          object cmbProxiMoveOne: TComboBox
            Left = 16
            Top = 17
            Width = 178
            Height = 23
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 2
            OnChange = cmbProxiMoveOneChange
          end
          object chkFormatOne: TCheckBox
            Left = 25
            Top = 102
            Width = 169
            Height = 17
            Caption = #1581#1584#1601' '#1575#1586' '#1583#1587#1578#1711#1575#1607' '#1605#1576#1583#1575
            TabOrder = 3
          end
        end
      end
      object statusFrom: TStatusBar
        Left = 0
        Top = 323
        Width = 784
        Height = 33
        BiDiMode = bdRightToLeft
        Font.Charset = ARABIC_CHARSET
        Font.Color = clPurple
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Panels = <
          item
            Alignment = taCenter
            Bevel = pbRaised
            Width = 100
          end
          item
            Alignment = taCenter
            Width = 250
          end
          item
            Alignment = taCenter
            Width = 50
          end>
        ParentBiDiMode = False
        UseSystemFont = False
      end
      object Button1: TButton
        Left = 40
        Top = 262
        Width = 81
        Height = 28
        Caption = #1575#1606#1589#1585#1575#1601
        TabOrder = 7
        OnClick = Button1Click
      end
    end
  end
  object dtaFinger: TDataSource
    DataSet = adoQryFinger
    Left = 16
    Top = 208
  end
  object adoQryFinger: TADOQuery
    CursorType = ctStatic
    OnCalcFields = adoQryFingerCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from finger')
    Left = 16
    Top = 120
    object adoQryFingerBarCode: TStringField
      FieldKind = fkCalculated
      FieldName = 'BarCode'
      Size = 8
      Calculated = True
    end
    object adoQryFingername: TStringField
      FieldKind = fkCalculated
      FieldName = 'name'
      Calculated = True
    end
    object adoQryFingerFamily: TStringField
      FieldKind = fkCalculated
      FieldName = 'Family'
      Size = 30
      Calculated = True
    end
    object adoQryFingermaster: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'master'
      Calculated = True
    end
    object adoQryFingerProxi: TWideStringField
      FieldName = 'Proxi'
      Size = 8
    end
    object adoQryFingerSample: TWideStringField
      FieldName = 'Sample'
      Size = 8
    end
  end
  object adoTblFinger: TADOTable
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Data Source=Excel' +
      ' Files'
    CursorType = ctStatic
    TableName = 'finger'
    Left = 16
    Top = 88
  end
  object adoTblPersons: TADOTable
    CursorType = ctStatic
    TableName = 'persons'
    Left = 16
    Top = 168
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.db'
    Filter = '*.db|*.db'
    Left = 464
    Top = 144
  end
end
