unit FormProductUpdate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, DataModul, FormProductView ;

type
  TfrmProductUpdate = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
     var ProizvodID : String ;
     var ImeDobavljaca : String;

  end;

var
  frmProductUpdate: TfrmProductUpdate;

implementation
{$R *.fmx}



procedure TfrmProductUpdate.Button1Click(Sender: TObject);
begin
self.Hide;
frmProductView.Show;
end;

procedure TfrmProductUpdate.Button2Click(Sender: TObject);
begin
  var Proizvod := Edit1.Text.Trim;
  var Cena := Edit2.Text.Trim;
  var Kolicina := Edit3.Text.Trim;
  var Dobavljac := ComboBox1.Selected.Text;
  var IDDobavljaca : String  ;

     while not mainDataModul.queryDobavljaciPorudzbenicaPunjenje.Eof do
  begin
    if mainDataModul.queryDobavljaciPorudzbenicaPunjenje['ImeDobavljaca'] = Dobavljac then
    begin
      IDDobavljaca := mainDataModul.queryDobavljaciPorudzbenicaPunjenje['IDTabele'];
      break
     end;
    mainDataModul.queryDobavljaciPorudzbenicaPunjenje.Next;

  end;



  mainDataModul.queryUpdate.ExecSQL('UPDATE Proizvod SET IDDobavljaca= "' + IDDobavljaca + '", ImeProizvoda= "' + Proizvod + '", CenaKupovine= "' + Cena + '", Kolicina= "' + Kolicina + '"  WHERE IDTabele = ' + ProizvodID );
  ShowMessage('Uspesna izmena');
  mainDataModul.queryPrikazProizvoda.Refresh;

  self.Hide;
  frmProductView.Show;
end;

procedure TfrmProductUpdate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TfrmProductUpdate.FormShow(Sender: TObject);
begin
       ComboBox1.Items.Clear;

  mainDataModul.queryDobavljaciZahtevPunjenje.First;

  while not mainDataModul.queryDobavljaciZahtevPunjenje.Eof do
  begin
    ComboBox1.items.Add(mainDataModul.queryDobavljaciZahtevPunjenje['ImeDobavljaca']);
    mainDataModul.queryDobavljaciZahtevPunjenje.Next;
  end;

ComboBox1.ItemIndex :=  ComboBox1.Items.IndexOf(ImeDobavljaca);



end;

end.



