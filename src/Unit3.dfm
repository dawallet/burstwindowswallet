object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Plotter'
  ClientHeight = 242
  ClientWidth = 592
  Color = clBtnFace
  TransparentColorValue = clRed
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmExplicit
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 21
    Width = 336
    Height = 13
    Caption = 
      'You have xx GB free on drive X:/. You want to fill up XX GB with' +
      ' Plots?'
  end
  object Label2: TLabel
    Left = 397
    Top = 40
    Width = 28
    Height = 13
    Caption = 'XX GB'
  end
  object Label3: TLabel
    Left = 17
    Top = 40
    Width = 22
    Height = 13
    Caption = '1 GB'
  end
  object Label4: TLabel
    Left = 103
    Top = 92
    Width = 259
    Height = 13
    Alignment = taCenter
    Caption = 'How many CPU cores you want to use?  You chose:  X'
  end
  object Label5: TLabel
    Left = 398
    Top = 111
    Width = 37
    Height = 13
    Caption = 'X Cores'
  end
  object Label6: TLabel
    Left = 8
    Top = 111
    Width = 38
    Height = 13
    Caption = '  1 Core'
  end
  object Label7: TLabel
    Left = 170
    Top = 157
    Width = 103
    Height = 13
    Caption = 'Your BURST Account:'
  end
  object Label8: TLabel
    Left = 456
    Top = 18
    Width = 61
    Height = 13
    Caption = 'Start Nonce:'
  end
  object Label9: TLabel
    Left = 456
    Top = 111
    Width = 42
    Height = 13
    Caption = 'Stagger:'
  end
  object Label10: TLabel
    Left = 482
    Top = 64
    Width = 12
    Height = 13
    Caption = '01'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel
    Left = 456
    Top = 64
    Width = 20
    Height = 13
    Caption = 'e.g.'
  end
  object Label12: TLabel
    Left = 469
    Top = 83
    Width = 21
    Height = 13
    Caption = '#PC'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label13: TLabel
    Left = 503
    Top = 64
    Width = 12
    Height = 13
    Caption = '02'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel
    Left = 500
    Top = 83
    Width = 27
    Height = 13
    Caption = '#Disk'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel
    Left = 524
    Top = 64
    Width = 60
    Height = 13
    Caption = '000 000 001'
  end
  object Label17: TLabel
    Left = 540
    Top = 83
    Width = 31
    Height = 13
    Caption = 'Range'
  end
  object Label16: TLabel
    Left = 496
    Top = 64
    Width = 4
    Height = 13
    Caption = '|'
  end
  object Label19: TLabel
    Left = 530
    Top = 83
    Width = 4
    Height = 13
    Caption = '|'
  end
  object Label20: TLabel
    Left = 496
    Top = 83
    Width = 4
    Height = 13
    Caption = '|'
  end
  object Label21: TLabel
    Left = 517
    Top = 64
    Width = 4
    Height = 13
    Caption = '|'
  end
  object Button1: TButton
    Left = 13
    Top = 199
    Width = 75
    Height = 25
    Caption = 'Back'
    TabOrder = 0
    OnClick = Button1Click
  end
  object TrackBar1: TTrackBar
    Left = 62
    Top = 40
    Width = 329
    Height = 34
    Min = 1
    Position = 1
    TabOrder = 1
    OnChange = TrackBar1Change
  end
  object TrackBar2: TTrackBar
    Left = 62
    Top = 111
    Width = 330
    Height = 26
    Min = 1
    Position = 1
    TabOrder = 2
    OnChange = TrackBar2Change
  end
  object Textfield: TEdit
    Left = 135
    Top = 176
    Width = 177
    Height = 21
    TabOrder = 3
    Text = 'BURST-XXXX-XXXX-XXXX-XXXX'
  end
  object Button2: TButton
    Left = 470
    Top = 199
    Width = 75
    Height = 25
    Caption = 'Start Plotting'
    TabOrder = 4
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 481
    Top = 166
    Width = 95
    Height = 17
    Caption = 'Async '
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 456
    Top = 37
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 6
    TextHint = '0'
  end
  object Edit2: TEdit
    Left = 456
    Top = 132
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 7
    TextHint = 'e.g. 4096'
  end
  object CheckBox2: TCheckBox
    Left = 17
    Top = 176
    Width = 97
    Height = 17
    Caption = 'Expert mode'
    TabOrder = 8
    OnClick = CheckBox2Click
  end
end
