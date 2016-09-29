unit BurstWallet2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, TLHelp32, Vcl.Clipbrd, ShellAPI, Vcl.Menus,
  Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, idHTTP, IdBaseComponent,IdComponent,IOUtils,
  IdTCPConnection, IdTCPClient,IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
IdSSLOpenSSL, registry, JSON, DBXJSON;

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
    Network1: TMenuItem;
    N10Burstbyburstcoininfo1: TMenuItem;
    N5Burstburstteamus1: TMenuItem;
    N5Burstburstcoinpt1: TMenuItem;
    N2Burstburstcoinbiz1: TMenuItem;
    UpdateAvailable1: TMenuItem;
    Sourceforge1: TMenuItem;
    Github1: TMenuItem;
    Forums2: TMenuItem;
    DDLBlockchain1: TMenuItem;
    IRCChat1: TMenuItem;
    OnlineLocal1: TMenuItem;
    Alttechchat1: TMenuItem;
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
    procedure ToolButton5Click(Sender: TObject);
    procedure Network1Click(Sender: TObject);
    procedure N10Burstbyburstcoininfo1Click(Sender: TObject);
    procedure N5Burstburstteamus1Click(Sender: TObject);
    procedure N5Burstburstcoinpt1Click(Sender: TObject);
    procedure N2Burstburstcoinbiz1Click(Sender: TObject);
    procedure Sourceforge1Click(Sender: TObject);
    procedure Github1Click(Sender: TObject);
    procedure DDLBlockchain1Click(Sender: TObject);
    procedure Forums2Click(Sender: TObject);
    procedure OnlineLocal1Click(Sender: TObject);
    procedure IRCChat1Click(Sender: TObject);
    procedure Alttechchat1Click(Sender: TObject);



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






procedure TForm1.Alttechchat1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://alttech.chat/login', nil, nil, SW_SHOWNORMAL);
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

procedure TForm1.DDLBlockchain1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://db.burst-team.us', nil, nil, SW_SHOWNORMAL);
Showmessage('Unzip the Download in C:\Users\Username\Appdata\Roaming\BurstWallet\burst_db folder and restart the client.')
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
  IdHTTP2: TIdHTTP;
  IdHTTP3: TIdHTTP;
  totalcoins: String;
  totalcoinsInt: Integer;
  coinprice: String;
  coinpriceEx: real;
  amount: real;
  result: real;
  marketcap: String;
  check: String;
  dummy2: String;
  LJsonArr : TJSONArray;
  LJsonObj: TJSONObject;
  price_usd : TJSONValue;
  percent_change_24h : TJSONValue;
  market_cap_usd : TJSONValue;
  price_btc : TJSONValue;
  mydata : String;
  checkver: String;
  lStream: TFilestream;
  price_usd_clean: String;
  formatSettings: TFormatSettings;

begin
 WinExec('run_java_autodetect.bat', SW_HIDE);
 try
  try
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
        Showmessage('All online wallets are not available at the moment or you have no internet connection.');

        end;
      end;
      end;
      end;
        IdHTTP2.Free;
     end;

   except




  end;



     try
     IdHTTP2 := TIdHTTP.Create;
     //IdHTTP2.ReadTimeout := 30000;
  //  idHTTP2.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(idHTTP2);
   // idHTTP2.HandleRedirects := True;
      checkver:= idHTTP2.Get('https://mwallet.burst-team.us:8125/client/0.3.6.txt');
      UpdateAvailable1.Visible := true;
        IdHTTP2.Free;
     except
       //   Showmessage('no new version');
     end;


  try
   IdHTTP2.Create;
   LJsonArr := TJsonArray.Create;

  // mydata:= idHTTP2.Get('https://api.coinmarketcap.com/v1/ticker/burst/');
  mydata:= GetURLAsString('https://api.coinmarketcap.com/v1/ticker/burst/');
  //   Showmessage(mydata);

   LJsonArr := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mydata), 0) as TJSONArray;



  LJsonObj := LJsonArr.Get(0) as TJSONObject;
  price_usd := LJsonObj.GetValue('price_usd') as TJSONValue;
  price_btc := LJsonObj.GetValue('price_btc') as TJSONValue;
  percent_change_24h :=  LJsonObj.GetValue('percent_change_24h') as TJSONValue;
  market_cap_usd := LJsonObj.GetValue('market_cap_usd') as TJSONValue;

   // LJsonArr.Free;
     IdHTTP2.Free;
  except
   // Showmessage('Json error');
  end;





   try
    begin
     IdHTTP3 := TIdHTTP.Create;
     coinprice:= price_btc.ToString.Remove((price_btc.ToString.Length)-1);
     Delete(coinprice, 1,1);
   // coinprice := Copy(coinprice, 1, Pos(',', coinprice) - 1);

   //  Showmessage(coinprice);


       try
        begin
           // market cap
           marketcap:= market_cap_usd.ToString;
           marketcap := marketcap.Remove(marketcap.Length-3);
           Delete(marketcap, 1,1);
            case marketcap.Length of
             1, 2, 3, 4, 5: ;
             6: Insert(',', marketcap, 4) ;
             7: begin
                 Insert(',', marketcap, 2) ;
                  Insert(',', marketcap, 6) ;
                 end;
             8: begin
                Insert(',', marketcap, 3) ;
                Insert(',', marketcap, 8) ;
                end;
             9: begin
                 Insert(',', marketcap, 4) ;
                   Insert(',', marketcap, 10) ;
                 end;
              end
          end
          except
        //  Showmessage('Market Cap error')
        end;


       ToolButton6.Caption := ('$ '+marketcap);
       // coinprice
        ToolButton2.Caption := '฿ '+ coinprice;


         // 10.000 Burst info
        formatSettings.DecimalSeparator := '.';
        price_usd_clean := price_usd.ToString.Remove(price_usd.ToString.Length-2);
        Delete(price_usd_clean, 1,1);
         // Showmessage(price_usd_clean);
         result:= ((StrToFloat(price_usd_clean, formatSettings)) * 10000);
         // Showmessage(FloatToStr(result));
         price_usd_clean:= FloatToStrF((result), ffFixed, 15, 2);
         price_usd_clean  := StringReplace(price_usd_clean, ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);
         //ToolButton4.Caption := '$ '+(FloatToStrF((result), ffFixed, 15, 2)) ;
         ToolButton4.Caption := '$ '+ price_usd_clean;
         // Mining Wallet info
      try
       begin
       IdHTTP3.create;
       mining:=TFile.ReadAllText('plotter/miningaddress.txt');

        mining:= StringReplace(mining, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
        mining:= (idHTTP3.Get('https://mwallet.burst-team.us:8125/burst?requestType=rsConvert&account='+mining));
        Delete(mining, 1, 79);
        mining:= StringReplace((mining),'"}','',[rfReplaceAll]);
        mining:= StringReplace((mining),' ','',[rfReplaceAll]);
        mining:= StringReplace((mining),#13#10,'',[rfReplaceAll]);
        mining:= (idHTTP3.Get('https://mwallet.burst-team.us:8125/burst?requestType=getBalance&account='+mining));
        Delete(mining, 1, 26);
       begin
         mining := Copy(mining, 1, Pos(',', mining) - 10);
       end;

 //  Showmessage(mining);
       mining:=(mining+' BURST');
       mining:= StringReplace(mining, 'ount\" not s BURST', '0', [rfReplaceAll, rfIgnoreCase]);
       ToolButton15.Caption:=(mining);
        IdHTTP3.Free;

      end
        except
        //  Showmessage('Mining Wallet info exception')
      end;

    end

    except
      begin
      ToolButton1.Visible:=false;
      ToolButton2.Visible:=false;
      ToolButton3.Visible:=false;
      ToolButton4.Visible:=false;
      ToolButton5.Caption:='Market Information';
      ToolButton6.Visible:=false;
      ToolButton14.Visible:=false;
      ToolButton15.Visible:=false;
       //IdHTTP.Free;
       end;
   end;


except

  end;

end;





procedure TForm1.FormHide(Sender: TObject);
begin

  ShowWindow(Application.Handle, SW_HIDE);
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


procedure TForm1.HowToCrowdfund1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://forums.burst-team.us/topic/69/how-to-start-a-crowdfund-on-burst-quickstart-manual', nil, nil, SW_SHOWNORMAL);

end;


procedure TForm1.IRCChat1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://kiwiirc.com/client/irc.kiwiirc.com/##burst-coin', nil, nil, SW_SHOWNORMAL);

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

procedure TForm1.N5Burstburstcoinpt1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://faucet.burstcoin.pt', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.N5Burstburstteamus1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://faucet.burst-team.us', nil, nil, SW_SHOWNORMAL);
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
        Showmessage('All online wallets are down at the moment :( or you have no internet connection!');

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



procedure TForm1.Network1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://util.burst-team.us:8888', nil, nil, SW_SHOWNORMAL);
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

procedure TForm1.OnlineLocal1Click(Sender: TObject);
begin
Showmessage('The online and local wallet are showing the same if in sync.'+#13#10+'All data is saved distributed on the Blockchain. With the online wallet you do not need to download the whole Blockchain first.  '+#13#10+'As a disadvantage you rely on a third party. With the local wallet you are totally independent but it will show the real balances only if the Blockchain is fully downloaded.')
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  Show();
 WindowState := wsNormal;
 Application.BringToFront()
end;

procedure TForm1.Sourceforge1Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'https://sourceforge.net/projects/burstwindowswallet/', nil, nil, SW_SHOWNORMAL);

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var

    IdHTTP: TIdHTTP;
    IdHTTP2: TIdHTTP;
    IdHTTP3: TIdHTTP;
  totalcoins: String;
  totalcoinsInt: Integer;
  coinprice: String;
  coinpriceEx: real;
  amount: real;
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
  lStream: TFilestream;
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
      ToolButton14.Visible:=true;
      ToolButton15.Visible:=true;
  end;
     try
     IdHTTP2 := TIdHTTP.Create;
     //IdHTTP2.ReadTimeout := 30000;
  //  idHTTP2.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(idHTTP2);
   // idHTTP2.HandleRedirects := True;
      checkver:= idHTTP2.Get('https://mwallet.burst-team.us:8125/client/0.3.6.txt');
      UpdateAvailable1.Visible := true;
        IdHTTP2.Free;
     except
       //   Showmessage('no new version');
     end;


  try
   IdHTTP2.Create;
   LJsonArr := TJsonArray.Create;

  // mydata:= idHTTP2.Get('https://api.coinmarketcap.com/v1/ticker/burst/');
  mydata:= GetURLAsString('https://api.coinmarketcap.com/v1/ticker/burst/');
  //   Showmessage(mydata);

   LJsonArr := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(mydata), 0) as TJSONArray;



  LJsonObj := LJsonArr.Get(0) as TJSONObject;
  price_usd := LJsonObj.GetValue('price_usd') as TJSONValue;
  price_btc := LJsonObj.GetValue('price_btc') as TJSONValue;
  percent_change_24h :=  LJsonObj.GetValue('percent_change_24h') as TJSONValue;
  market_cap_usd := LJsonObj.GetValue('market_cap_usd') as TJSONValue;

   // LJsonArr.Free;
     IdHTTP2.Free;
  except
   // Showmessage('Json error');
  end;





   try
    begin
     IdHTTP3 := TIdHTTP.Create;
     coinprice:= price_btc.ToString.Remove((price_btc.ToString.Length)-1);
     Delete(coinprice, 1,1);
   // coinprice := Copy(coinprice, 1, Pos(',', coinprice) - 1);

   //  Showmessage(coinprice);


       try
        begin
           // market cap
           marketcap:= market_cap_usd.ToString;
           marketcap := marketcap.Remove(marketcap.Length-3);
           Delete(marketcap, 1,1);
            case marketcap.Length of
             1, 2, 3, 4, 5: ;
             6: Insert(',', marketcap, 4) ;
             7: begin
                 Insert(',', marketcap, 2) ;
                  Insert(',', marketcap, 6) ;
                 end;
             8: begin
                Insert(',', marketcap, 3) ;
                Insert(',', marketcap, 8) ;
                end;
             9: begin
                 Insert(',', marketcap, 4) ;
                   Insert(',', marketcap, 10) ;
                 end;
              end
          end
          except
        //  Showmessage('Market Cap error')
        end;


       ToolButton6.Caption := ('$ '+marketcap);
       // coinprice
        ToolButton2.Caption := '฿ '+ coinprice;


         // 10.000 Burst info
        formatSettings.DecimalSeparator := '.';
        price_usd_clean := price_usd.ToString.Remove(price_usd.ToString.Length-2);
        Delete(price_usd_clean, 1,1);
         // Showmessage(price_usd_clean);
         result:= ((StrToFloat(price_usd_clean, formatSettings)) * 10000);
         // Showmessage(FloatToStr(result));
         price_usd_clean:= FloatToStrF((result), ffFixed, 15, 2);
         price_usd_clean  := StringReplace(price_usd_clean, ',', '.',
                          [rfReplaceAll, rfIgnoreCase]);
         //ToolButton4.Caption := '$ '+(FloatToStrF((result), ffFixed, 15, 2)) ;
         ToolButton4.Caption := '$ '+ price_usd_clean;
         // Mining Wallet info
      try
       begin
       idHTTP3.create;
       mining:=TFile.ReadAllText('plotter/miningaddress.txt');

        mining:= StringReplace(mining, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
        mining:= (idHTTP3.Get('https://mwallet.burst-team.us:8125/burst?requestType=rsConvert&account='+mining));
        Delete(mining, 1, 79);
        mining:= StringReplace((mining),'"}','',[rfReplaceAll]);
        mining:= StringReplace((mining),' ','',[rfReplaceAll]);
        mining:= StringReplace((mining),#13#10,'',[rfReplaceAll]);
        mining:= (idHTTP3.Get('https://mwallet.burst-team.us:8125/burst?requestType=getBalance&account='+mining));
        Delete(mining, 1, 26);
       begin
         mining := Copy(mining, 1, Pos(',', mining) - 10);
       end;

 //  Showmessage(mining);
       mining:=(mining+' BURST');
       mining:= StringReplace(mining, 'ount\" not s BURST', '0', [rfReplaceAll, rfIgnoreCase]);
       ToolButton15.Caption:=(mining);
        IdHTTP3.Free;

      end
        except
        // Showmessage('Mining Wallet info exception')
      end;

    end

    except
      begin
      ToolButton1.Visible:=false;
      ToolButton2.Visible:=false;
      ToolButton3.Visible:=false;
      ToolButton4.Visible:=false;
      ToolButton5.Caption:='Market Information';
      ToolButton6.Visible:=false;
      ToolButton14.Visible:=false;
      ToolButton15.Visible:=false;
       //IdHTTP.Free;
       end;
   end;


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
