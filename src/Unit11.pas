unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TlHelp32, System.UITypes;

type
  TForm11 = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}
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


procedure DeleteDir(const DirName: string);
var
  Path: string;
  F: TSearchRec;

begin
  Path:= DirName + '\*.*';
  if FindFirst(Path, faAnyFile, F) = 0 then begin
    try
      repeat
        if (F.Attr and faDirectory <> 0) then begin
          if (F.Name <> '.') and (F.Name <> '..') then begin
            DeleteDir(DirName + '\' + F.Name);
          end;
        end
        else
          DeleteFile(DirName + '\' + F.Name);
      until FindNext(F) <> 0;
    finally
      FindClose(F);
    end;
  end;
  RemoveDir(DirName);
end;




procedure TForm11.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
if MessageDlg('Are you sure that you want to delete and resync the Blockchain from genesis block?', mtConfirmation, [mbyes, mbcancel], 0) = mrYes then
 begin
Killtask('javaw.exe');
Sleep(600);
DeleteDir('burst_db');
Sleep(1000);
WinExec('run_java_autodetect.bat', SW_HIDE);
Label2.Visible:=true;
Button2.Caption:='Close';

end;

end;

end.
