unit FormSupplierView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  Data.DbxSqlite, Data.FMTBcd, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, FMX.Grid,
  Data.Bind.DBScope, Data.SqlExpr, Data.DB, FMX.ScrollBox;

type
  TfrmSupplierView = class(TForm)
    backBtn: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Grid1: TGrid;
    procedure backBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSupplierView: TfrmSupplierView;

implementation

  uses MainAppForm;

{$R *.fmx}

procedure TfrmSupplierView.backBtnClick(Sender: TObject);
begin
  frmSupplierView.Hide;
  frmStartView.Show;
end;

end.
