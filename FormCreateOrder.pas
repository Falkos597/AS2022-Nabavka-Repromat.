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
  FireDAC.Comp.Client, FMX.ListBox, Datasnap.Provider,FormAddProduct;

type
  TfrmCreateOrder = class(TForm)
    Label4: TLabel;
    primalacLabel: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    Grid1: TGrid;
    Button1: TButton;
    Button2: TButton;
    StringColumn1: TStringColumn;
    IntegerColumn1: TIntegerColumn;
    CheckColumn1: TCheckColumn;
    IntegerColumn2: TIntegerColumn;
    StringColumn3: TStringColumn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    queryStatusPunjenje: TFDQuery;
    FDConnection: TFDConnection;
    queryDobavljacPunjenje: TFDQuery;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
  public
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
  frmAddProduct.queryUnosUTabelu.ExecSQL('DELETE FROM ListaProizvodaZahtevaTemp');
  frmAddProduct.tablePregledListe.ApplyUpdates(0);
end;

procedure TfrmCreateOrder.Button2Click(Sender: TObject);
begin
    //Kod za eksportovanje u fajl
end;

procedure TfrmCreateOrder.Button3Click(Sender: TObject);
begin
 frmAddProduct.Show;
 self.hide;
end;

procedure TfrmCreateOrder.FormCreate(Sender: TObject);
begin
FDConnection.Connected := True;
  ComboBox2.Items.Clear;
    with queryStatusPunjenje do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'select ImeStatusa from Status' ;
      open;

      queryStatusPunjenje.First;

      while not queryStatusPunjenje.Eof do
      begin
        ComboBox2.items.Add(queryStatusPunjenje['ImeStatusa']);

        queryStatusPunjenje.Next;
      end;

    end;
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

    FDConnection.Connected := False;

end;


end.
