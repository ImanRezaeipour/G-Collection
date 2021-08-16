object TreeDM: TTreeDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 233
  Width = 245
  object adoqryTemp: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Data ' +
      'Source=komeil'
    Parameters = <>
    Left = 128
    Top = 32
  end
end
