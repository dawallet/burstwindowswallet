unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ovceditf, ovcedpop,
  ovcedsld, ovcdbsed, ovcbase, ovcslide, ovcdbsld, Vcl.ComCtrls, Types, IOUtils, ShellApi;

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
  private
    { Private-Deklarationen }

  public
    { Public-Deklarationen }
        ma: Textfile;
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
path: String;
parameters: String;
Memory: TMemoryStatus;
dirSize: Int64;
multiplier: Int64;

begin
//wplotgenerator [account id] [start nonce] [number of nonces] [stagger size] [threads]
   AssignFile(ma,'plotter/miningaddress.txt');
    Rewrite(MA);
    Writeln(MA,Textfield.Text);
    CloseFile(MA);

Memory.dwLength := SizeOf(Memory);
GlobalMemoryStatus(Memory);

//Showmessage(IntToStr(CharToNum(Form2.DriveComboBox1.Drive)-31));
multiplier:= (CharToNum(Form2.DriveComboBox1.Drive)-31)*100000000;

//ShowMessage('wplotgenerator' + ' ' + (Textfield.Text) + ' ' + '0' +' '+ IntToStr(((1024*1000) div 256) *(TrackBar1.Position)) + ' ' + IntToStr(Memory.dwTotalPhys div 1024 div 2048) + ' ' + IntToStr(TrackBar2.Position));
path:= (Form2.DriveComboBox1.Drive) + ':\Burst\';

_GetFolderSize(ExcludeTrailingPathDelimiter(path + 'plots\'), dirSize, false);
dirSize:= (dirSize div 1024 div 256)+1;
//Showmessage(IntToStr(dirSize));

parameters :='wplotgenerator.exe '+((Textfield.Text) + ' ' + IntToStr(dirSize + multiplier) +' '+ IntToStr(((1024*1024) div 256) *(TrackBar1.Position)) + ' ' + IntToStr((Memory.dwTotalPhys div 1024 div 512 div 8)*8) + ' ' + IntToStr(TrackBar2.Position));
ShellExecute(0, 'open', PChar('cmd.exe'),PChar('/K '+parameters), PChar(path), SW_SHOW);

close;
end;

procedure TForm3.FormActivate(Sender: TObject);

begin

Label1.Caption:= 'You have ' + IntToStr(Form2.FreeD) + ' GB free on the chosen Drive. How much you want to fill with Plots?';
Label2.Caption:= IntToStr(Form2.FreeD) + ' GB';
TrackBar1.Max:= Form2.FreeD;


    Textfield.Text:=(TFile.ReadAllText('plotter/miningaddress.txt'));

end;

procedure TForm3.FormCreate(Sender: TObject);
var
Memory: TMemoryStatus;
begin
Label4.Caption := 'Number of available CPU Cores: ' + IntToStr(System.CPUCount);
Label5.Caption := IntToStr(System.CPUCount) + ' Cores';
TrackBar2.Max := (System.CPUCount);

Memory.dwLength := SizeOf(Memory);
  GlobalMemoryStatus(Memory);

end;

end.
