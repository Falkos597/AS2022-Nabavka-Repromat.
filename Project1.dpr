program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormSignIn in 'FormSignIn.pas' {frmSignUp},
  FormSignUp in 'FormSignUp.pas' {frmSignIn},
  MainAppForm in 'MainAppForm.pas' {frmStartView},
  FormOrderView in 'FormOrderView.pas' {frmOrderView},
  FormSupplierView in 'FormSupplierView.pas' {frmSupplierView},
  FormCreateOrder in 'FormCreateOrder.pas' {frmCreateOrder},
  FormViewProducts in 'FormViewProducts.pas' {frmViewProducts};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TfrmStartView, frmStartView);
  Application.CreateForm(TfrmOrderView, frmOrderView);
  Application.CreateForm(TfrmSignIn, frmSignIn);
  Application.CreateForm(TfrmSupplierView, frmSupplierView);
  Application.CreateForm(TfrmCreateOrder, frmCreateOrder);
  Application.CreateForm(TfrmViewProducts, frmViewProducts);
  Application.Run;
end.
