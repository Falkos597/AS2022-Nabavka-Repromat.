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
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);


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
    mainDataModul.queryPrikazProizvodaNoveP.Refresh;
end;


procedure TfrmAddProduct.Button2Click(Sender: TObject);
begin
  var indeks := Edit3.Text.ToInteger;
  var check := True;

  if edit3.Text.IsEmpty then
  begin
    ShowMessage('Unesite Indeks koji �elite da izbri�ete.');
    exit
  end;

  mainDataModul.queryPrikazProizvodaNovePorudzbenice.First;
  while not mainDataModul.queryPrikazProizvodaNovePorudzbenice.Eof do
  begin
    if mainDataModul.queryPrikazProizvodaNovePorudzbenice['Indeks'] = indeks then
    begin
      mainDataModul.queryInsert.ExecSQL('DELETE FROM ListaProizvodaZahtevaTemp WHERE IDUnosa = ' + IntToStr(indeks));
      check := False;
    end;

    mainDataModul.queryPrikazProizvodaNovePorudzbenice.Next;
  end;

  mainDataModul.queryPrikazProizvodaNovePorudzbenice.Refresh;

  if check then
  ShowMessage('Uneli ste nepostojeci indeks;');
end;

procedure TfrmAddProduct.Button3Click(Sender: TObject);
begin

  if not ((ComboBox1.Selected.IsSelected) and (ComboBox2.Selected.IsSelected)) then
  begin
    ShowMessage('Lo� unos!!!');
    exit
  end else
  begin
    var ProizvodjacTemp := ComboBox1.Selected.Text;
    var ProizvodTemp := ComboBox2.Selected.Text;
  end;

  var ProizvodID :Integer;
  var ProizvodIme := ComboBox2.Selected.Text;
  var KolicinaProizvoda := StrToInt(Edit1.Text);

  mainDataModul.queryProizvodiPorudzbenicePunjenje.First;

  while not mainDataModul.queryProizvodiPorudzbenicePunjenje.Eof do
  begin
    if mainDataModul.queryProizvodiPorudzbenicePunjenje['ImeProizvoda'] = ProizvodIme then
    begin
      ProizvodID := mainDataModul.queryProizvodiPorudzbenicePunjenje['IDProizvoda'];

      mainDataModul.queryInsert.ExecSQL('INSERT INTO ListaProizvodaZahtevaTemp (IDUnosa, IDProizvoda, Kolicina) VALUES (' + IntToStr(frmCreateOrder.indeksBrojac) + ', ' + IntToStr(ProizvodID) + ', ' + IntToStr(KolicinaProizvoda) + ')');
      frmCreateOrder.indeksBrojac := frmCreateOrder.indeksBrojac + 1;
    end;
    mainDataModul.queryProizvodiPorudzbenicePunjenje.Next;
  end;

  mainDataModul.queryPrikazProizvodaNovePorudzbenice.Refresh;

end;

procedure TfrmAddProduct.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.Enabled:=true;
  ComboBox2.Items.Clear;

      mainDataModul.queryProizvodiPorudzbenicePunjenje.First;

      while not mainDataModul.queryProizvodiPorudzbenicePunjenje.Eof do
      begin
      if mainDataModul.queryProizvodiPorudzbenicePunjenje['ImeDobavljaca']=ComboBox1.Selected.Text then
        begin
          ComboBox2.items.Add(mainDataModul.queryProizvodiPorudzbenicePunjenje['ImeProizvoda']);
        end;
        mainDataModul.queryProizvodiPorudzbenicePunjenje.Next;
      end;

end;



procedure TfrmAddProduct.FormShow(Sender: TObject);
begin
  ComboBox2.Enabled:=False;
  ComboBox1.Items.Clear;

  mainDataModul.queryDobavljaciPorudzbenicePunjenje.First;

  while not mainDataModul.queryDobavljaciPorudzbenicePunjenje.Eof do
  begin
    ComboBox1.items.Add(mainDataModul.queryDobavljaciPorudzbenicePunjenje['ImeDobavljaca']);
    mainDataModul.queryDobavljaciPorudzbenicePunjenje.Next;
  end;

end;

end.

