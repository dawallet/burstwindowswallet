object Form12: TForm12
  Left = 0
  Top = 0
  Caption = 'Update'
  ClientHeight = 118
  ClientWidth = 391
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
    Width = 363
    Height = 26
    Caption = 
      'We recommend to upgrade to the new All-In-One Solution named QBu' +
      'ndle. It offers new features, higher security and continuous dev' +
      'elopement. '
    WordWrap = True
  end
  object Label2: TLabel
    Left = 40
    Top = 66
    Width = 215
    Height = 13
    Caption = 'https://github.com/PoC-Consortium/Qbundle'
  end
  object Button2: TButton
    Left = 279
    Top = 59
    Width = 75
    Height = 25
    Caption = 'Open Github'
    TabOrder = 0
    OnClick = Button2Click
  end
end
