object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Miner '
  ClientHeight = 166
  ClientWidth = 512
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
  object Label2: TLabel
    Left = 276
    Top = 9
    Width = 60
    Height = 13
    Caption = 'Found Plots:'
  end
  object Label3: TLabel
    Left = 388
    Top = 9
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
    Width = 205
    Height = 26
    Caption = 'You have to do this one-time or when you want to change pool:'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 388
    Top = 52
    Width = 27
    Height = 13
    Caption = 'Pool: '
  end
  object Label6: TLabel
    Left = 418
    Top = 52
    Width = 72
    Height = 13
    Caption = 'none - choose!'
  end
  object Label12: TLabel
    Left = 276
    Top = 144
    Width = 214
    Height = 24
    Alignment = taCenter
    Caption = 'beta: GPU assisted mining (OpenCL needed)'
    Layout = tlCenter
    WordWrap = True
  end
  object Label11: TLabel
    Left = 18
    Top = 123
    Width = 205
    Height = 27
    Caption = 
      'For changing reward assignment you need at least 1 Burst e.g. fr' +
      'om a faucet'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    WordWrap = True
    OnClick = Label11Click
  end
  object Button1: TButton
    Left = 388
    Top = 71
    Width = 102
    Height = 25
    Hint = 'CPU assisted mining. Works always.'
    Caption = 'Start Mining'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 276
    Top = 28
    Width = 85
    Height = 99
    ItemHeight = 13
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 388
    Top = 25
    Width = 102
    Height = 21
    AutoComplete = False
    TabOrder = 2
    OnChange = ComboBox1Change
    Items.Strings = (
      'burst.ninja'
      'pool.burstcoin.it'
      'burst.poolto.be'
      'mininghere.com')
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
    Left = 388
    Top = 102
    Width = 102
    Height = 25
    Hint = 'GPU assisted mining with OpenCL'
    Caption = 'Start Mining (beta)'
    CommandLinkHint = 'GPU assisted mining with OpenCL'
    TabOrder = 5
    OnClick = Button5Click
  end
end
