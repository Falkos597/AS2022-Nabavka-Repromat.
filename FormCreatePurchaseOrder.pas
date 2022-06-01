unit FormCreatePurchaseOrder;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.ListBox, FMX.StdCtrls, FMX.Edit, DataModul, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.Effects, FMX.Filter.Effects;

type
  TfrmCreatePurchaseOrder = class(TForm)
    Grid1: TGrid;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label4: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label5: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindingsList1: TBindingsList;
    MaskToAlphaEffect1: TMaskToAlphaEffect;
    ComboBox3: TComboBox;
    Label8: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    var indeksBrojac : Integer;
    { Public declarations }
  end;

var
  frmCreatePurchaseOrder: TfrmCreatePurchaseOrder;

implementation

uses FormPurchaseOrderView;

{$R *.fmx}

procedure TfrmCreatePurchaseOrder.Button1Click(Sender: TObject);
begin
  if (not ComboBox1.Selected.IsSelected) or (not ComboBox2.Selected.IsSelected) or Edit1.Text.IsEmpty then
  begin
    ShowMessage('Loš unos!!!');
    exit
  end;

  ComboBox1.Enabled := False;
  var dobavljac := ComboBox1.Selected.Text;
  var imeProizvoda := ComboBox2.Selected.Text;
  var kolicina := Edit1.Text;
  var ProizvodID : String;
  var uslovID := IntToStr(indeksBrojac);

  mainDataModul.queryProizvodiZahtevPunjenje.First;

  while not mainDataModul.queryProizvodiZahtevPunjenje.Eof do
  begin
    if mainDataModul.queryProizvodiZahtevPunjenje['ImeProizvoda'] = imeProizvoda then
    begin
      ProizvodID := mainDataModul.queryProizvodiZahtevPunjenje['IDProizvoda'];
      mainDataModul.queryInsert.ExecSQL('INSERT INTO ListaProizvodaTemp (IDUnosa, IDProizvoda, Kolicina) VALUES ("' + uslovID + '", "' + ProizvodID + '", "' + kolicina + '")');
      indeksBrojac := indeksBrojac + 1;
      break
    end;
    mainDataModul.queryProizvodiZahtevPunjenje.Next;
  end;

  mainDataModul.queryPrikazProizvodaNovePorudzbenice.Refresh;
end;

procedure TfrmCreatePurchaseOrder.Button2Click(Sender: TObject);
begin

  if Edit2.Text.IsEmpty then
  begin
    ShowMessage('Unesite Indeks koji želite da izbrišete.');
    exit
  end;

  var indeks := Edit2.Text.ToInteger;

  mainDataModul.queryPrikazProizvodaNovePorudzbenice.First;
  while not mainDataModul.queryPrikazProizvodaNovePorudzbenice.Eof do
  begin
    if mainDataModul.queryPrikazProizvodaNovePorudzbenice['Indeks'] = indeks then
    begin
      mainDataModul.queryInsert.ExecSQL('DELETE FROM ListaProizvodaTemp WHERE IDUnosa = ' + IntToStr(indeks));
      mainDataModul.queryPrikazProizvodaNovePorudzbenice.Refresh;
      Edit2.Text := '';
      if mainDataModul.queryPrikazProizvodaNovePorudzbenice.RecordCount = 0 then
      begin
        ComboBox1.Enabled := True;
        indeksBrojac := 0;
      end;

      exit
    end;

    mainDataModul.queryPrikazProizvodaNovePorudzbenice.Next;
  end;

  ShowMessage('Uneli ste nepostojeci indeks;');
end;

procedure TfrmCreatePurchaseOrder.Button3Click(Sender: TObject);
begin
  if Edit3.Text.IsEmpty then
  begin
    ShowMessage('Unesite ime podnosioca!');
    exit
  end;
  if mainDataModul.queryPrikazProizvodaNovePorudzbenice.RecordCount = 0 then
  begin
    ShowMessage('Unesite proizvode na porudžbenici!');
    exit
  end;

  var imePodnosioca := Edit3.Text;
  var imeStatusa := ComboBox3.Selected.Text;
  var stanjeID : Integer;
  var dateAndTime := TimeToStr(Now)+ ' ' + DateToStr(Now);

  mainDataModul.queryStatusPorudzbeniePunjenje.First;

  while not mainDataModul.queryStatusPorudzbeniePunjenje.Eof do
  begin
    if mainDataModul.queryStatusPorudzbeniePunjenje['ImeStatusa'] = imeStatusa then
    begin
      stanjeID := mainDataModul.queryStatusPorudzbeniePunjenje['IDTabele'];
      break
    end;

    mainDataModul.queryStatusPorudzbeniePunjenje.Next;
  end;


  mainDataModul.queryInsert.ExecSQL('INSERT INTO Porudzbenica (IDStatus, ImePodnosioca, DatumPodnosenja) VALUES ("' +IntToStr(stanjeID)+ '", "' +imePodnosioca+ '", "' +dateAndTime+ '")');
  mainDataModul.queryLastIndex.Refresh;
  var indeksOfLastPor := mainDataModul.queryLastIndex['last_insert_rowid()'];

  mainDataModul.queryPrikazProizvodaNovePorudzbenice.First;
  while not mainDataModul.queryPrikazProizvodaNovePorudzbenice.Eof do
  begin
    mainDataModul.queryProizvodiZahtevPunjenje.First;
    while not mainDataModul.queryProizvodiZahtevPunjenje.Eof do
    begin

      if mainDataModul.queryProizvodiZahtevPunjenje['ImeProizvoda'] = mainDataModul.queryPrikazProizvodaNovePorudzbenice['ImeProizvoda'] then
      begin

        var idProizvoda := mainDataModul.queryProizvodiZahtevPunjenje['IDProizvoda'];
        var kolicina := mainDataModul.queryPrikazProizvodaNovePorudzbenice['Kolicina'];
        mainDataModul.queryInsert.ExecSQL('INSERT INTO ListaProizvoda (IDPorudzbenice, IDProizvoda, Kolicina) VALUES(' + IntToStr(indeksOfLastPor).Trim + ', ' + IntToStr(idProizvoda).Trim + ', ' + IntToStr(kolicina).Trim + ')');

      end;

      mainDataModul.queryProizvodiZahtevPunjenje.Next;
    end;

    mainDataModul.queryPrikazProizvodaNovePorudzbenice.Next;
  end;

  mainDataModul.queryDelete.ExecSQL('DELETE FROM ListaProizvodaTemp WHERE 1');
  mainDataModul.queryPrikazPorudzbenica.Refresh;
  mainDataModul.queryPrikazZahtevaZaNabavku.Refresh;

  ShowMessage('Uspesno kreiranje porudzbenice!');
  self.Hide;
  frmPurchaseOrderView.Show;

end;

procedure TfrmCreatePurchaseOrder.Button4Click(Sender: TObject);
begin
  Self.Hide;
  frmPurchaseOrderView.Show;
  mainDataModul.queryPrikazPorudzbenica.Refresh;
end;

procedure TfrmCreatePurchaseOrder.ComboBox1Change(Sender: TObject);
begin
  ComboBox2.Enabled:=true;
  ComboBox2.Items.Clear;

      mainDataModul.queryProizvodiZahtevPunjenje.First;

      while not mainDataModul.queryProizvodiZahtevPunjenje.Eof do
      begin
      if mainDataModul.queryProizvodiZahtevPunjenje['ImeDobavljaca']=ComboBox1.Selected.Text then
        begin
          ComboBox2.items.Add(mainDataModul.queryProizvodiZahtevPunjenje['ImeProizvoda']);
        end;
        mainDataModul.queryProizvodiZahtevPunjenje.Next;
      end;
end;

procedure TfrmCreatePurchaseOrder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmCreatePurchaseOrder.FormShow(Sender: TObject);
begin
  ComboBox2.Enabled := False;
  ComboBox1.Enabled := True;

  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';

  ComboBox1.Items.Clear;
  ComboBox3.Items.Clear;

  mainDataModul.queryDobavljaciZahtevPunjenje.First;

  while not mainDataModul.queryDobavljaciZahtevPunjenje.Eof do
  begin
    ComboBox1.items.Add(mainDataModul.queryDobavljaciZahtevPunjenje['ImeDobavljaca']);
    mainDataModul.queryDobavljaciZahtevPunjenje.Next;
  end;

  mainDataModul.queryStatusPorudzbeniePunjenje.First;

  while not mainDataModul.queryStatusPorudzbeniePunjenje.Eof do
  begin
    ComboBox3.items.Add(mainDataModul.queryStatusPorudzbeniePunjenje['ImeStatusa']);
    mainDataModul.queryStatusPorudzbeniePunjenje.Next;
  end;

  indeksBrojac := 0;

  mainDataModul.queryDelete.ExecSQL('DELETE FROM ListaProizvodaTemp WHERE 1');
  mainDataModul.queryPrikazProizvodaNovePorudzbenice.Refresh;
end;

end.
