unit FormUpdateSupplier;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, DataModul;

type
  TfrmUpdateSupplier = class(TForm)
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
    procedure backBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
  var dobavljacId : String;
  var dobavljacIme : String;
  var dobavljacZemlja : String;
  var dobavljacGrad : String;
  var dobavljacUlica : String;
  var dobavljacEmail : String;
    { Public declarations }
  end;

var
  frmUpdateSupplier: TfrmUpdateSupplier;

implementation

uses FormSupplierView;

{$R *.fmx}

procedure TfrmUpdateSupplier.backBtnClick(Sender: TObject);
begin
  self.Hide;
  frmSupplierView.Show;
end;

procedure TfrmUpdateSupplier.Button1Click(Sender: TObject);
begin
  dobavljacIme := Edit1.Text.Trim;
  dobavljacZemlja := Edit2.Text.Trim;
  dobavljacGrad := Edit3.Text.Trim;
  dobavljacUlica := Edit4.Text.Trim;
  dobavljacEmail := Edit5.Text.Trim;

  mainDataModul.queryUpdate.ExecSQL('UPDATE Dobavljac SET ImeDobavljaca= "' + dobavljacIme + '", Zemlja= "' + dobavljacZemlja + '", Grad= "' + dobavljacGrad + '", Ulica= "' + dobavljacUlica + '", Email= "' + dobavljacEmail + '" WHERE IDTabele = ' + dobavljacId);
  ShowMessage('Uspesna izmena');
  mainDataModul.queryPrikazDobavljaca.Refresh;

  self.Hide;
  frmSupplierView.Show;

end;

end.
