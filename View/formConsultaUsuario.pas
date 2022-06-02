unit formConsultaUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmConsultaUsuario = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    edtConsulta: TEdit;
    BitBtn1: TBitBtn;
    memConsultaUsuario: TFDMemTable;
    memConsultaUsuarioROWID: TIntegerField;
    dsConsulta: TDataSource;
    memConsultaUsuarioUSUARIO: TStringField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure CarregarUsuarios;
  public
    { Public declarations }
    RetornoConsulta : Integer;
  end;

var
  frmConsultaUsuario: TfrmConsultaUsuario;

implementation

uses
  uUsuario, dmConexao;

{$R *.dfm}

{ TForm1 }

procedure TfrmConsultaUsuario.BitBtn1Click(Sender: TObject);
begin
  CarregarUsuarios;
end;

procedure TfrmConsultaUsuario.CarregarUsuarios;
var Usuario : TUsuario;
begin
  Usuario := TUsuario.Create(dm.fdConn);

  if Trim(edtConsulta.Text) <> '' then
    Usuario.Usuario := edtConsulta.Text;

  memConsultaUsuario.Close;
  memConsultaUsuario.Open;
  memConsultaUsuario.CopyDataSet(Usuario.RetornaQryConsulta);
end;

procedure TfrmConsultaUsuario.DBGrid1DblClick(Sender: TObject);
begin
  RetornoConsulta := memConsultaUsuarioROWID.AsInteger;
  Close;
end;

procedure TfrmConsultaUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfrmConsultaUsuario.FormShow(Sender: TObject);
begin
  CarregarUsuarios;
end;

end.
