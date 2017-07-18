unit Unit2;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Gauges, Vcl.StdCtrls, ShellApi, Vcl.ComCtrls, Types, IOUtils,
  Vcl.FileCtrl;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Gauge1: TGauge;
    DriveComboBox1: TDriveComboBox;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CalculateDiskSize(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
     Total, FreeD: Int64;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
uses Unit3;

procedure TForm2.CalculateDiskSize(Sender: TObject);
  begin
   try
   Total:=DiskSize(ord(Form2.DriveComboBox1.Drive)-64) div 1024;
   Total:= Total div 1024;
   Total:= Total div 1024;
   FreeD:=DiskFree(ord(Form2.DriveComboBox1.Drive)-64) div 1024;
   FreeD:= FreeD div 1024;
   FreeD:= FreeD div 1024;
   Form2.Gauge1.MaxValue:=Total;
   Form2.Gauge1.Progress:=Total - FreeD;
   Form2.Label1.Caption:='Total size: '+IntToStr(Total) + ' GB';
   Form2.Label2.Caption:='Free: '+IntToStr(FreeD) + ' GB';
   except
   Showmessage('Error in calculating Disk size.');
   end;
  end;

procedure TForm2.Button1Click(Sender: TObject);
var
currentdir: String;
   plotdir: String;
  begin
    Form3.Show;
    plotdir:= (DriveComboBox1.Drive+':\Burst');
    CreateDir(DriveComboBox1.Drive+':\Burst');
    currentdir := GetCurrentDir + '\XPlotter';

    try
    { Copy directory from source path to destination path }
    TDirectory.Copy(currentdir, (DriveComboBox1.Drive + ':\Burst'));
   except
    { Catch the possible exceptions }
    MessageDlg('Incorrect source path or destination path', mtError, [mbOK], 0);
   end;
   Close;
  end;

procedure TForm2.Button2Click(Sender: TObject);
  begin
  Close;
  end;

procedure TForm2.Button3Click(Sender: TObject);
  begin
  ShellExecute(0, 'open', 'https://forums.burst-team.us/topic/288/plots-101', nil, nil, SW_SHOWNORMAL);
  end;

procedure TForm2.DriveComboBox1Change(Sender: TObject);
  begin
  Form2.CalculateDiskSize(self);
  end;

procedure TForm2.FormCreate(Sender: TObject);
  begin
  Form2.CalculateDiskSize(self);
  end;
end.
