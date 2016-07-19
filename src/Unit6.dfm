object Form6: TForm6
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Account Manager'
  ClientHeight = 388
  ClientWidth = 238
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 60
    Height = 13
    Caption = 'Load Wallet:'
  end
  object ListBox1: TListBox
    Left = 7
    Top = 27
    Width = 225
    Height = 353
    ItemHeight = 13
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    OnEnter = ListBox1Enter
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 45000
    OnTimer = Timer1Timer
    Left = 112
    Top = 200
  end
end
