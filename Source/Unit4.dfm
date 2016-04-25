object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Miner '
  ClientHeight = 181
  ClientWidth = 535
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
  OnCreate = FormCreate
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 276
    Top = 9
    Width = 60
    Height = 13
    Caption = 'Found Plots:'
  end
  object Label3: TLabel
    Left = 395
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Choose pool:'
  end
  object Label4: TLabel
    Left = 18
    Top = 71
    Width = 139
    Height = 13
    Caption = 'Change Reward Assignment:'
  end
  object Label7: TLabel
    Left = 18
    Top = 20
    Width = 204
    Height = 26
    Caption = 'You have to do this one-time or when you want to change pool:'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 395
    Top = 51
    Width = 27
    Height = 13
    Caption = 'Pool: '
  end
  object Label6: TLabel
    Left = 425
    Top = 51
    Width = 72
    Height = 13
    Caption = 'none - choose!'
  end
  object Label11: TLabel
    Left = 19
    Top = 107
    Width = 204
    Height = 39
    Caption = 
      'For changing reward assignment you need at least 1 Burst e.g. fr' +
      'om a faucet and a fully synchronized blockchain.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    WordWrap = True
    OnClick = Label11Click
  end
  object Label1: TLabel
    Left = 517
    Top = 79
    Width = 10
    Height = 13
    Caption = 'or'
  end
  object Label8: TLabel
    Left = 517
    Top = 110
    Width = 10
    Height = 13
    Caption = 'or'
  end
  object Button1: TButton
    Left = 395
    Top = 74
    Width = 116
    Height = 25
    Hint = 'CPU assisted mining. Works always.'
    Caption = 'Start Mining (default)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 276
    Top = 28
    Width = 85
    Height = 133
    ItemHeight = 13
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 395
    Top = 24
    Width = 116
    Height = 21
    AutoComplete = False
    TabOrder = 2
    OnChange = ComboBox1Change
    Items.Strings = (
      'pool.burst-team.us'
      'burst.poolto.be'
      'us-burstpool.broke-it.net'
      'pool.burstcoin.de'
      'pool.burstcoin.it'
      'mininghere.com'
      'burst.ninja')
  end
  object Button2: TButton
    Left = 163
    Top = 65
    Width = 60
    Height = 25
    Caption = 'Change'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 248
    Top = 0
    Width = 4
    Height = 169
    Default = True
    TabOrder = 4
  end
  object Button5: TButton
    Left = 395
    Top = 136
    Width = 116
    Height = 25
    Hint = 'GPU assisted mining with OpenCL'
    Caption = 'Start Mining (OpenCL)'
    CommandLinkHint = 'GPU assisted mining with OpenCL'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button4: TButton
    Left = 395
    Top = 105
    Width = 116
    Height = 25
    Caption = 'Start Mining (AVX)'
    TabOrder = 6
    OnClick = Button4Click
  end
end
