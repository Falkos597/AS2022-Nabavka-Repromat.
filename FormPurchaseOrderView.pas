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
  FMX.StdCtrls, FMX.Edit, FormViewProducts, DataModul;

type
  TfrmPurchaseOrderView = class(TForm)
    Grid1: TGrid;
    buttonNazad: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
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
   mainDataModul.queryPregledPorudzbenica.First;
   var ind :Integer;
   TryStrToInt(Edit1.Text, ind);
   var prov :Boolean := True;

   while NOT mainDataModul.queryPregledPorudzbenica.Eof do
   begin

    if mainDataModul.queryPregledPorudzbenica['Indeks'] = ind then
    begin

      id := mainDataModul.queryPregledPorudzbenica['Indeks'];
      frmViewProducts.idStr := IntToStr(id);
      frmViewProducts.Show;
      frmViewProducts.gridPorudzbenica.Visible := true;
      Self.hide;
      prov :=False;
      break;

    end;

    mainDataModul.queryPregledPorudzbenica.Next;

   end;

  if prov then
  ShowMessage('Uneli ste nepostojeći indeks!');

end;

procedure TfrmPurchaseOrderView.buttonNazadClick(Sender: TObject);
begin
  Self.Hide;
  frmStartView.Show;
end;

end.
