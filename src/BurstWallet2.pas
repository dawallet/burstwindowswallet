unit BurstWallet2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, TLHelp32, Vcl.Clipbrd, ShellAPI, Vcl.Menus, SHDocVw, Vcl.ComCtrls, Vcl.StdCtrls,
  idHTTP, IdBaseComponent,IdComponent,IOUtils, IdTCPConnection, IdTCPClient, IdSSLOpenSSL, JSON, WinInet, WinSvc, Vcl.OleCtrls, Vcl.ToolWin,
  SHDocVw_TLB;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    WalletManager1: TMenuItem;
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
    Forums1: TMenuItem;
    ToolButton12: TToolButton;
    Network1: TMenuItem;
    N10Burstbyburstcoininfo1: TMenuItem;
    N5Burstburstteamus1: TMenuItem;
    UpdateAvailable1: TMenuItem;
    Forums2: TMenuItem;
    DDLBlockchain1: TMenuItem;
    OnlineLocal1: TMenuItem;
    C1: TMenuItem;
    Timer2: TTimer;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    Timer4: TTimer;
    N2: TMenuItem;
    Timer3: TTimer;
    WebBrowser1: TWebBrowser;
    Network2: TMenuItem;
    BlockExplorer1: TMenuItem;
    Forums21: TMenuItem;
    BurstWiki1: TMenuItem;
    News1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    BlockExplorer31: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure AddWallet1Click(Sender: TObject);
    procedure LoadWallet1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure WmSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure HeaderControl1MouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure DeleteWallet1Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure Market1Click(Sender: TObject);
    procedure Lotteries1Click(Sender: TObject);
    procedure Crowdfunding2Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure N10Burstbyburstcoininfo1Click(Sender: TObject);
    procedure N5Burstburstteamus1Click(Sender: TObject);
    procedure N5Burstburstcoinpt1Click(Sender: TObject);
    procedure N2Burstburstcoinbiz1Click(Sender: TObject);
    procedure Github1Click(Sender: TObject);
    procedure Forums2Click(Sender: TObject);
    procedure OnlineLocal1Click(Sender: TObject);
    procedure Alttechchat1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure UpdateAvailable1Click(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure pingofburstbin1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Network2Click(Sender: TObject);
    procedure BlockExplorer1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure Forums21Click(Sender: TObject);
    procedure BurstWiki1Click(Sender: TObject);
    procedure News1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure BlockExplorer31Click(Sender: TObject);


  private
    { Private-Deklarationen }
  coinprice: String;
  result: real;
  marketcap: String;
  LJsonArr : TJSONArray;
  LJsonObj: TJSONObject;
  price_usd : TJSONValue;
  percent_change_24h : TJSONValue;
  market_cap_usd : TJSONValue;
  price_btc : TJSONValue;
  mydata : String;
  price_usd_clean: String;
  formatSettings: TFormatSettings;
  statestring: String;
  firstStart: String;
  MemoryJava: TMemoryStatusex;
  public
    { Public-Deklarationen }
    mining: String;
    ws: Textfile;
    fs: Textfile;
    allcore: Boolean;
    percentage: real;
    owallet1: String;
    owallet2: String;
    owallet3: String;
    owallet4: String;
  end;

var
  Form1: TForm1;

implementation
uses Unit5, Unit6, Unit2, Unit4, Unit3, Unit10, Unit11, Unit7, Unit12,
  Unit13;
{$R *.dfm}

procedure Delay( const msecs:integer);
var
FirstTickCount:longint;
begin
FirstTickCount:=GetTickCount;
repeat
Application.ProcessMessages;
until
((GetTickCount-FirstTickCount) >= Longint(msecs));
end;

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

function GetProcID(sProcName: String): Integer;
var
  hProcSnap: THandle;
  pe32: TProcessEntry32;
begin
  result := -1;
  hProcSnap := CreateToolHelp32SnapShot(TH32CS_SNAPPROCESS, 0);
  if hProcSnap = INVALID_HANDLE_VALUE then exit;

  pe32.dwSize := SizeOf(ProcessEntry32);

  { wenn es geklappt hat }
  if Process32First(hProcSnap, pe32) = true then
    { und los geht's: Prozess suchen}
    while Process32Next(hProcSnap, pe32) = true do
    begin
      if pos(sProcName, pe32.szExeFile) <> 0then
        result := pe32.th32ProcessID;
    end;
CloseHandle(hProcSnap);
end;

function GetURLAsString(aURL: string): string;
var
  lHTTP: TIdHTTP;
  lStream: TStringStream;
begin
  lHTTP := TIdHTTP.Create(nil);
  lStream := TStringStream.Create(Result);
  try
    lHTTP.Get(aURL, lStream);
    lStream.Position := 0;
    Result := lStream.ReadString(lStream.Size);
  finally
    FreeAndNil(lHTTP);
    FreeAndNil(lStream);
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


Function EnumWindowsCallback(WND: HWND; lParam: LPARAM): Boolean; StdCall;
Var
   PID:  Cardinal;
   Wait: Boolean;
Begin
     Result := True;
     If GetParent(WND) = 0 Then
        GetWindowThreadProcessID(WND, PID);
     If (lParam And (-1)) = -1 Then Begin
        Wait := True;
        lParam := (lParam And (Not (-1)));
     End Else
        Wait := False;
     If PID = lParam Then
        If Wait Then
           SendMessage(WND, WM_CLOSE, 0, 0)
        Else
           PostMessage(WND, WM_CLOSE, 0, 0);
End;

function DownloadFile2(
    const url: string;
    const destinationFileName: string): boolean;
var
  hInet: HINTERNET;
  hFile: HINTERNET;
  localFile: File;
  buffer: array[1..1024] of byte;
  bytesRead: DWORD;
begin
  result := False;
  hInet := InternetOpen(PChar(application.title),
    INTERNET_OPEN_TYPE_PRECONFIG,nil,nil,0);
  hFile := InternetOpenURL(hInet,PChar(url),nil,0,0,0);
  if Assigned(hFile) then
  begin
    AssignFile(localFile,destinationFileName);
    Rewrite(localFile,1);
    repeat
      InternetReadFile(hFile,@buffer,SizeOf(buffer),bytesRead);
      BlockWrite(localFile,buffer,bytesRead);
    until bytesRead = 0;
    CloseFile(localFile);
    result := true;
    InternetCloseHandle(hFile);
  end;
  InternetCloseHandle(hInet);
end;

procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;AWorkCountMax: Int64);
begin
 //// ProgressBar1.Max := AWorkCountMax;
  //ProgressBar1.Position := 0;
end;

procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  //ProgressBar1.Position := AWorkCount;
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  { Hide the window and set its state variable to wsMinimized. }
  Hide;
  WindowState := wsMinimized;

  TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.BlockExplorer1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://www.burstcoin.biz', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.BlockExplorer31Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://burstcoin.zone/wordpress/blockexplorer/', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.BurstWiki1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://burst.wiki', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
Form10.Show;
end;

procedure TForm1.AddWallet1Click(Sender: TObject);
begin
 Form5.Show;
end;

procedure TForm1.Alttechchat1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://alttech.chat/login', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.C1Click(Sender: TObject);
begin
Form11.Show;
end;

procedure TForm1.Close1Click(Sender: TObject);
var
  PID : String;
  TS : TextFile;
 begin
 Timer2.Enabled:=false;
   try

     PID := GetProcId('javaw.exe').ToString;
    // Showmessage(PID);
       AssignFile(ts,'3rd/close_softly.bat');
       Rewrite(TS);
      if isWin64 = true then
       Writeln(TS,'SendSignalCtrlC64 '+PID)
       else
       Writeln(TS,'SendSignalCtrlC '+PID);
       CloseFile(TS);
        ShellExecute(0, 'open', PChar('close_softly.bat'),PChar('/K'), PChar('3rd'), SW_HIDE);
     except
     Killtask('javaw.exe');
  end;
   clipboard := TClipBoard.create;
   clipboard.AsText :='';
   AssignFile(ws,'var/winstate');
   Rewrite(WS);
   begin
   if Self.WindowState = wsMaximized then
   Writeln(WS,'wsMaximized')
   else Writeln(WS,'wsNormal');
   end;
   CloseFile(WS);
  Form1.Hide;
  Form7.Show;
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
var
  PID : String;
  TS : TextFile;
 begin
 Timer2.Enabled:=false;
 try
        PID := GetProcId('javaw.exe').ToString;
        AssignFile(ts,'3rd/close_softly.bat');
        Rewrite(TS);
       if isWin64 = true then
        Writeln(TS,'SendSignalCtrlC64 '+PID)
       else
        Writeln(TS,'SendSignalCtrlC '+PID);
        CloseFile(TS);
        ShellExecute(0, 'open', PChar('close_softly.bat'),PChar('/K'), PChar('3rd'), SW_HIDE);
     except
     Killtask('javaw.exe');
 end;

clipboard := TClipBoard.create;
clipboard.AsText :='';
 AssignFile(ws,'var/winstate');
   Rewrite(WS);
   begin
   if Self.WindowState = wsMaximized then
       Writeln(WS,'wsMaximized')
   else Writeln(WS,'wsNormal');
   end;
   CloseFile(WS);
Form1.Hide;
Form7.Show;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
// ShowWindow(Application.Handle, SW_HIDE);
end;

procedure LoadOWallet;
  begin

 end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  begin
  owallet1 := TFile.ReadAllText('var/owallet1');
  owallet1 := StringReplace(owallet1, #13#10, '', [rfReplaceAll, rfIgnoreCase]);

  owallet2 := TFile.ReadAllText('var/owallet2');
  owallet2 := StringReplace(owallet2, #13#10, '', [rfReplaceAll, rfIgnoreCase]);

  owallet3 := TFile.ReadAllText('var/owallet3');
  owallet3 := StringReplace(owallet3, #13#10, '', [rfReplaceAll, rfIgnoreCase]);

  owallet4 := TFile.ReadAllText('var/owallet4');
  owallet4 := StringReplace(owallet4, #13#10, '', [rfReplaceAll, rfIgnoreCase]);

  try
     WebBrowser1.Navigate(owallet1);
     except
     Showmessage('Online wallets are not available at the moment. Use the your Local Wallet instead.');
  end;
  end;

  try
   LJsonArr := TJsonArray.Create;
   mydata:= GetURLAsString('https://api.coinmarketcap.com/v1/ticker/burst/');
   LJsonArr := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mydata), 0) as TJSONArray;
   LJsonObj := LJsonArr.Get(0) as TJSONObject;
   price_usd := LJsonObj.GetValue('price_usd') as TJSONValue;
   price_btc := LJsonObj.GetValue('price_btc') as TJSONValue;
   percent_change_24h :=  LJsonObj.GetValue('percent_change_24h') as TJSONValue;
   market_cap_usd := LJsonObj.GetValue('market_cap_usd') as TJSONValue;
  except
  end;

   try
    begin
     coinprice:= price_btc.ToString.Remove((price_btc.ToString.Length)-1);
     Delete(coinprice, 1,1);
       try
        begin
           // market cap
           marketcap:= market_cap_usd.ToString;
           marketcap := marketcap.Remove(marketcap.Length-3);
           Delete(marketcap, 1,1);
            case marketcap.Length of
             1, 2, 3, 4, 5: ;
             6: Insert('''', marketcap, 4) ;
             7: begin
                  Insert('''', marketcap, 2) ;
                  Insert('''', marketcap, 6) ;
                 end;
             8: begin
                 Insert('''', marketcap, 3) ;
                 Insert('''', marketcap, 7) ;
                end;
             9: begin
                 Insert('''', marketcap, 4) ;
                 Insert('''', marketcap, 8) ;
                 end;
            10: begin
                  Insert('''', marketcap, 2) ;
                  Insert('''', marketcap, 6) ;
                  Insert('''', marketcap, 10) ;
                 end;
              end
          end
          except
        //  Showmessage('Market Cap error')
        end;

       ToolButton6.Caption := ('$ '+marketcap);
       // coinprice
        ToolButton2.Caption := '฿ '+ coinprice;
        formatSettings.DecimalSeparator := '.';
        price_usd_clean := price_usd.ToString.Remove(price_usd.ToString.Length-2);
        Delete(price_usd_clean, 1,1);
         // Showmessage(price_usd_clean);
         result:= ((StrToFloat(price_usd_clean, formatSettings)) * 1000);
         // Showmessage(FloatToStr(result));
         price_usd_clean:= FloatToStrF((result), ffFixed, 15, 2);
         price_usd_clean  := StringReplace(price_usd_clean, ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);
         //ToolButton4.Caption := '$ '+(FloatToStrF((result), ffFixed, 15, 2)) ;
         ToolButton4.Caption := '$ '+ price_usd_clean;
      end;
    except
      begin
      ToolButton1.Visible:=false;
      ToolButton2.Visible:=false;
      ToolButton3.Visible:=false;
      ToolButton4.Visible:=false;
      ToolButton5.Caption:='Market Information';
      ToolButton6.Visible:=false;
       end;
   end;

   try
   begin
    firstStart := TFile.ReadAllText('var/firststart');
    firstStart := StringReplace(firstStart, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
    if firstStart = 'true' then
      begin
       AssignFile(fs,'var/firststart');
       Rewrite(FS);
       Writeln(FS,'false');
       CloseFile(FS);
       Timer3.Enabled:= true;
      end;
   end;
   except
   Showmessage('Something went wrong');
 end;
  MemoryJava.dwLength := SizeOf(MemoryJava);
  GlobalMemoryStatusEx(MemoryJava);

 try
  if firstStart ='false' then
 // Showmessage(IntToStr(MemoryJava.ullAvailPhys));
      if MemoryJava.ullAvailPhys > 1000000000 then
        WinExec('run_java_autodetect.bat', SW_HIDE)
        else
         begin
         Showmessage('Not enough free RAM to run the the Local Wallet. Use the Online Wallet instead.'+#13#10+'The Burst Client is fully functional without a running Local Wallet.');
         N7.Visible := false;
         end;
 finally
 end;
 WebBrowser1.Navigate(owallet1);
end;


procedure TForm1.FormHide(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 statestring := TFile.ReadAllText('var/winstate');
 statestring:= StringReplace(statestring, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
 begin
   if statestring = 'wsMaximized' then
    begin
     ShowWindowAsync(Handle, SW_MAXIMIZE);
    end
   else
  // ShowWindow(Handle, SW_NORMAL);
 end;
end;

procedure TForm1.Forums21Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://forums.getburst.net/', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.Forums2Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://forums.burst-team.us/category/5/help-support', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.Github1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://github.com/dawallet/burstwindowswallet/releases/', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.HeaderControl1MouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
   WebBrowser1.Navigate('https://wallet.burst-team.us');
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

procedure TForm1.N10Burstbyburstcoininfo1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://faucet.burstcoin.info', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.N2Burstburstcoinbiz1Click(Sender: TObject);
begin
 ShellExecute(0, 'open', 'http://burstcoin.biz/faucet', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
   ShellExecute(0, 'open', 'https://explore.burst.cryptoguru.org/tool/observe', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.N4Click(Sender: TObject);
begin
 ShellExecute(0, 'open', 'http://burstxd.com/blocks/', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.N5Burstburstcoinpt1Click(Sender: TObject);
begin
 ShellExecute(0, 'open', 'http://faucet.burstnation.com', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.N5Burstburstteamus1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://faucet.burst-team.us', nil, nil, SW_SHOWNORMAL);
end;
procedure TForm1.pingofburstbin1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://faucet.pingofburst.win', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.N6Click(Sender: TObject);
begin
 N7.Enabled := True;
 N6.Enabled := False;
 WebBrowser1.Navigate(owallet1);
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
Timer2.Enabled := true;
 except
  WebBrowser1.Navigate(GetCurrentDir+'\offline_2.html');
  N7.Enabled := True;
 end;
IdHTTP2.Free;

end;

procedure TForm1.Network2Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://www.burstcoin.cc', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.News1Click(Sender: TObject);
begin
 ShellExecute(0, 'open', 'https://faucet.burstcoin.info', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.OnlineLocal1Click(Sender: TObject);
begin
Showmessage('The online and local wallet are able to give you access to the same Accounts'+#13#10+'All data is saved distributed on the Blockchain. The online wallet is ready to use but  '+#13#10+'the disadvantage is that you rely on a third party. If it breaks you have to wait until it gets fixed.'+#13#10+'With a synced local wallet you are totally independent but it will show the real balances only if'+#13#10+'the Blockchain is fully downloaded.')
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  Show();
 WindowState := wsNormal;
 Application.BringToFront()
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
    IdHTTP2: TIdHTTP;
    coinprice: String;
    result: real;
    marketcap: String;
    LJsonArr : TJSONArray;
    LJsonObj: TJSONObject;
    price_usd : TJSONValue;
    percent_change_24h : TJSONValue;
    market_cap_usd : TJSONValue;
    price_btc : TJSONValue;
    mydata : String;
    checkver: String;
    price_usd_clean: String;
    formatSettings: TFormatSettings;

begin
 try
  begin
      ToolButton1.Visible:=true;
      ToolButton2.Visible:=true;
      ToolButton3.Visible:=true;
      ToolButton4.Visible:=true;
      ToolButton5.Caption:='Market Cap:';
      ToolButton6.Visible:=true;
  end;
     try
     IdHTTP2 := TIdHTTP.Create;
      checkver:= idHTTP2.Get('https://mwallet.burst-team.us:8125/client/0.3.10.txt');
      UpdateAvailable1.Visible := true;
      N2.Visible := true;
        IdHTTP2.Free;
     except
       //   Showmessage('no new version');
     end;


  try
   IdHTTP2.Create;
   LJsonArr := TJsonArray.Create;
   mydata:= GetURLAsString('https://api.coinmarketcap.com/v1/ticker/burst/');
  //   Showmessage(mydata);

  LJsonArr := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mydata), 0) as TJSONArray;
  LJsonObj := LJsonArr.Get(0) as TJSONObject;
  price_usd := LJsonObj.GetValue('price_usd') as TJSONValue;
  price_btc := LJsonObj.GetValue('price_btc') as TJSONValue;
  percent_change_24h :=  LJsonObj.GetValue('percent_change_24h') as TJSONValue;
  market_cap_usd := LJsonObj.GetValue('market_cap_usd') as TJSONValue;
  IdHTTP2.Free;
  except
   // Showmessage('Json error');
  end;

   try
    begin

     coinprice:= price_btc.ToString.Remove((price_btc.ToString.Length)-1);
     Delete(coinprice, 1,1);
       try
        begin
           // market cap
           marketcap:= market_cap_usd.ToString;
           marketcap := marketcap.Remove(marketcap.Length-3);
           Delete(marketcap, 1,1);
           case marketcap.Length of
               1, 2, 3, 4, 5: ;
             6: Insert('''', marketcap, 4) ;
             7: begin
                  Insert('''', marketcap, 2) ;
                  Insert('''', marketcap, 6) ;
                 end;
             8: begin
                 Insert('''', marketcap, 3) ;
                 Insert('''', marketcap, 7) ;
                end;
             9: begin
                 Insert('''', marketcap, 4) ;
                 Insert('''', marketcap, 8) ;
                 end;
            10: begin
                  Insert('''', marketcap, 2) ;
                  Insert('''', marketcap, 6) ;
                  Insert('''', marketcap, 10) ;
                 end;
           end
        end;
          except
        //  Showmessage('Market Cap error')
         end;


       ToolButton6.Caption := ('$ '+marketcap);
        ToolButton2.Caption := '฿ '+ coinprice;
        formatSettings.DecimalSeparator := '.';
        price_usd_clean := price_usd.ToString.Remove(price_usd.ToString.Length-2);
        Delete(price_usd_clean, 1,1);
         // Showmessage(price_usd_clean);
         result:= ((StrToFloat(price_usd_clean, formatSettings)) * 1000);
         // Showmessage(FloatToStr(result));
         price_usd_clean:= FloatToStrF((result), ffFixed, 15, 2);
         price_usd_clean  := StringReplace(price_usd_clean, ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);
         //ToolButton4.Caption := '$ '+(FloatToStrF((result), ffFixed, 15, 2)) ;
         ToolButton4.Caption := '$ '+ price_usd_clean;
         // Mining Wallet info
         end
    except
      begin
      ToolButton1.Visible:=false;
      ToolButton2.Visible:=false;
      ToolButton3.Visible:=false;
      ToolButton4.Visible:=false;
      ToolButton5.Caption:='Market Information';
      ToolButton6.Visible:=false;
       end;
   end;
   except
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  PID : String;
  closedPID: String;
  TS : TextFile;
 begin
 if allcore = false then
  begin
    if  percentage < 98 then
      try

       PID := GetProcId('javaw.exe').ToString;
    // Showmessage(PID);
       AssignFile(ts,'3rd/close_softly.bat');
       Rewrite(TS);
      if isWin64 = true then
       Writeln(TS,'SendSignalCtrlC64 '+PID)
       else
       Writeln(TS,'SendSignalCtrlC '+PID);
      CloseFile(TS);
      ShellExecute(0, 'open', PChar('close_softly.bat'),PChar('/K'), PChar('3rd'), SW_HIDE);
      except
      Killtask('javaw.exe');
      end;
closedPID := PID;
Timer2.Enabled:= false;
allcore := true;

while closedPID = PID do

 begin
  Sleep(5000);
 PID := GetProcId('javaw.exe').ToString;
 //Showmessage(PID);
 end;
 WinExec('run_java_autodetect_all_cpus.bat', SW_HIDE);
end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
Form13.Show;
Timer3.Enabled := false;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
var
BlockchainStatus : TJSONObject;
  currBlockHeight : TJSONValue;
  ownBlockHeight : TJSONValue;
  bcdata: String;
  percentageStr: String;
begin
  try
  BlockchainStatus := TJsonObject.Create;
  bcdata:= GetURLAsString('http://localhost:8125/burst?requestType=getBlockchainStatus');
  BlockchainStatus := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(bcdata), 0) as TJSONObject;
  currBlockHeight := BlockchainStatus.GetValue('lastBlockchainFeederHeight') as TJSONValue;
  ownBlockHeight := BlockchainStatus.GetValue('numberOfBlocks') as TJSONValue;
   if StrToInt(currBlockHeight.ToString) > 0 then
   begin
   try
   percentage := ((StrToFloat(ownBlockHeight.ToString) / StrToFloat(currBlockHeight.ToString))*100)+0.001;
   percentageStr := (FloatToStrF((percentage), ffFixed, 15, 2));
   percentageStr := StringReplace(percentageStr,',', '.',[rfReplaceAll, rfIgnoreCase]);
   ToolButton15.Caption := percentageStr +' %';

   except
   ToolButton15.Caption := 'N/A';
   end;
   ToolButton14.Visible := true;
   ToolButton15.Visible := true;
   ToolButton17.Visible := true;
  end
  except
 end;
end;
procedure TForm1.ToolButton10Click(Sender: TObject);
begin
if isWin64 = true then
begin
Form4.Show
end
else
Showmessage('Mining is not supported on a 32 bit system. Upgrade or use another PC.')
end;

procedure TForm1.ToolButton11Click(Sender: TObject);
begin
if isWin64 = true then
Form2.Show
else
Showmessage('Plotting is not supported on a 32 bit system. Use another computer.');
end;

procedure TForm1.ToolButton15Click(Sender: TObject);
begin
Timer2.Enabled:=true;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://burst.today/', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://burst.today', nil, nil, SW_SHOWNORMAL);
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

procedure TForm1.UpdateAvailable1Click(Sender: TObject);
begin
Form12.Show
end;
end.
