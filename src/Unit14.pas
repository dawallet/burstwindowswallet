unit Unit14;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm14 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
   deviceID: String;
  end;

var
  Form14: TForm14;

implementation

{$R *.dfm}
 uses Unit4;

procedure TForm14.Button1Click(Sender: TObject);
begin
 deviceID:='0';



 Form4.Hide;
 Hide;
end;

procedure TForm14.Button2Click(Sender: TObject);
begin
 deviceID:='1';

 Form4.Hide;
 Hide;
end;

end.
