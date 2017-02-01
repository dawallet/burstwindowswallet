program BurstSOW2;

uses
  Vcl.Forms,
  Windows,
  Dialogs,
  BurstWallet2 in 'BurstWallet2.pas' {Form1},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Vcl.Themes,
  Vcl.Styles,
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit9 in 'Unit9.pas' {Form9},
  Unit10 in 'Unit10.pas' {Form10},
  Unit11 in 'Unit11.pas' {Form11},
  Unit8 in 'Unit8.pas' {Form8};

// CheckPrevious in 'CheckPrevious.pas';

{$R *.res}
var
  Mutex : THandle;
begin
  Mutex := CreateMutex(nil, True, 'My_Unique_Application_Mutex_Name');
  if (Mutex = 0) OR (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
  ShowMessage('Burst Client already running. Check for the icon in the tray!');
   end
  else
  begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm8, Form8);
  Application.Run;
      if Mutex = 0 then
      CloseHandle(Mutex);
    end;

end.
