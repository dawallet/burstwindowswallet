unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IOUtils, Vcl.Clipbrd, StrUtils, ShellApi, idHTTP,  IdBaseComponent,IdComponent;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Button3: TButton;
    Label9: TLabel;
    Button4: TButton;
    Label10: TLabel;
    Label11: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
  private
    { Private-Deklarationen }
    p: Textfile;
    pool : String;
  public
    { Public-Deklarationen }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}
uses BurstWallet2;

function IsDirectoryEmpty(const directory : string) : boolean;
 var
   searchRec :TSearchRec;
 begin
   try
    result := (FindFirst(directory+'\*.*', faAnyFile, searchRec) = 0) AND
              (FindNext(searchRec) = 0) AND
              (FindNext(searchRec) <> 0) ;
   finally
     FindClose(searchRec) ;
   end;
 end;

procedure TForm4.Button1Click(Sender: TObject);
 var
   t : TextFile;
   directories: String;
begin
if not ListBox1.Items.Count < 1 then
  if Label6.Caption = 'none - choose!' then
  Showmessage('You have to choose a pool first. Left side!')
  else

 begin
    directories:= ListBox1.Items.GetText;
    directories:= StringReplace(directories, '\', '\\', [rfReplaceAll, rfIgnoreCase]);

    directories:= StringReplace(directories, #13#10, '","', [rfReplaceAll, rfIgnoreCase]);
      delete(directories, length(directories), 1);
      delete(directories, length(directories), 1);
      delete(directories, length(directories), 1);

  begin
    AssignFile(t,'miner-burst-1.151009/miner.conf');
    Rewrite(T);
    Writeln(T,'{');
    Writeln(T,'"Mode" : "pool",');
    Writeln(T,'"Server" : "'+Label6.Caption+'",');
    Writeln(T,'"Port" : 8124,');
    Writeln(T,'"SendBestOnly" : true,');
    Writeln(T,'"SendInterval" : 200,');
    Writeln(T,'"TargetDeadline": 3000000,');
    Writeln(T,'"UseFastRcv" : false,');
    Writeln(T,'');
    Writeln(T,'"UpdaterAddr" : "'+Label6.Caption+'",');
    Writeln(T,'"UpdaterPort" : 8124,');
    Writeln(T,'"UpdateInterval" : 2000,');
    Writeln(T,'');
    Writeln(T,'"ShowWinner" : true,');
    Writeln(T,'"InfoAddr" : "'+Label6.Caption+'",');
    Writeln(T,'"InfoPort" : 8124,');
    Writeln(T,'');
    Writeln(T,'"EnableProxy" : false,');
    Writeln(T,'"ProxyPort" : 8126,');
    Writeln(T,'');
    Writeln(T,'"Paths":');
    Writeln(T,'[');
    Writeln(T,'        "'+directories+'"');
    Writeln(T,'],');
    Writeln(T,'"CacheSize" : 4000,');
    Writeln(T,'"UseSorting" : true,');
    Writeln(T,'"UseBoost" : false,');
    Writeln(T,'');
    Writeln(T,'"Debug" : true,');
    Writeln(T,'"UseLog" : true,');
    Writeln(T,'"ShowMsg" : false,');
   Writeln(T,'"ShowUpdates" : false');
      Writeln(T,'}');
    CloseFile(T);
  end;
ShellExecute(0, 'open', PChar('miner.exe'),PChar('/K'), PChar('miner-burst-1.151009'), SW_SHOW);
close;
 end
else
Showmessage('No plots found. You have to generate plots before mining! Or you have to put your Plots to: X:\Burst\plots or X:\plots\');

end;
procedure TForm4.Button2Click(Sender: TObject);
var
clipboard2: Tclipboard;
begin
Form1.Webbrowser1.Navigate('http://127.0.0.1:8125/rewardassignmentshort.html');
Form1.N7.Enabled := True;
clipboard2 := TClipBoard.create;
if Combobox1.Text = 'burst.ninja' then
    clipboard2.AsText:='BURST-7CPJ-BW8N-U4XF-CWW3U';
if  Combobox1.Text = 'pool.burstcoin.it' then
     clipboard2.AsText:='BURST-LGKU-3UUM-M6Q5-86SLK';
if  Combobox1.Text = 'burst.poolto.be' then
     clipboard2.AsText:='BURST-5AXK-EABZ-7FTB-4NBT9';
ShowMessage('The pool address '+clipboard.AsText+' of '+Combobox1.Text+' got copied into your clipboard.'+#13#10+ 'Paste it into the second textbox: "Recipient - Burst address of pool" and paste your wallet passphrase in the first textbox.');
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
 AssignFile(p,'miner-burst-1.151009/chosen_pool.txt');
   Rewrite(P);
   Writeln(P,Combobox1.Text);
   CloseFile(P);
Showmessage('Changes saved');

    pool:=TFile.ReadAllText('miner-burst-1.151009/chosen_pool.txt');
    pool:= StringReplace(pool, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
    Label6.Caption:=(pool);

end;

procedure TForm4.FormActivate(Sender: TObject);
var

character: Char;
begin
ListBox1.Items.Clear;
   For character:= 'Z' downto 'C' do
  if TDirectory.Exists(character+':\Burst\plots') then
  if not IsDirectoryEmpty(character+':\Burst\plots')
  then ListBox1.Items.Add(character+':\Burst\plots');
    if TDirectory.Exists(character+':\plots')   then
   if not IsDirectoryEmpty(character+':\plots')

  then ListBox1.Items.Add(character+':\plots');



    pool:=TFile.ReadAllText('miner-burst-1.151009/chosen_pool.txt');
    pool:= StringReplace(pool, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
  if pool = '' then
    else
    Label6.Caption:=(pool);

end;

procedure TForm4.FormHide(Sender: TObject);
begin
ListBox1.Items.Clear;
end;

procedure TForm4.Label11Click(Sender: TObject);
begin
ShellExecute(0, 'open', 'http://f.burstcoin.info', nil, nil, SW_SHOWNORMAL);
end;

end.
