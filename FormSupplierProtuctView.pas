unit FormSupplierProtuctView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, DataModul, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope;

type
  TfrmSupplierProductView = class(TForm)
    Label7: TLabel;
    btnZahtev: TButton;
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure FormShow(Sender: TObject);
    procedure btnZahtevClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    var dobavljacID : String;
    { Public declarations }
  end;

var
  frmSupplierProductView: TfrmSupplierProductView;

implementation

uses FormSupplierView;

{$R *.fmx}

procedure TfrmSupplierProductView.btnZahtevClick(Sender: TObject);
begin
  self.hide;
  frmSupplierView.Show;
end;

procedure TfrmSupplierProductView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmSupplierProductView.FormShow(Sender: TObject);
begin
with mainDataModul.queryPrikazProizvodaDobavljaca do
  begin
    SQL.Text := 'SELECT Proizvod.ImeProizvoda, Dobavljac.ImeDobavljaca, Proizvod.CenaKupovine ' +
                'FROM Proizvod ' +
                'INNER JOIN Dobavljac ' +
                'ON Proizvod.IDDobavljaca = Dobavljac.IDTabele ' +
                'WHERE Dobavljac.IDTabele =  ' + dobavljacID;
    Open;
  end;
end;

end.
