unit FormProductAdd;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FormProductView, DataModul,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TProductAdd = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProductAdd: TProductAdd;

implementation



{$R *.fmx}

procedure TProductAdd.Button1Click(Sender: TObject);
begin
  self.Hide();
  frmProductView.Show();
end;


procedure TProductAdd.Button2Click(Sender: TObject);

var Proizvod: string;
var Kolicina, Cena: string;
var Dobavljac : string;
var DobavljacID : Integer;

begin

  if (not ComboBox1.Selected.IsSelected) or Edit1.Text.IsEmpty or Edit2.Text.IsEmpty or Edit3.Text.IsEmpty then
  begin
    ShowMessage('Pogresan unos unos!!!');
    exit
  end;

  Dobavljac := ComboBox1.Selected.Text;
  Proizvod := Edit1.Text;
  Kolicina := Edit3.Text.Trim;
  Cena := Edit2.Text.Trim;

  mainDataModul.queryDobavljaciPorudzbenicaPunjenje.Refresh;
  mainDataModul.queryDobavljaciPorudzbenicaPunjenje.First;

  while not mainDataModul.queryDobavljaciPorudzbenicaPunjenje.Eof do
  begin

    if mainDataModul.queryDobavljaciPorudzbenicaPunjenje['ImeDobavljaca'] = Dobavljac then
    begin
      DobavljacID := mainDataModul.queryDobavljaciPorudzbenicaPunjenje['IDTabele'];
      break
    end;
    mainDataModul.queryDobavljaciPorudzbenicaPunjenje.Next;

  end;

  mainDataModul.queryInsert.ExecSQL('INSERT INTO Proizvod (IDDobavljaca, ImeProizvoda, CenaKupovine, Kolicina ) VALUES ("' + IntToStr(DobavljacID) + '", "' + Proizvod + '", "' + Cena + '","' + Kolicina + '"  )');
  mainDataModul.queryPrikazProizvoda.Refresh;
  ShowMessage(' Uspesno dodat proizvod ' + Proizvod );

  self.Hide;
  frmProductView.Show;
end;

procedure TProductAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TProductAdd.FormShow(Sender: TObject);
begin
  ComboBox1.Items.Clear;

  mainDataModul.queryDobavljaciZahtevPunjenje.First;

  while not mainDataModul.queryDobavljaciZahtevPunjenje.Eof do
  begin
    ComboBox1.items.Add(mainDataModul.queryDobavljaciZahtevPunjenje['ImeDobavljaca']);
    mainDataModul.queryDobavljaciZahtevPunjenje.Next;
  end;

  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
end;
end.
