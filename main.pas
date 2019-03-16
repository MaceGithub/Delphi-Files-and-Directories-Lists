unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.FileCtrl, Vcl.StdCtrls,
  FileAndDirectoryUtils, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    btnCreateList: TButton;
    memoResult: TMemo;
    Label1: TLabel;
    editWildCardmask: TEdit;
    Label2: TLabel;
    editRegularExpression: TEdit;
    Panel1: TPanel;
    rbtnDirectories: TRadioButton;
    rbtnFilesAndDirectories: TRadioButton;
    rbtnFiles: TRadioButton;
    Panel2: TPanel;
    rbtnName: TRadioButton;
    rbtnPath: TRadioButton;
    procedure btnCreateListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Generics.Collections;


procedure TForm1.btnCreateListClick(Sender: TObject);
var
  ResultList: TList<String>;
  Index:      Integer;
  ItemIndex:  Integer;
begin

  ItemIndex := DirectoryListBox1.itemindex;
  if rbtnPath.Checked then begin
    if rbtnFilesAndDirectories.Checked then
      ResultList := TFileAndDirectoryPathList.Create(DirectoryListBox1.GetItemPath(ItemIndex),
                                                     editWildCardmask.Text,
                                                     editRegularExpression.Text);
    if rbtnFiles.Checked then
      ResultList := TFilePathList.Create(DirectoryListBox1.GetItemPath(ItemIndex),
                                         editWildCardmask.Text,
                                         editRegularExpression.Text);
    if rbtnDirectories.Checked then
      ResultList := TDirectoryPathList.Create(DirectoryListBox1.GetItemPath(ItemIndex),
                                              editWildCardmask.Text,
                                              editRegularExpression.Text);
  end
  else begin
    if rbtnFilesAndDirectories.Checked then
      ResultList := TFileAndDirectoryNameList.Create(DirectoryListBox1.GetItemPath(ItemIndex),
                                                     editWildCardmask.Text,
                                                     editRegularExpression.Text);
    if rbtnFiles.Checked then
      ResultList := TFilenameList.Create(DirectoryListBox1.GetItemPath(ItemIndex),
                                         editWildCardmask.Text,
                                         editRegularExpression.Text);
    if rbtnDirectories.Checked then
      ResultList := TDirectoryNameList.Create(DirectoryListBox1.GetItemPath(ItemIndex),
                                              editWildCardmask.Text,
                                              editRegularExpression.Text);
  end;

  memoResult.Lines.Clear;
  Index := 0;
  while (Index < ResultList.count) do
  begin
    memoResult.Lines.Add(ResultList.List[Index]);
    Inc(Index);
  end;

end;


end.
