object frmCreateDBs: TfrmCreateDBs
  Left = 272
  Top = 210
  HelpContext = 88
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1575#1610#1580#1575#1583' '#1608' '#1576#1575#1586#1587#1575#1586#1610' '#1576#1575#1606#1603#1607#1575#1610' '#1575#1591#1604#1575#1593#1575#1578#1610
  ClientHeight = 281
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    411
    281)
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 342
    Top = 190
    Width = 59
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = #1576#1575#1606#1603' '#1578#1585#1583#1583' '#1587#1575#1604
    Visible = False
    ExplicitTop = 182
  end
  object Label2: TLabel
    Left = 236
    Top = 190
    Width = 30
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = #1605#1575#1607#1607#1575#1610
    Visible = False
    ExplicitTop = 182
  end
  object cmdAll: TBitBtn
    Left = 325
    Top = 225
    Width = 80
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1607'&'#1605#1607
    TabOrder = 0
    OnClick = cmdAllClick
    Glyph.Data = {
      F2010000424DF201000000000000760000002800000024000000130000000100
      0400000000007C01000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
      3333333333388F3333333333000033334224333333333333338338F333333333
      0000333422224333333333333833338F33333333000033422222243333333333
      83333338F3333333000034222A22224333333338F33F33338F33333300003222
      A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
      38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
      2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
      0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
      333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
      33333A2224A2233333333338F338F83300003333333333A2224A333333333333
      8F338F33000033333333333A222433333333333338F338F30000333333333333
      A224333333333333338F38F300003333333333333A223333333333333338F8F3
      000033333333333333A3333333333333333383330000}
    NumGlyphs = 2
    ExplicitTop = 217
  end
  object cmdOK: TBitBtn
    Left = 218
    Top = 225
    Width = 79
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = '&'#1576#1575#1586#1587#1575#1586#1610
    TabOrder = 1
    OnClick = cmdOKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    ExplicitTop = 217
  end
  object cmdHelp: TBitBtn
    Left = 105
    Top = 225
    Width = 78
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 2
    Kind = bkHelp
    ExplicitTop = 217
  end
  object cmdClose: TBitBtn
    Left = 7
    Top = 225
    Width = 79
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = '&'#1582#1585#1608#1580
    TabOrder = 3
    Kind = bkClose
    ExplicitTop = 217
  end
  object chklstDBS: TCheckListBox
    Left = 0
    Top = 0
    Width = 411
    Height = 169
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BiDiMode = bdRightToLeft
    Columns = 2
    ItemHeight = 15
    Items.Strings = (
      #1576#1575#1606#1705' '#1587#1575#1582#1578#1605#1575#1606#1607#1575
      #1576#1575#1606#1705' '#1601#1610#1588#1607#1575
      #1576#1575#1606#1705' '#1594#1584#1575#1607#1575
      #1576#1575#1606#1705' '#1602#1610#1605#1578' '#1594#1584#1575#1607#1575
      #1576#1575#1606#1705' '#1711#1585#1608#1607#1607#1575#1610' '#1705#1575#1585#1610
      #1576#1575#1606#1705' '#1575#1606#1608#1575#1593' '#1575#1587#1578#1582#1583#1575#1605
      #1576#1575#1606#1705' '#1576#1582#1588#1607#1575
      #1576#1575#1606#1705' '#1605#1588#1582#1589#1575#1578' '#1662#1585#1587#1606#1604
      #1576#1575#1606#1705' '#1585#1586#1585#1608' '#1594#1584#1575
      #1576#1575#1606#1705' '#1576#1585#1606#1575#1605#1607' '#1705#1604#1610#1583#1607#1575#1610' '#1583#1587#1578#1711#1575#1607#1607#1575
      #1576#1575#1606#1705' '#1583#1587#1578#1711#1575#1607#1607#1575
      #1576#1575#1606#1705' '#1705#1575#1585#1576#1585#1575#1606
      #1576#1575#1606#1705' '#1608#1575#1581#1583#1607#1575#1610' '#1578#1575#1576#1593#1607
      #1576#1575#1606#1705' '#1576#1585#1606#1575#1605#1607' '#1594#1584#1575#1610#1610' '#1607#1601#1578#1711#1610
      #1576#1575#1606#1705' '#1578#1585#1583#1583#1607#1575#1610' '#1581#1590#1608#1585#1608#1594#1610#1575#1576
      #1576#1575#1606#1705' '#1575#1593#1578#1576#1575#1585' '#1662#1585#1587#1606#1604
      #1576#1575#1606#1705' '#1605#1585#1705#1586' '#1607#1586#1610#1606#1607
      #1576#1575#1606#1705' '#1610#1575#1585#1575#1606#1607' '#1607#1575
      #1576#1575#1606#1705' '#1593#1583#1605' '#1581#1590#1608#1585
      #1576#1575#1606#1705' '#1575#1610#1587#1578#1711#1575#1607' '#1607#1575#1610' '#1705#1606#1578#1585#1604)
    ParentBiDiMode = False
    TabOrder = 4
    ExplicitHeight = 161
  end
  object cbyear: TComboBox
    Left = 275
    Top = 187
    Width = 58
    Height = 23
    Style = csDropDownList
    Anchors = [akLeft, akBottom]
    ItemHeight = 15
    ItemIndex = 0
    TabOrder = 5
    Text = '1379'
    Visible = False
    Items.Strings = (
      '1379'
      '1380'
      '1381'
      '1382'
      '1383'
      '1384'
      '1385'
      '1386'
      '1387'
      '1388'
      '1389'
      '1390'
      '1391'
      '1392'
      '1393'
      '1394'
      '1395'
      '1396'
      '1397'
      '1398'
      '1399'
      '1400'
      '1401'
      '1402'
      '1403'
      '1404'
      '1405')
    ExplicitTop = 179
  end
  object chklstmonth: TCheckListBox
    Left = 7
    Top = 176
    Width = 220
    Height = 36
    Anchors = [akLeft, akBottom]
    Columns = 6
    ItemHeight = 15
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12')
    TabOrder = 6
    Visible = False
    ExplicitTop = 168
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 251
    Width = 397
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1576#1575#1586#1587#1575#1586#1610' '#1605#1575#1606#1583#1607' '#1575#1593#1578#1576#1575#1585' '#1575#1601#1585#1575#1583
    TabOrder = 7
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    ExplicitTop = 243
  end
end