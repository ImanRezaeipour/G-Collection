object frmParams: TfrmParams
  Left = 168
  Top = 139
  HelpContext = 12
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1606#1592#1610#1605' '#1662#1575#1585#1575#1605#1578#1585#1607#1575
  ClientHeight = 330
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    453
    330)
  PixelsPerInch = 96
  TextHeight = 15
  object lbl8: TLabel
    Left = 11
    Top = 152
    Width = 19
    Height = 15
    Caption = #1585#1610#1575#1604
    Visible = False
  end
  object lbl7: TLabel
    Left = 19
    Top = 128
    Width = 118
    Height = 15
    Caption = #1605#1576#1604#1594' '#1662#1610#1588' '#1601#1585#1590' '#1588#1575#1585#1688' '#1603#1575#1585#1578
    Visible = False
  end
  object lbl1: TLabel
    Left = 100
    Top = 181
    Width = 22
    Height = 15
    Caption = #1605#1585#1603#1586
    Visible = False
  end
  object cmbDepartment: TComboBox
    Left = 8
    Top = 202
    Width = 185
    Height = 23
    Style = csDropDownList
    ItemHeight = 15
    TabOrder = 0
    Visible = False
    OnKeyDown = cmbDepartmentKeyDown
  end
  object cmdOK: TBitBtn
    Left = 8
    Top = 235
    Width = 129
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1579#1576#1578
    ModalResult = 1
    TabOrder = 3
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
    ExplicitTop = 104
  end
  object cmdHelp: TBitBtn
    Left = 8
    Top = 266
    Width = 129
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 4
    Kind = bkHelp
  end
  object cmdCancel: TBitBtn
    Left = 8
    Top = 297
    Width = 129
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 5
    Kind = bkCancel
  end
  object grp1: TGroupBox
    Left = 175
    Top = 8
    Width = 273
    Height = 314
    Anchors = [akTop, akRight, akBottom]
    Caption = #1605#1578#1606' '#1578#1571#1610#1610#1583' '#1586#1610#1585' '#1711#1586#1575#1585#1588#1575#1578
    TabOrder = 1
    ExplicitLeft = 186
    object lbl2: TLabel
      Left = 232
      Top = 24
      Width = 35
      Height = 15
      Caption = #1605#1578#1606' '#1575#1608#1604
    end
    object lbl3: TLabel
      Left = 234
      Top = 56
      Width = 33
      Height = 15
      Caption = #1605#1578#1606' '#1583#1608#1605
    end
    object lbl4: TLabel
      Left = 231
      Top = 88
      Width = 36
      Height = 15
      Caption = #1605#1578#1606' '#1587#1608#1605
    end
    object lbl5: TLabel
      Left = 223
      Top = 120
      Width = 44
      Height = 15
      Caption = #1605#1578#1606' '#1670#1607#1575#1585#1605
    end
    object lbl6: TLabel
      Left = 231
      Top = 152
      Width = 36
      Height = 15
      Caption = #1605#1578#1606' '#1662#1606#1580#1605
    end
    object txtRptSign1: TEdit
      Left = 8
      Top = 24
      Width = 201
      Height = 23
      BiDiMode = bdRightToLeft
      MaxLength = 30
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyPress = txtRptSign1KeyPress
    end
    object txtRptSign2: TEdit
      Left = 8
      Top = 56
      Width = 201
      Height = 23
      BiDiMode = bdRightToLeft
      MaxLength = 30
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyPress = txtRptSign1KeyPress
    end
    object txtRptSign3: TEdit
      Left = 8
      Top = 88
      Width = 201
      Height = 23
      BiDiMode = bdRightToLeft
      MaxLength = 30
      ParentBiDiMode = False
      TabOrder = 2
      OnKeyPress = txtRptSign1KeyPress
    end
    object txtRptSign4: TEdit
      Left = 8
      Top = 120
      Width = 201
      Height = 23
      BiDiMode = bdRightToLeft
      MaxLength = 30
      ParentBiDiMode = False
      TabOrder = 3
      OnKeyPress = txtRptSign1KeyPress
    end
    object txtRptSign5: TEdit
      Left = 8
      Top = 152
      Width = 201
      Height = 23
      BiDiMode = bdRightToLeft
      MaxLength = 30
      ParentBiDiMode = False
      TabOrder = 4
      OnKeyPress = txtRptSign1KeyPress
    end
  end
  object txtCardCredMonthly: TEdit
    Left = 35
    Top = 152
    Width = 105
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 2
    Visible = False
    OnKeyPress = txtCardCredMonthlyKeyPress
  end
  object rdoDayOfChange: TRadioGroup
    Left = 8
    Top = 8
    Width = 161
    Height = 97
    BiDiMode = bdRightToLeft
    Caption = #1606#1581#1608#1607' '#1575#1587#1578#1601#1575#1583#1607' '#1575#1586' '#1585#1608#1586' '#1575#1576#1578#1583#1575#1610' '#1583#1608#1585#1607
    Items.Strings = (
      #1575#1586' '#1591#1585#1610#1602' '#1711#1585#1608#1607' '#1587#1602#1601' '#1605#1575#1607#1575#1606#1607
      #1575#1586' '#1591#1585#1610#1602' '#1605#1581#1604#1607#1575#1610' '#1582#1583#1605#1578)
    ParentBiDiMode = False
    TabOrder = 6
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 256
    Top = 24
  end
end
