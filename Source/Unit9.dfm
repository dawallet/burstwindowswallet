object Form9: TForm9
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Miner x86'
  ClientHeight = 242
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmExplicit
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 336
    Top = 13
    Width = 60
    Height = 13
    Caption = 'Found Plots:'
  end
  object Label2: TLabel
    Left = 24
    Top = 13
    Width = 272
    Height = 13
    Caption = 'You have to do this ONCE or if you want to change pool:'
  end
  object Label3: TLabel
    Left = 23
    Top = 51
    Width = 76
    Height = 13
    Caption = '1. Choose pool:'
  end
  object Label4: TLabel
    Left = 24
    Top = 109
    Width = 148
    Height = 13
    Caption = '2. Change reward assignment:'
  end
  object Label5: TLabel
    Left = 24
    Top = 180
    Width = 103
    Height = 13
    Caption = '3. Save configuration'
  end
  object Label6: TLabel
    Left = 152
    Top = 133
    Width = 141
    Height = 39
    Caption = 
      'You need a fully downloaded Blockchain and at least 1 Burst for ' +
      'a change!'
    Color = clGradientInactiveCaption
    ParentColor = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 352
    Top = 199
    Width = 75
    Height = 25
    Caption = 'Start Mining'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 336
    Top = 32
    Width = 105
    Height = 161
    ItemHeight = 13
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 23
    Top = 75
    Width = 145
    Height = 21
    TabOrder = 2
    Text = 'DevPool2'
    OnClick = ComboBox1Click
  end
  object Button2: TButton
    Left = 23
    Top = 133
    Width = 75
    Height = 25
    Caption = 'Change'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 24
    Top = 199
    Width = 75
    Height = 25
    Caption = 'Save changes'
    TabOrder = 4
  end
  object Button4: TButton
    Left = 317
    Top = 8
    Width = 4
    Height = 224
    Default = True
    TabOrder = 5
  end
end
