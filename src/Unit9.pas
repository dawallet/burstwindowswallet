unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IOUtils,Vcl.Clipbrd, StrUtils, ShellApi;
type
  TForm9 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button4: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form9: TForm9;

implementation
uses BurstWallet2;
{$R *.dfm}
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




procedure TForm9.Button1Click(Sender: TObject);
var
 directories: String;
 shortdirectories: String;
 currentdir: String;
 i: Integer;
  begin

if not ListBox1.Items.Count < 1 then
 begin
i := ListBox1.Items.Count;

for i := 0 to ListBox1.Items.Count -1 do
begin
  directories:= ListBox1.Items.Strings[i];


  currentdir := GetCurrentDir + '\pocminer_pool_v1';

try
    { Copy directory from source path to destination path }
    shortdirectories:= directories;
    shortdirectories:= Copy(shortdirectories, 1, 8);
    //Showmessage(shortdirectories);
    TDirectory.Copy(currentdir, shortdirectories);
  except
    { Catch the possible exceptions }
    MessageDlg('Incorrect source path or destination path', mtError, [mbOK], 0);
  end;

  ShellExecute(0, 'open', PChar('cmd.exe'),PChar('/K mine.bat'), PChar(shortdirectories), SW_SHOW);
//directories:= StringReplace(directories, '\', '\\', [rfReplaceAll, rfIgnoreCase]);
//directories:= StringReplace(directories, #13#10, '+', [rfReplaceAll, rfIgnoreCase]);
//delete(directories, length(directories), 5);
 end;

close;
end;
end;
procedure TForm9.Button2Click(Sender: TObject);
var
clipboard2: Tclipboard;
begin
Form1.Webbrowser1.Navigate('https://wallet1.burstnation.com:8125/rewardassignmentshort.html');
clipboard2 := TClipBoard.create;
clipboard2.AsText:='BURST-8NZ9-X6AX-72BK-2KFM2';
ShowMessage('The pool address BURST-8NZ9-X6AX-72BK-2KFM2 of DevPool2 got copied into your clipboard.'+#13#10+ 'Paste it into the second textbox: "Recipient - Burst address of pool" and paste your wallet passphrase in the first textbox.');
Hide;
end;

procedure TForm9.ComboBox1Click(Sender: TObject);
begin
Showmessage('You have a 32bit system. This limits the pools you can choose.')
end;

procedure TForm9.FormActivate(Sender: TObject);
var
 character: Char;
begin
ListBox1.Items.Clear;
   For character:= 'Z' downto 'C' do
  if TDirectory.Exists(character+':\Burst\x86\plots') then
  if not IsDirectoryEmpty(character+':\Burst\x86\plots')
  then ListBox1.Items.Add(character+':\Burst\x86\plots');
   
end;


procedure TForm9.FormHide(Sender: TObject);
begin
ListBox1.Items.Clear;
end;

end.
