unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Clipbrd, Vcl.StdCtrls, IoUtils, System.Types, System.UITypes,
  Vcl.ExtCtrls;

type
  TForm6 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Timer1: TTimer;
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1Enter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }

  end;

var
  Form6: TForm6;
   clipboard: TClipboard;
  fileName: String;
   text2: tstringlist;
   pwString: String;
implementation

{$R *.dfm}
uses Unit5, BurstWallet2;

{$R *.Windows.fmx MSWINDOWS}

function HexToString(const aEncodedString: string): string;
var
  Bufsize: Integer;
begin
  Bufsize := Length(aEncodedString) div 2;
  SetLength(Result, Bufsize div sizeof(char));
  HexToBin(PChar(aEncodedString), Pointer(result), Bufsize);
end;

function EnDeCrypt(const Value : String) : String;
var
 CharIndex : integer;
 begin
 Result := Value;
 for CharIndex := 1 to Length(Value) do
   Result[CharIndex] := chr(not(ord(Value[CharIndex]) + CharIndex ));
 end;


procedure GetFilesInDirectory(ADirectory: string; AMask: String; AList: TStrings; ARekursiv: Boolean);
var
  SR: TSearchRec;
begin
  if (ADirectory<>'') and (ADirectory[length(ADirectory)]<>'\') then
    ADirectory:=ADirectory+'\';

  if (FindFirst(ADirectory+AMask,faAnyFile-faDirectory,SR)=0) then begin
    repeat
      if (SR.Name<>'.') and (SR.Name<>'..') and (SR.Attr<>faDirectory) then
          AList.Add(ADirectory+SR.Name)
    until FindNext(SR)<>0;
    FindClose(SR);
  end;

  if ARekursiv then
    if (FindFirst(ADirectory+'*.*',faDirectory,SR)=0) then
    begin
      repeat
        if (SR.Name<>'.') and (SR.Name<>'..') then
          GetFilesInDirectory(ADirectory+SR.Name,AMask,AList,True);
      until FindNext(SR)<>0;
      FindClose(SR);
    end;
end;






procedure TForm6.FormActivate(Sender: TObject);
begin
                  Listbox1.Items.Clear;
 GetFilesInDirectory('','*.txt',Listbox1.Items,False);
end;

procedure TForm6.ListBox1DblClick(Sender: TObject);
begin
text2 := tstringlist.Create;
clipboard := TClipBoard.create;
fileName := ListBox1.Items[ListBox1.ItemIndex];
clipboard.AsText := HexToString(EnDeCrypt(TFile.ReadAllText(fileName)));

Showmessage('Passphrase of ' + ListBox1.Items[ListBox1.ItemIndex] + ' is now for 30 seconds in your clipboard! Use Right-Click -> Paste');
Timer1.Enabled:=true;
hide;
end;

procedure TForm6.ListBox1Enter(Sender: TObject);
begin
                  Listbox1.Items.Clear;
 GetFilesInDirectory('','*.txt',Listbox1.Items,False);
end;

procedure TForm6.Timer1Timer(Sender: TObject);
begin

clipboard.Clear;
Timer1.Enabled:=false;
end;

end.

