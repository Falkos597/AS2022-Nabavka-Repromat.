program Nabavka;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormSignIn in 'FormSignIn.pas' {frmSignUp},
  FormSignUp in 'FormSignUp.pas' {frmSignIn},
  MainAppForm in 'MainAppForm.pas' {frmStartView},
  FormOrderView in 'FormOrderView.pas' {frmRequestOrderView},
  FormSupplierView in 'FormSupplierView.pas' {frmSupplierView},
  FormCreateOrder in 'FormCreateOrder.pas' {frmCreateOrder},
  FormViewProducts in 'FormViewProducts.pas' {frmViewProducts},
  FormPurchaseOrderView in 'FormPurchaseOrderView.pas' {frmPurchaseOrderView},
  FormAddProduct in 'FormAddProduct.pas' {frmAddProduct};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TfrmStartView, frmStartView);
  Application.CreateForm(TfrmRequestOrderView, frmRequestOrderView);
  Application.CreateForm(TfrmSignIn, frmSignIn);
  Application.CreateForm(TfrmSupplierView, frmSupplierView);
  Application.CreateForm(TfrmCreateOrder, frmCreateOrder);
  Application.CreateForm(TfrmViewProducts, frmViewProducts);
  Application.CreateForm(TfrmPurchaseOrderView, frmPurchaseOrderView);
  Application.CreateForm(TfrmAddProduct, frmAddProduct);
  Application.Run;
end.
