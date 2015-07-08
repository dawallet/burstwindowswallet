unit BurstWallet2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, TLHelp32, Vcl.Clipbrd, ShellAPI, Vcl.Menus,
  Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls, Vcl.ToolWin;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    MainMenu1: TMainMenu;
    WalletManager1: TMenuItem;
    Crowdfunding1: TMenuItem;
    Lotteries1: TMenuItem;
    About1: TMenuItem;
    AddWallet1: TMenuItem;
    LoadWallet1: TMenuItem;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    Open1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Lotteries1Click(Sender: TObject);
    procedure Crowdfunding1Click(Sender: TObject);
    procedure AddWallet1Click(Sender: TObject);
    procedure Home1Click(Sender: TObject);
    procedure LoadWallet1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure WmSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure HeaderControl1MouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation
uses Unit5, Unit6;
{$R *.dfm}

procedure TForm1.WmSysCommand(var Msg: TWMSysCommand);
begin
  if msg.CmdType = SC_CLOSE then
     begin
     hide;
     ShowWindow(Application.Handle, SW_HIDE);
     end
  else
    inherited;
end;

function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  { Hide the window and set its state variable to wsMinimized. }
  Hide;
  WindowState := wsMinimized;

  TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
ShowMessage('Burst Windows Wallet version 0.1.5 for Windows by daWallet' +#13#10+ 'Using Official Online Wallet: https://wallet.burst.city by Crowetic and Catbref');
end;

procedure TForm1.AddWallet1Click(Sender: TObject);
begin
 Form5.Show;
end;







procedure TForm1.Close1Click(Sender: TObject);
begin
Killtask('javaw.exe');
clipboard := TClipBoard.create;
clipboard.AsText :='';
close;
end;

procedure TForm1.Crowdfunding1Click(Sender: TObject);
begin
   WebBrowser1.Navigate('http://127.0.0.1:8125/atcrowdfund.html');
    N7.Enabled := True;
 N6.Enabled := True;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
// ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Webbrowser1.Navigate('https://wallet.burst.city');
WinExec('run_java_autodetect.bat', SW_HIDE);
//CreateProcess(nil, 'java -jar "c:\program files\my java app\test.jar"', nil, nil, False, 0, nil, nil, StartupInfo,
//ProcessInfo);


end;

procedure TForm1.FormHide(Sender: TObject);
begin

  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.HeaderControl1MouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
   WebBrowser1.Navigate('https://wallet.burst.city');
end;

procedure TForm1.Home1Click(Sender: TObject);
begin

WebBrowser1.Navigate('https://wallet.burst.city');
  N6.Enabled:=false;
  N7.Enabled:=true;
end;

procedure TForm1.LoadWallet1Click(Sender: TObject);
begin
                    Form6.Show;
end;

procedure TForm1.Lotteries1Click(Sender: TObject);
begin
     WebBrowser1.Navigate('http://127.0.0.1:8125/atlotteries.html');
         N7.Enabled := True;
          N6.Enabled := True;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  WebBrowser1.Navigate('https://wallet.burst.city');
  N6.Enabled:=false;
  N7.Enabled:=true;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
 WebBrowser1.Navigate('http://127.0.0.1:8125');
 N7.Enabled := False;
 N6.Enabled := True;
end;



procedure TForm1.Open1Click(Sender: TObject);
begin
  Show();
 WindowState := wsNormal;
 Application.BringToFront()
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);

begin
 // Pos := TSmallPoint(GetMessagePos()); // position when input message generated

  // see http://support.microsoft.com/kb/135788

 // TrayIcon1.Visible := true;
 Show();
 WindowState := wsNormal;
 Application.BringToFront()
end;

procedure TForm1.TrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

end.
