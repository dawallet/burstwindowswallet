unit Unit12;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellApi;

type
  TForm12 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}
uses BurstWallet2, Unit7;

procedure TForm12.Button1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://sourceforge.net/projects/burstwindowswallet/', nil, nil, SW_SHOWNORMAL);
Close;
end;

procedure TForm12.Button2Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://github.com/dawallet/burstwindowswallet/releases/', nil, nil, SW_SHOWNORMAL);
Close;
end;

end.
