program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormSignIn in 'FormSignIn.pas' {frmSignUp},
  FormSignUp in 'FormSignUp.pas' {frmSignIn},
  MainAppForm in 'MainAppForm.pas' {frmStartView};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TfrmSignIn, frmSignIn);
  Application.CreateForm(TfrmStartView, frmStartView);
  Application.Run;
end.
