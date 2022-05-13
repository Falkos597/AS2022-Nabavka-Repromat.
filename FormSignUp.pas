unit FormSignUp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, MainAppForm, FMX.Layouts, FMX.ExtCtrls;

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
    procedure signUpBtnClick(Sender: TObject);
    procedure signInBtnClick(Sender: TObject);
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

procedure TfrmSignIn.signInBtnClick(Sender: TObject);
begin
  frmSignIn.Hide;
  frmStartView.Show;
end;

procedure TfrmSignIn.signUpBtnClick(Sender: TObject);
begin
  frmSignUp.Show;
  Self.Hide;
end;

end.
