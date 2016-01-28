object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Miner '
  ClientHeight = 266
  ClientWidth = 491
  Color = clBtnFace
  DefaultMonitor = dmMainForm
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
    Top = 88
    Width = 76
    Height = 13
    Caption = '1. Choose pool:'
  end
  object Label4: TLabel
    Left = 19
    Top = 138
    Width = 152
    Height = 13
    Caption = '2. Change Reward Assignment:'
  end
  object Label7: TLabel
    Left = 19
    Top = 69
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
  object Label5: TLabel
    Left = 365
    Top = 162
    Width = 27
    Height = 13
    Caption = 'Pool: '
  end
  object Label6: TLabel
    Left = 395
    Top = 162
    Width = 72
    Height = 13
    Caption = 'none - choose!'
  end
  object Label12: TLabel
    Left = 345
    Top = 243
    Width = 124
    Height = 13
    Alignment = taCenter
    Caption = 'beta: GPU assisted mining'
  end
  object Button1: TButton
    Left = 365
    Top = 181
    Width = 102
    Height = 25
    Hint = 'CPU assisted mining. Works always.'
    Caption = 'Start Mining'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 365
    Top = 35
    Width = 102
    Height = 126
    ItemHeight = 13
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 26
    Top = 107
    Width = 132
    Height = 21
    AutoComplete = False
    TabOrder = 2
    Items.Strings = (
      'burst.ninja'
      'pool.burstcoin.it'
      'burst.poolto.be'
      'mininghere.com')
  end
  object Button2: TButton
    Left = 26
    Top = 157
    Width = 132
    Height = 25
    Caption = 'Change'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 177
    Top = 153
    Width = 143
    Height = 80
    BorderWidth = 2
    TabOrder = 4
    object Label10: TLabel
      Left = 1
      Top = 0
      Width = 132
      Height = 52
      Caption = 
        'This works only with a fully downloaded blockchain and you need ' +
        'at least 1 Burst in your mining wallet'
      Layout = tlCenter
      WordWrap = True
    end
    object Label11: TLabel
      Left = 48
      Top = 61
      Width = 88
      Height = 13
      Caption = 'e.g. from a faucet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label11Click
    end
  end
  object Button3: TButton
    Left = 334
    Top = 8
    Width = 5
    Height = 251
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
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 365
    Top = 212
    Width = 102
    Height = 25
    Hint = 'GPU assisted mining with OpenCL'
    Caption = 'Start Mining (beta)'
    CommandLinkHint = 'GPU assisted mining with OpenCL'
    TabOrder = 7
    OnClick = Button5Click
  end
end
