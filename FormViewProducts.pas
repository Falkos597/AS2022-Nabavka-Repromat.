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
  Data.Bind.Grid, Data.Bind.DBScope, DataModul;

type
  TfrmViewProducts = class(TForm)
    Button1: TButton;
    gridPorudzbenica: TGrid;
    gridZahteva: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
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
  gridPorudzbenica.Visible := false;
  gridZahteva.Visible := false;
  frmRequestOrderView.Show;

end;

procedure TfrmViewProducts.FormShow(Sender: TObject);
begin

  with mainDataModul.queryProizvodiNaZahtevu do
  begin
    SQL.Text := SQL.Text + idStr;
    Open;
  end;

  with mainDataModul.queryProizvodiNaPorudzbenici do
  begin
    SQL.Text := SQL.Text + idStr;
    Open;
  end;

end;

end.
