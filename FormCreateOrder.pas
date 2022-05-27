unit FormCreateOrder;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ListBox, Datasnap.Provider,FormAddProduct, DataModul,
  Fmx.Bind.Grid, Data.Bind.Grid;

type
  TfrmCreateOrder = class(TForm)
    Label4: TLabel;
    primalacLabel: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button3: TButton;
    StringGrid1: TStringGrid;
    Label7: TLabel;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
  var indeksBrojac : Integer;
    { Public declarations }
  end;

var
  frmCreateOrder: TfrmCreateOrder;

implementation

uses MainAppForm;

{$R *.fmx}

procedure TfrmCreateOrder.Button1Click(Sender: TObject);
begin
  self.Hide;
  frmStartView.Show;
end;

procedure TfrmCreateOrder.Button2Click(Sender: TObject);
begin
  var idStanja : String;
  var idHitnosti : String;

  if Edit1.Text.IsEmpty or (not ComboBox1.Selected.IsSelected) or (not ComboBox2.Selected.IsSelected) then
  begin
    ShowMessage('Los unos!');
    exit
  end;

  mainDataModul.queryStanjeZahtevPunjenje.First;
  while not mainDataModul.queryStanjeZahtevPunjenje.Eof do
  begin

    if mainDataModul.queryStanjeZahtevPunjenje['ImeStanja'] = ComboBox2.Selected.Text then
    begin
      idStanja :=mainDataModul.queryStanjeZahtevPunjenje['IDTabele'];
    end;

    mainDataModul.queryStanjeZahtevPunjenje.Next;
  end;

  mainDataModul.queryHitnostZahtevPunjenje.First;
  while not mainDataModul.queryHitnostZahtevPunjenje.Eof do
  begin

   if mainDataModul.queryHitnostZahtevPunjenje['ImeHitnosti'] = ComboBox1.Selected.Text then
    begin
      idHitnosti :=mainDataModul.queryHitnostZahtevPunjenje['IDTabele'];

    end;

    mainDataModul.queryHitnostZahtevPunjenje.Next;
  end;

  var dateAndTime := TimeToStr(Now)+ ' ' + DateToStr(Now);

  mainDataModul.queryInsert.ExecSQL('INSERT INTO ZahtevZaNabavku (IDStanja, IDHitnosti, ImePodnosioca, DatumPodnosenja) VALUES ("' + idStanja + '", "'+ idHitnosti + '", "' + Edit1.Text + '", "' + dateAndTime + '")');
  mainDataModul.queryLastIndex.Refresh;
  var indeksZah := mainDataModul.queryLastIndex['last_insert_rowid()'];



  mainDataModul.queryPrikazProizvodaNoveP.First;
  while not mainDataModul.queryPrikazProizvodaNoveP.Eof do
  begin
    mainDataModul.queryProizvodiZahtevPunjenje.First;
    while not mainDataModul.queryProizvodiZahtevPunjenje.Eof do
    begin

    if mainDataModul.queryProizvodiZahtevPunjenje['ImeProizvoda'] = mainDataModul.queryPrikazProizvodaNoveP['ImeProizvoda'] then
      begin

      var idProizvoda := mainDataModul.queryProizvodiZahtevPunjenje['IDProizvoda'];
      var kolicina := mainDataModul.queryPrikazProizvodaNoveP['Kolicina'];
      mainDataModul.queryInsert.ExecSQL('INSERT INTO ListaProizvodaZahtev (IDZahteva, IDProizvoda, Kolicina) VALUES(' + IntToStr(indeksZah).Trim + ', ' + IntToStr(idProizvoda).Trim + ', ' + IntToStr(kolicina).Trim + ')');

      end;

    mainDataModul.queryProizvodiZahtevPunjenje.Next;
    end;

    mainDataModul.queryPrikazProizvodaNoveP.Next;
  end;

//  mainDataModul.queryDelete.ExecSQL('DELETE FROM ListaProizvodaZahtevaTemp WHERE 1');
  mainDataModul.queryPrikazProizvodaNoveP.Refresh;

  ShowMessage('Uspesno kreiranje porudzbenice!');
end;

procedure TfrmCreateOrder.Button3Click(Sender: TObject);
begin
 frmAddProduct.Show;
end;

procedure TfrmCreateOrder.FormShow(Sender: TObject);
begin

indeksBrojac := 0;

ComboBox2.Items.Clear;

  mainDataModul.queryStanjeZahtevPunjenje.First;
  while not mainDataModul.queryStanjeZahtevPunjenje.Eof do
  begin
    ComboBox2.items.Add(mainDataModul.queryStanjeZahtevPunjenje['ImeStanja']);

    mainDataModul.queryStanjeZahtevPunjenje.Next;
  end;

ComboBox1.Items.Clear;

  mainDataModul.queryHitnostZahtevPunjenje.First;
  while not mainDataModul.queryHitnostZahtevPunjenje.Eof do
  begin
    ComboBox1.items.Add(mainDataModul.queryHitnostZahtevPunjenje['ImeHitnosti']);

    mainDataModul.queryHitnostZahtevPunjenje.Next;
  end;

  //mainDataModul.queryDelete.ExecSQL('DELETE FROM ListaProizvodaZahtevaTemp WHERE 1');
  mainDataModul.queryPrikazProizvodaNovePorudzbenice.Refresh;
end;

end.
