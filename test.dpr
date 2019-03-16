program test;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  FileAndDirectoryUtils in 'FileAndDirectoryUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
