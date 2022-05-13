unit FormPurchaseOrderView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Comp.Client,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.StdCtrls, FMX.Edit, FormViewProducts;

type
  TfrmPurchaseOrderView = class(TForm)
    Grid1: TGrid;
    FDConnection: TFDConnection;
    queryPregled: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    buttonNazad: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure buttonNazadClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    id :Integer;
    { Public declarations }
  end;

var
  frmPurchaseOrderView: TfrmPurchaseOrderView;

implementation

uses MainAppForm;

{$R *.fmx}

procedure TfrmPurchaseOrderView.Button1Click(Sender: TObject);
begin
  queryPregled.First;
   var ind :Integer;
   TryStrToInt(Edit1.Text, ind);
   var prov :Boolean := True;

   while NOT queryPregled.Eof do
   begin

    if queryPregled['Indeks'] = ind then
    begin

      id := queryPregled['Indeks'];
      frmViewProducts.idStr := IntToStr(id);
      frmViewProducts.Show;
      frmViewProducts.gridPorudzbenica.Visible := true;
      frmViewProducts.queryPorudzbenice.Open;
      Self.hide;
      prov :=False;
      break;

    end;

    queryPregled.Next;

   end;
  if prov then
  ShowMessage('Uneli ste nepostojeći indeks!');
end;

procedure TfrmPurchaseOrderView.buttonNazadClick(Sender: TObject);
begin
  Self.Hide;
  frmStartView.Show;
end;

procedure TfrmPurchaseOrderView.FormCreate(Sender: TObject);
begin
  FDConnection.Connected := True;
//  var path := Application.GetNamePath + 'Nabavka.db';
//
//    with FDConnection do
//      begin
//      close;
//        with Params do
//        begin
//          Clear;
//          Add('DriverID=SQLite');
//          Add('Database=' + path);
//        end;
//        Open;
//    end;

  with queryPregled do
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


end;



end.
