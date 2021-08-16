object frmDscntDtl: TfrmDscntDtl
  Left = 135
  Top = 55
  HelpContext = 9
  BiDiMode = bdRightToLeft
  BorderStyle = bsSingle
  Caption = '»—‰«„Â —Ì“Ì ê—ÊÂ  Œ›Ì›'
  ClientHeight = 403
  ClientWidth = 564
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object grpAll: TGroupBox
    Left = 0
    Top = 0
    Width = 564
    Height = 249
    Align = alTop
    TabOrder = 0
    object cmdNew: TBitBtn
      Left = 462
      Top = 216
      Width = 97
      Height = 25
      Caption = '&ÃœÌœ'
      TabOrder = 0
      OnClick = cmdNewClick
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
    object cmdEdit: TBitBtn
      Left = 366
      Top = 216
      Width = 97
      Height = 25
      Caption = '«&’·«Õ'
      TabOrder = 1
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
      Left = 270
      Top = 216
      Width = 97
      Height = 25
      Caption = '&Õ–›'
      TabOrder = 2
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
    object cmdHelp: TBitBtn
      Left = 104
      Top = 216
      Width = 97
      Height = 25
      Caption = '—«&Â‰„«'
      TabOrder = 3
      Kind = bkHelp
    end
    object cmdClose: TBitBtn
      Left = 8
      Top = 216
      Width = 97
      Height = 25
      Caption = '&Œ—ÊÃ'
      TabOrder = 4
      Kind = bkClose
    end
    object dbgDscntDtl: TDBGrid
      Left = 4
      Top = 12
      Width = 555
      Height = 192
      DataSource = dtaDscntDtl
      TabOrder = 5
      TitleFont.Charset = ARABIC_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Arabic Transparent'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DscntDtl_No'
          Title.Alignment = taCenter
          Title.Caption = 'ﬂœ'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Srvc'
          Title.Alignment = taCenter
          Title.Caption = 'Œœ„« '
          Width = 170
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DscntDtl_Percent'
          Title.Alignment = taCenter
          Title.Caption = 'œ—’œ  Œ›Ì›'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DscntDtl_Limit'
          Title.Alignment = taCenter
          Title.Caption = 'Õœ „Ã«“'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DscntDtl_SDate'
          Title.Alignment = taCenter
          Title.Caption = '«“  «—ÌŒ'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DscntDtl_eDate'
          Title.Alignment = taCenter
          Title.Caption = ' «  «—ÌŒ'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Daily'
          Title.Alignment = taCenter
          Title.Caption = '—Ê“«‰Â'
          Width = 35
          Visible = True
        end>
    end
  end
  object GrpEdit: TGroupBox
    Left = 0
    Top = 249
    Width = 564
    Height = 150
    Align = alTop
    TabOrder = 1
    object lbl1: TLabel
      Left = 523
      Top = 51
      Width = 28
      Height = 15
      Caption = 'Œœ„« '
    end
    object lbl2: TLabel
      Left = 523
      Top = 84
      Width = 28
      Height = 15
      Caption = ' Œ›Ì›'
    end
    object lbl3: TLabel
      Left = 346
      Top = 84
      Width = 41
      Height = 15
      Caption = 'Õœ „Ã«“'
    end
    object lbl0: TLabel
      Left = 517
      Top = 21
      Width = 13
      Height = 15
      Caption = 'ﬂœ'
    end
    object lbl4: TLabel
      Left = 422
      Top = 84
      Width = 27
      Height = 15
      Caption = 'œ—’œ'
      Font.Charset = ARABIC_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = []
      ParentFont = False
    end
    object txtPercent: TEdit
      Left = 453
      Top = 80
      Width = 62
      Height = 23
      TabOrder = 2
    end
    object txtLimit: TEdit
      Left = 277
      Top = 80
      Width = 66
      Height = 23
      TabOrder = 3
    end
    object grpCredType: TGroupBox
      Left = 7
      Top = 9
      Width = 258
      Height = 102
      Caption = '‰Ê⁄ «⁄ »«—'
      TabOrder = 4
      object lblFrom: TLabel
        Left = 107
        Top = 50
        Width = 65
        Height = 15
        Caption = ' «—ÌŒ ‘—Ê⁄'
      end
      object lblTo: TLabel
        Left = 22
        Top = 50
        Width = 55
        Height = 15
        Caption = ' «—ÌŒ Å«Ì«‰'
      end
      object rdoDaily: TRadioButton
        Left = 190
        Top = 25
        Width = 59
        Height = 17
        Caption = '—Ê“«‰Â'
        TabOrder = 0
        OnClick = rdoDailyClick
      end
      object rdoDate: TRadioButton
        Left = 97
        Top = 25
        Width = 91
        Height = 17
        Caption = '„ÕœÊœÂ “„«‰Ì'
        TabOrder = 1
        OnClick = rdoDateClick
      end
      object txtsDate: TEdit
        Left = 97
        Top = 69
        Width = 88
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 2
        OnExit = txtsDateExit
        OnKeyPress = txtsDateKeyPress
      end
      object txteDate: TEdit
        Left = 6
        Top = 69
        Width = 88
        Height = 23
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 3
        OnExit = txteDateExit
        OnKeyPress = txtsDateKeyPress
      end
    end
    object btnSave: TBitBtn
      Left = 467
      Top = 119
      Width = 90
      Height = 25
      Caption = 'À» '
      TabOrder = 5
      OnClick = btnSaveClick
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
    object btnCancel: TBitBtn
      Left = 6
      Top = 119
      Width = 89
      Height = 25
      Cancel = True
      Caption = '«‰’—«›'
      TabOrder = 6
      OnClick = btnCancelClick
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
    object txtCode: TEdit
      Left = 453
      Top = 17
      Width = 62
      Height = 23
      TabOrder = 0
    end
    object cmbService: TComboBox
      Left = 277
      Top = 48
      Width = 238
      Height = 23
      ItemHeight = 15
      TabOrder = 1
    end
  end
  object dtaDscntDtl: TDataSource
    DataSet = atblDscntDtl
    Left = 40
    Top = 144
  end
  object atblDscntDtl: TADOTable
    CursorType = ctStatic
    OnCalcFields = atblDscntDtlCalcFields
    TableName = 'dscntDtl'
    Left = 104
    Top = 144
    object atblDscntDtlDscntDtl_No: TIntegerField
      FieldName = 'DscntDtl_No'
    end
    object atblDscntDtlDscntDtl_Service: TIntegerField
      FieldName = 'DscntDtl_Service'
    end
    object atblDscntDtlDscntDtl_Percent: TIntegerField
      FieldName = 'DscntDtl_Percent'
    end
    object atblDscntDtlDscntDtl_Limit: TIntegerField
      FieldName = 'DscntDtl_Limit'
    end
    object atblDscntDtlDscntDtl_SDate: TWideStringField
      FieldName = 'DscntDtl_SDate'
      Size = 10
    end
    object atblDscntDtlDscntDtl_eDate: TWideStringField
      FieldName = 'DscntDtl_eDate'
      Size = 10
    end
    object atblDscntDtlDscntDtl_Daily: TBooleanField
      FieldName = 'DscntDtl_Daily'
    end
    object atblDscntDtlDaily: TStringField
      FieldKind = fkCalculated
      FieldName = 'Daily'
      Calculated = True
    end
    object atblDscntDtlDscntDtl_GrpNo: TIntegerField
      FieldName = 'DscntDtl_GrpNo'
    end
    object atblDscntDtlSrvc: TStringField
      FieldKind = fkCalculated
      FieldName = 'Srvc'
      Size = 50
      Calculated = True
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 168
    Top = 80
  end
end
