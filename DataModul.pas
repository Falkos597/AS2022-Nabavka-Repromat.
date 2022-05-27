unit DataModul;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.VCLUI.Wait;

type
  TmainDataModul = class(TDataModule)
    FDConnection: TFDConnection;
    queryPrikazZahtevaZaNabavku: TFDQuery;
    querySviKlijenti: TFDQuery;
    queryPrikazProizvodaNovePorudzbenice: TFDQuery;
    queryDobavljaciZahtevPunjenje: TFDQuery;
    queryProizvodiZahtevPunjenje: TFDQuery;
    queryPrikazProizvodaNoveP: TFDQuery;
    queryPrikazPorudzbenica: TFDQuery;
    queryProizvodiNaZahtevu: TFDQuery;
    queryDobavljaciPorudzbenicaPunjenje: TFDQuery;
    queryStatusPorudzbeniePunjenje: TFDQuery;
    queryDelete: TFDQuery;
    queryProizvodiNaPorudzbenici: TFDQuery;
    queryInsert: TFDQuery;
    tableListaProizvodaZahtev: TFDTable;
    queryPrikazDobavljaca: TFDQuery;
    queryUpdate: TFDQuery;
    queryLastIndex: TFDQuery;
    queryHitnostZahtevPunjenje: TFDQuery;
    queryStanjeZahtevPunjenje: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainDataModul: TmainDataModul;

implementation

uses FormViewProducts;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TmainDataModul.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Connected := False;
  var path := ExtractFilePath(ParamStr(0)) + '\Nabavka.db';
  FDConnection.Params.Values['Database'] := path;
  FDConnection.Connected := True;

  with queryPrikazZahtevaZaNabavku do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT ZahtevZaNabavku.IDTabele as Indeks, ImePodnosioca, Stanje.ImeStanja as Stanje, Hitnost.ImeHitnosti, DatumPodnosenja ' +
                'FROM ZahtevZaNabavku ' +
                'INNER JOIN Stanje ' +
                'ON ZahtevZaNabavku.IDStanja = Stanje.IDTabele ' +
                'INNER JOIN Hitnost ' +
                'ON ZahtevZaNabavku.IDHitnosti = Hitnost.IDTabele ' +
                'ORDER BY ZahtevZaNabavku.IDTabele DESC';
    Open;
  end;

  with querySviKlijenti do
  begin
   Close;
   SQL.Clear;
   SQL.Text :=  'SELECT  *' +
                'FROM Korisnici';
   Open;
  end;

  with queryDobavljaciZahtevPunjenje do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT ImeDobavljaca FROM Dobavljac' ;
    open;
  end;

  with queryPrikazProizvodaNovePorudzbenice do
  begin
    Close;
    SQL.Clear;
    SQL.Text := ' SELECT IDUnosa as Indeks, ImeDobavljaca, ImeProizvoda, ListaProizvodaZahtevaTemp.Kolicina as Kolicina, Proizvod.CenaKupovine as Cena ' +
                ' from ListaProizvodaZahtevaTemp ' +
                ' INNER JOIN Proizvod '+
                ' ON ListaProizvodaZahtevaTemp.IDProizvoda = Proizvod.IDTabele '+
                ' INNER JOIN Dobavljac ' +
                ' ON Proizvod.IDDobavljaca = Dobavljac.IDTabele';
    open;
  end;

  with queryStatusPorudzbeniePunjenje do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select * from Status' ;
    open;
  end;

  with queryDobavljaciPorudzbenicaPunjenje do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT ImeDobavljaca FROM Dobavljac' ;
    open;
  end;

  with queryProizvodiZahtevPunjenje do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT  Proizvod.IDTabele as IDProizvoda, Proizvod.ImeProizvoda, Dobavljac.IDTabele as IDDobavljaca, Dobavljac.ImeDobavljaca ' +
                'FROM Proizvod ' +
                'INNER JOIN Dobavljac '+
                'ON Proizvod.IDDobavljaca = Dobavljac.IDTabele' ;
    open;
  end;

  with queryPrikazPorudzbenica do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT Porudzbenica.IDTabele as Indeks, ImePodnosioca, Status.ImeStatusa as Status, DatumPodnosenja ' +
                'FROM Porudzbenica ' +
                'INNER JOIN Status ' +
                'ON Porudzbenica.IDStatus = Status.IDTabele ' +
                'ORDER BY DatumPodnosenja DESC';

    Open;
  end;

    with queryProizvodiNaZahtevu do
  begin
   Close;
   SQL.Clear;
   SQL.Text :=  'SELECT Proizvod.ImeProizvoda, ListaProizvodaZahtev.Kolicina, Proizvod.CenaKupovine ' +
                'FROM ListaProizvodaZahtev ' +
                'INNER JOIN Proizvod ' +
                'ON ListaProizvodaZahtev.IDProizvoda = Proizvod.IDTabele ' +
                'INNER JOIN ZahtevZaNabavku ' +
                'ON ListaProizvodaZahtev.IDZahteva = ZahtevZaNabavku.IDTabele ' +
                'WHERE ZahtevZaNabavku.IDTabele =  ';
  end;

  with queryProizvodiNaPorudzbenici do
  begin
   Close;
   SQL.Clear;
   SQL.Text :=  'SELECT Porudzbenica.IDTabele as Indeks Por, Proizvod.ImeProizvoda, ListaProizvoda.Kolicina, Proizvod.CenaKupovine  ' +
                'FROM ListaProizvoda ' +
                'INNER JOIN Proizvod ' +
                'ON ListaProizvoda.IDProizvoda = Proizvod.IDTabele ' +
                'INNER JOIN Porudzbenica ' +
                'ON ListaProizvoda.IDPorudzbenice = Porudzbenica.IDTabele ' +
                'WHERE Porudzbenica.IDTabele = ';
  end;

  with queryPrikazProizvodaNoveP do
  begin
    Close;
    SQL.Clear;
    SQL.Text := ' SELECT ImeDobavljaca, ImeProizvoda, ListaProizvodaZahtevaTemp.Kolicina as Kolicina, Proizvod.CenaKupovine as Cena ' +
                ' from ListaProizvodaZahtevaTemp ' +
                ' INNER JOIN Proizvod '+
                ' ON ListaProizvodaZahtevaTemp.IDProizvoda = Proizvod.IDTabele '+
                ' INNER JOIN Dobavljac ' +
                ' ON Proizvod.IDDobavljaca = Dobavljac.IDTabele';
    open;
  end;

  with queryPrikazDobavljaca do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Dobavljac' ;
    open;
  end;

  with queryLastIndex do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT last_insert_rowid()' ;
    open;
  end;

  with queryHitnostZahtevPunjenje do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Hitnost' ;
    open;
  end;

  with queryStanjeZahtevPunjenje do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM Stanje' ;
    open;
  end;

end;

end.
