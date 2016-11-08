unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, WinInet, System.Zip,
  Vcl.ComCtrls, ExtActns, Vcl.ExtCtrls;

type
  TForm8 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Timer1: TTimer;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);


  private
    { Private-Deklarationen }

  public
    Progress, ProgressMax: Cardinal;
    StatusCode: TURLDownloadStatus;
    StatusText: String; var Cancel: Boolean;
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}
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


function DownloadFile(const url: string; const destinationFileName: string):
boolean;
var
hInet: HINTERNET;
hFile: HINTERNET;
localFile: file;
buffer: array[1..65535] of Byte;
bytesRead: DWORD;
b: boolean;
begin
b := False;
hInet := WinInet.InternetOpen('MyFile', INTERNET_OPEN_TYPE_DIRECT, nil,
nil, 0);
if Assigned(hInet) then
begin
hFile := InternetOpenURL(hInet, PWideChar(url), nil, 0,
INTERNET_FLAG_PRAGMA_NOCACHE, 0);
if Assigned(hFile) then
begin
AssignFile(localFile, destinationFileName);
Rewrite(localFile, 1);
bytesRead := 0;
repeat
InternetReadFile(hFile, @buffer, SizeOf(buffer), bytesRead);
BlockWrite(localFile, buffer, bytesRead);
until bytesRead = 0;
CloseFile(localFile);
InternetCloseHandle(hFile);
end;
InternetCloseHandle(hInet);
b := true;
end;
DownloadFile := b;
end;


procedure URL_OnDownloadProgress;

begin
//ProgressBar1.Max:= ProgressMax;
//ProgressBar1.Position:= Progress;
end;


procedure TForm8.Button1Click(Sender: TObject);
begin
Application.ProcessMessages;
DownloadFile('http://db.burst-team.us','db.zip');
    sleep(1000);
    application.processmessages;

//OnDownloadProgress := URL_OnDownloadProgress;
{if TZipFile.IsValid('db.zip') = true then
 begin
   Showmessage('Good Zip file, trying to extract now...');
       TZipFile.ExtractZipFile('db.zip','burst_db/');

 end
 else
    Showmessage('Something went wrong haitch');

      }
end;

procedure TForm8.Timer1Timer(Sender: TObject);
var dirSize: Int64;
dirSize2: Int64;
begin
_GetFolderSize(ExcludeTrailingPathDelimiter(GetCurrentDir +'\burst_db'), dirSize, false);
_GetFolderSize(ExcludeTrailingPathDelimiter(GetCurrentDir +'\'), dirSize2, false);
dirSize := dirSize div 1024 div 1024 ;
dirSize2 := dirSize2 div 1024 div 1024 ;
Label2.Caption := IntToStr(dirSize);
Label4.Caption := IntToStr(dirSize2);
end;

end.
