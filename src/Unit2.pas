unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.FileCtrl, ShellApi, Vcl.ComCtrls, Types, IOUtils;

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
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
   Total, FreeD: Int64;
   plotdir: String;
  end;

var
  Form2: TForm2;
  Disk: Byte;

implementation

{$R *.dfm}
uses Unit3;

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

procedure TForm2.Button1Click(Sender: TObject);
var
currentdir: String;
begin
Form3.Show;
plotdir:= (((DriveComboBox1.Drive))+':\Burst');
CreateDir(((DriveComboBox1.Drive))+':\Burst');
currentdir := GetCurrentDir + '\XPlotter';

try
    { Copy directory from source path to destination path }
    TDirectory.Copy(currentdir, ((((DriveComboBox1.Drive))) + ':\Burst'));
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
ShowMessage('Plots are prewritten hashes for mining Burst. As an example: imagine that 500 GB of plots are like 5 CPU / GPU or ASICS you mine with:' +#13#10+ 'If you double your plot size you double your mining power!' +#13#10+ 'You have to plot only ONCE! Then you can mine with your Plots as long as you want. To plot 500 GB can takes 12 hours on a average machine.')
end;

procedure TForm2.DriveComboBox1Change(Sender: TObject);

begin
  try
    Total:=DiskSize(ord(DriveComboBox1.Drive)-64) div 1024;
  Total:= Total div 1024;
  Total:= Total div 1024;
  FreeD:=DiskFree(ord(DriveComboBox1.Drive)-64) div 1024;
  FreeD:= FreeD div 1024;
  FreeD:= FreeD div 1024;
  Gauge1.MaxValue:=Total;
  Gauge1.Progress:=Total - FreeD;
  Label1.Caption:='Total size: '+IntToStr(Total) + ' GB';
  Label2.Caption:='Free: '+IntToStr(FreeD) + ' GB';
  except

  end;


end;

procedure TForm2.FormCreate(Sender: TObject);

begin
try
  Total:=DiskSize(Disk) div 1024;
  Total:= Total div 1024;
  Total:= Total div 1024;
  FreeD:=DiskFree(Disk) div 1024;
  FreeD:= FreeD div 1024;
  FreeD:= FreeD div 1024;
  Gauge1.MaxValue:=Total;
  Gauge1.Progress:=Total - FreeD;
  Label1.Caption:='Total size: '+IntToStr(Total) + ' GB';
  Label2.Caption:='Free: '+IntToStr(FreeD) + ' GB';
 except

 end;

end;

end.
