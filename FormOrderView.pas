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
  Data.Bind.DBScope, Fmx.Bind.Grid, Data.Bind.Grid, FMX.Edit, FormViewProducts,
  FormCreateOrder, DataModul;

type
  TfrmRequestOrderView = class(TForm)
    buttonNazad: TButton;
    Grid1: TGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label7: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Button6: TButton;
    procedure backBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    id :Integer;
    { Public declarations }
  end;

var
  frmRequestOrderView: TfrmRequestOrderView;

implementation

uses MainAppForm;

{$R *.fmx}

procedure TfrmRequestOrderView.backBtnClick(Sender: TObject);
begin
  frmRequestOrderView.hide;
  frmStartView.Show;
end;

procedure TfrmRequestOrderView.Button1Click(Sender: TObject);
begin

   mainDataModul.queryPrikazZahtevaZaNabavku.First;
   var ind :Integer;
   TryStrToInt(Edit1.Text, ind);


   while NOT mainDataModul.queryPrikazZahtevaZaNabavku.Eof do
   begin

    if mainDataModul.queryPrikazZahtevaZaNabavku['Indeks'] = ind then
    begin

      id := mainDataModul.queryPrikazZahtevaZaNabavku['Indeks'];
      frmViewProducts.idStr := IntToStr(id);
      frmViewProducts.Show;
      frmViewProducts.gridZahteva.Visible := true;
      frmViewProducts.btnZahtev.Visible := true;
      frmRequestOrderView.hide;
      exit

    end;

    mainDataModul.queryPrikazZahtevaZaNabavku.Next;

   end;

  ShowMessage('Uneli ste nepostojeći indeks!');

end;

procedure TfrmRequestOrderView.Button4Click(Sender: TObject);
begin
  self.Hide;
  frmCreateOrder.Show;
end;

procedure TfrmRequestOrderView.Button6Click(Sender: TObject);
begin
   mainDataModul.queryPrikazZahtevaZaNabavku.First;
   var ind :Integer;
   TryStrToInt(Edit1.Text, ind);

   while not mainDataModul.queryPrikazZahtevaZaNabavku.Eof do
   begin

    if mainDataModul.queryPrikazZahtevaZaNabavku['Indeks'] = ind then
    begin

      mainDataModul.queryDelete.ExecSQL('DELETE FROM ListaProizvodaZahtev WHERE IDZahteva = ' + IntToStr(ind));
      mainDataModul.queryDelete.ExecSQL('DELETE FROM ZahtevZaNabavku WHERE IDTabele = ' + IntToStr(ind));
      mainDataModul.queryPrikazZahtevaZaNabavku.Refresh;
      ShowMessage('Uspesno izbrisan zahtev za nabavku sa indeksom ' + IntToStr(ind));
      exit

    end;

    mainDataModul.queryPrikazZahtevaZaNabavku.Next;

   end;

  ShowMessage('Uneli ste nepostojeći indeks!');
end;

procedure TfrmRequestOrderView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Application.Terminate;
end;

procedure TfrmRequestOrderView.FormShow(Sender: TObject);
begin
  mainDataModul.queryPrikazZahtevaZaNabavku.Refresh;
end;

end.
