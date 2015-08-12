unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IOUtils,Vcl.Clipbrd, StrUtils, ShellApi;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    Button2: TButton;
    Panel1: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
  private
    { Private-Deklarationen }
       directories: String;
   currentdir: String;
  public
    { Public-Deklarationen }
  end;

var
  Form7: TForm7;

implementation

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

procedure TForm7.Button1Click(Sender: TObject);
var
path: String;
begin
if not ListBox1.Items.Count < 1 then
 begin
path:= ListBox1.Items.GetText;



ShellExecute(0, 'open', PChar('cmd.exe'),PChar('/K mine.bat'), PChar(path), SW_SHOW);
close;
 end
else
Showmessage('No plots found. You have to generate plots before mining!');

end;
procedure TForm7.Button2Click(Sender: TObject);
var
clipboard2: Tclipboard;
begin
Form1.Webbrowser1.Navigate('http://127.0.0.1:8125/rewardassignmentshort.html');
clipboard2 := TClipBoard.create;
clipboard2.AsText:='BURST-8NZ9-X6AX-72BK-2KFM2';
ShowMessage('The pool address BURST-8NZ9-X6AX-72BK-2KFM2 of DevPool2 got copied into your clipboard.'+#13#10+ 'Paste it into the second textbox: "Recipient - Burst address of pool" and paste your wallet passphrase in the first textbox.');
Hide;
end;

procedure TForm7.Button4Click(Sender: TObject);
begin
//ToDo
Showmessage('Changes saved');
end;

procedure TForm7.ComboBox1Click(Sender: TObject);
begin
Showmessage('You want to choose other pools? You are using a 32bit system and for now this is the only solution I can offer you.')
end;

procedure TForm7.FormActivate(Sender: TObject);
var
 character: Char;
begin
currentdir := GetCurrentDir + '\pocminer_pool_v1';

ListBox1.Items.Clear;
   For character:= 'Z' downto 'A' do
  if TDirectory.Exists(character+':\Burst\plots') then
  if not IsDirectoryEmpty(character+':\Burst\plots')
  then

begin  ListBox1.Items.Add(character+':\Burst\plots');
       try
    { Copy directory from source path to destination path }
    TDirectory.Copy(currentdir, character+':\Burst');
  except
    { Catch the possible exceptions }
    MessageDlg('Incorrect source path or destination path', mtError, [mbOK], 0);
  end;
end;
end;

procedure TForm7.FormHide(Sender: TObject);
begin
ListBox1.Items.Clear;
end;

procedure TForm7.Label11Click(Sender: TObject);
begin
Form1.Webbrowser1.Navigate('http://f.burstcoin.info/');
end;





end.
