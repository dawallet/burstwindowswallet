object Form12: TForm12
  Left = 0
  Top = 0
  Caption = 'Update'
  ClientHeight = 89
  ClientWidth = 348
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
    Left = 14
    Top = 11
    Width = 323
    Height = 39
    Caption = 
      'There is a newer version of the Burst Client for Windows availab' +
      'le! It is highly recommended to download the update from the ori' +
      'ginal source:   '
    WordWrap = True
  end
  object Label2: TLabel
    Left = 164
    Top = 58
    Width = 10
    Height = 13
    Caption = 'or'
  end
  object Button1: TButton
    Left = 79
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Sourceforge'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 183
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Github'
    TabOrder = 1
    OnClick = Button2Click
  end
end
