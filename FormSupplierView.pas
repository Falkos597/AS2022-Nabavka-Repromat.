unit FormSupplierView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  Data.DbxSqlite, Data.FMTBcd, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, FMX.Grid,
  Data.Bind.DBScope, Data.SqlExpr, Data.DB, FMX.ScrollBox, FMX.Edit, DataModul,
  Fmx.Bind.Grid, Data.Bind.Grid, FormAddSupplier, FormUpdateSupplier, FormSupplierProtuctView;

type
  TfrmSupplierView = class(TForm)
    StringGrid1: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    backBtn: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label7: TLabel;
    procedure backBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
  var indeks : Integer;
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

procedure TfrmSupplierView.Button1Click(Sender: TObject);
begin
  if(Edit1.Text.IsEmpty) then
  begin
    ShowMessage('Unesite indeks dobavljaca!');
    exit
  end;

  frmSupplierProductView.dobavljacID := Edit1.Text;

  self.Hide;
  frmSupplierProductView.show;
end;

procedure TfrmSupplierView.Button2Click(Sender: TObject);
begin
Self.Hide;
frmAddSupplier.Show;
end;

procedure TfrmSupplierView.Button3Click(Sender: TObject);
begin
  if(Edit1.Text.IsEmpty) then
  begin
    ShowMessage('Unesite indeks dobavljaca!');
    exit
  end;

  indeks := Edit1.Text.ToInteger;

  mainDataModul.queryPrikazDobavljaca.First;
  while not mainDataModul.queryPrikazDobavljaca.Eof do
  begin
    if mainDataModul.queryPrikazDobavljaca['IDTabele'] = IntToStr(indeks) then
    begin
      mainDataModul.queryDelete.ExecSQL('DELETE FROM Dobavljac WHERE IDTabele = ' + IntToStr(indeks));
      ShowMessage('Uspesno brisanje.');
      mainDataModul.queryPrikazDobavljaca.Refresh;
      exit
    end;

  mainDataModul.queryPrikazDobavljaca.Next;
  end;
end;

procedure TfrmSupplierView.Button4Click(Sender: TObject);
begin
  if(Edit1.Text.IsEmpty) then
  begin
    ShowMessage('Unesite indeks dobavljaca!');
    exit
  end;

  indeks := Edit1.Text.ToInteger;

  mainDataModul.queryPrikazDobavljaca.First;
  while not mainDataModul.queryPrikazDobavljaca.Eof do
  begin
    if mainDataModul.queryPrikazDobavljaca['IDTabele'] = IntToStr(indeks) then
    begin

      frmUpdateSupplier.dobavljacId := mainDataModul.queryPrikazDobavljaca['IDTabele'];
      frmUpdateSupplier.Edit1.Text := mainDataModul.queryPrikazDobavljaca['ImeDobavljaca'];
      frmUpdateSupplier.Edit2.Text := mainDataModul.queryPrikazDobavljaca['Zemlja'];
      frmUpdateSupplier.Edit3.Text := mainDataModul.queryPrikazDobavljaca['Grad'];
      frmUpdateSupplier.Edit4.Text := mainDataModul.queryPrikazDobavljaca['Ulica'];
      frmUpdateSupplier.Edit5.Text := mainDataModul.queryPrikazDobavljaca['Email'];

      self.Hide;
      frmUpdateSupplier.Show;
      exit

    end;

  mainDataModul.queryPrikazDobavljaca.Next;
  end;

end;

procedure TfrmSupplierView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

end.
