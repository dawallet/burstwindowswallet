object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Miner '
  ClientHeight = 173
  ClientWidth = 532
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
    Left = 257
    Top = 9
    Width = 60
    Height = 13
    Caption = 'Found Plots:'
  end
  object Label3: TLabel
    Left = 352
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Choose pool:'
  end
  object Label4: TLabel
    Left = 18
    Top = 74
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
    Left = 359
    Top = 57
    Width = 27
    Height = 13
    Caption = 'Pool: '
  end
  object Label6: TLabel
    Left = 392
    Top = 57
    Width = 72
    Height = 13
    Caption = 'none - choose!'
  end
  object Label11: TLabel
    Left = 18
    Top = 118
    Width = 214
    Height = 26
    Caption = 
      'To change the reward assignment you need at least 1 Burstcoin e.' +
      'g. from a faucet.'
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
    Left = 436
    Top = 118
    Width = 10
    Height = 13
    Caption = 'or'
  end
  object Label8: TLabel
    Left = 482
    Top = 31
    Width = 4
    Height = 13
    Caption = ':'
  end
  object Label9: TLabel
    Left = 97
    Top = 182
    Width = 344
    Height = 13
    Caption = 
      'Beware: For Solo Mining your passphrase has to be saved in plain' +
      'text:  '
  end
  object Label10: TLabel
    Left = 122
    Top = 228
    Width = 293
    Height = 26
    Alignment = taCenter
    Caption = 
      'Do not forget to change reward assignment back to yourself if yo' +
      'u were pool mining before! '
    WordWrap = True
  end
  object Button1: TButton
    Left = 355
    Top = 91
    Width = 166
    Height = 25
    Hint = 'CPU assisted mining. Works always.'
    Caption = 'Start Mining (CPU / AVX)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 257
    Top = 28
    Width = 85
    Height = 133
    Enabled = False
    ExtendedSelect = False
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 352
    Top = 28
    Width = 129
    Height = 21
    AutoComplete = False
    TabOrder = 2
    OnChange = ComboBox1Change
    Items.Strings = (
      'poolofd32th.club'
      'pool.burstcoin.space'
      'pool.burstcoin.party'
      'burst.lexitoshi.uk'
      'burstneon.ddns.net'
      'pool.burstcoin.sk'
      'pool.burstcoin.ml'
      'burst.btfg.space'
      'burstpool.ddns.net'
      'pool.burstmining.club'
      'pool.burstcoinmining.com'
      'pool.burstcoin.eu'
      'pool.burstcoin.biz'
      'pool.burst-team.us'
      'pool.ccminer.net'
      'burst.poolto.be'
      '127.0.0.1')
  end
  object Button2: TButton
    Left = 163
    Top = 69
    Width = 60
    Height = 25
    Caption = 'Change'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 241
    Top = -8
    Width = 4
    Height = 177
    Default = True
    TabOrder = 4
  end
  object Button5: TButton
    Left = 356
    Top = 137
    Width = 165
    Height = 25
    Hint = 'GPU assisted mining with OpenCL'
    Caption = 'Start Mining (OpenCL)'
    CommandLinkHint = 'GPU assisted mining with OpenCL'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Edit1: TEdit
    Left = 487
    Top = 28
    Width = 34
    Height = 21
    TabOrder = 6
    Text = '8124'
  end
  object Edit2: TEdit
    Left = 97
    Top = 201
    Width = 276
    Height = 21
    TabOrder = 7
  end
  object Button4: TButton
    Left = 379
    Top = 199
    Width = 69
    Height = 25
    Caption = 'Save'
    TabOrder = 8
    OnClick = Button4Click
  end
end
