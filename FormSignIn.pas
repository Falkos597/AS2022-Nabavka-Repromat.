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
  FireDAC.DApt, FireDAC.Comp.DataSet, DataModul;

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
    Label6: TLabel;
    procedure signUpBtnClick(Sender: TObject);
    procedure signInBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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



procedure TfrmSignUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
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

  mainDataModul.querySviKlijenti.First;
  while not mainDataModul.querySviKlijenti.Eof do
   begin
     Username := mainDataModul.querySviKlijenti['KorisnickoIme'];
     Password := mainDataModul.querySviKlijenti['Sifra'];

     if usernameEdit.Text = Username then
     begin
         if passwordEdit.Text = Password then
       begin
         frmStartView.Show;
         frmSignUp.Hide;
         check := True;
         Break
       end;
     end;

       mainDataModul.querySviKlijenti.Next;
   end;

  if not Check then
  ShowMessage('Pogrešno korisničko ime ili šifra.');

end;

end.

