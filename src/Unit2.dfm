object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Plotter'
  ClientHeight = 250
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 120
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 210
    Top = 120
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Label2'
  end
  object Gauge1: TGauge
    Left = 24
    Top = 69
    Width = 217
    Height = 21
    Progress = 0
  end
  object Button1: TButton
    Left = 80
    Top = 200
    Width = 105
    Height = 25
    Caption = 'Plot this Drive'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DriveComboBox1: TDriveComboBox
    Left = 24
    Top = 26
    Width = 217
    Height = 19
    TabOrder = 1
    OnChange = DriveComboBox1Change
  end
  object Button2: TButton
    Left = 24
    Top = 160
    Width = 97
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 144
    Top = 160
    Width = 97
    Height = 25
    Caption = 'What are Plots?'
    TabOrder = 3
    OnClick = Button3Click
  end
end
