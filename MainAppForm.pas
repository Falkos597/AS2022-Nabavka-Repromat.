unit MainAppForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ExtCtrls,
  FormOrderView, FormCreateOrder, FormSupplierView, FormPurchaseOrderView, FormProductView;

type
  TfrmStartView = class(TForm)
    orderViewBtn: TButton;
    createOrderBtn: TButton;
    supplierViewBtn: TButton;
    ImageViewer1: TImageViewer;
    Button2: TButton;
    procedure orderViewBtnClick(Sender: TObject);
    procedure createOrderBtnClick(Sender: TObject);
    procedure supplierViewBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStartView: TfrmStartView;

implementation

{$R *.fmx}

procedure TfrmStartView.orderViewBtnClick(Sender: TObject);
begin
  self.Hide;
  frmRequestOrderView.Show;
end;

procedure TfrmStartView.Button2Click(Sender: TObject);
begin
  self.Hide;
  frmPurchaseOrderView.Show;
end;

procedure TfrmStartView.createOrderBtnClick(Sender: TObject);
begin
  self.Hide;
  frmProductView.Show;
end;

procedure TfrmStartView.supplierViewBtnClick(Sender: TObject);
begin
  self.Hide;
  frmSupplierView.Show;
end;

end.
