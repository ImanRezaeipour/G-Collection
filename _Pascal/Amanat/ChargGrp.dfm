object frmchargGrp: TfrmchargGrp
  Left = 256
  Top = 115
  BiDiMode = bdRightToLeft
  BorderStyle = bsSingle
  Caption = #1583#1608#1585#1607' '#1588#1575#1585#1688
  ClientHeight = 531
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pan_insert: TPanel
    Left = 0
    Top = 306
    Width = 670
    Height = 225
    Align = alBottom
    Enabled = False
    TabOrder = 0
    Visible = False
    object PageControl1: TPageControl
      Left = 1
      Top = 8
      Width = 668
      Height = 216
      ActivePage = TabSheet1
      Align = alBottom
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1570#1610#1578#1605#1607#1575#1610' '#1583#1608#1585#1607
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          660
          188)
        object lbl_tarikh: TLabel
          Left = 297
          Top = 16
          Width = 46
          Height = 13
          Anchors = [akTop, akRight]
          Caption = #1578#1575#1585#1610#1582' '#1588#1575#1585#1688
          ExplicitLeft = 126
        end
        object Label1: TLabel
          Left = 605
          Top = 92
          Width = 23
          Height = 13
          Anchors = [akTop, akRight]
          Caption = #1588#1585#1581
          ExplicitLeft = 434
        end
        object Label2: TLabel
          Left = 269
          Top = 58
          Width = 48
          Height = 13
          Anchors = [akTop, akRight]
          Caption = #1578#1575#1585#1610#1582' '#1575#1606#1602#1590#1575
          Visible = False
          ExplicitLeft = 98
        end
        object Label3: TLabel
          Left = 605
          Top = 42
          Width = 45
          Height = 13
          Anchors = [akTop, akRight]
          Caption = #1586#1605#1575#1606' '#1588#1575#1585#1688
          ExplicitLeft = 434
        end
        object txt_Code: TLabeledEdit
          Left = 492
          Top = 14
          Width = 107
          Height = 21
          Anchors = [akTop, akRight]
          BiDiMode = bdRightToLeft
          EditLabel.Width = 33
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdRightToLeft
          EditLabel.Caption = #1603#1583' '#1583#1608#1585#1607
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpRight
          ParentBiDiMode = False
          ReadOnly = True
          TabOrder = 0
        end
        object txt_tarikhsh: TMaskEdit
          Left = 191
          Top = 6
          Width = 100
          Height = 21
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 1
          OnExit = txt_tarikhshExit
          OnKeyPress = txt_tarikhshKeyPress
        end
        object txt_Price: TLabeledEdit
          Left = 189
          Top = 33
          Width = 101
          Height = 21
          Anchors = [akTop, akRight]
          BiDiMode = bdRightToLeft
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdRightToLeft
          EditLabel.Caption = #1605#1576#1604#1594
          EditLabel.ParentBiDiMode = False
          LabelPosition = lpRight
          ParentBiDiMode = False
          TabOrder = 3
          OnKeyPress = txt_PriceKeyPress
        end
        object txt_Desc: TMemo
          Left = 174
          Top = 77
          Width = 425
          Height = 61
          Anchors = [akTop, akRight]
          BiDiMode = bdRightToLeft
          Lines.Strings = (
            '')
          ParentBiDiMode = False
          ScrollBars = ssBoth
          TabOrder = 4
        end
        object txt_tarikhex: TMaskEdit
          Left = 174
          Top = 55
          Width = 93
          Height = 21
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 5
          Visible = False
          OnExit = txt_tarikhexExit
        end
        object pan_save: TPanel
          Left = 0
          Top = 149
          Width = 660
          Height = 39
          Align = alBottom
          Enabled = False
          TabOrder = 6
          DesignSize = (
            660
            39)
          object btn_cancel: TBitBtn
            Left = 16
            Top = 8
            Width = 75
            Height = 24
            Cursor = crHandPoint
            Caption = #1575#1606#1589#1585#1575#1601
            TabOrder = 1
            OnClick = btn_cancelClick
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
          object BitBtn6: TBitBtn
            Left = 577
            Top = 8
            Width = 75
            Height = 23
            Cursor = crHandPoint
            Anchors = [akTop, akRight]
            Caption = #1579#1576#1578
            TabOrder = 0
            OnClick = BitBtn6Click
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
        end
        object txt_Time: TEdit
          Left = 547
          Top = 41
          Width = 52
          Height = 21
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          MaxLength = 10
          ParentBiDiMode = False
          TabOrder = 2
          OnExit = txt_timeExit
          OnKeyPress = txt_timeKeyPress
        end
      end
    end
  end
  object Pan_dbg: TPanel
    Left = 0
    Top = 0
    Width = 670
    Height = 306
    Align = alClient
    TabOrder = 1
    object d: TDBGrid
      Left = 1
      Top = 1
      Width = 668
      Height = 269
      Align = alClient
      BiDiMode = bdRightToLeft
      DataSource = DschargGrp
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentBiDiMode = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dDblClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'GrpCode'
          Title.Alignment = taCenter
          Title.Caption = #1603#1583' '#1583#1608#1585#1607
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'timestr'
          Title.Alignment = taCenter
          Title.Caption = #1586#1605#1575#1606' '#1588#1575#1585#1688
          Width = 59
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'GrpDate'
          Title.Alignment = taCenter
          Title.Caption = #1606#1575#1585#1610#1582' '#1588#1575#1585#1688
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'GrpPrice'
          Title.Alignment = taCenter
          Title.Caption = #1605#1576#1604#1594
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'GrpDesc'
          Title.Alignment = taCenter
          Title.Caption = #1588#1585#1581
          Width = 200
          Visible = True
        end>
    end
    object pan_con: TPanel
      Left = 1
      Top = 270
      Width = 668
      Height = 35
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        668
        35)
      object btnnewd: TBitBtn
        Left = 581
        Top = 5
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #1583#1608#1585#1607' '#1580#1583#1576#1583
        TabOrder = 0
        OnClick = btnnewdClick
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
          333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
          0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
          07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
          0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
          33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
          B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
          3BB33773333773333773B333333B3333333B7333333733333337}
        NumGlyphs = 2
      end
      object btn_edit: TBitBtn
        Left = 500
        Top = 5
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #1575#1589#1604#1575#1581' '#1583#1608#1585#1607
        TabOrder = 1
        OnClick = btn_editClick
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
      object btn_del: TBitBtn
        Left = 419
        Top = 5
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #1581#1584#1601' '#1583#1608#1585#1607
        TabOrder = 2
        OnClick = btn_delClick
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
      object btn_newp: TBitBtn
        Left = 338
        Top = 5
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #1575#1601#1586#1608#1583#1606' '#1575#1601#1585#1575#1583
        TabOrder = 3
        OnClick = btn_newpClick
        NumGlyphs = 2
      end
      object btn_viewp: TBitBtn
        Left = 223
        Top = 5
        Width = 109
        Height = 25
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = #1606#1605#1575#1610#1588' '#1575#1601#1585#1575#1583
        TabOrder = 4
        OnClick = btn_viewpClick
      end
    end
  end
  object atblchargGrp: TADOQuery
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\DP_Win_Prg\Credi' +
      't3\CREDIT.MDB;Persist Security Info=False'
    CursorType = ctStatic
    OnCalcFields = atblchargGrpCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM ChargeGrp'
      'order by GrpCode')
    Left = 56
    Top = 64
    object atblchargGrpGrpCode: TIntegerField
      FieldName = 'GrpCode'
    end
    object atblchargGrpGrpTime: TWideStringField
      FieldName = 'GrpTime'
      Size = 5
    end
    object atblchargGrpGrpExpireDate: TWideStringField
      FieldName = 'GrpExpireDate'
      Size = 10
    end
    object atblchargGrpGrpDate: TWideStringField
      FieldName = 'GrpDate'
      Size = 10
    end
    object atblchargGrpGrpPrice: TBCDField
      FieldName = 'GrpPrice'
      Precision = 19
    end
    object atblchargGrpGrpDesc: TWideStringField
      FieldName = 'GrpDesc'
      Size = 100
    end
    object atblchargGrptimestr: TStringField
      FieldKind = fkCalculated
      FieldName = 'timestr'
      Size = 10
      Calculated = True
    end
  end
  object DschargGrp: TDataSource
    DataSet = atblchargGrp
    Left = 16
    Top = 96
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 16
    Top = 64
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 312
    Top = 65360
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 16
    Top = 128
  end
  object DataSource2: TDataSource
    Left = 432
    Top = 65312
  end
  object Dsmaxdate: TDataSource
    DataSet = qrymaxdate
    Left = 360
    Top = 32
  end
  object ADOQuery2: TADOQuery
    Parameters = <>
    Left = 344
    Top = 65312
  end
  object qrymaxdate: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT Max(chargegrp.GrpDATE) AS MaxOfGrpDATE'
      'FROM chargegrp')
    Left = 408
    Top = 104
  end
end
