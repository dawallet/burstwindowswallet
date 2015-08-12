object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Miner x86'
  ClientHeight = 276
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 16
    Width = 261
    Height = 13
    Caption = 'You can start to mine even when you are in the middle'
  end
  object Label2: TLabel
    Left = 365
    Top = 16
    Width = 60
    Height = 13
    Caption = 'Found Plots:'
  end
  object Label3: TLabel
    Left = 19
    Top = 84
    Width = 76
    Height = 13
    Caption = '1. Choose pool:'
  end
  object Label4: TLabel
    Left = 19
    Top = 134
    Width = 152
    Height = 13
    Caption = '2. Change Reward Assignment:'
  end
  object Label5: TLabel
    Left = 170
    Top = 157
    Width = 119
    Height = 13
    Caption = 'This works only with fully'
  end
  object Label6: TLabel
    Left = 170
    Top = 176
    Width = 110
    Height = 13
    Caption = 'downloaded Blockchain'
  end
  object Label7: TLabel
    Left = 19
    Top = 65
    Width = 272
    Height = 13
    Caption = 'You have to do this ONCE or if you want to change pool:'
  end
  object Label8: TLabel
    Left = 19
    Top = 35
    Width = 112
    Height = 13
    Caption = 'of the plotting process!'
  end
  object Label9: TLabel
    Left = 19
    Top = 201
    Width = 103
    Height = 13
    Caption = '3. Save configuration'
  end
  object Button1: TButton
    Left = 365
    Top = 220
    Width = 102
    Height = 25
    Caption = 'Start Mining'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 365
    Top = 35
    Width = 102
    Height = 179
    ItemHeight = 13
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 26
    Top = 103
    Width = 132
    Height = 21
    AutoComplete = False
    TabOrder = 2
    Text = 'DevPool2'
    Items.Strings = (
      'Burst.Ninja'
      'DevPool2'
      'Cryptomining.Farm'
      'burst.mininghere.com'
      'burst.poolto.be'
      'pool.burstcoin.de')
  end
  object Button2: TButton
    Left = 26
    Top = 161
    Width = 132
    Height = 25
    Caption = 'Change'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 164
    Top = 153
    Width = 132
    Height = 80
    BorderWidth = 2
    TabOrder = 4
    object Label10: TLabel
      Left = 8
      Top = 42
      Width = 106
      Height = 13
      Caption = 'and you need 1 Burst '
    end
    object Label11: TLabel
      Left = 8
      Top = 61
      Width = 88
      Height = 13
      Caption = 'e.g. from a faucet'
    end
  end
  object Button3: TButton
    Left = 326
    Top = 8
    Width = 5
    Height = 248
    Default = True
    TabOrder = 5
  end
  object Button4: TButton
    Left = 26
    Top = 220
    Width = 132
    Height = 25
    Caption = 'Save changes'
    TabOrder = 6
  end
end
