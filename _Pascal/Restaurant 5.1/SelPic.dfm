object frmSelPicture: TfrmSelPicture
  Left = 116
  Top = 63
  Width = 374
  Height = 299
  BiDiMode = bdLeftToRight
  Caption = #1575#1606#1578#1582#1575#1576' '#1578#1589#1608#1610#1585
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 22
    Top = 7
    Width = 16
    Height = 15
    Caption = '&'#1601#1575#1610#1604
  end
  object lbl3: TLabel
    Left = 8
    Top = 198
    Width = 84
    Height = 15
    Caption = #1601#1585'&'#1605#1578' '#1601#1575#1610#1604' '#1578#1589#1608#1610#1585#1610
  end
  object lbl2: TLabel
    Left = 145
    Top = 0
    Width = 46
    Height = 15
    Caption = #1662#1610#1588' '#1606#1605#1575#1610#1588
  end
  object FileListBox1: TFileListBox
    Left = 7
    Top = 21
    Width = 128
    Height = 170
    ItemHeight = 17
    Mask = '*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf'
    TabOrder = 0
    OnClick = FileListBox1Click
  end
  object FilterComboBox1: TFilterComboBox
    Left = 7
    Top = 212
    Width = 128
    Height = 23
    FileList = FileListBox1
    Filter = 
      'All Pictures(*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf)|*.jpg;*.jpeg;' +
      '*.bmp;*.ico;*.emf;*.wmf|Bitmap Files(*.BMP)|*.bmp|JPG Files(*.JP' +
      'G, *.JPEG)|*.jpg;*.jpeg|Icon Files(*.ICO)|*.ico|*.EMF|*.emf|*.WM' +
      'F|*.wmf'
    TabOrder = 1
    OnClick = FilterComboBox1Click
  end
  object cmdOK: TBitBtn
    Left = 240
    Top = 212
    Width = 80
    Height = 22
    Caption = #1575'&'#1606#1578#1582#1575#1576
    TabOrder = 2
    Kind = bkOK
  end
  object cmdCancel: TBitBtn
    Left = 155
    Top = 212
    Width = 79
    Height = 22
    Caption = #1575#1606'&'#1589#1585#1575#1601
    TabOrder = 3
    Kind = bkCancel
  end
  object Panel1: TPanel
    Left = 141
    Top = 21
    Width = 178
    Height = 170
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object imgPreview: TImage
      Left = 2
      Top = 2
      Width = 174
      Height = 167
      Stretch = True
    end
  end
  object DosMove1: TDosMove
    Active = True
    Options = [moEnter]
    Left = 104
    Top = 76
  end
end
