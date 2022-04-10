unit FormSignIn;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FMX.Ani, FormSignUp, MainAppForm;

type
  TfrmSignUp = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    signInBtn: TButton;
    usernameEdit: TEdit;
    passwordEdit: TEdit;
    Label3: TLabel;
    signUpBtn: TButton;
    procedure signUpBtnClick(Sender: TObject);
    procedure signInBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.fmx}

procedure TfrmSignUp.signInBtnClick(Sender: TObject);
begin
  frmSignUp.Hide;
  frmStartView.Show;
end;

procedure TfrmSignUp.signUpBtnClick(Sender: TObject);
begin
  frmSignUp.Hide;
  frmSignIn.Show;
end;

end.

procedure TfrmSignUp.Image1Click(Sender: TObject);
begin

end;

procedure TfrmSignUp.signInBtnClick(Sender: TObject);
begin
  if usernameEdit.Text.IsEmpty and  passwordEdit.Text.IsEmpty then
    Exit;

    var s := 'Admin';

  if usernameEdit.Text = s then
    if passwordEdit.Text = s then

end;

