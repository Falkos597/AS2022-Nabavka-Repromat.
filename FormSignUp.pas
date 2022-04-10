unit FormSignUp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, MainAppForm;

type
  TfrmSignIn = class(TForm)
    Y: TImageControl;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Button1: TButton;
    Label6: TLabel;
    signUpBtn: TButton;
    procedure signUpBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

procedure TfrmSignIn.Button1Click(Sender: TObject);
begin
  frmSignIn.Hide;
  frmStartView.Show;
end;

procedure TfrmSignIn.signUpBtnClick(Sender: TObject);
begin
  frmSignIn.Hide;
  frmSignUp.Show;
end;

end.
