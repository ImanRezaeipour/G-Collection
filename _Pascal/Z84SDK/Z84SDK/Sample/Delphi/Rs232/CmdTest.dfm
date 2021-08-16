object frmCmndTest: TfrmCmndTest
  Left = 170
  Top = 109
  BorderStyle = bsDialog
  Caption = 'Reader Command Test Directly'
  ClientHeight = 427
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Reader Code'
  end
  object Label2: TLabel
    Left = 144
    Top = 8
    Width = 51
    Height = 13
    Caption = 'Baud Rate'
  end
  object Label3: TLabel
    Left = 296
    Top = 8
    Width = 43
    Height = 13
    Caption = 'Com Port'
  end
  object Label4: TLabel
    Left = 8
    Top = 40
    Width = 47
    Height = 13
    Caption = 'Command'
  end
  object lblResult: TLabel
    Left = 8
    Top = 72
    Width = 409
    Height = 13
    AutoSize = False
    Caption = 'lblResult'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 96
    Width = 23
    Height = 13
    Caption = 'Date'
  end
  object Label6: TLabel
    Left = 128
    Top = 96
    Width = 23
    Height = 13
    Caption = 'Time'
  end
  object Label7: TLabel
    Left = 8
    Top = 128
    Width = 88
    Height = 13
    Caption = 'New Reader Code'
  end
  object Label8: TLabel
    Left = 144
    Top = 128
    Width = 76
    Height = 13
    Caption = 'New Baud Rate'
  end
  object Label9: TLabel
    Left = 8
    Top = 176
    Width = 43
    Height = 13
    Caption = 'Limit time'
  end
  object Label10: TLabel
    Left = 72
    Top = 160
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label11: TLabel
    Left = 136
    Top = 160
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object Label12: TLabel
    Left = 200
    Top = 160
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label13: TLabel
    Left = 264
    Top = 160
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object Label14: TLabel
    Left = 328
    Top = 160
    Width = 23
    Height = 13
    Caption = 'From'
  end
  object Label15: TLabel
    Left = 392
    Top = 160
    Width = 13
    Height = 13
    Caption = 'To'
  end
  object Label16: TLabel
    Left = 8
    Top = 208
    Width = 128
    Height = 13
    Caption = 'Message (4 * 16 character)'
  end
  object Label17: TLabel
    Left = 8
    Top = 256
    Width = 62
    Height = 13
    Caption = 'Card Number'
  end
  object Label18: TLabel
    Left = 168
    Top = 256
    Width = 43
    Height = 13
    Caption = 'Message'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 88
    Width = 433
    Height = 5
    Shape = bsTopLine
  end
  object Label19: TLabel
    Left = 8
    Top = 288
    Width = 68
    Height = 13
    Caption = 'From Card No.'
  end
  object Label20: TLabel
    Left = 176
    Top = 288
    Width = 58
    Height = 13
    Caption = 'To Card No.'
  end
  object Label21: TLabel
    Left = 128
    Top = 312
    Width = 68
    Height = 13
    Caption = 'Record data ='
  end
  object Label22: TLabel
    Left = 224
    Top = 96
    Width = 47
    Height = 13
    Caption = 'File Name'
  end
  object lblRecNo: TLabel
    Left = 200
    Top = 312
    Width = 6
    Height = 13
    Caption = '0'
  end
  object txtRdrCode: TEdit
    Left = 80
    Top = 8
    Width = 49
    Height = 21
    MaxLength = 3
    TabOrder = 0
    Text = '1'
  end
  object cmbBaudRate: TComboBox
    Left = 200
    Top = 8
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 1
    Text = '9600'
    Items.Strings = (
      '2400'
      '4800'
      '9600'
      '19200'
      '38400')
  end
  object cmbComPort: TComboBox
    Left = 344
    Top = 8
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 2
    Text = 'COM2'
    Items.Strings = (
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5'
      'COM6'
      'COM7'
      'COM8')
  end
  object cmbCommands: TComboBox
    Left = 64
    Top = 40
    Width = 233
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      'Link Test'
      'Restart Reader'
      'Reader Configuration'
      'Reader Version'
      'Set Date and Time'
      'Read Date and Time'
      'Change Reader'#39's Address'
      'Change Reader'#39's Baud Rate'
      'Set Limitation Time'
      'Read Limitation Time'
      'Send Message To Reader'
      'Send Message To Person'
      'Read Personal Message'
      'Delete Personal Message'
      'Delete All Personal Message'
      'Set Card No. Limitation'
      'Read Card No. Limitation'
      'Change Relation Mode'
      'Read Relation Mode'
      'Get Record (Online Mode-MTT5000)'
      'Collection (Reading New Records)'
      'Recovery Records'
      'Permanent Recovery'
      'Recovery Records In File'
      'Print To Readers'
      'Cut Print'
      'Send Beep'
      'Set Only Cards'
      'Get Only Cards'
      #13'Set Authority cards'
      'Get Authority cards'
      '')
  end
  object cmdRun: TBitBtn
    Left = 316
    Top = 41
    Width = 107
    Height = 25
    Caption = 'Run'
    TabOrder = 4
    OnClick = cmdRunClick
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
  end
  object txtNRdrCode: TEdit
    Left = 104
    Top = 128
    Width = 33
    Height = 21
    MaxLength = 3
    TabOrder = 7
    Text = '2'
  end
  object cmbNBDR: TComboBox
    Left = 224
    Top = 128
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 3
    TabOrder = 8
    Text = '19200'
    Items.Strings = (
      '2400'
      '4800'
      '9600'
      '19200'
      '38400')
  end
  object mskFTime1: TMaskEdit
    Left = 64
    Top = 176
    Width = 45
    Height = 21
    EditMask = '!90:00;1;0'
    MaxLength = 5
    TabOrder = 9
    Text = '  :  '
  end
  object mskTTime1: TMaskEdit
    Left = 120
    Top = 176
    Width = 37
    Height = 21
    EditMask = '!90:00;1;0'
    MaxLength = 5
    TabOrder = 10
    Text = '  :  '
  end
  object mskFTime2: TMaskEdit
    Left = 192
    Top = 176
    Width = 37
    Height = 21
    EditMask = '!90:00;1;0'
    MaxLength = 5
    TabOrder = 11
    Text = '  :  '
  end
  object mskTTime2: TMaskEdit
    Left = 248
    Top = 176
    Width = 37
    Height = 21
    EditMask = '!90:00;1;0'
    MaxLength = 5
    TabOrder = 12
    Text = '  :  '
  end
  object mskFTime3: TMaskEdit
    Left = 320
    Top = 176
    Width = 37
    Height = 21
    EditMask = '!90:00;1;0'
    MaxLength = 5
    TabOrder = 13
    Text = '  :  '
  end
  object mskTTime3: TMaskEdit
    Left = 376
    Top = 176
    Width = 37
    Height = 21
    EditMask = '!90:00;1;0'
    MaxLength = 5
    TabOrder = 14
    Text = '  :  '
  end
  object txtMsg1: TEdit
    Left = 8
    Top = 224
    Width = 105
    Height = 21
    MaxLength = 16
    TabOrder = 15
  end
  object txtMsg2: TEdit
    Left = 112
    Top = 224
    Width = 105
    Height = 21
    MaxLength = 16
    TabOrder = 16
  end
  object txtMsg3: TEdit
    Left = 216
    Top = 224
    Width = 105
    Height = 21
    MaxLength = 16
    TabOrder = 17
  end
  object txtMsg4: TEdit
    Left = 320
    Top = 224
    Width = 105
    Height = 21
    MaxLength = 16
    TabOrder = 18
  end
  object txtCardCode: TEdit
    Left = 72
    Top = 256
    Width = 89
    Height = 21
    MaxLength = 8
    TabOrder = 19
  end
  object txtMessage: TEdit
    Left = 216
    Top = 256
    Width = 209
    Height = 21
    MaxLength = 64
    TabOrder = 20
  end
  object txtFCardLimit: TEdit
    Left = 80
    Top = 288
    Width = 81
    Height = 21
    MaxLength = 8
    TabOrder = 21
  end
  object txtTCardLimit: TEdit
    Left = 240
    Top = 288
    Width = 81
    Height = 21
    MaxLength = 8
    TabOrder = 22
  end
  object chkOnLine: TCheckBox
    Left = 336
    Top = 128
    Width = 89
    Height = 17
    Caption = 'OnLine mode'
    TabOrder = 23
  end
  object mskDate: TMaskEdit
    Left = 40
    Top = 96
    Width = 77
    Height = 21
    EditMask = '!9999/99/99;1;_'
    MaxLength = 10
    TabOrder = 5
    Text = '    /  /  '
  end
  object mskTime: TMaskEdit
    Left = 160
    Top = 96
    Width = 47
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 6
    Text = '  :  '
  end
  object txtFName: TEdit
    Left = 280
    Top = 96
    Width = 145
    Height = 21
    TabOrder = 24
    Text = 'RdrRecs.Txt'
  end
  object lstData: TListBox
    Left = 8
    Top = 328
    Width = 417
    Height = 97
    Columns = 2
    ItemHeight = 13
    TabOrder = 25
  end
  object tmrOnline: TTimer
    Enabled = False
    OnTimer = tmrOnlineTimer
    Left = 352
    Top = 280
  end
end
