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
    Button2: TButton;
    Grid1: TGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label2: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure backBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

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
  frmRequestOrderView.Close;
  frmStartView.Show;
end;

procedure TfrmRequestOrderView.Button1Click(Sender: TObject);
begin

   mainDataModul.queryPregledZahtevaZaNabavku.First;
   var ind :Integer;
   TryStrToInt(Edit1.Text, ind);
   var prov :Boolean := True;

   while NOT mainDataModul.queryPregledZahtevaZaNabavku.Eof do
   begin

    if mainDataModul.queryPregledZahtevaZaNabavku['Indeks'] = ind then
    begin

      id := mainDataModul.queryPregledZahtevaZaNabavku['Indeks'];
      frmViewProducts.idStr := IntToStr(id);
      frmViewProducts.Show;
      frmViewProducts.gridZahteva.Visible := true;
      frmRequestOrderView.hide;
      prov :=False;
      break;

    end;

    mainDataModul.queryPregledZahtevaZaNabavku.Next;

   end;
  if prov then
  ShowMessage('Uneli ste nepostoje?i indeks!');

end;

procedure TfrmRequestOrderView.Button4Click(Sender: TObject);
begin
  self.Hide;
  frmCreateOrder.Show;
end;

end.
