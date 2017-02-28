object Form7: TForm7
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 5
  Caption = 'Shutting down...'
  ClientHeight = 60
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 142
    Height = 13
    Caption = 'Shutting down Burst Wallet...'
  end
  object Panel1: TPanel
    Left = 0
    Top = 2
    Width = 201
    Height = 57
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 160
    Top = 16
  end
end
