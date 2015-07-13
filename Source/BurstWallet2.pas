unit BurstWallet2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, TLHelp32, Vcl.Clipbrd, ShellAPI, Vcl.Menus,
  Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, idHTTP, IdBaseComponent,IdComponent,
  IdTCPConnection, IdTCPClient;

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
    local1: TMenuItem;
    Online1: TMenuItem;
    Local2: TMenuItem;
    Online2: TMenuItem;
    Timer1: TTimer;
    DeleteWallet1: TMenuItem;
    Exit1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure AddWallet1Click(Sender: TObject);
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
    procedure local1Click(Sender: TObject);
    procedure Online1Click(Sender: TObject);
    procedure Local2Click(Sender: TObject);
    procedure Online2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure DeleteWallet1Click(Sender: TObject);

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
ShowMessage('Burst Windows Wallet version 0.1.6 by daWallet' +#13#10+ 'You want to buy me a beer?  BURST-YZJ6-LYBY-WAC6-BQYGC' +#13#10+ #13#10+ 'Using Official Online Wallet: https://wallet.burst.city by Crowetic and Catbref'  +#13#10+ 'Special thanks to Irontiga');
end;

procedure TForm1.AddWallet1Click(Sender: TObject);
begin
 Form5.Show;
end;


function IsWebSiteUP( AURL: String): Boolean;
var
  HTTP: TidHTTP;
  Restlt: Boolean;
begin
  Result := True;
  HTTP := TidHTTP.Create(nil);
  try
    HTTP.Get( AURL);
    // See the table below for standard HTTP response
    // codes.
    // Modify this case statement to handle the others
    // that you want to catch.
    case HTTP.ResponseCode of
    400..505:
      begin
        Restlt := False;
      end;
    end; {case}
  finally
    HTTP.Free;

end;
end;




procedure TForm1.Close1Click(Sender: TObject);
begin
Killtask('javaw.exe');
clipboard := TClipBoard.create;
clipboard.AsText :='';
close;
end;

procedure TForm1.DeleteWallet1Click(Sender: TObject);
begin
     hide;
     ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
Killtask('javaw.exe');
clipboard := TClipBoard.create;
clipboard.AsText :='';
close;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
// ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  IdHTTP: TIdHTTP;
  marketcap: Single;
  marketcapString: String;
  amount: Single;
  result: Single;
begin
Webbrowser1.Navigate('https://wallet.burst.city');
WinExec('run_java_autodetect.bat', SW_HIDE);
//CreateProcess(nil, 'java -jar "c:\program files\my java app\test.jar"', nil, nil, False, 0, nil, nil, StartupInfo,
//ProcessInfo);

IdHTTP := TIdHTTP.Create;

   ToolButton6.Caption := ('$ ' + StringReplace(idHTTP.Get('http://www.burstcoin.fr/api/?r=market_cap&e=average'), ' ', '.',[rfReplaceAll]));
   ToolButton2.Caption := (idHTTP.Get('http://www.burstcoin.fr/api/?r=last_price&e=average')+' ฿' );
   marketcapString:= (idHTTP.Get('http://www.burstcoin.fr/api/?r=market_cap&e=average'));
   marketcapString:= StringReplace(marketcapString, ' ', '',[rfReplaceAll]);
   marketcap := StrToFloat(marketcapString);

   amount:= StrToFloat(idHTTP.Get('http://www.burstcoin.fr/api/?r=total_coins&e=average'));
   result:= ((marketcap / amount) * 1000);
   ToolButton4.Caption := (FloatToStrF(result, ffFixed, 15, 2)) +' $';
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


procedure TForm1.LoadWallet1Click(Sender: TObject);
begin
                    Form6.Show;
end;

procedure TForm1.local1Click(Sender: TObject);
begin
      WebBrowser1.Navigate('http://127.0.0.1:8125/atcrowdfund.html');
    N7.Enabled := true;
    N6.Enabled := True;
end;

procedure TForm1.Local2Click(Sender: TObject);
begin
             WebBrowser1.Navigate('http://127.0.0.1:8125/atlotteries.html');
         N7.Enabled := True;
          N6.Enabled := True;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  WebBrowser1.Navigate('https://wallet.burst.city');
  N6.Enabled:=False;
  N7.Enabled:=True;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
 WebBrowser1.Navigate('http://127.0.0.1:8125');
 N7.Enabled := False;
 N6.Enabled := True;
end;



procedure TForm1.Online1Click(Sender: TObject);
begin
           WebBrowser1.Navigate('https://wallet.burst.city/atcrowdfund.html');
    N7.Enabled := True;
 N6.Enabled := True;
end;

procedure TForm1.Online2Click(Sender: TObject);
begin
      WebBrowser1.Navigate('https://wallet.burst.city/atlotteries.html');
         N7.Enabled := True;
          N6.Enabled := True;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  Show();
 WindowState := wsNormal;
 Application.BringToFront()
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var          IdHTTP: TIdHTTP;
               marketcap: Single;
  marketcapString: String;
  amount: Single;
  result: Single;
begin

   IdHTTP := TIdHTTP.Create;

   ToolButton6.Caption := ('$ ' + StringReplace(idHTTP.Get('http://www.burstcoin.fr/api/?r=market_cap&e=average'), ' ', '.',[rfReplaceAll]));
   ToolButton2.Caption := (idHTTP.Get('http://www.burstcoin.fr/api/?r=last_price&e=average')+' ฿' );
   marketcapString:= (idHTTP.Get('http://www.burstcoin.fr/api/?r=market_cap&e=average'));
   marketcapString:= StringReplace(marketcapString, ' ', '',[rfReplaceAll]);
   marketcap := StrToFloat(marketcapString);

   amount:= StrToFloat(idHTTP.Get('http://www.burstcoin.fr/api/?r=total_coins&e=average'));
   result:= ((marketcap / amount) * 1000);
   ToolButton4.Caption := (FloatToStrF(result, ffFixed, 15, 2)) +' $';
end;


procedure TForm1.TrayIcon1Click(Sender: TObject);

begin

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
