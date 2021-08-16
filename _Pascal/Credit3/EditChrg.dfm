object frmEditCharge: TfrmEditCharge
  Left = 162
  Top = 91
  HelpContext = 14
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1608#1610#1585#1575#1610#1588' '#1575#1593#1578#1576#1575#1585' '#1603#1575#1585#1578#1607#1575
  ClientHeight = 440
  ClientWidth = 561
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    561
    440)
  PixelsPerInch = 96
  TextHeight = 15
  object DBText1: TDBText
    Left = 224
    Top = 216
    Width = 65
    Height = 17
  end
  object DBText2: TDBText
    Left = 208
    Top = 248
    Width = 65
    Height = 17
  end
  object Panel1: TPanel
    Left = 8
    Top = 126
    Width = 551
    Height = 312
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      551
      312)
    object SpeedButton2: TSpeedButton
      Left = 288
      Top = 152
      Width = 23
      Height = 22
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 278
      Width = 97
      Height = 25
      Caption = '&'#1582#1585#1608#1580
      TabOrder = 0
      Kind = bkClose
    end
    object cmdHelp: TBitBtn
      Left = 108
      Top = 278
      Width = 97
      Height = 25
      Caption = #1585#1575'&'#1607#1606#1605#1575
      TabOrder = 1
      Kind = bkHelp
    end
    object dbgCharge: TDBGrid
      Left = 5
      Top = 5
      Width = 535
      Height = 267
      Anchors = [akLeft, akTop, akRight]
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      TabOrder = 2
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = cmdEditClick
      OnKeyDown = dbgChargeKeyDown
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DtlCode'
          PickList.Strings = (
            '1\2'
            '2'
            '2'
            '3'
            '3'
            '4'
            '54')
          Title.Caption = #1588#1605#1575#1585#1607' '#1583#1608#1585#1607
          Width = 69
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'GRPPRICE'
          Title.Caption = #1605#1576#1604#1594' '#1583#1608#1585#1607
          Width = 79
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Empl_No'
          Title.Caption = #1705#1583
          Width = 97
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'familyname'
          Title.Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' - '#1606#1575#1605
          Width = 136
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Empl_Name'
          Visible = False
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Empl_Family'
          Visible = False
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'active'
          Title.Caption = #1575#1606#1578#1602#1575#1604' '#1576#1607' '#1603#1575#1585#1578
          Width = 110
          Visible = True
        end>
    end
    object BitBtn3: TBitBtn
      Left = 449
      Top = 278
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1578#1594#1610#1610#1585' '#1583#1608#1585#1607
      TabOrder = 3
      OnClick = BitBtn3Click
      NumGlyphs = 2
    end
    object BitBtn4: TBitBtn
      Left = 350
      Top = 278
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1581#1584#1601
      TabOrder = 4
      OnClick = BitBtn4Click
      NumGlyphs = 2
    end
  end
  object Pagefind: TPageControl
    Left = 8
    Top = 2
    Width = 551
    Height = 118
    Cursor = crHandPoint
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = PagefindChange
    object TabSheet1: TTabSheet
      Caption = #1583#1608#1585#1607
      DesignSize = (
        543
        89)
      object grpAll: TGroupBox
        Left = 20
        Top = 1
        Width = 514
        Height = 85
        Anchors = [akLeft, akTop, akRight]
        Caption = #1580#1587#1578#1580#1608
        TabOrder = 0
        DesignSize = (
          514
          85)
        object lbl2: TLabel
          Left = 616
          Top = 203
          Width = 207
          Height = 15
          AutoSize = False
          Caption = #1601#1585#1583
          Visible = False
        end
        object lbl1: TLabel
          Left = 747
          Top = 203
          Width = 22
          Height = 14
          Caption = #1578#1575#1585#1610#1582
        end
        object Label2: TLabel
          Left = 381
          Top = 20
          Width = 13
          Height = 14
          Caption = #1705#1583
        end
        object Label5: TLabel
          Left = 425
          Top = 20
          Width = 58
          Height = 14
          Caption = #1588#1605#1575#1585#1607' '#1583#1608#1585#1607
        end
        object SpeedButton1: TSpeedButton
          Left = 6
          Top = 9
          Width = 23
          Height = 21
          Cursor = crHandPoint
          Flat = True
          Glyph.Data = {
            36050000424D360500000000000036000000280000001A000000100000000100
            1800000000000005000000000000000000000000000000000000E9B895E9B895
            E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B8
            95E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9
            B895E9B895E9B8950000EBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEB
            BD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9C
            EBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9C0000EDC2A3EDC2A3
            EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2
            A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3ED
            C2A3EDC2A3EDC2A30000F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0
            C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9
            F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A90000F2CCB0F2CCB0
            F2CCB0F2CCB0F2CCB0F2CCB0EEB997F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CC
            B0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2
            CCB0F2CCB0F2CCB00000F4D1B7F4D1B7F4D1B7F4D1B7F4D1B7F4D1B7E68859E4
            B79AF4D1B7F4D1B7F4D1B7F4D1B7A79ECD1020E0C6B1C4F4D1B7F4D1B7F4D1B7
            F4D1B7A799C8F4D1B7F4D1B7F4D1B7F4D1B7F4D1B7F4D1B70000F7D6BDF7D6BD
            F7D6BDF7D6BDF7D6BDF7D6BDE07040904820E9BC9FF7D6BDF7D6BDE9CDC10028
            FF1028F04050D0F7D6BDF7D6BDF7D6BD3D4CD70010B0F7D6BDF7D6BDF7D6BDF7
            D6BDF7D6BDF7D6BD0000F9DBC4F9DBC4F9DBC4F9DBC4F9DBC4F9DBC4E07840E0
            6830904820E2AF90F9DBC4F9DBC42C50FB1030FF0028FFEAD0C7F9DBC47C7DE1
            0018C06C71DCF9DBC4F9DBC4F9DBC4F9DBC4F9DBC4F9DBC40000FBE0CBFBE0CB
            FBE0CBFBE0CBFBE0CBFBE0CBE08050F08850D05820904820E3B295FBE0CBE3CF
            D13050FF2040FF8D8FE5B1ABDB0028F04058F0FBE0CBFBE0CBFBE0CBFBE0CBFB
            E0CBFBE0CBFBE0CB0000FCE1CBFCE1CBFCE1CBFCE1CBFCE1CBFCE1CBE08850FF
            A070F08040D06020A05830EBB696FCE1CBDBCAD44B67FB3050FF2040FF3050FF
            EED6CEFCE1CBFCE1CBFCE1CBFCE1CBFCE1CBFCE1CBFCE1CB0000FCE2CCFCE2CC
            FCE2CCFCE2CCFCE2CCFCE2CCE08860FFB080FF9860D07040F4CDB0FCE2CCFCE2
            CCFCE2CCD0C5D84068FF4060FFC8BFD8FCE2CCFCE2CCFCE2CCFCE2CCFCE2CCFC
            E2CCFCE2CCFCE2CC0000FCE3CEFCE3CEFCE3CEFCE3CEFCE3CEFCE3CEE09060FF
            B890D07840F4CEB2FCE3CEFCE3CEFCE3CEC6C1DD5078FF5078FF647DF94B6FFC
            E4D2D4FCE3CEFCE3CEFCE3CEFCE3CEFCE3CEFCE3CEFCE3CE0000FCE4D0FCE4D0
            FCE4D0FCE4D0FCE4D0FCE4D0E09870E18557F4CEB3FCE4D0FCE4D0FCE4D0B0B4
            E45078FF5078FFBBBBE1FCE4D06485F95A76FCD0C4DBFCE4D0FCE4D0FCE4D0FC
            E4D0FCE4D0FCE4D00000FCE5D1FCE5D1FCE5D1FCE5D1FCE5D1FCE5D1D07850F9
            D5BBFCE5D1FCE5D1FCE5D18599F05078FF5078FFD0C9DCFCE5D1FCE5D1FCE5D1
            B0B5E57A92F3FCE5D1FCE5D1FCE5D1FCE5D1FCE5D1FCE5D10000FDE6D3FDE6D3
            FDE6D3FDE6D3FDE6D3FDE6D3F5D2BAFDE6D3FDE6D3FDE6D3FDE6D3859AF16585
            F9DCD1DBFDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FD
            E6D3FDE6D3FDE6D30000FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FD
            E7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5
            FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D50000}
          OnClick = SpeedButton1Click
        end
        object cmdEdit: TBitBtn
          Left = 583
          Top = 184
          Width = 97
          Height = 25
          Caption = #1575'&'#1589#1604#1575#1581
          TabOrder = 0
          Visible = False
          OnClick = cmdEditClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
            000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
            00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
            F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
            0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
            FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
            FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
            0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
            00333377737FFFFF773333303300000003333337337777777333}
          NumGlyphs = 2
        end
        object cmdDelete: TBitBtn
          Left = 687
          Top = 231
          Width = 97
          Height = 25
          Caption = '&'#1581#1584#1601
          TabOrder = 1
          Visible = False
          OnClick = cmdDeleteClick
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
        object ComboBox1: TComboBox
          Left = 403
          Top = 40
          Width = 80
          Height = 22
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          ItemHeight = 14
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = ComboBox1Click
        end
        object cmbCardName: TComboBox
          Left = 15
          Top = 40
          Width = 153
          Height = 22
          ItemHeight = 14
          TabOrder = 3
          OnChange = cmbCardNameChange
          OnKeyPress = cmbCardNameKeyPress
        end
        object cmbCardCode: TComboBox
          Left = 174
          Top = 40
          Width = 223
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          BiDiMode = bdLeftToRight
          ItemHeight = 14
          ParentBiDiMode = False
          TabOrder = 4
          OnChange = cmbCardCodeChange
          OnClick = cmbCardCodeClick
          OnExit = cmbCardCodeExit
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1580#1587#1578#1580#1608#1610' '#1575#1601#1585#1575#1583' '#1588#1575#1585#1688' '#1588#1583#1607
      ImageIndex = 1
      DesignSize = (
        543
        89)
      object GroupBox1: TGroupBox
        Left = 0
        Top = 1
        Width = 539
        Height = 85
        Anchors = [akLeft, akTop, akRight]
        Caption = #1580#1587#1578#1580#1608
        TabOrder = 0
        DesignSize = (
          539
          85)
        object Label4: TLabel
          Left = 616
          Top = 203
          Width = 207
          Height = 15
          AutoSize = False
          Caption = #1601#1585#1583
          Visible = False
        end
        object Label6: TLabel
          Left = 747
          Top = 203
          Width = 22
          Height = 14
          Caption = #1578#1575#1585#1610#1582
        end
        object Label3: TLabel
          Left = 342
          Top = 18
          Width = 13
          Height = 14
          Caption = #1705#1583
        end
        object BitBtn1: TBitBtn
          Left = 583
          Top = 184
          Width = 97
          Height = 25
          Caption = #1575'&'#1589#1604#1575#1581
          TabOrder = 0
          Visible = False
          OnClick = cmdEditClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
            000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
            00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
            F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
            0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
            FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
            FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
            0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
            00333377737FFFFF773333303300000003333337337777777333}
          NumGlyphs = 2
        end
        object BitBtn2: TBitBtn
          Left = 687
          Top = 231
          Width = 97
          Height = 25
          Caption = '&'#1581#1584#1601
          TabOrder = 1
          Visible = False
          OnClick = cmdDeleteClick
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
        object cmbcode: TDBLookupComboBox
          Left = 243
          Top = 38
          Width = 285
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          BiDiMode = bdLeftToRight
          DataField = 'Empl_No'
          DataSource = DataSource4
          KeyField = 'Empl_No'
          ListField = 'Empl_No'
          ListSource = DataSource5
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = cmbcodeClick
        end
        object cmbname: TDBLookupComboBox
          Left = 3
          Top = 38
          Width = 234
          Height = 22
          DataField = 'Empl_No'
          DataSource = DataSource4
          KeyField = 'Empl_No'
          ListField = 'te'
          ListSource = DataSource5
          TabOrder = 3
          OnClick = cmbnameClick
        end
        object cmbcode1: TComboBox
          Left = 243
          Top = 68
          Width = 129
          Height = 22
          BiDiMode = bdLeftToRight
          ItemHeight = 14
          ParentBiDiMode = False
          TabOrder = 4
          Visible = False
          OnChange = cmbcode1Change
          OnClick = cmbcode1Click
        end
        object cmbname1: TComboBox
          Left = 24
          Top = 66
          Width = 213
          Height = 22
          ItemHeight = 14
          TabOrder = 5
          Visible = False
          OnChange = cmbname1Change
        end
      end
    end
  end
  object grpEdit: TGroupBox
    Left = -16
    Top = 305
    Width = 494
    Height = 47
    TabOrder = 0
    Visible = False
    object lbl3: TLabel
      Left = 431
      Top = 20
      Width = 43
      Height = 15
      Caption = #1605#1576#1604#1594' '#1588#1575#1585#1688
    end
    object Label1: TLabel
      Left = 398
      Top = 48
      Width = 48
      Height = 15
      Caption = #1662#1575#1610#1575#1606' '#1575#1593#1578#1576#1575#1585
      Visible = False
    end
    object txtCharge: TEdit
      Left = 288
      Top = 16
      Width = 137
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = txtChargeKeyPress
    end
    object cmdSave: TBitBtn
      Left = 112
      Top = 15
      Width = 97
      Height = 25
      Caption = '&'#1579#1576#1578
      Default = True
      TabOrder = 1
      OnClick = cmdSaveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
        055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
        005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
        B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
        305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
        305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
        30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
        3055577777555557F7F555000555555999555577755555577755}
      NumGlyphs = 2
    end
    object cmdCancel: TBitBtn
      Left = 8
      Top = 15
      Width = 97
      Height = 25
      Cancel = True
      Caption = '&'#1575#1606#1589#1585#1575#1601
      TabOrder = 2
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
    object txtExpDate: TEdit
      Left = 248
      Top = 48
      Width = 137
      Height = 23
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 3
      Visible = False
      OnKeyPress = txtChargeKeyPress
    end
  end
  object Edit1: TEdit
    Left = 741
    Top = 99
    Width = 83
    Height = 23
    TabOrder = 1
    Text = '0'
    Visible = False
    OnChange = Edit1Change
  end
  object txtdate: TEdit
    Left = 363
    Top = 358
    Width = 83
    Height = 23
    TabOrder = 2
    Text = '0'
    Visible = False
    OnChange = Edit1Change
  end
  object Edit4: TEdit
    Left = 135
    Top = 229
    Width = 111
    Height = 23
    TabOrder = 5
    Visible = False
    OnChange = Edit4Change
  end
  object grpChangeGrp: TGroupBox
    Left = 43
    Top = 232
    Width = 350
    Height = 77
    Caption = #1578#1594#1610#1610#1585' '#1583#1608#1585#1607' '#1588#1575#1585#1688
    TabOrder = 6
    object Label7: TLabel
      Left = 290
      Top = 37
      Width = 42
      Height = 15
      Caption = #1583#1608#1585#1607' '#1580#1583#1610#1583
    end
    object SpeedButton3: TSpeedButton
      Left = 5
      Top = 4
      Width = 23
      Height = 21
      Cursor = crHandPoint
      Flat = True
      Glyph.Data = {
        36050000424D360500000000000036000000280000001A000000100000000100
        1800000000000005000000000000000000000000000000000000E9B895E9B895
        E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B8
        95E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9B895E9
        B895E9B895E9B8950000EBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEB
        BD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9C
        EBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9CEBBD9C0000EDC2A3EDC2A3
        EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2
        A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3EDC2A3ED
        C2A3EDC2A3EDC2A30000F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0
        C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9
        F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A9F0C7A90000F2CCB0F2CCB0
        F2CCB0F2CCB0F2CCB0F2CCB0EEB997F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CC
        B0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2CCB0F2
        CCB0F2CCB0F2CCB00000F4D1B7F4D1B7F4D1B7F4D1B7F4D1B7F4D1B7E68859E4
        B79AF4D1B7F4D1B7F4D1B7F4D1B7A79ECD1020E0C6B1C4F4D1B7F4D1B7F4D1B7
        F4D1B7A799C8F4D1B7F4D1B7F4D1B7F4D1B7F4D1B7F4D1B70000F7D6BDF7D6BD
        F7D6BDF7D6BDF7D6BDF7D6BDE07040904820E9BC9FF7D6BDF7D6BDE9CDC10028
        FF1028F04050D0F7D6BDF7D6BDF7D6BD3D4CD70010B0F7D6BDF7D6BDF7D6BDF7
        D6BDF7D6BDF7D6BD0000F9DBC4F9DBC4F9DBC4F9DBC4F9DBC4F9DBC4E07840E0
        6830904820E2AF90F9DBC4F9DBC42C50FB1030FF0028FFEAD0C7F9DBC47C7DE1
        0018C06C71DCF9DBC4F9DBC4F9DBC4F9DBC4F9DBC4F9DBC40000FBE0CBFBE0CB
        FBE0CBFBE0CBFBE0CBFBE0CBE08050F08850D05820904820E3B295FBE0CBE3CF
        D13050FF2040FF8D8FE5B1ABDB0028F04058F0FBE0CBFBE0CBFBE0CBFBE0CBFB
        E0CBFBE0CBFBE0CB0000FCE1CBFCE1CBFCE1CBFCE1CBFCE1CBFCE1CBE08850FF
        A070F08040D06020A05830EBB696FCE1CBDBCAD44B67FB3050FF2040FF3050FF
        EED6CEFCE1CBFCE1CBFCE1CBFCE1CBFCE1CBFCE1CBFCE1CB0000FCE2CCFCE2CC
        FCE2CCFCE2CCFCE2CCFCE2CCE08860FFB080FF9860D07040F4CDB0FCE2CCFCE2
        CCFCE2CCD0C5D84068FF4060FFC8BFD8FCE2CCFCE2CCFCE2CCFCE2CCFCE2CCFC
        E2CCFCE2CCFCE2CC0000FCE3CEFCE3CEFCE3CEFCE3CEFCE3CEFCE3CEE09060FF
        B890D07840F4CEB2FCE3CEFCE3CEFCE3CEC6C1DD5078FF5078FF647DF94B6FFC
        E4D2D4FCE3CEFCE3CEFCE3CEFCE3CEFCE3CEFCE3CEFCE3CE0000FCE4D0FCE4D0
        FCE4D0FCE4D0FCE4D0FCE4D0E09870E18557F4CEB3FCE4D0FCE4D0FCE4D0B0B4
        E45078FF5078FFBBBBE1FCE4D06485F95A76FCD0C4DBFCE4D0FCE4D0FCE4D0FC
        E4D0FCE4D0FCE4D00000FCE5D1FCE5D1FCE5D1FCE5D1FCE5D1FCE5D1D07850F9
        D5BBFCE5D1FCE5D1FCE5D18599F05078FF5078FFD0C9DCFCE5D1FCE5D1FCE5D1
        B0B5E57A92F3FCE5D1FCE5D1FCE5D1FCE5D1FCE5D1FCE5D10000FDE6D3FDE6D3
        FDE6D3FDE6D3FDE6D3FDE6D3F5D2BAFDE6D3FDE6D3FDE6D3FDE6D3859AF16585
        F9DCD1DBFDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FDE6D3FD
        E6D3FDE6D3FDE6D30000FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FD
        E7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5
        FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D5FDE7D50000}
      OnClick = SpeedButton3Click
    end
    object btnChangeGrp: TBitBtn
      Left = 23
      Top = 33
      Width = 97
      Height = 25
      Caption = #1575#1580#1585#1575
      TabOrder = 0
      OnClick = btnChangeGrpClick
      NumGlyphs = 2
    end
    object cmbNewGrp: TComboBox
      Left = 146
      Top = 33
      Width = 129
      Height = 23
      BiDiMode = bdLeftToRight
      ItemHeight = 15
      ParentBiDiMode = False
      TabOrder = 1
    end
  end
  object dtaCharge: TDataSource
    DataSet = atblCharge
    Left = 285
    Top = 213
  end
  object atblCharge: TADOTable
    CursorType = ctStatic
    OnCalcFields = atblChargeCalcFields
    IndexFieldNames = 'Charge_EmplNo'
    TableName = 'Charge'
    Left = 253
    Top = 173
    object atblChargeCharge_Date: TWideStringField
      FieldName = 'Charge_Date'
      Size = 10
    end
    object atblChargeCharge_EmplNo: TWideStringField
      FieldName = 'Charge_EmplNo'
      Size = 8
    end
    object atblChargeCharge_Price: TBCDField
      DisplayWidth = 10
      FieldName = 'Charge_Price'
      Precision = 19
    end
    object atblChargeFamilyName: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamilyName'
      Size = 50
      Calculated = True
    end
    object atblChargeCharge_ExpireDate: TWideStringField
      FieldName = 'Charge_ExpireDate'
      Size = 10
    end
    object atblChargeCharge_Time: TWideStringField
      FieldName = 'Charge_Time'
      Size = 5
    end
    object atblChargeCharge_Moved: TBooleanField
      FieldName = 'Charge_Moved'
    end
    object atblChargeMoved: TStringField
      FieldKind = fkCalculated
      FieldName = 'Moved'
      Size = 10
      Calculated = True
    end
    object atblChargeTime: TStringField
      FieldKind = fkCalculated
      FieldName = 'Time'
      Size = 5
      Calculated = True
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 181
    Top = 181
  end
  object ADOQuery1: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=credit;Data Source=.'
    CursorType = ctStatic
    OnCalcFields = ADOQuery1CalcFields
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Employee.Empl_ID, ChargeDtl.Dtlmoved, ChargeDtl.DtlCode, ' +
        'Employee.Empl_Name, Employee.Empl_Family, Employee.Empl_No,Charg' +
        'eGrp.GRPPRICE'
      
        'FROM ChargeGrp INNER JOIN (Employee INNER JOIN ChargeDtl ON Empl' +
        'oyee.Empl_No = ChargeDtl.DtlEmplNo) ON ChargeGrp.GrpCode = Charg' +
        'eDtl.DtlCode')
    Left = 69
    Top = 317
    object ADOQuery1familyname: TStringField
      FieldKind = fkCalculated
      FieldName = 'familyname'
      Size = 50
      Calculated = True
    end
    object ADOQuery1Empl_ID: TWideStringField
      FieldName = 'Empl_ID'
      Size = 15
    end
    object ADOQuery1Dtlmoved: TBooleanField
      FieldName = 'Dtlmoved'
    end
    object ADOQuery1DtlCode: TIntegerField
      FieldName = 'DtlCode'
    end
    object ADOQuery1Empl_Name: TWideStringField
      FieldName = 'Empl_Name'
      Size = 15
    end
    object ADOQuery1Empl_Family: TWideStringField
      FieldName = 'Empl_Family'
      Size = 25
    end
    object ADOQuery1Empl_No: TWideStringField
      FieldName = 'Empl_No'
      Size = 8
    end
    object ADOQuery1active: TStringField
      FieldKind = fkCalculated
      FieldName = 'active'
      Size = 10
      Calculated = True
    end
    object ADOQuery1GRPPRICE: TBCDField
      FieldName = 'GRPPRICE'
      Precision = 19
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 29
    Top = 317
  end
  object ADOQuery2: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 64
    Top = 264
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery2
    Left = 32
    Top = 264
  end
  object ADOQuery3: TADOQuery
    Parameters = <>
    Left = 72
    Top = 216
  end
  object DataSource3: TDataSource
    DataSet = ADOQuery3
    Left = 32
    Top = 216
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable1CalcFields
    TableName = 'Employee'
    Left = 355
    Top = 176
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
  object ADOTable2: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = ADOTable2CalcFields
    TableName = 'Employee'
    Left = 323
    Top = 176
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
  object DataSource4: TDataSource
    DataSet = ADOTable1
    Left = 355
    Top = 208
  end
  object DataSource5: TDataSource
    DataSet = ADOTable2
    Left = 323
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 160
    object N1: TMenuItem
      Caption = #1576#1604#1610
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1582#1610#1585
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #1578#1594#1610#1610#1585' '#1583#1608#1585#1607
      OnClick = N4Click
    end
  end
  object qryupdate: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select * from chargedtl')
    Left = 256
    Top = 208
  end
  object DataSource6: TDataSource
    DataSet = qryupdate
    Left = 288
    Top = 176
  end
end
