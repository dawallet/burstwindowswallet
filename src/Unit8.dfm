object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Direct Download and Repair'
  ClientHeight = 227
  ClientWidth = 256
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
    Left = 32
    Top = 56
    Width = 125
    Height = 13
    Caption = 'Size extracted Blockchain:'
  end
  object Label2: TLabel
    Left = 200
    Top = 56
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label3: TLabel
    Left = 32
    Top = 24
    Width = 150
    Height = 13
    Caption = 'Size of Downloaded Blockchain:'
  end
  object Label4: TLabel
    Left = 200
    Top = 24
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Button1: TButton
    Left = 66
    Top = 104
    Width = 127
    Height = 25
    Caption = 'Download and Extract'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 208
    Top = 192
  end
end
