object frmParams: TfrmParams
  Left = 224
  Top = 221
  HelpContext = 201
  BiDiMode = bdRightToLeft
  BorderStyle = bsDialog
  Caption = #1578#1606#1592#1610#1605' '#1662#1575#1585#1575#1605#1578#1585#1607#1575
  ClientHeight = 465
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = ARABIC_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arabic Transparent'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  DesignSize = (
    550
    465)
  PixelsPerInch = 96
  TextHeight = 15
  object cmdOK: TBitBtn
    Left = 451
    Top = 435
    Width = 98
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1579#1576#1578
    ModalResult = 1
    TabOrder = 0
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
    ExplicitTop = 388
  end
  object cmdHelp: TBitBtn
    Left = 107
    Top = 435
    Width = 98
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1585#1575'&'#1607#1606#1605#1575
    TabOrder = 1
    Kind = bkHelp
    ExplicitTop = 388
  end
  object cmdCancel: TBitBtn
    Left = 3
    Top = 435
    Width = 98
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1575#1606#1589#1585#1575#1601
    TabOrder = 2
    Kind = bkCancel
    ExplicitTop = 388
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 550
    Height = 430
    ActivePage = TabSheet4
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    ExplicitHeight = 383
    object TabSheet1: TTabSheet
      Caption = #1578#1606#1592#1610#1605#1575#1578' '#1608#1593#1583#1607' '#1607#1575' '#1608' '#1586#1605#1575#1606' '#1587#1585#1608' '#1594#1584#1575
      ExplicitHeight = 353
      object grp1: TGroupBox
        Left = 6
        Top = 25
        Width = 532
        Height = 209
        Caption = #1594#1584#1575#1607#1575#1610' '#1602#1575#1576#1604' '#1587#1585#1608' '#1608' '#1586#1605#1575#1606' '#1608' '#1578#1593#1583#1575#1583' '#1587#1585#1608' '#1570#1606#1607#1575
        TabOrder = 0
        object lbl1: TLabel
          Left = 421
          Top = 35
          Width = 35
          Height = 15
          Caption = #1575#1586#1587#1575#1593#1578
        end
        object lbl2: TLabel
          Left = 351
          Top = 32
          Width = 6
          Height = 15
          Caption = #1578#1575
        end
        object lbl4: TLabel
          Left = 421
          Top = 83
          Width = 35
          Height = 15
          Caption = #1575#1586#1587#1575#1593#1578
        end
        object lbl5: TLabel
          Left = 351
          Top = 82
          Width = 6
          Height = 15
          Caption = #1578#1575
        end
        object lbl7: TLabel
          Left = 421
          Top = 131
          Width = 35
          Height = 15
          Caption = #1575#1586#1587#1575#1593#1578
        end
        object lbl8: TLabel
          Left = 351
          Top = 132
          Width = 6
          Height = 15
          Caption = #1578#1575
        end
        object lbl6: TLabel
          Left = 194
          Top = 84
          Width = 91
          Height = 15
          Caption = #1578#1593#1583#1575#1583' '#1583#1585' '#1576#1585#1606#1575#1605#1607' '#1594#1584#1575#1610#1610
        end
        object lbl9: TLabel
          Left = 194
          Top = 132
          Width = 91
          Height = 15
          Caption = #1578#1593#1583#1575#1583' '#1583#1585' '#1576#1585#1606#1575#1605#1607' '#1594#1584#1575#1610#1610
        end
        object lbl3: TLabel
          Left = 194
          Top = 36
          Width = 91
          Height = 15
          Caption = #1578#1593#1583#1575#1583' '#1583#1585' '#1576#1585#1606#1575#1605#1607' '#1594#1584#1575#1610#1610
        end
        object Label4: TLabel
          Left = 59
          Top = 84
          Width = 72
          Height = 15
          Caption = #1605#1576#1606#1575#1610' '#1588#1605#1575#1585#1607' '#1601#1610#1588
        end
        object Label5: TLabel
          Left = 59
          Top = 132
          Width = 72
          Height = 15
          Caption = #1605#1576#1606#1575#1610' '#1588#1605#1575#1585#1607' '#1601#1610#1588
        end
        object Label6: TLabel
          Left = 59
          Top = 36
          Width = 72
          Height = 15
          Caption = #1605#1576#1606#1575#1610' '#1588#1605#1575#1585#1607' '#1601#1610#1588
        end
        object chkMokhalafat: TCheckBox
          Left = 464
          Top = 168
          Width = 57
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1605#1582#1604#1601#1575#1578
          ParentBiDiMode = False
          TabOrder = 12
          OnKeyPress = chkSobhanehKeyPress
        end
        object chkSobhaneh: TCheckBox
          Left = 464
          Top = 35
          Width = 57
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1589#1576#1581#1575#1606#1607
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = chkSobhanehClick
          OnKeyPress = chkSobhanehKeyPress
        end
        object chkNahar: TCheckBox
          Left = 472
          Top = 83
          Width = 49
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1606#1575#1607#1575#1585
          ParentBiDiMode = False
          TabOrder = 4
          OnClick = chkNaharClick
          OnKeyPress = chkSobhanehKeyPress
        end
        object chkSham: TCheckBox
          Left = 480
          Top = 130
          Width = 41
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1588#1575#1605
          ParentBiDiMode = False
          TabOrder = 8
          OnClick = chkShamClick
          OnKeyPress = chkSobhanehKeyPress
        end
        object txtFromSobh: TEdit
          Left = 362
          Top = 32
          Width = 55
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 1
          OnExit = txtFromSobhExit
          OnKeyPress = txtFromSobhKeyPress
        end
        object txtToSobh: TEdit
          Left = 293
          Top = 32
          Width = 55
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 2
          OnExit = txtToSobhExit
          OnKeyPress = txtFromSobhKeyPress
        end
        object txtFromNahar: TEdit
          Left = 362
          Top = 80
          Width = 55
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 5
          OnExit = txtFromNaharExit
          OnKeyPress = txtFromSobhKeyPress
        end
        object txtToNahar: TEdit
          Left = 293
          Top = 80
          Width = 55
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 6
          OnExit = txtToNaharExit
          OnKeyPress = txtFromSobhKeyPress
        end
        object txtFromSham: TEdit
          Left = 362
          Top = 128
          Width = 55
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 9
          OnExit = txtFromShamExit
          OnKeyPress = txtFromSobhKeyPress
        end
        object txtToSham: TEdit
          Left = 293
          Top = 128
          Width = 55
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 10
          OnExit = txtToShamExit
          OnKeyPress = txtFromSobhKeyPress
        end
        object txtNaharKeyNo: TEdit
          Left = 143
          Top = 80
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          MaxLength = 1
          ParentBiDiMode = False
          TabOrder = 7
          OnKeyPress = txtSobhKeyNoKeyPress
        end
        object txtShamKeyNo: TEdit
          Left = 143
          Top = 128
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          MaxLength = 1
          ParentBiDiMode = False
          TabOrder = 11
          OnKeyPress = txtSobhKeyNoKeyPress
        end
        object txtSobhKeyNo: TEdit
          Left = 143
          Top = 32
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          MaxLength = 1
          ParentBiDiMode = False
          TabOrder = 3
          OnKeyPress = txtSobhKeyNoKeyPress
        end
        object txtNaharFirstFish: TEdit
          Left = 7
          Top = 80
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          MaxLength = 5
          ParentBiDiMode = False
          TabOrder = 13
          Text = '1'
          OnKeyPress = txtSobhKeyNoKeyPress
        end
        object txtShamFirstFish: TEdit
          Left = 7
          Top = 128
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          MaxLength = 5
          ParentBiDiMode = False
          TabOrder = 14
          Text = '1'
          OnKeyPress = txtSobhKeyNoKeyPress
        end
        object txtSobhFirstFish: TEdit
          Left = 7
          Top = 32
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          MaxLength = 5
          ParentBiDiMode = False
          TabOrder = 15
          Text = '1'
          OnKeyPress = txtSobhKeyNoKeyPress
        end
      end
      object chkSobhInSham: TCheckBox
        Left = 3
        Top = 236
        Width = 525
        Height = 17
        Caption = 
          #1583#1585' '#1589#1608#1585#1578#1610' '#1705#1607' '#1583#1585' '#1608#1593#1583#1607' '#1588#1575#1605' '#1583#1608#1576#1575#1585' '#1705#1575#1585#1578' '#1586#1583#1607' '#1588#1583' '#1576#1585#1575#1610' '#1576#1575#1585' '#1583#1608#1605' '#1601#1610#1588' '#1589#1576#1581#1575#1606 +
          #1607' '#1601#1585#1583#1575' '#1589#1575#1583#1585' '#1711#1585#1583#1583' ('#1606#1601#1578' '#1608#1711#1575#1586#1662#1575#1585#1587')'
        Font.Charset = ARABIC_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
      end
      object chkKasr: TCheckBox
        Left = 3
        Top = 256
        Width = 525
        Height = 17
        Caption = 
          #1575#1711#1585' '#1601#1585#1583' '#1583#1585' '#1608#1593#1583#1607' '#1582#1575#1585#1580' '#1575#1586#1588#1610#1601#1578' '#1705#1575#1585#1578' '#1586#1583' '#1576#1607' '#1575#1608' '#1594#1584#1575' '#1583#1575#1583#1607' '#1588#1608#1583' '#1608' '#1583#1585' '#1601#1610#1588'(' +
          #1705#1587#1585' '#1575#1586' '#1581#1602#1608#1602')'#1670#1575#1662' '#1588#1608#1583' ('#1576#1610#1605#1575#1585#1587#1578#1575#1606' '#1593#1585#1601#1575#1606')'
        Font.Charset = ARABIC_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arabic Transparent'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1578#1606#1592#1610#1605#1575#1578' '#1602#1610#1605#1578' '#1711#1584#1575#1585#1610
      ImageIndex = 1
      ExplicitHeight = 353
      object Label14: TLabel
        Left = 111
        Top = 226
        Width = 409
        Height = 15
        Caption = 
          #1581#1583#1575#1602#1604' '#1575#1593#1578#1576#1575#1585'  :                                   '#1585#1610#1575#1604'  ('#1605#1579#1575#1604' : ' +
          '1000 '#1585#1610#1575#1604'   '#1610#1575'   2000- '#1585#1610#1575#1604')'
      end
      object grp3: TGroupBox
        Left = 17
        Top = 11
        Width = 511
        Height = 90
        Caption = #1602#1610#1605#1578' '#1711#1584#1575#1585#1610' '#1594#1584#1575#1610' '#1605#1610#1607#1605#1575#1606
        TabOrder = 0
        object lbl11: TLabel
          Left = 428
          Top = 44
          Width = 66
          Height = 15
          Caption = #1602#1610#1605#1578' '#1594#1584#1575#1610' '#1575#1608#1604
        end
        object cmbFirstPriceGuest: TComboBox
          Left = 274
          Top = 40
          Width = 145
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 0
          OnKeyPress = chkSobhanehKeyPress
          Items.Strings = (
            #1662#1600#1600#1600#1585#1587#1606#1604#1610
            #1662#1610#1605#1575#1606#1603#1575#1585#1610)
        end
        object chkSecondFoodGuest: TCheckBox
          Left = 163
          Top = 42
          Width = 81
          Height = 17
          BiDiMode = bdRightToLeft
          Caption = #1594#1584#1575#1610' '#1575#1590#1575#1601#1610
          ParentBiDiMode = False
          TabOrder = 1
          OnKeyPress = chkSobhanehKeyPress
        end
        object cmbSecondPriceGuest: TComboBox
          Left = 12
          Top = 40
          Width = 145
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 2
          OnKeyPress = chkSobhanehKeyPress
          Items.Strings = (
            #1662#1600#1600#1600#1585#1587#1606#1604#1610
            #1662#1610#1605#1575#1606#1603#1575#1585#1610)
        end
      end
      object grp2: TGroupBox
        Left = 17
        Top = 107
        Width = 511
        Height = 89
        Caption = #1602#1610#1605#1578' '#1711#1584#1575#1585#1610' '#1594#1584#1575#1610' '#1662#1585#1587#1606#1604
        TabOrder = 1
        object lbl10: TLabel
          Left = 429
          Top = 40
          Width = 66
          Height = 15
          Caption = #1602#1610#1605#1578' '#1594#1584#1575#1610' '#1575#1608#1604
        end
        object cmbFirstPricePerson: TComboBox
          Left = 275
          Top = 37
          Width = 145
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 0
          OnKeyPress = chkSobhanehKeyPress
          Items.Strings = (
            #1662#1600#1600#1600#1585#1587#1606#1604#1610
            #1662#1610#1605#1575#1606#1603#1575#1585#1610)
        end
        object chkSecondFoodPerson: TCheckBox
          Left = 164
          Top = 40
          Width = 81
          Height = 17
          BiDiMode = bdRightToLeft
          Caption = #1594#1584#1575#1610' '#1575#1590#1575#1601#1610
          ParentBiDiMode = False
          TabOrder = 1
          OnKeyPress = chkSobhanehKeyPress
        end
        object cmbSecondPricePerson: TComboBox
          Left = 13
          Top = 37
          Width = 145
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 2
          OnKeyPress = chkSobhanehKeyPress
          Items.Strings = (
            #1662#1600#1600#1600#1585#1587#1606#1604#1610
            #1662#1610#1605#1575#1606#1603#1575#1585#1610)
        end
      end
      object txtMinCredit: TEdit
        Left = 329
        Top = 223
        Width = 119
        Height = 23
        BiDiMode = bdLeftToRight
        MaxLength = 8
        ParentBiDiMode = False
        TabOrder = 2
        OnKeyPress = txtNaharKeyNoKeyPress
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1578#1606#1592#1610#1605#1575#1578' '#1705#1606#1578#1585#1604' '#1578#1585#1583#1583
      ImageIndex = 2
      ExplicitHeight = 353
      object Label1: TLabel
        Left = 241
        Top = 181
        Width = 87
        Height = 15
        Caption = #1589#1576#1581#1575#1606#1607' '#1587#1585#1608' '#1606#1588#1608#1583' .'
      end
      object Label2: TLabel
        Left = 257
        Top = 209
        Width = 72
        Height = 15
        Caption = #1606#1607#1575#1585' '#1587#1585#1608' '#1606#1588#1608#1583' .'
      end
      object Label3: TLabel
        Left = 259
        Top = 239
        Width = 69
        Height = 15
        Caption = #1588#1575#1605' '#1587#1585#1608' '#1606#1588#1608#1583' .'
      end
      object grp5: TGroupBox
        Left = 222
        Top = 18
        Width = 319
        Height = 143
        Caption = #1603#1606#1578#1585#1604' '#1578#1585#1583#1583' '#1581#1590#1608#1585' '#1608' '#1594#1610#1575#1576
        TabOrder = 0
        object lbl16: TLabel
          Left = 238
          Top = 28
          Width = 71
          Height = 15
          Caption = #1605#1576#1606#1575#1610' '#1603#1606#1578#1585#1604' '#1578#1585#1583#1583
        end
        object lbl17: TLabel
          Left = 231
          Top = 79
          Width = 57
          Height = 15
          Caption = #1583#1608#1585#1607' '#1587#1585#1603#1588#1610
        end
        object lbl18: TLabel
          Left = 143
          Top = 80
          Width = 28
          Height = 15
          AutoSize = False
          Caption = #1583#1602#1610#1602#1607
        end
        object Label13: TLabel
          Left = 2
          Top = 111
          Width = 53
          Height = 15
          AutoSize = False
          Caption = 'Time Out'
          Visible = False
        end
        object cmbControlBase: TComboBox
          Left = 29
          Top = 24
          Width = 203
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 0
          OnKeyPress = chkSobhanehKeyPress
          Items.Strings = (
            #1603#1575#1585#1578' '#1575#1608#1604
            #1578#1593#1583#1575#1583' '#1603#1575#1585#1578' '#1601#1585#1583)
        end
        object chkClockOnLine: TCheckBox
          Left = 105
          Top = 61
          Width = 206
          Height = 17
          Caption = #1575#1585#1578#1576#1575#1591' '#1583#1575#1574#1605#1610' '#1576#1575' '#1583#1587#1578#1711#1575#1607#1607#1575#1610' '#1581#1590#1608#1585' '#1608' '#1594#1610#1575#1576
          TabOrder = 1
          OnClick = chkClockOnLineClick
          OnKeyPress = chkSobhanehKeyPress
        end
        object txtCycle: TEdit
          Left = 178
          Top = 76
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          MaxLength = 5
          ParentBiDiMode = False
          TabOrder = 2
          OnKeyPress = txtNaharKeyNoKeyPress
        end
        object chkOffOutTime: TCheckBox
          Left = 110
          Top = 108
          Width = 201
          Height = 17
          Caption = #1602#1591#1593' '#1575#1585#1578#1576#1575#1591' '#1583#1585' '#1586#1605#1575#1606' '#1582#1575#1585#1580' '#1575#1586' '#1605#1581#1583#1608#1583#1607
          TabOrder = 3
          OnKeyPress = chkSobhanehKeyPress
        end
        object txtRestCycle: TEdit
          Left = 59
          Top = 106
          Width = 47
          Height = 23
          BiDiMode = bdLeftToRight
          MaxLength = 5
          ParentBiDiMode = False
          TabOrder = 4
          Visible = False
          OnKeyPress = txtNaharKeyNoKeyPress
        end
      end
      object chkNaharMaxIn: TCheckBox
        Left = 387
        Top = 208
        Width = 152
        Height = 17
        Caption = #1583#1585' '#1589#1608#1585#1578' '#1608#1585#1608#1583' '#1576#1593#1583' '#1575#1586' '#1587#1575#1593#1578
        TabOrder = 1
        OnClick = chkNaharMaxInClick
      end
      object chkShamMaxIn: TCheckBox
        Left = 384
        Top = 239
        Width = 155
        Height = 17
        Caption = #1583#1585' '#1589#1608#1585#1578' '#1608#1585#1608#1583' '#1576#1593#1583' '#1575#1586' '#1587#1575#1593#1578
        TabOrder = 2
        OnClick = chkShamMaxInClick
      end
      object chkSobhanehMaXIn: TCheckBox
        Left = 384
        Top = 179
        Width = 155
        Height = 17
        Caption = #1583#1585' '#1589#1608#1585#1578' '#1608#1585#1608#1583' '#1576#1593#1583' '#1575#1586' '#1587#1575#1593#1578
        TabOrder = 3
        OnClick = chkSobhanehMaXInClick
      end
      object txtSobhanehMaxIn: TEdit
        Left = 334
        Top = 177
        Width = 50
        Height = 23
        BiDiMode = bdLeftToRight
        Enabled = False
        MaxLength = 5
        ParentBiDiMode = False
        TabOrder = 4
        OnExit = txtSobhanehMaxInExit
      end
      object txtNaharMaxIn: TEdit
        Left = 335
        Top = 205
        Width = 50
        Height = 23
        BiDiMode = bdLeftToRight
        Enabled = False
        MaxLength = 5
        ParentBiDiMode = False
        TabOrder = 5
        OnExit = txtNaharMaxInExit
      end
      object txtShamMaxIn: TEdit
        Left = 335
        Top = 235
        Width = 50
        Height = 23
        BiDiMode = bdLeftToRight
        Enabled = False
        MaxLength = 5
        ParentBiDiMode = False
        TabOrder = 6
        OnExit = txtShamMaxInExit
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 18
        Width = 210
        Height = 182
        Caption = #1606#1581#1608#1607' '#1583#1585#1610#1575#1601#1578' '#1575#1591#1604#1575#1593#1575#1578' '#1581#1590#1608#1585#1608#1594#1610#1575#1576' '#1575#1601#1585#1575#1583' '
        TabOrder = 7
        object lblSQLPass: TLabel
          Left = 126
          Top = 153
          Width = 44
          Height = 15
          Caption = #1603#1604#1605#1607' '#1593#1576#1608#1585
          Enabled = False
        end
        object lblSqlUser: TLabel
          Left = 126
          Top = 126
          Width = 41
          Height = 15
          Caption = #1606#1575#1605' '#1705#1575#1585#1576#1585' '
          Enabled = False
        end
        object lblServer: TLabel
          Left = 127
          Top = 75
          Width = 72
          Height = 15
          Caption = #1606#1575#1605' '#1587#1585#1608#1610#1587' '#1583#1607#1606#1583#1607
          Enabled = False
        end
        object lbldatabasename: TLabel
          Left = 124
          Top = 100
          Width = 79
          Height = 15
          Caption = #1606#1575#1605' '#1576#1575#1606#1705' '#1575#1591#1604#1575#1593#1575#1578#1610
          Enabled = False
        end
        object rdoFromRdr: TRadioButton
          Left = 7
          Top = 22
          Width = 195
          Height = 17
          Caption = #1583#1585#1610#1575#1601#1578' '#1605#1587#1578#1602#1610#1605' '#1575#1586' '#1583#1587#1578#1711#1575#1607#1607#1575' '
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rdoFromRdrClick
        end
        object rdoFromDB: TRadioButton
          Left = 6
          Top = 46
          Width = 195
          Height = 17
          Caption = #1583#1585#1610#1575#1601#1578' '#1575#1586' '#1576#1575#1606#1705' '#1606#1585#1605' '#1575#1601#1586#1575#1585' '#1581#1590#1608#1585#1608#1594#1610#1575#1576
          TabOrder = 1
          OnClick = rdoFromDBClick
        end
        object txtSqlPass: TEdit
          Left = 15
          Top = 148
          Width = 108
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          PasswordChar = '*'
          TabOrder = 5
        end
        object txtSqlUser: TEdit
          Left = 15
          Top = 122
          Width = 108
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 4
        end
        object txtServer: TEdit
          Left = 15
          Top = 70
          Width = 108
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 2
        end
        object txtdatabasename: TEdit
          Left = 15
          Top = 96
          Width = 108
          Height = 23
          BiDiMode = bdLeftToRight
          Enabled = False
          ParentBiDiMode = False
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 204
        Width = 210
        Height = 61
        Caption = #1705#1575#1585#1576#1585' '#1580#1605#1593' '#1570#1608#1585#1610' '#1570#1606#1604#1575#1610#1606
        TabOrder = 8
        object Label15: TLabel
          Left = 162
          Top = 30
          Width = 37
          Height = 15
          Caption = #1606#1575#1605' '#1603#1575#1585#1576#1585
        end
        object cmbUsers: TComboBox
          Left = 9
          Top = 26
          Width = 145
          Height = 23
          BiDiMode = bdLeftToRight
          ItemHeight = 15
          ParentBiDiMode = False
          TabOrder = 0
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1587#1575#1610#1585' '#1578#1606#1592#1610#1605#1575#1578
      ImageIndex = 3
      ExplicitHeight = 353
      DesignSize = (
        542
        400)
      object grp4: TGroupBox
        Left = 3
        Top = 268
        Width = 536
        Height = 129
        Anchors = [akLeft, akBottom]
        Caption = #1605#1578#1606' '#1578#1571#1610#1610#1583' '#1586#1610#1585' '#1711#1586#1575#1585#1588#1575#1578
        TabOrder = 0
        ExplicitTop = 221
        object lbl12: TLabel
          Left = 468
          Top = 28
          Width = 35
          Height = 15
          Caption = #1605#1578#1606' '#1575#1608#1604
        end
        object lbl13: TLabel
          Left = 469
          Top = 51
          Width = 33
          Height = 15
          Caption = #1605#1578#1606' '#1583#1608#1605
        end
        object lbl14: TLabel
          Left = 468
          Top = 75
          Width = 36
          Height = 15
          Caption = #1605#1578#1606' '#1587#1608#1605
        end
        object lbl15: TLabel
          Left = 467
          Top = 99
          Width = 44
          Height = 15
          Caption = #1605#1578#1606' '#1670#1607#1575#1585#1605
        end
        object txtEnd4: TEdit
          Left = 8
          Top = 95
          Width = 445
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 3
          OnKeyPress = txtEnd1KeyPress
        end
        object txtEnd3: TEdit
          Left = 8
          Top = 71
          Width = 445
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 2
          OnKeyPress = txtEnd1KeyPress
        end
        object txtEnd2: TEdit
          Left = 8
          Top = 47
          Width = 445
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 1
          OnKeyPress = txtEnd1KeyPress
        end
        object txtEnd1: TEdit
          Left = 8
          Top = 23
          Width = 445
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 0
          OnKeyPress = txtEnd1KeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = -1
        Width = 263
        Height = 138
        Caption = #1605#1578#1606' '#1586#1610#1585' '#1601#1610#1588#1607#1575
        TabOrder = 1
        object Label7: TLabel
          Left = 206
          Top = 17
          Width = 35
          Height = 15
          Caption = #1605#1578#1606' '#1575#1608#1604
        end
        object Label8: TLabel
          Left = 207
          Top = 40
          Width = 33
          Height = 15
          Caption = #1605#1578#1606' '#1583#1608#1605
        end
        object Label9: TLabel
          Left = 206
          Top = 64
          Width = 36
          Height = 15
          Caption = #1605#1578#1606' '#1587#1608#1605
        end
        object Label10: TLabel
          Left = 205
          Top = 88
          Width = 44
          Height = 15
          Caption = #1605#1578#1606' '#1670#1607#1575#1585#1605
        end
        object Label11: TLabel
          Left = 209
          Top = 112
          Width = 36
          Height = 15
          Caption = #1605#1578#1606' '#1662#1606#1580#1605
        end
        object txtfish4: TEdit
          Left = 53
          Top = 85
          Width = 145
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 3
          OnKeyPress = txtEnd1KeyPress
        end
        object txtfish3: TEdit
          Left = 53
          Top = 61
          Width = 145
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 2
          OnKeyPress = txtEnd1KeyPress
        end
        object txtfish2: TEdit
          Left = 53
          Top = 37
          Width = 145
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 1
          OnKeyPress = txtEnd1KeyPress
        end
        object txtfish1: TEdit
          Left = 53
          Top = 13
          Width = 145
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 0
          OnKeyPress = txtEnd1KeyPress
        end
        object txtfish5: TEdit
          Left = 53
          Top = 109
          Width = 145
          Height = 23
          BiDiMode = bdRightToLeft
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 4
          OnKeyPress = txtEnd1KeyPress
        end
        object cb1: TCheckBox
          Left = 5
          Top = 17
          Width = 41
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1601#1593#1575#1604
          ParentBiDiMode = False
          TabOrder = 5
        end
        object cb2: TCheckBox
          Left = 5
          Top = 41
          Width = 41
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1601#1593#1575#1604
          ParentBiDiMode = False
          TabOrder = 6
        end
        object cb3: TCheckBox
          Left = 5
          Top = 65
          Width = 41
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1601#1593#1575#1604
          ParentBiDiMode = False
          TabOrder = 7
        end
        object cb4: TCheckBox
          Left = 5
          Top = 89
          Width = 41
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1601#1593#1575#1604
          ParentBiDiMode = False
          TabOrder = 8
        end
        object cb5: TCheckBox
          Left = 5
          Top = 113
          Width = 41
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1601#1593#1575#1604
          ParentBiDiMode = False
          TabOrder = 9
        end
      end
      object GroupBox3: TGroupBox
        Left = 273
        Top = -1
        Width = 266
        Height = 138
        TabOrder = 2
        object Label12: TLabel
          Left = 193
          Top = 15
          Width = 57
          Height = 15
          Caption = #1606#1575#1605' '#1587#1575#1582#1578#1605#1575#1606' :'
          Visible = False
        end
        object lblPrsImgsFld: TLabel
          Left = 171
          Top = 112
          Width = 87
          Height = 15
          Caption = #1605#1587#1610#1585' '#1578#1589#1575#1608#1610#1585' '#1662#1585#1587#1606#1604
        end
        object cmbBuilding: TComboBox
          Left = 22
          Top = 11
          Width = 169
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 0
          Visible = False
          OnKeyPress = chkSobhanehKeyPress
          Items.Strings = (
            #1603#1575#1585#1578' '#1575#1608#1604
            #1578#1593#1583#1575#1583' '#1603#1575#1585#1578' '#1601#1585#1583)
        end
        object chkMustReserve: TCheckBox
          Left = 24
          Top = 38
          Width = 108
          Height = 17
          Caption = #1585#1586#1585#1608' '#1575#1580#1576#1575#1585#1610' '#1575#1587#1578' .'
          Enabled = False
          TabOrder = 1
        end
        object chkRunReserve: TCheckBox
          Left = 156
          Top = 38
          Width = 97
          Height = 17
          Caption = #1585#1586#1585#1608' '#1575#1593#1605#1575#1604' '#1588#1608#1583' .'
          TabOrder = 2
          OnClick = chkRunReserveClick
        end
        object rdoOwnBuilding: TRadioButton
          Left = 4
          Top = 62
          Width = 250
          Height = 17
          Caption = #1662#1585#1587#1606#1604' '#1601#1602#1591' '#1583#1585' '#1587#1575#1582#1578#1605#1575#1606' '#1605#1581#1604' '#1582#1583#1605#1578' '#1582#1608#1583' '#1605#1580#1575#1586' '#1607#1587#1578#1606#1583' .'
          TabOrder = 3
        end
        object rdoAllBuilding: TRadioButton
          Left = 4
          Top = 87
          Width = 250
          Height = 17
          Caption = #1662#1585#1587#1606#1604' '#1583#1585' '#1607#1605#1607' '#1587#1575#1582#1578#1605#1575#1606#1607#1575' '#1605#1580#1575#1586' '#1607#1587#1578#1606#1583' .'
          TabOrder = 4
        end
        object txtPrsImgsFld: TEdit
          Left = 50
          Top = 109
          Width = 115
          Height = 23
          BiDiMode = bdLeftToRight
          MaxLength = 30
          ParentBiDiMode = False
          TabOrder = 5
          OnKeyPress = txtEnd1KeyPress
        end
        object chkPrsImgsFld: TCheckBox
          Left = 4
          Top = 113
          Width = 40
          Height = 17
          Alignment = taLeftJustify
          BiDiMode = bdRightToLeftNoAlign
          Caption = #1601#1593#1575#1604
          ParentBiDiMode = False
          TabOrder = 6
          OnClick = chkPrsImgsFldClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 3
        Top = 143
        Width = 536
        Height = 119
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 3
        ExplicitHeight = 72
        object lblAutoLoginUser: TLabel
          Left = 478
          Top = 39
          Width = 45
          Height = 15
          Caption = #1606#1575#1605' '#1705#1575#1585#1576#1585' :'
        end
        object lblAutoLoginPass: TLabel
          Left = 225
          Top = 39
          Width = 52
          Height = 15
          Caption = #1705#1604#1605#1607' '#1593#1576#1608#1585' :'
        end
        object lblAutoFishLstPicsRdrCodeR: TLabel
          Left = 419
          Top = 91
          Width = 104
          Height = 15
          BiDiMode = bdRightToLeft
          Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607' '#1587#1605#1578' '#1585#1575#1587#1578' :'
          ParentBiDiMode = False
        end
        object lblAutoFishLstPicsRdrCodeL: TLabel
          Left = 162
          Top = 91
          Width = 95
          Height = 15
          BiDiMode = bdRightToLeft
          Caption = #1606#1575#1605' '#1583#1587#1578#1711#1575#1607' '#1587#1605#1578' '#1670#1662' :'
          ParentBiDiMode = False
        end
        object cmbAutoLoginUser: TComboBox
          Left = 294
          Top = 36
          Width = 178
          Height = 23
          Style = csDropDownList
          ItemHeight = 15
          TabOrder = 0
          OnKeyPress = chkSobhanehKeyPress
        end
        object txtAutoLoginPass: TEdit
          Left = 16
          Top = 36
          Width = 203
          Height = 23
          BiDiMode = bdLeftToRight
          MaxLength = 30
          ParentBiDiMode = False
          PasswordChar = '*'
          TabOrder = 1
          OnKeyPress = txtEnd1KeyPress
        end
        object chkAutoLogin: TCheckBox
          Left = 382
          Top = 13
          Width = 143
          Height = 17
          BiDiMode = bdRightToLeft
          Caption = #1608#1585#1608#1583' '#1582#1608#1583#1705#1575#1585' '#1705#1575#1585#1576#1585' '#1576#1607' '#1587#1610#1587#1578#1605
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = chkAutoLoginClick
        end
        object cmbAutoFishLstPicsRdrCodeR: TComboBox
          Left = 266
          Top = 88
          Width = 147
          Height = 23
          Style = csDropDownList
          BiDiMode = bdRightToLeft
          ItemHeight = 15
          ParentBiDiMode = False
          TabOrder = 3
        end
        object chkAutoFishLstPics: TCheckBox
          Left = 324
          Top = 65
          Width = 201
          Height = 17
          BiDiMode = bdRightToLeft
          Caption = #1575#1580#1585#1575#1610' '#1582#1608#1583#1705#1575#1585' '#1606#1605#1575#1610#1588' '#1580#1605#1593' '#1570#1608#1585#1610' '#1578#1589#1608#1610#1585#1610
          ParentBiDiMode = False
          TabOrder = 4
          OnClick = chkAutoFishLstPicsClick
        end
        object cmbAutoFishLstPicsRdrCodeL: TComboBox
          Left = 9
          Top = 88
          Width = 147
          Height = 23
          Style = csDropDownList
          BiDiMode = bdRightToLeft
          ItemHeight = 15
          ParentBiDiMode = False
          TabOrder = 5
        end
      end
    end
  end
end
