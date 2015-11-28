unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes, Vcl.ComCtrls, Types, IOUtils, ShellApi,idHTTP;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Label7: TLabel;
    Textfield: TEdit;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
  private
    { Private-Deklarationen }

  public
    { Public-Deklarationen }
        ma: Textfile;
        gen: Textfile;
  end;
 // wplotgenerator 1 0 9600 1920 %NUMBER_OF_PROCESSORS%
var
  Form3: TForm3;

implementation

{$R *.dfm}
uses Unit2;

function CharToNum(Ch: Char): Integer;
  asm
          SUB     AL,65
  end;

procedure _GetFolderSize(const path: string; var Sz: int64; Recurse: boolean);
var
SR : TSearchRec;
res : integer;
n : int64;
begin
res := FindFirst(path +'\*.*', faAnyFile, SR);
if res = 0 then
try
while res = 0 do begin
if (SR.Name <> '.') and (SR.Name <> '..') then begin
if ((SR.Attr and faDirectory) = faDirectory) then begin
if Recurse then
_GetFolderSize(path +'\' +SR.Name, Sz, true);
end else begin
n := SR.FindData.nFileSizeHigh;
n := (n shl (4 *sizeof(n))) or SR.FindData.nFileSizeLow;
Inc(Sz, n);
end;
end;

res := FindNext(SR);
end;
finally
FindClose(SR);
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


procedure CopyFilesToPath(aFiles: array of string; DestPath: string);
var
  InFile, OutFile: string;
begin
  for InFile in aFiles do
  begin
    OutFile := TPath.Combine( DestPath, TPath.GetFileName( InFile ) );
    TFile.Copy( InFile, OutFile, True);
  end;
end;

function GetSystemMem: string;  { Returns installed RAM (as viewed by your OS) in GB, with 2 decimals }
VAR MS_Ex : MemoryStatusEx;
begin
 FillChar (MS_Ex, SizeOf(MemoryStatusEx), #0);
 MS_Ex.dwLength := SizeOf(MemoryStatusEx);
 GlobalMemoryStatusEx (MS_Ex);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
Form2.Show;
Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
var
idHTTP: TIdHTTP;
addressstring: String;
path: String;
parameters: String;
pocParameters: String;
Memory: TMemoryStatusex;
dirSize: Int64;
multiplier: Int64;
BatContent: TStringList;

begin
//wplotgenerator [account id] [start nonce] [number of nonces] [stagger size] [threads]

IdHTTP := TIdHTTP.Create;
  try
   begin
      addressstring:= (idHTTP.Get('http://localhost:8125/burst?requestType=rsConvert&account='+Textfield.Text));

    Delete(addressstring, 1, 79);
    addressstring:= StringReplace((addressstring),'"}','',[rfReplaceAll]);
    addressstring:= StringReplace((addressstring),' ','',[rfReplaceAll]);
    addressstring:= StringReplace((addressstring),#13#10,'',[rfReplaceAll]);
    //Showmessage(addressstring)
    end;
   except
   Showmessage('Wallet Server not started!');
    end;

  begin
  IdHTTP.Free;



   AssignFile(ma,'plotter/miningaddress.txt');
   Rewrite(MA);
   Writeln(MA,Textfield.Text);
   CloseFile(MA);

    Memory.dwLength := SizeOf(Memory);
    GlobalMemoryStatusEx(Memory);

//Showmessage(IntToStr(CharToNum(Form2.DriveComboBox1.Drive)-31));
multiplier:= (CharToNum(Form2.DriveComboBox1.Drive)-31)*100000000;

//ShowMessage('wplotgenerator' + ' ' + (Textfield.Text) + ' ' + '0' +' '+ IntToStr(((1024*1000) div 256) *(TrackBar1.Position)) + ' ' + IntToStr(Memory.dwTotalPhys div 1024 div 2048) + ' ' + IntToStr(TrackBar2.Position));
path:= (Form2.DriveComboBox1.Drive) + ':\Burst\';

_GetFolderSize(ExcludeTrailingPathDelimiter(path + 'plots\'), dirSize, false);
dirSize:= (dirSize div 1024 div 256)+1;
//Showmessage(IntToStr(dirSize));

pocParameters :='run_generate.bat '+((addressstring) + ' ' + IntToStr(dirSize + multiplier) +' '+ IntToStr(((1024*1024) div 256) *(TrackBar1.Position)) + ' ' + IntToStr((((Memory.ullTotalPhys div 1024 div 1024 div 10)*8)div 64)*64) + ' ' + IntToStr(TrackBar2.Position));
parameters :='wplotgenerator.exe '+((addressstring) + ' ' + IntToStr(dirSize + multiplier) +' '+ IntToStr(((1024*1024) div 256) *(TrackBar1.Position)) + ' ' + IntToStr((Memory.ullAvailPhys div 1024 div 512 div 64)*64) + ' ' + IntToStr(TrackBar2.Position));

if addressstring = '' then
   Showmessage('Your Burst Account is not activated, mistyped or does not exist.')
else
    begin

    if isWin64 = true then
    begin
    ShellExecute(0, 'open', PChar('cmd.exe'),PChar('/K '+parameters), PChar(path), SW_SHOW);
     end
      else
     begin
    Showmessage('You use a 32 bit system! For you theres only the original java plotter available which is slower. Never mind.');

    BatContent:=TStringList.Create;
    BatContent.Add('java -Xmx'+IntToStr(Memory.ullTotalPhys div 800 div 4096)+'m -cp pocminer.jar;lib/*;lib/akka/*;lib/jetty/* pocminer.POCMiner generate %*');
    BatContent.SaveToFile(path+'/run_generate.bat');
    BatContent.Free;

    ShellExecute(0, 'open', PChar('cmd.exe'),PChar('/K '+pocParameters), PChar(path), SW_SHOW);
     end;

    //Showmessage(parameters);
    close;
    end



  end;

end;

procedure TForm3.FormActivate(Sender: TObject);
var
address: String;

begin

Label1.Caption:= 'You have ' + IntToStr(Form2.FreeD) + ' GB free on the chosen Drive. You want to fill 1GB with Plots?';
Label2.Caption:= IntToStr(Form2.FreeD-1) + ' GB';
TrackBar1.Max:= Form2.FreeD-1;
TrackBar2.Position:= System.CPUCount;

    address:=TFile.ReadAllText('plotter/miningaddress.txt');
    address:= StringReplace(address, #13#10, '', [rfReplaceAll, rfIgnoreCase]);
    Textfield.Text:=(address);

end;

procedure TForm3.FormCreate(Sender: TObject);
var
  Memory: TMemoryStatus;
begin
  Label4.Caption := 'Number of CPUs you want to use:';
  Label5.Caption := IntToStr(System.CPUCount) + ' Cores';
  TrackBar2.Max := (System.CPUCount);

  Memory.dwLength := SizeOf(Memory);
  GlobalMemoryStatus(Memory);

end;

procedure TForm3.TrackBar1Change(Sender: TObject);
begin
Label1.Caption:= 'You have ' + IntToStr(Form2.FreeD) + ' GB free on the chosen Drive. You want to fill ' + IntToStr(TrackBar1.Position) + ' GB with Plots?';
end;

procedure TForm3.TrackBar2Change(Sender: TObject);
begin
Label4.Caption:= 'How many CPU cores you want to use?  You chose: '+IntToStr(TrackBar2.Position);
end;

end.
