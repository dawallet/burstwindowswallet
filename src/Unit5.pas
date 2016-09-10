unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IoUtils, System.Types, System.UITypes;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
     SaveStringToFile: String;
  end;

var
  Form5: TForm5;
  PassString: String;
  LoadString: String;
  NameString: String;
  SaveString: String;
  AnString: AnsiString;



implementation

{$R *.dfm}
function StringToHex(const aString: String): string;
var
  BufSize: Integer;
begin
  BufSize := Length(aString)*Sizeof(Char);
  SetLength(Result, BufSize*2);
  BinToHex(Pointer(aString), PChar(result),Bufsize);
end;

function EnDeCrypt(const Value : String) : String;
var
 CharIndex : integer;
 begin
 Result := Value;
 for CharIndex := 1 to Length(Value) do
   Result[CharIndex] := chr(not(ord(Value[CharIndex]) + CharIndex ));
 end;

procedure LoadStringFromFile(Filename, LoadString: string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
  try
    SetLength (LoadString, fs.Size);
    if fs.size>0 then
      fs.Read (LoadString[1], fs.Size);
  finally
    fs.Free;
  end;
end;
procedure TForm5.Button1Click(Sender: TObject);
var
  text: TStringList;
begin
PassString := Edit2.Text;
NameString := Edit1.Text;
text := tstringlist.Create;


if NameString = '' then

  ShowMessage('No Name entered. Please choose a name for your wallet.')
 else
 begin
if PassString = '' then
  ShowMessage('No Passphrase entered')
  else
  begin
  PassString := StringToHex(PassString);
  PassString := EnDeCrypt(PassString);

    text.Add(PassString);
    text.SaveToFile(Edit1.Text + '.txt', TEncoding.UTF8);

    Showmessage(Edit1.Text + ' saved locally and not in plain text!');
    Edit2.Text :='';
    Edit1.Text :='';

    close;
  end;
end;

end;


procedure TForm5.Button2Click(Sender: TObject);
begin
close;
end;

end.
