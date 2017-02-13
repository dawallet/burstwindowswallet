object Form11: TForm11
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Clean up DB'
  ClientHeight = 130
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 266
    Height = 52
    Caption = 
      'Sometimes the local Wallet does not start because of a corrupted' +
      ' DB. Click the Button below to delete the Database (DB / Blockch' +
      'ain) and restart the local Wallet for you automatically. '
    WordWrap = True
  end
  object Label2: TLabel
    Left = 246
    Top = 113
    Width = 25
    Height = 13
    Caption = 'Done'
    Visible = False
  end
  object Button2: TButton
    Left = 55
    Top = 89
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 171
    Top = 89
    Width = 75
    Height = 25
    Caption = 'Clean DB'
    TabOrder = 1
    OnClick = Button3Click
  end
end
