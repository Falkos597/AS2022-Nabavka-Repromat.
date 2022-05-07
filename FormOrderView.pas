unit FormOrderView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ExtCtrls, System.Rtti, FMX.Grid.Style,
  FMX.Grid, FMX.ScrollBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Fmx.Bind.Grid, Data.Bind.Grid, FMX.Edit, FormViewProducts;

type
  TfrmOrderView = class(TForm)
    backBtn: TButton;
    Button2: TButton;
    FDConnection: TFDConnection;
    queryPregled: TFDQuery;
    Grid1: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Edit1: TEdit;
    Label1: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure backBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    id :Integer;
    { Public declarations }
  end;

var
  frmOrderView: TfrmOrderView;

implementation

uses MainAppForm,FormCreateOrder;

{$R *.fmx}

procedure TfrmOrderView.backBtnClick(Sender: TObject);
begin
  frmOrderView.Close;
  frmStartView.Show;
end;

procedure TfrmOrderView.Button1Click(Sender: TObject);
begin

   queryPregled.First;
   var ind :Integer;
   TryStrToInt(Edit1.Text, ind) ;

   while NOT queryPregled.Eof do
   begin

    if queryPregled['Indeks'] = ind then
    begin

      id := queryPregled['Indeks'];
      frmViewProducts.Show;
      frmOrderView.hide;

    end;

    queryPregled.Next;

   end;

end;

procedure TfrmOrderView.Button4Click(Sender: TObject);
begin
  self.Hide;
  frmCreateOrder.Show;
end;

procedure TfrmOrderView.FormCreate(Sender: TObject);
begin

  with queryPregled do
  begin

    Close;
    SQL.Clear;
    SQL.Text := 'select porudzbenica.IDTabele as Indeks, ImePodnosioca, Status.ImeStatusa as Status, DatumPodnosenja from porudzbenica inner join status on porudzbenica.IDStatus = status.IDTabele order by DatumPodnosenja desc' ;
    Open;

  end;

end;

end.
