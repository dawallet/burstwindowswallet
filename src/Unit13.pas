unit Unit13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm13 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

uses BurstWallet2;

procedure TForm13.Button1Click(Sender: TObject);
begin
WinExec('run_java_autodetect.bat', SW_HIDE);
Hide;
end;

procedure TForm13.Button2Click(Sender: TObject);
begin
  WinExec('run_java_autodetect_all_cpus.bat', SW_HIDE);
  Hide;
end;

end.
