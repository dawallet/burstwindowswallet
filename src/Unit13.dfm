object Form13: TForm13
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 220
  ClientWidth = 344
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 17
    Top = 44
    Width = 288
    Height = 32
    Caption = 
      'With this all-in-one suite you can create your own Burst Wallet,' +
      ' plot your drive and mine your plots! '
    WordWrap = True
  end
  object Label2: TLabel
    Left = 56
    Top = 8
    Width = 239
    Height = 19
    Caption = 'Welcome to the Burst Client! '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 17
    Top = 87
    Width = 291
    Height = 48
    Caption = 
      'Important: The Client is fully functional even without a fully s' +
      'ynchronized local wallet! You don'#39't have to wait. '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 17
    Top = 146
    Width = 294
    Height = 16
    Caption = 'Do you still want to speed up the local wallet sync? '
  end
  object Button1: TButton
    Left = 161
    Top = 176
    Width = 169
    Height = 25
    Caption = 'No, sync in the background'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 17
    Top = 176
    Width = 121
    Height = 25
    Caption = 'Yes, use all cores'
    TabOrder = 1
    OnClick = Button2Click
  end
end
