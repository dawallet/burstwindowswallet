object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Plotter'
  ClientHeight = 241
  ClientWidth = 453
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
    Left = 178
    Top = 155
    Width = 103
    Height = 13
    Caption = 'Your BURST Account:'
  end
  object Label8: TLabel
    Left = 64
    Top = 92
    Width = 61
    Height = 13
    Caption = 'Start Nonce:'
    Visible = False
  end
  object Label18: TLabel
    Left = 303
    Top = 92
    Width = 43
    Height = 13
    Caption = 'Threads:'
    Visible = False
  end
  object Button1: TButton
    Left = 17
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
    Left = 143
    Top = 174
    Width = 177
    Height = 21
    TabOrder = 3
    Text = 'BURST-XXXX-XXXX-XXXX-XXXX'
  end
  object Button2: TButton
    Left = 360
    Top = 199
    Width = 75
    Height = 25
    Caption = 'Start Plotting'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 64
    Top = 111
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 5
    Text = '0'
    TextHint = '0'
    Visible = False
  end
  object CheckBox2: TCheckBox
    Left = 17
    Top = 176
    Width = 97
    Height = 17
    Caption = 'Expert mode'
    TabOrder = 6
    OnClick = CheckBox2Click
  end
  object Edit3: TEdit
    Left = 303
    Top = 111
    Width = 34
    Height = 21
    NumbersOnly = True
    TabOrder = 7
    Text = '1'
    Visible = False
  end
end
