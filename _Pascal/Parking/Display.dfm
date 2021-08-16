object frmDisplay: TfrmDisplay
  Left = 219
  Top = 122
  HelpContext = 208
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = '«— »«ÿ »« ‰„«Ì‘ê—Â«'
  ClientHeight = 103
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 179
    Top = 0
    Width = 13
    Height = 15
    Caption = '&ﬂœ'
    FocusControl = txtCode
  end
  object lblMsg: TLabel
    Left = 14
    Top = 56
    Width = 206
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Font.Charset = ARABIC_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arabic Transparent'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 63
    Top = 0
    Width = 29
    Height = 15
    Caption = '&„ﬁœ«—'
    FocusControl = txtData
  end
  object cmdOK: TBitBtn
    Left = 148
    Top = 78
    Width = 65
    Height = 22
    Caption = '& √ÌÌœ'
    TabOrder = 2
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
  end
  object cmdExit: TBitBtn
    Left = 7
    Top = 78
    Width = 64
    Height = 22
    Caption = '&Œ—ÊÃ'
    TabOrder = 4
    Kind = bkClose
  end
  object txtCode: TEdit
    Left = 162
    Top = 21
    Width = 51
    Height = 23
    MaxLength = 3
    TabOrder = 0
    OnChange = txtCodeChange
    OnKeyPress = txtCodeKeyPress
  end
  object cmdHelp: TBitBtn
    Left = 78
    Top = 78
    Width = 64
    Height = 22
    Caption = '—«&Â‰„«'
    TabOrder = 3
    Kind = bkHelp
  end
  object txtData: TEdit
    Left = 7
    Top = 21
    Width = 149
    Height = 23
    MaxLength = 12
    TabOrder = 1
    OnChange = txtCodeChange
    OnKeyPress = txtDataKeyPress
  end
end
