unit FormAddSupplier;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, DataModul;

type
  TfrmAddSupplier = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    backBtn: TButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure backBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmAddSupplier: TfrmAddSupplier;

implementation

uses FormSupplierView;

{$R *.fmx}

procedure TfrmAddSupplier.backBtnClick(Sender: TObject);
begin
  self.Hide;
  frmSupplierView.Show;
end;

procedure TfrmAddSupplier.Button1Click(Sender: TObject);
begin
  if(Edit1.Text.IsEmpty or Edit2.Text.IsEmpty or Edit3.Text.IsEmpty or Edit4.Text.IsEmpty or Edit5.Text.IsEmpty) then
  begin
    ShowMessage('Unesite sve informacije!');
    exit
  end;

  var dobavljacIme := Edit1.Text.Trim;
  var dobavljacZemlja := Edit2.Text.Trim;
  var dobavljacGrad := Edit3.Text.Trim;
  var dobavljacUlica := Edit4.Text.Trim;
  var dobavljacEmail := Edit5.Text.Trim;

  mainDataModul.queryPrikazDobavljaca.First;

  while not mainDataModul.queryPrikazDobavljaca.Eof do
  begin
    if mainDataModul.queryPrikazDobavljaca['ImeDobavljaca'] = dobavljacIme then
    begin
      ShowMessage('Postoji dobavljac sa tim imenom!');
      exit
    end;

    if(mainDataModul.queryPrikazDobavljaca['Email'] = dobavljacEmail) then
    begin
      ShowMessage('Postoji dobavljac sa tim email-om!');
      exit
    end;

    if(mainDataModul.queryPrikazDobavljaca['Ulica']= dobavljacUlica) then
    begin
      ShowMessage('Postoji dobavljac na toj adresi!');
      exit
    end;

    mainDataModul.queryPrikazDobavljaca.Next;

  end;

  mainDataModul.queryInsert.ExecSQL('INSERT INTO Dobavljac(ImeDobavljaca, Zemlja, Grad, Ulica, Email) VALUES ("' + dobavljacIme + '" ,"' + dobavljacZemlja + '" ,"' + dobavljacGrad + '" ,"' + dobavljacUlica + '" ,"' + dobavljacEmail + '" )');
  ShowMessage('Dobavljac uspesno dodat!');
  mainDataModul.queryPrikazDobavljaca.Refresh;

end;

procedure TfrmAddSupplier.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

end.
