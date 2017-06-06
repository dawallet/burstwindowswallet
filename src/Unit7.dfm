object Form7: TForm7
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 5
  Caption = 'Shutting down...'
  ClientHeight = 56
  ClientWidth = 195
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
    Left = 28
    Top = 15
    Width = 145
    Height = 26
    Alignment = taCenter
    Caption = 'Shutting down Burst Wallet... This can take several minutes.'
    Layout = tlCenter
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 1
    Top = 0
    Width = 194
    Height = 54
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 65520
    Top = 48
  end
end
