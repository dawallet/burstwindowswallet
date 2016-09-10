unit BurstWallet2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, TLHelp32, Vcl.Clipbrd, ShellAPI, Vcl.Menus,
  Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, idHTTP, IdBaseComponent,IdComponent,IOUtils,
  IdTCPConnection, IdTCPClient, registry, JSON;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    MainMenu1: TMainMenu;
    WalletManager1: TMenuItem;
    Crowdfunding1: TMenuItem;
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
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    Faucets1: TMenuItem;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    HowToCrowdfund1: TMenuItem;
    Crowdfunding2: TMenuItem;
    Forums1: TMenuItem;
    ToolButton12: TToolButton;
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
    procedure Online1Click(Sender: TObject);
    procedure Online2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure DeleteWallet1Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure burstfaucetcom1Click(Sender: TObject);
    procedure Market1Click(Sender: TObject);
    procedure Lotteries1Click(Sender: TObject);
    procedure Crowdfunding2Click(Sender: TObject);
    procedure HowToCrowdfund1Click(Sender: TObject);
    procedure Faucets1Click(Sender: TObject);
    procedure Forums1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);



  private
    { Private-Deklarationen }

  public
    { Public-Deklarationen }
     mining: String;
  end;

var
  Form1: TForm1;




implementation
uses Unit5, Unit6, Unit2, Unit4, Unit3, Unit9, Unit10;
{$R *.dfm}

//todo  Click on footer - change currency, caption and so on
// expert mode

function IsWin64: Boolean;
var
  IsWow64Process : function(hProcess : THandle; var Wow64Process : BOOL): BOOL; stdcall;
  Wow64Process : BOOL;
begin
  Result := False;
  IsWow64Process := GetProcAddress(GetModuleHandle(Kernel32), 'IsWow64Process');
  if Assigned(IsWow64Process) then begin
    if IsWow64Process(GetCurrentProcess, Wow64Process) then begin
      Result := Wow64Process;
    end;
  end;
end;

function ExtractNumberInString( sChaine: String ): String ;
var
i: Integer ;
begin
Result := '' ;
for i := 1 to length( sChaine ) do
begin
if sChaine[ i ] in ['0'..'9'] then
Result := Result + sChaine[ i ] ;
end ;
end ;

function ParseJsonStr(jStr, jPar1, jPar2: String): String;
var
  jObj: TJSONObject;
  jVal: TJSONValue;
begin
  Result:= '';
  jObj := TJSONObject.ParseJSONValue(jStr) as TJSONObject;
  try
    jVal:= jObj.Get(jPar1).JsonValue;
    Result:= TJSONObject(jVal).Get(jPar2).JsonValue.Value;
  finally
    jObj.Free;
  end;
end;


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


procedure TForm1.burstfaucetcom1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://www.burstfaucet.com', nil, nil, SW_SHOWNORMAL);

end;

procedure TForm1.About1Click(Sender: TObject);
begin
Form10.Show;
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

procedure TForm1.Crowdfunding2Click(Sender: TObject);
begin
      WebBrowser1.Navigate('http://127.0.0.1:8125/atcrowdfund.html');
    N7.Enabled := true;
    N6.Enabled := True;
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

procedure TForm1.Faucets1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://faucet.burst-team.us', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
// ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  IdHTTP: TIdHTTP;
  totalcoins: String;
  totalcoinsInt: Integer;
  coinprice: String;
  coinpriceEx: real;
  amount: real;
  result: real;
  marketcap: String;
  check: String;
  dummy2: String;
  IdHTTP2: TIdHTTP;

begin
IdHTTP2 := TIdHTTP.Create;
 N7.Enabled := True;
 N6.Enabled := False;
try
 dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8125/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
 WebBrowser1.Navigate('https://wallet.burst-team.us:8125');
 except
  try
    dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8126/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
    WebBrowser1.Navigate('https://wallet.burst-team.us:8126');
  except
    try
     dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8127/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
     WebBrowser1.Navigate('https://wallet.burst-team.us:8127');
    except
      try
      dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8128/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
      WebBrowser1.Navigate('https://wallet.burst-team.us:8128');
      except
        try
        dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8128/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
        WebBrowser1.Navigate('https://wallet.burst-team.us:8128');
        except
        Showmessage('All online wallets are down at the moment :( or you have no internet connection.');

        end;
      end;
      end;
  end;

 end;
IdHTTP2.Free;

//WebBrowser1.Navigate('file:///'+GetCurrentDir+'/offline_1.html');
WinExec('run_java_autodetect.bat', SW_HIDE);

IdHTTP := TIdHTTP.Create;

  try
  begin
    coinprice:= (idHTTP.Get('https://api.coinmarketcap.com/v1/ticker/burst/'));
    Delete(coinprice, 1, 127);
    coinprice := Copy(coinprice, 1, Pos(',', coinprice) - 1);

    //Showmessage(coinprice);

    totalcoins:= (idHTTP.Get('https://www.cryptocompare.com/api/data/coinsnapshot/?fsym=BURST&tsym=USD'));
    Delete(totalcoins, 1, 183);
    totalcoins := Copy(totalcoins, 1, Pos('.', totalcoins) - 1);

  //  Showmessage(totalcoins);
    totalcoinsInt := StrToInt(totalcoins);

    coinprice:= StringReplace(coinprice, '.', ',',[rfReplaceAll]);
    coinpriceEx:= StrToFloat(coinprice);

   // market cap
    marketcap:= FloatToStrF((coinpriceEx * totalcoinsInt), ffFixed, 15, 0);
    Insert(' ', marketcap, 4);
    ToolButton6.Caption := ('$ '+marketcap);
   // coinprice
    ToolButton2.Caption := '$ '+(coinprice);
    //฿

   // 10.000 Burst info
   result:= ((StrToFloat(coinprice)) * 10000);
   //Showmessage(FloatToStr(result));
   ToolButton4.Caption := '$ '+(FloatToStrF((result), ffFixed, 15, 2)) ;

   // Mining Wallet info

    mining:=TFile.ReadAllText('plotter/miningaddress.txt');

    mining:= StringReplace(mining, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
    mining:= (idHTTP.Get('https://mwallet.burst-team.us:8125/burst?requestType=rsConvert&account='+mining));
    Delete(mining, 1, 79);
    mining:= StringReplace((mining),'"}','',[rfReplaceAll]);
    mining:= StringReplace((mining),' ','',[rfReplaceAll]);
    mining:= StringReplace((mining),#13#10,'',[rfReplaceAll]);
    mining:= (idHTTP.Get('https://mwallet.burst-team.us:8125/burst?requestType=getBalance&account='+mining));
    Delete(mining, 1, 26);
       begin
         mining := Copy(mining, 1, Pos(',', mining) - 10);
       end;

 //  Showmessage(mining);
   mining:=(mining+' BURST');
   mining:= StringReplace(mining, 'ount\" not s BURST', '0', [rfReplaceAll, rfIgnoreCase]);
   ToolButton15.Caption:=(mining);
  end;
   except
      ToolButton1.Visible:=false;
      ToolButton2.Visible:=false;
      ToolButton3.Visible:=false;
      ToolButton4.Visible:=false;
      ToolButton5.Caption:='Market Information';
      ToolButton6.Visible:=false;
      ToolButton14.Visible:=false;
      ToolButton15.Visible:=false;
  end;

  IdHTTP.Free;

end;

procedure TForm1.FormHide(Sender: TObject);
begin

  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.Forums1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://forums.burst-team.us/category/5/help-support', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.HeaderControl1MouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
   WebBrowser1.Navigate('https://wallet.burst-team.us');
end;


procedure TForm1.HowToCrowdfund1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://forums.burst-team.us/topic/69/how-to-start-a-crowdfund-on-burst-quickstart-manual', nil, nil, SW_SHOWNORMAL);

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

procedure TForm1.Market1Click(Sender: TObject);
begin
    WebBrowser1.Navigate('http://burstcoin.info/market/');
end;

procedure TForm1.N6Click(Sender: TObject);
var
dummy2: String;
IdHTTP2: TIdHTTP;
begin
IdHTTP2 := TIdHTTP.Create;
 N7.Enabled := True;
 N6.Enabled := False;
 try
 dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8125/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
 WebBrowser1.Navigate('https://wallet.burst-team.us:8125');
 except
  try
    dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8126/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
    WebBrowser1.Navigate('https://wallet.burst-team.us:8126');
  except
    try
     dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8127/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
     WebBrowser1.Navigate('https://wallet.burst-team.us:8127');
    except
      try
      dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8128/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
      WebBrowser1.Navigate('https://wallet.burst-team.us:8128');
      except
        try
        dummy2:= (idHTTP2.Get('https://wallet.burst-team.us:8128/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
        WebBrowser1.Navigate('https://wallet.burst-team.us:8128');
        except
        Showmessage('All online wallets are down at the moment :(');

        end;
      end;
      end;
  end;

 end;
IdHTTP2.Free;
end;


procedure TForm1.N7Click(Sender: TObject);
var
dummy: String;
IdHTTP2: TIdHTTP;
begin
IdHTTP2 := TIdHTTP.Create;
 N7.Enabled := False;
 N6.Enabled := True;
 try
dummy:= (idHTTP2.Get('http://127.0.0.1:8125/burst?requestType=rsConvert&account=BURST-QHCJ-9HB5-PTGC-5Q8J9'));
WebBrowser1.Navigate('http://127.0.0.1:8125');
 except

  WebBrowser1.Navigate('file:///'+GetCurrentDir+'/offline_2.html');
  N7.Enabled := True;
 end;
IdHTTP2.Free;

end;



procedure TForm1.Online1Click(Sender: TObject);
begin
           WebBrowser1.Navigate('https://wallet.burst-team.us/atcrowdfund.html');
    N7.Enabled := True;
 N6.Enabled := True;
end;

procedure TForm1.Online2Click(Sender: TObject);
begin
      WebBrowser1.Navigate('https://wallet.burst-team.us/atlotteries.html');
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
var
    IdHTTP: TIdHTTP;
  totalcoins: String;
  totalcoinsInt: Integer;
  coinprice: String;
  coinpriceEx: real;
  amount: real;
  result: real;
  marketcap: String;

begin

    IdHTTP := TIdHTTP.Create;
try
  try
  begin
    coinprice:= (idHTTP.Get('https://api.coinmarketcap.com/v1/ticker/burst/'));
    Delete(coinprice, 1, 127);
    coinprice := Copy(coinprice, 1, Pos(',', coinprice) - 1);

   // Showmessage(coinprice);

    totalcoins:= (idHTTP.Get('https://www.cryptocompare.com/api/data/coinsnapshot/?fsym=BURST&tsym=USD'));
    Delete(totalcoins, 1, 183);
    totalcoins := Copy(totalcoins, 1, Pos('.', totalcoins) - 1);

   // Showmessage(totalcoins);
    totalcoinsInt := StrToInt(totalcoins);

    coinprice:= StringReplace(coinprice, '.', ',',[rfReplaceAll]);
    coinpriceEx:= StrToFloat(coinprice);

   // market cap
    marketcap:= FloatToStrF((coinpriceEx * totalcoinsInt), ffFixed, 15, 0);
    Insert(' ', marketcap, 4);
    ToolButton6.Caption := ('$ '+marketcap);
   // coinprice
    ToolButton2.Caption := '$ '+(coinprice);
    //฿

   // 10.000 Burst info
   result:= ((StrToFloat(coinprice)) * 10000);
   //Showmessage(FloatToStr(result));
   ToolButton4.Caption := '$ '+(FloatToStrF((result), ffFixed, 15, 2)) ;

   // Mining Wallet info

    mining:=TFile.ReadAllText('plotter/miningaddress.txt');

    mining:= StringReplace(mining, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
    mining:= (idHTTP.Get('https://mwallet.burst-team.us:8125/burst?requestType=rsConvert&account='+mining));
    Delete(mining, 1, 79);
    mining:= StringReplace((mining),'"}','',[rfReplaceAll]);
    mining:= StringReplace((mining),' ','',[rfReplaceAll]);
    mining:= StringReplace((mining),#13#10,'',[rfReplaceAll]);
    mining:= (idHTTP.Get('https://mwallet.burst-team.us:8125/burst?requestType=getBalance&account='+mining));
    Delete(mining, 1, 26);
       begin
         mining := Copy(mining, 1, Pos(',', mining) - 10);
       end;

   //Showmessage(mining);
   mining:=(mining+' BURST');
    mining:= StringReplace(mining, 'ount\" not s BURST', '0', [rfReplaceAll, rfIgnoreCase]);
   ToolButton15.Caption:=(mining);
  end;
   except
      ToolButton1.Visible:=false;
      ToolButton2.Visible:=false;
      ToolButton3.Visible:=false;
      ToolButton4.Visible:=false;
      ToolButton5.Caption:='Market Information';
      ToolButton6.Visible:=false;
      ToolButton14.Visible:=false;
      ToolButton15.Visible:=false;
  end;
finally
  IdHTTP.Free;
end;
end;






procedure TForm1.ToolButton10Click(Sender: TObject);
begin
if isWin64 = true then
begin
Form4.Show
end
else
Form9.Show;

end;



procedure TForm1.ToolButton11Click(Sender: TObject);
begin
Form2.Show;
//Form2.DriveComboBox1.Update;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://coinmarketcap.com/currencies/burst/', nil, nil, SW_SHOWNORMAL);
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
     // PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

end.
