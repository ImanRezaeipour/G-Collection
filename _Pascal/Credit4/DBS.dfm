object frmDBS: TfrmDBS
  Left = 335
  Top = 175
  BiDiMode = bdRightToLeft
  Caption = #1605#1593#1585#1601#1610' '#1576#1575#1606#1603#1607#1575#1610' '#1575#1591#1604#1575#1593#1575#1578#1610
  ClientHeight = 164
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBConnection: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    Left = 384
    Top = 24
  end
  object adoTblPersons: TADOTable
    Connection = DBConnection
    TableName = 'persons'
    Left = 24
    Top = 24
  end
  object adoQryG: TADOQuery
    Connection = DBConnection
    Parameters = <>
    Left = 288
    Top = 24
  end
  object adoTblClkDBS: TADOTable
    Connection = DBConnection
    Left = 112
    Top = 24
  end
  object adoTblBargehDBS: TADOTable
    Connection = DBConnection
    Left = 200
    Top = 24
  end
  object adoTblG: TADOTable
    Connection = DBConnection
    Left = 336
    Top = 24
  end
  object adoTblTmpPersons: TADOTable
    Connection = DBConnection
    TableName = 'tmpPersons'
    Left = 56
    Top = 24
  end
  object adotblPart: TADOTable
    Connection = DBConnection
    Left = 160
    Top = 24
  end
  object adoTblEDBS: TADOTable
    Connection = DBConnection
    TableName = 'TE138401'
    Left = 240
    Top = 24
  end
end
