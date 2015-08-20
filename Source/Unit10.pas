unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm10 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure TForm10.Button2Click(Sender: TObject);
begin
Button2.Visible:= false;
Button3.Visible:= true;
Button1.Caption:='DONATE!';
end;

procedure TForm10.Button3Click(Sender: TObject);
begin
Button2.Visible:= true;
Button3.Visible:=false;
Button1.Caption:='Close';
end;

end.
