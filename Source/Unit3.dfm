object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Plotter'
  ClientHeight = 258
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 53
    Top = 21
    Width = 357
    Height = 13
    Caption = 
      'You have xx GB free on drive X:/. How much you want to fill up w' +
      'ith Plots?'
  end
  object Label2: TLabel
    Left = 405
    Top = 40
    Width = 28
    Height = 13
    Caption = 'XX GB'
  end
  object Label3: TLabel
    Left = 21
    Top = 40
    Width = 22
    Height = 13
    Caption = '1 GB'
  end
  object Label4: TLabel
    Left = 133
    Top = 92
    Width = 193
    Height = 13
    Alignment = taCenter
    Caption = 'How many CPU Cores you want to use? '
  end
  object Label5: TLabel
    Left = 396
    Top = 111
    Width = 37
    Height = 13
    Caption = 'X Cores'
  end
  object Label6: TLabel
    Left = 23
    Top = 111
    Width = 32
    Height = 13
    Caption = '1 Core'
  end
  object Label7: TLabel
    Left = 160
    Top = 157
    Width = 151
    Height = 13
    Caption = 'Your Burst Numeric Account ID:'
  end
  object Button1: TButton
    Left = 27
    Top = 215
    Width = 75
    Height = 25
    Caption = 'Back'
    TabOrder = 0
    OnClick = Button1Click
  end
  object TrackBar1: TTrackBar
    Left = 61
    Top = 40
    Width = 329
    Height = 34
    Min = 1
    Position = 1
    TabOrder = 1
  end
  object TrackBar2: TTrackBar
    Left = 61
    Top = 111
    Width = 329
    Height = 26
    Min = 1
    Position = 2
    TabOrder = 2
  end
  object Textfield: TEdit
    Left = 160
    Top = 176
    Width = 145
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    Text = '12345678901234567890'
  end
  object Button2: TButton
    Left = 364
    Top = 215
    Width = 75
    Height = 25
    Caption = 'Start Plotting'
    TabOrder = 4
    OnClick = Button2Click
  end
end
