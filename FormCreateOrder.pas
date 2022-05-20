unit FormCreateOrder;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.ListBox, Datasnap.Provider,FormAddProduct, DataModul,
  Fmx.Bind.Grid, Data.Bind.Grid;

type
  TfrmCreateOrder = class(TForm)
    Label4: TLabel;
    primalacLabel: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Button3: TButton;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
  var indeksBrojac : Integer;
    { Public declarations }
  end;

var
  frmCreateOrder: TfrmCreateOrder;

implementation

uses MainAppForm;

{$R *.fmx}

procedure TfrmCreateOrder.Button1Click(Sender: TObject);
begin
  self.Hide;
  frmStartView.Show;
end;

procedure TfrmCreateOrder.Button3Click(Sender: TObject);
begin
 frmAddProduct.Show;
end;

procedure TfrmCreateOrder.FormShow(Sender: TObject);
begin

indeksBrojac := 0;

ComboBox2.Items.Clear;

  mainDataModul.queryStatusPorudzbeniePunjenje.First;
  while not mainDataModul.queryStatusPorudzbeniePunjenje.Eof do
  begin
    ComboBox2.items.Add(mainDataModul.queryStatusPorudzbeniePunjenje['ImeStatusa']);

    mainDataModul.queryStatusPorudzbeniePunjenje.Next;
  end;

ComboBox1.Items.Clear;

      mainDataModul.queryDobavljaciPorudzbenicaPunjenje.First;
      while not mainDataModul.queryDobavljaciPorudzbenicaPunjenje.Eof do
      begin
        ComboBox1.items.Add(mainDataModul.queryDobavljaciPorudzbenicaPunjenje['ImeDobavljaca']);

        mainDataModul.queryDobavljaciPorudzbenicaPunjenje.Next;
      end;

      mainDataModul.queryDelete.ExecSQL('DELETE FROM ListaProizvodaZahtevaTemp WHERE 1');
      mainDataModul.queryPrikazProizvodaNovePorudzbenice.Refresh;
end;

end.
