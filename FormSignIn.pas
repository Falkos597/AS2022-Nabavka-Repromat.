unit FormSignIn;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Ani, FormSignUp, MainAppForm,
  FMX.Layouts, FMX.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmSignUp = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    signInBtn: TButton;
    usernameEdit: TEdit;
    passwordEdit: TEdit;
    Label3: TLabel;
    signUpBtn: TButton;
    ImageViewer1: TImageViewer;
    FDConnection: TFDConnection;
    queryKlijenti: TFDQuery;
    procedure signUpBtnClick(Sender: TObject);
    procedure signInBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.fmx}

procedure TfrmSignUp.signUpBtnClick(Sender: TObject);
begin
  frmSignUp.Hide;
  frmSignIn.Show;
end;



procedure TfrmSignUp.FormCreate(Sender: TObject);
begin
  FDConnection.Connected := True;
//  var path := (Application.GetNamePath + '\Nabavka.db');
//  ShowMessage(path);
//  with FDConnection do
//  begin
//    close;
//      with Params do
//      begin
//        Clear;
//        Add('DriverID=SQLite');
//        Add('Database=' + path);
//      end;
//  end;

  with queryKlijenti do
  begin
   Close;
   SQL.Clear;
   SQL.Text :=  'SELECT  KorisnickoIme, Sifra ' +
                'FROM Korisnici';
   Open;
  end;


end;


procedure TfrmSignUp.FormHide(Sender: TObject);
begin
FDConnection.Connected := False;
end;

procedure TfrmSignUp.signInBtnClick(Sender: TObject);
begin
  if usernameEdit.Text.IsEmpty and  passwordEdit.Text.IsEmpty then
  begin
    ShowMessage('Unesite korisničko ime i šifru.');
  end;

    var Username :string;
    var Password :string;
    var check := False;

  queryKlijenti.First;
  while not queryKlijenti.Eof do
   begin
     Username := queryKlijenti['KorisnickoIme'];
     Password := queryKlijenti['Sifra'];

     if usernameEdit.Text = Username then
     begin
         if passwordEdit.Text = Password then
       begin
         frmStartView.Show;
         frmSignUp.Hide;
         check := True;
       end;
     end;

       queryKlijenti.Next;
   end;

  if not Check then
  ShowMessage('Pogrešno korisničko ime ili šifra.');

end;

end.

