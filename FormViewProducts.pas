unit FormViewProducts;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Grid, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.StdCtrls, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope;

type
  TfrmViewProducts = class(TForm)
    gridPorudzbenica: TGrid;
    FDConnection: TFDConnection;
    queryZahtevi: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Button1: TButton;
    queryPorudzbenice: TFDQuery;
    gridZahteva: TGrid;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  idStr :String;
    { Public declarations }
  end;

var
  frmViewProducts: TfrmViewProducts;

implementation

uses FormOrderView;

{$R *.fmx}

procedure TfrmViewProducts.Button1Click(Sender: TObject);
begin

  frmViewProducts.Close;
  gridPorudzbenica.Visible := false;
  gridZahteva.Visible := false;
  frmRequestOrderView.Show;

end;

procedure TfrmViewProducts.FormCreate(Sender: TObject);
begin

  FDConnection.Connected := False;
  var path := ExtractFilePath(ParamStr(0)) + '\Nabavka.db';
  FDConnection.Params.Values['Database'] := path;
  FDConnection.Connected := True;

end;

procedure TfrmViewProducts.FormShow(Sender: TObject);
begin

  //Query za pregled proizvoda na zahtevu za nabavku
  with queryZahtevi do
  begin
   Close;
   SQL.Clear;
   SQL.Text :=  'SELECT Proizvod.ImeProizvoda, ListaProizvodaZahtev.Kolicina, Proizvod.CenaKupovine ' +
                'FROM ListaProizvodaZahtev ' +
                'INNER JOIN Proizvod ' +
                'ON ListaProizvodaZahtev.IDProizvoda = Proizvod.IDTabele ' +
                'INNER JOIN ZahtevZaNabavku ' +
                'ON ListaProizvodaZahtev.IDZahteva = ZahtevZaNabavku.IDTabele ' +
                'WHERE ZahtevZaNabavku.IDTabele =  '+ idStr;
  end;

  //Query za pregled proizvoda na porudzbenici
  with queryPorudzbenice do
  begin
   Close;
   SQL.Clear;
   SQL.Text :=  'SELECT Porudzbenica.IDTabele as Indeks Por, Proizvod.ImeProizvoda, ListaProizvoda.Kolicina, Proizvod.CenaKupovine  ' +
                'FROM ListaProizvoda ' +
                'INNER JOIN Proizvod ' +
                'ON ListaProizvoda.IDProizvoda = Proizvod.IDTabele ' +
                'INNER JOIN Porudzbenica ' +
                'ON ListaProizvoda.IDPorudzbenice = Porudzbenica.IDTabele ' +
                'WHERE Porudzbenica.IDTabele = ' + idStr;
  end;

end;

end.
