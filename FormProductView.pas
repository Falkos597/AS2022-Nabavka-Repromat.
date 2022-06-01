unit FormProductView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.Edit, DataModul, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope ;

type
  TfrmProductView = class(TForm)
    Grid1: TGrid;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    backBtn: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label7: TLabel;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    procedure backBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProductView: TfrmProductView;

implementation

uses MainAppForm,  FormProductAdd, FormProductUpdate;


{$R *.fmx}

procedure TfrmProductView.backBtnClick(Sender: TObject);
begin
self.Hide;
frmStartView.Show;
end;

procedure TfrmProductView.Button2Click(Sender: TObject);
begin
    self.Hide();
    ProductAdd.Show();

end;

procedure TfrmProductView.Button3Click(Sender: TObject);
begin
if(Edit1.Text.IsEmpty) then
  begin
    ShowMessage('Unesite indeks dobavljaca!');
    exit
  end;

  var indeks := Edit1.Text.ToInteger;

  mainDataModul.queryPrikazProizvoda.First;
  while not mainDataModul.queryPrikazProizvoda.Eof do
  begin
    if mainDataModul.queryPrikazProizvoda['Indeks'] = IntToStr(indeks) then
    begin
      mainDataModul.queryDelete.ExecSQL('DELETE FROM Proizvod WHERE IDTabele = ' + IntToStr(indeks));
      ShowMessage('Uspesno brisanje.');
      mainDataModul.queryPrikazProizvoda.Refresh;
      exit
    end;

  mainDataModul.queryPrikazProizvoda.Next;

  end;

  ShowMessage('Uneli ste nepostojeci indeks!');
end;

procedure TfrmProductView.Button4Click(Sender: TObject);
begin
if(Edit1.Text.IsEmpty) then
  begin
    ShowMessage('Unesite indeks dobavljaca!');
    exit
  end;

  var indeks := Edit1.Text.ToInteger;


  mainDataModul.queryPrikazProizvoda.First;
  while not mainDataModul.queryPrikazProizvoda.Eof do
  begin
    if mainDataModul.queryPrikazProizvoda['Indeks'] = IntToStr(indeks) then
    begin

      frmProductUpdate.ProizvodID := mainDataModul.queryPrikazProizvoda['Indeks'];
      frmProductUpdate.ImeDobavljaca := mainDataModul.queryPrikazProizvoda['ImeDobavljaca'];
      frmProductUpdate.Edit1.Text := mainDataModul.queryPrikazProizvoda['ImeProizvoda'];
      frmProductUpdate.Edit2.Text := mainDataModul.queryPrikazProizvoda['CenaKupovine'];
      frmProductUpdate.Edit3.Text := mainDataModul.queryPrikazProizvoda['Kolicina'];

      self.Hide;
      frmProductUpdate.Show;
      exit
    end;

  mainDataModul.queryPrikazProizvoda.Next;
  end;

  ShowMessage('Uneli ste nepostojeci indeks!');;
end;

procedure TfrmProductView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Application.Terminate;
end;

end.
