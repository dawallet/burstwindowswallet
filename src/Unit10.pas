unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, ShellApi,
  Vcl.StdCtrls;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
begin
close;
end;



procedure TForm10.Label4Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://www.burstnation.com', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm10.Label6Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://github.com/burst-team/burstcoin/releases/', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm10.Label9Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://www.burstnation.com/filebase/', nil, nil, SW_SHOWNORMAL);
end;


end.
