unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, TlHelp32;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses BurstWallet2;

function IsExeRunning(const AExeName: string): boolean;
var
  h: THandle;
  p: TProcessEntry32;
begin
  Result := False;

  p.dwSize := SizeOf(p);
  h := CreateToolHelp32Snapshot(TH32CS_SnapProcess, 0);
  try
    Process32First(h, p);
    repeat
      Result := AnsiUpperCase(AExeName) = AnsiUpperCase(p.szExeFile);
    until Result or (not Process32Next(h, p));
  finally
    CloseHandle(h);
  end;
end;

procedure TForm7.FormActivate(Sender: TObject);
begin
Timer1.Enabled := true;
end;

procedure TForm7.Timer1Timer(Sender: TObject);
begin
 if  IsExeRunning('javaw.exe')then
 else
 Form1.close;
end;

end.
