object frmRequest: TfrmRequest
  Left = 0
  Top = 0
  BiDiMode = bdRightToLeft
  BorderWidth = 2
  Caption = #1583#1585#1582#1608#1575#1587#1578' '#1605#1580#1608#1586' '#1608#1585#1608#1583
  ClientHeight = 380
  ClientWidth = 175
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 175
    Height = 380
    Align = alClient
    Color = clTeal
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object lblBoxNo: TLabel
      Left = 94
      Top = 262
      Width = 74
      Height = 13
      Caption = #1588#1605#1575#1585#1607' '#1589#1606#1583#1608#1602' :'
      ParentShowHint = False
      ShowHint = True
    end
    object lblContractEndDate: TLabel
      Left = 69
      Top = 281
      Width = 98
      Height = 13
      Caption = #1578#1575#1585#1610#1582' '#1587#1585#1585#1587#1610#1583' '#1602#1585#1575#1585#1583#1575#1583
      ParentShowHint = False
      ShowHint = True
    end
    object lblName: TLabel
      Left = 102
      Top = 224
      Width = 65
      Height = 13
      Caption = #1606#1575#1605' '#1582#1575#1606#1608#1575#1583#1711#1610' :'
    end
    object lblCoNamei: TLabel
      Left = 98
      Top = 243
      Width = 74
      Height = 13
      Caption = #1605#1588#1578#1585#1610' '#1581#1602#1610#1602#1610
      ParentShowHint = False
      ShowHint = True
    end
    object pnlPicture: TPanel
      Left = 5
      Top = 34
      Width = 164
      Height = 188
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Font.Charset = ARABIC_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arabic Transparent'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object imgPicture: TImage
        Left = 2
        Top = 2
        Width = 159
        Height = 183
        Stretch = True
      end
      object lblCredit: TLabel
        Left = 7
        Top = 74
        Width = 149
        Height = 34
        Alignment = taCenter
        AutoSize = False
        BiDiMode = bdRightToLeft
        Caption = #1601#1575#1602#1583' '#1575#1593#1578#1576#1575#1585
        Font.Charset = ARABIC_CHARSET
        Font.Color = clRed
        Font.Height = -27
        Font.Name = 'Arabic Transparent'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object lblCommonBox: TLabel
        Left = -4
        Top = 152
        Width = 171
        Height = 34
        Alignment = taCenter
        AutoSize = False
        BiDiMode = bdRightToLeft
        Caption = #1589#1606#1583#1608#1602' '#1605#1588#1578#1585#1705
        Font.Charset = ARABIC_CHARSET
        Font.Color = clRed
        Font.Height = -27
        Font.Name = 'Arabic Transparent'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        Transparent = True
        Visible = False
      end
    end
    object btnYes: TButton
      Left = 88
      Top = 325
      Width = 81
      Height = 25
      Caption = #1605#1580#1575#1586' '
      ModalResult = 1
      TabOrder = 1
      OnClick = btnYesClick
    end
    object btnNo: TButton
      Left = 7
      Top = 325
      Width = 79
      Height = 25
      Caption = #1594#1610#1585' '#1605#1580#1575#1586
      ModalResult = 2
      TabOrder = 2
      OnClick = btnNoClick
    end
    object btnVorC: TButton
      Left = 7
      Top = 352
      Width = 162
      Height = 25
      Caption = #1605#1588#1575#1607#1583#1607' '#1608#1705#1604#1575
      ModalResult = 1
      TabOrder = 3
      OnClick = btnVorCClick
    end
    object btnPrint: TButton
      Left = 7
      Top = 298
      Width = 162
      Height = 25
      Caption = #1670#1575#1662' '#1662#1585#1608#1575#1606#1607' '#1608#1585#1608#1583
      ModalResult = 1
      TabOrder = 4
      OnClick = btnPrintClick
    end
    object btnSign: TButton
      Left = 7
      Top = 8
      Width = 162
      Height = 25
      Caption = #1606#1605#1575#1610#1588' '#1575#1605#1590#1575#1569
      ModalResult = 1
      TabOrder = 5
      OnClick = btnSignClick
    end
  end
end
