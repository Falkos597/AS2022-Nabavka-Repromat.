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
    Grid1: TGrid;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  frmOrderView.Show;

end;

procedure TfrmViewProducts.FormShow(Sender: TObject);
begin

  idStr := IntToStr(frmOrderView.id);
  with FDQuery1 do
  begin
   close;
   SQL.Clear;
   SQL.Text :=  'select porudzbenica.idtabele as Indeks Por, proizvod.ImeProizvoda, listaproizvoda.kolicina ' +
                'from ListaProizvoda ' +
                'inner join Proizvod ' +
                'on ListaProizvoda.IDProizvoda = Proizvod.IDTabele ' +
                'inner join porudzbenica ' +
                'on ListaProizvoda.IDPorudzbenice = Porudzbenica.IDTabele ' +
                'where porudzbenica.idtabele = ' + idStr;
   Open;
  end;
end;

end.
