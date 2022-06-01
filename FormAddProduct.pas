unit FormAddProduct;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.StdCtrls, FMX.ListBox, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Grid, FMX.Edit, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  Datasnap.Provider, Datasnap.DBClient, Fmx.Bind.Grid, Data.Bind.Grid, DataModul;

type
  TfrmAddProduct = class(TForm)
    Grid1: TGrid;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit3: TEdit;
    Label7: TLabel;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


private
    { Private declarations }
  public
  var ProizvodjacTemp :String;
  var ProizvodTemp :String;
    { Public declarations }
  end;

var
  frmAddProduct:TfrmAddProduct ;

implementation

 uses FormCreateOrder;

{$R *.fmx}

procedure TfrmAddProduct.Button1Click(Sender: TObject);
begin
    Self.hide;
    frmCreateOrder.Show;
    mainDataModul.queryPrikazProizvodaNovogZahteva.Refresh;
end;


procedure TfrmAddProduct.Button2Click(Sender: TObject);
begin
  var indeks := Edit3.Text.ToInteger;

  if edit3.Text.IsEmpty then
  begin
    ShowMessage('Unesite Indeks koji želite da izbrišete.');
    exit
  end;

  mainDataModul.queryPrikazProizvodaNovogZ.First;
  while not mainDataModul.queryPrikazProizvodaNovogZ.Eof do
  begin
    if mainDataModul.queryPrikazProizvodaNovogZ['Indeks'] = indeks then
    begin
      mainDataModul.queryInsert.ExecSQL('DELETE FROM ListaProizvodaZahtevaTemp WHERE IDUnosa = ' + IntToStr(indeks));
      mainDataModul.queryPrikazProizvodaNovogZ.Refresh;
      exit
    end;

    mainDataModul.queryPrikazProizvodaNovogZ.Next;
  end;


  ShowMessage('Uneli ste nepostojeći indeks;');
end;

procedure TfrmAddProduct.Button3Click(Sender: TObject);
begin

  if (not ComboBox1.Selected.IsSelected) or (not ComboBox2.Selected.IsSelected) or Edit1.Text.IsEmpty then
  begin
    ShowMessage('Loš unos!!!');
    exit
  end ;

  var ProizvodID :Integer;
  var ProizvodIme := ComboBox2.Selected.Text;
  var KolicinaProizvoda := StrToInt(Edit1.Text);

  mainDataModul.queryProizvodiZahtevPunjenje.First;

  while not mainDataModul.queryProizvodiZahtevPunjenje.Eof do
  begin
    if mainDataModul.queryProizvodiZahtevPunjenje['ImeProizvoda'] = ProizvodIme then
    begin
      ProizvodID := mainDataModul.queryProizvodiZahtevPunjenje['IDProizvoda'];

      mainDataModul.queryInsert.ExecSQL('INSERT INTO ListaProizvodaZahtevaTemp (IDUnosa, IDProizvoda, Kolicina) VALUES (' + IntToStr(frmCreateOrder.indeksBrojac) + ', ' + IntToStr(ProizvodID) + ', ' + IntToStr(KolicinaProizvoda) + ')');
      frmCreateOrder.indeksBrojac := frmCreateOrder.indeksBrojac + 1;
    end;
    mainDataModul.queryProizvodiZahtevPunjenje.Next;
  end;

  mainDataModul.queryPrikazProizvodaNovogZ.Refresh;

end;

procedure TfrmAddProduct.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.Enabled:=true;
  ComboBox2.Items.Clear;

      mainDataModul.queryProizvodiZahtevPunjenje.First;

      while not mainDataModul.queryProizvodiZahtevPunjenje.Eof do
      begin
      if mainDataModul.queryProizvodiZahtevPunjenje['ImeDobavljaca']=ComboBox1.Selected.Text then
        begin
          ComboBox2.items.Add(mainDataModul.queryProizvodiZahtevPunjenje['ImeProizvoda']);
        end;
        mainDataModul.queryProizvodiZahtevPunjenje.Next;
      end;

end;



procedure TfrmAddProduct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TfrmAddProduct.FormShow(Sender: TObject);
begin
  ComboBox2.Enabled:=False;
  ComboBox1.Items.Clear;

  mainDataModul.queryDobavljaciZahtevPunjenje.First;

  while not mainDataModul.queryDobavljaciZahtevPunjenje.Eof do
  begin
    ComboBox1.items.Add(mainDataModul.queryDobavljaciZahtevPunjenje['ImeDobavljaca']);
    mainDataModul.queryDobavljaciZahtevPunjenje.Next;
  end;

end;

end.

