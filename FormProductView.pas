unit FormProductView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid;

type
  TfrmProductView = class(TForm)
    Grid1: TGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    backBtn: TButton;
    procedure backBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProductView: TfrmProductView;

implementation

uses MainAppForm;


{$R *.fmx}

procedure TfrmProductView.backBtnClick(Sender: TObject);
begin
self.Hide;
frmStartView.Show;
end;

end.
