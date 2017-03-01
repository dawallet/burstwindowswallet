object Form14: TForm14
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Choose your device'
  ClientHeight = 88
  ClientWidth = 320
  Color = clBtnFace
  DefaultMonitor = dmMainForm
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
    Left = 17
    Top = 12
    Width = 295
    Height = 13
    Caption = 'Try out both options and find out which works better for you:'
  end
  object Button1: TButton
    Left = 60
    Top = 44
    Width = 75
    Height = 25
    Caption = 'Device 1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 185
    Top = 44
    Width = 75
    Height = 25
    Caption = 'Device 2'
    TabOrder = 1
    OnClick = Button2Click
  end
end
