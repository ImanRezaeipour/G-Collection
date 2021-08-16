object Form1: TForm1
  Left = 134
  Top = 112
  Width = 328
  Height = 119
  Caption = 'Fish Tools'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblRecNo: TLabel
    Left = 136
    Top = 72
    Width = 44
    Height = 13
    Caption = 'lblRecNo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 72
    Width = 49
    Height = 13
    Caption = 'Total Fish:'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 49
    Height = 13
    Caption = 'From Date'
    Visible = False
  end
  object Label3: TLabel
    Left = 176
    Top = 8
    Width = 49
    Height = 13
    Caption = 'From Date'
    Visible = False
  end
  object lblTotal: TLabel
    Left = 64
    Top = 72
    Width = 34
    Height = 13
    Caption = 'lblTotal'
  end
  object Button1: TButton
    Left = 8
    Top = 40
    Width = 305
    Height = 25
    Caption = 'Repare Fish'
    TabOrder = 0
    OnClick = Button1Click
  end
  object txtFDate: TEdit
    Left = 64
    Top = 8
    Width = 81
    Height = 21
    TabOrder = 1
    Visible = False
    OnExit = txtFDateExit
  end
  object txtTDate: TEdit
    Left = 232
    Top = 8
    Width = 81
    Height = 21
    TabOrder = 2
    Visible = False
    OnExit = txtTDateExit
  end
  object btnRepairDuplicate: TButton
    Left = 7
    Top = 8
    Width = 305
    Height = 25
    Caption = 'Delete Duplicates '
    TabOrder = 3
    OnClick = btnRepairDuplicateClick
  end
  object tblF: TTable
    Left = 216
    Top = 64
  end
  object tblFF: TTable
    Left = 248
    Top = 64
  end
end
