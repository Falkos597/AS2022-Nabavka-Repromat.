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
  Datasnap.Provider, Datasnap.DBClient, Fmx.Bind.Grid, Data.Bind.Grid;

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
    queryDobavljacPunjenje: TFDQuery;
    FDConnection: TFDConnection;
    queryProizvodiPunjenje: TFDQuery;
    Button3: TButton;
    Edit3: TEdit;
    queryPregledListe: TFDQuery;
    queryUnosUTabelu: TFDQuery;
    tablePregledListe: TFDTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    tablePregledListeIDZahteva: TIntegerField;
    tablePregledListeIDProizvoda: TIntegerField;
    tablePregledListeKolicina: TIntegerField;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);


private
    { Private declarations }
  public
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
end;

  var ProizvodjacTemp :String;
  var ProizvodTemp :String;
procedure TfrmAddProduct.Button3Click(Sender: TObject);
begin

  if (ComboBox1.Selected.IsSelected) and (ComboBox2.Selected.IsSelected) then
  begin
    ShowMessage('Loš unos!!!');
    exit
  end else
  begin
    var ProizvodjacTemp := ComboBox1.Selected.Text;
    var ProizvodTemp := ComboBox2.Selected.Text;
  end;

  var ProizvodID :Integer;
  var ProizvodIme := ComboBox2.Selected.Text;
  var KolicinaProizvoda := StrToInt(Edit1.Text);

  queryProizvodiPunjenje.First;

  while not queryProizvodiPunjenje.Eof do
  begin
    if queryProizvodiPunjenje['ImeProizvoda'] = ProizvodIme then
    begin
      ProizvodID := queryProizvodiPunjenje['IDProizvoda'];

      queryUnosUTabelu.ExecSQL('INERT INTO ListaProizvodaZahtevaTemp (IDProizvoda, Kolicina) VALUES (' + IntToStr(ProizvodID) + ', ' + IntToStr(KolicinaProizvoda) + ')');
    end;
    queryProizvodiPunjenje.Next;
  end;


  with queryPregledListe do
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



end;

procedure TfrmAddProduct.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.Enabled:=true;
  ComboBox2.Items.Clear;
    with queryProizvodiPunjenje do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT  Proizvod.IDTabele as IDProizvoda, Proizvod.ImeProizvoda, Dobavljac.IDTabele as IDDobavljaca, Dobavljac.ImeDobavljaca FROM Proizvod INNER JOIN Dobavljac ON Proizvod.IDTabele = Dobavljac.IDTabele;' ;
      open;

      queryProizvodiPunjenje.First;

      while not queryProizvodiPunjenje.Eof do
      begin
      if queryProizvodiPunjenje['ImeDobavljaca']=ComboBox1.Selected.Text then
        begin
          ComboBox2.items.Add(queryProizvodiPunjenje['ImeProizvoda']);
        end;
        queryProizvodiPunjenje.Next;
      end;

    end;


end;



procedure TfrmAddProduct.FormCreate(Sender: TObject);
begin

  FDConnection.Connected := False;
  var path := ExtractFilePath(ParamStr(0)) + '\Nabavka.db';
  FDConnection.Params.Values['Database'] := path;
  FDConnection.Connected := True;

ComboBox2.Enabled:=false;
ComboBox1.Items.Clear;
    with queryDobavljacPunjenje do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'select ImeDobavljaca from Dobavljac' ;
      open;

      queryDobavljacPunjenje.First;

      while not queryDobavljacPunjenje.Eof do
      begin
        ComboBox1.items.Add(queryDobavljacPunjenje['ImeDobavljaca']);

        queryDobavljacPunjenje.Next;
          end;

    end;

end;

end.

