object frmDepartActive: TfrmDepartActive
  Left = 263
  Top = 157
  Align = alClient
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1604#1610#1587#1578' '#1605#1585#1575#1603#1586' '#1601#1593#1575#1604
  ClientHeight = 242
  ClientWidth = 230
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ParentBiDiMode = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object dbgDepartActive: TDBGrid
    Left = 0
    Top = 0
    Width = 230
    Height = 242
    Align = alClient
    DataSource = dtaDepartActive
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ARABIC_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arabic Transparent'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Depart_Name'
        Title.Alignment = taCenter
        Title.Caption = #1605#1585#1575#1603#1586' '#1601#1593#1575#1604
        Width = 225
        Visible = True
      end>
  end
  object dtaDepartActive: TDataSource
    DataSet = aqryDepartActive
    Left = 48
    Top = 32
  end
  object aqryDepartActive: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sa;Persist Security Info=True;User ' +
      'ID=sa;Initial Catalog=Credit;Data Source=RNDServer'
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Department')
    Left = 152
    Top = 32
  end
  object tmrDepartment: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrDepartmentTimer
    Left = 32
    Top = 152
  end
end
