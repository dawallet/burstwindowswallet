object Form11: TForm11
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Clean up DB'
  ClientHeight = 118
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 331
    Height = 39
    Caption = 
      'Sometimes the local Wallet does not start because of a corrupted' +
      ' DB. Click the Button below to delete some or all Blocks of the ' +
      'Database (DB / Blockchain). Clean DB restarts the local Wallet f' +
      'or you automatically. '
    WordWrap = True
  end
  object Label2: TLabel
    Left = 213
    Top = 104
    Width = 25
    Height = 13
    Caption = 'Done'
    Visible = False
  end
  object Label4: TLabel
    Left = 117
    Top = 79
    Width = 23
    Height = 13
    Caption = 'or'
  end
  object Button2: TButton
    Left = 246
    Top = 73
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 140
    Top = 73
    Width = 75
    Height = 25
    Caption = 'Clean DB'
    TabOrder = 1
    OnClick = Button3Click
  end
  object Button1: TButton
    Left = 30
    Top = 73
    Width = 75
    Height = 25
    Caption = 'PopOff'
    TabOrder = 2
    OnClick = Button1Click
  end
end
