unit FormSignUp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, MainAppForm, FMX.Layouts, FMX.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfrmSignIn = class(TForm)
    Label1: TLabel;
    firstNameEdit: TEdit;
    Label2: TLabel;
    secondNameEdit: TEdit;
    Label3: TLabel;
    emailEdit: TEdit;
    Label4: TLabel;
    passwordEdit: TEdit;
    Label5: TLabel;
    confirmPaswordEdit: TEdit;
    signInBtn: TButton;
    Label6: TLabel;
    signUpBtn: TButton;
    ImageViewer1: TImageViewer;
    FDConnection: TFDConnection;
    queryProvera: TFDQuery;
    queryUpisKorisnika: TFDQuery;
    procedure signUpBtnClick(Sender: TObject);
    procedure signInBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignIn: TfrmSignIn;

implementation

{$R *.fmx}

uses FormSignIn;

procedure TfrmSignIn.FormCreate(Sender: TObject);
begin
  FDConnection.Connected := False;
  var path := ExtractFilePath(ParamStr(0)) + '\Nabavka.db';
  FDConnection.Params.Values['Database'] := path;
  FDConnection.Connected := True;

  with queryProvera do
  begin
   Close;
   SQL.Clear;
   SQL.Text :=  'SELECT  * ' +
                'FROM Korisnici';
   Open;
  end;

end;

procedure TfrmSignIn.signInBtnClick(Sender: TObject);
begin
  var emailTemp := emailEdit.Text.Trim;
  var korisnickoImeTemp := secondNameEdit.Text.Trim;
  var imeTemp := firstNameEdit.Text.Trim;
  var sifraTemp := passwordEdit.Text.Trim;
  var sifraPotTemp := confirmPaswordEdit.Text.Trim;
  var check := True;

  queryProvera.First;
  while not queryProvera.Eof do
  begin
    if imeTemp.IsEmpty OR korisnickoImeTemp.IsEmpty OR emailTemp.IsEmpty OR sifraTemp.IsEmpty OR sifraPotTemp.IsEmpty then
    begin
      ShowMessage('Pogrešan unos!');
      check := False;
      Break
    end;

    if not (sifraTemp = sifraPotTemp) then
    begin
      ShowMessage('Šifre se moraju poklapati!');
      check := False;
      Break
    end;

//    if queryProvera['KorisnickoIme'] = korisnickoImeTemp then
//    begin
//      ShowMessage('Korisničko ime već postoji!');
//      check := False;
//      Break
//    end;
//
//    if queryProvera['Email'] = emailTemp then
//    begin
//      ShowMessage('Email ime već postoji!');
//      check := False;
//      Break
//    end;

    queryProvera.Next;
  end;

  if check then
  begin
  with queryUpisKorisnika do
  begin
  Close;
  SQL.Clear;
  SQL.Text :=  'INSERT INTO Korisnici (KorisnickoIme, Sifra, Email) VALUES( ' + korisnickoImeTemp + ' , ' + sifraTemp +  ' , ' + emailTemp + ' )' ;
  Open;
  end;
  frmSignIn.Hide;
  frmStartView.Show;
  end;

end;

procedure TfrmSignIn.signUpBtnClick(Sender: TObject);
begin
  frmSignUp.Show;
  Self.Hide;
end;

end.
