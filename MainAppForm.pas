unit MainAppForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ExtCtrls,
  FormOrderView, FormCreateOrder, FormSupplierView;

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
  frmStartView.Close;
  frmOrderView.Show;
end;

procedure TfrmStartView.createOrderBtnClick(Sender: TObject);
begin
  frmStartView.Close;
  frmCreateOrder.Show;
end;

procedure TfrmStartView.supplierViewBtnClick(Sender: TObject);
begin
  frmStartView.Close;
  frmSupplierView.Show;
end;

end.
