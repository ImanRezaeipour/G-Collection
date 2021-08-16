object frmDBS: TfrmDBS
  Left = 252
  Top = 157
  Caption = 'frmDBS'
  ClientHeight = 65
  ClientWidth = 343
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object tblInputCar: TADOTable
    CursorType = ctStatic
    TableName = 'InputCar'
    Left = 72
    Top = 8
  end
  object tblMachines: TADOTable
    TableName = 'Machines'
    Left = 120
    Top = 8
  end
  object qryDBS: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from cars')
    Left = 256
    Top = 8
  end
  object adoConnect: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=1234;Persist Security Info=True;Use' +
      'r ID=sa;Initial Catalog=Parking;Data Source=.;Use Procedure for ' +
      'Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=KA' +
      'VANDI;Use Encryption for Data=False;Tag with column collation wh' +
      'en possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 16
    Top = 8
  end
  object tblPersons: TADOTable
    TableName = 'Persons'
    Left = 160
    Top = 8
  end
  object tblBarCodes: TADOTable
    IndexFieldNames = 'Card_Code'
    TableName = 'BarCodes'
    Left = 208
    Top = 8
    object tblBarCodesCard_Code: TStringField
      Alignment = taRightJustify
      DisplayLabel = '       '#1588#1605#1575#1607' '#1603#1583
      DisplayWidth = 14
      FieldName = 'Card_Code'
      Size = 8
    end
    object tblBarCodesStName: TStringField
      DisplayLabel = '             '#1608#1590#1593#1610#1578
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'StName'
      Calculated = True
    end
    object tblBarCodesCard_State: TSmallintField
      FieldName = 'Card_State'
      Visible = False
    end
  end
  object adoQryG: TADOQuery
    Connection = adoConnect
    Parameters = <>
    Left = 296
    Top = 16
  end
end
