unit formConsultaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.ImageList, Vcl.ImgList;

type
  TfrmConsultaCliente = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    edtConsulta: TEdit;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    dsConsulta: TDataSource;
    memConsultaCliente: TFDMemTable;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnImprimir: TSpeedButton;
    btnFinalizar: TSpeedButton;
    btnUsuarios: TSpeedButton;
    memConsultaClienteROWID: TIntegerField;
    memConsultaClienteNOME_CLIENTE: TStringField;
    memConsultaClienteCPF_CNPJ: TStringField;
    memConsultaClienteENDERECO: TStringField;
    memConsultaClienteCELULAR: TStringField;
    memConsultaClienteEMAIL: TStringField;
    memConsultaClienteCIDADE: TStringField;
    memConsultaClienteUF: TStringField;
    procedure btnNovoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnUsuariosClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CarregarClientes;
  public
    { Public declarations }
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

uses
  dmConexao, formCadastroCliente, uCliente, formLogin, formCadastroUsuario, formRelatorioCliente;

{$R *.dfm}

procedure TfrmConsultaCliente.BitBtn1Click(Sender: TObject);
begin
  CarregarClientes();
end;

procedure TfrmConsultaCliente.btnEditarClick(Sender: TObject);
var frmCadastroCliente : TfrmCadastroCliente;
    Cliente : TCliente;
begin
  if memConsultaCliente.IsEmpty then
    Exit;


  Cliente := TCliente.Create(dm.fdConn);
  Cliente.Id := memConsultaClienteROWID.AsInteger;
  Cliente.Carregar;

  try
    Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);


    frmCadastroCliente.CarregaCliente(Cliente);
    frmCadastroCliente.ShowModal;
  finally
    FreeAndNil(frmCadastroCliente);
    CarregarClientes();
  end;
end;

procedure TfrmConsultaCliente.btnExcluirClick(Sender: TObject);
var Cliente : TCliente;
begin
  Cliente := TCliente.Create(dm.fdConn);
  try
    if not memConsultaCliente.IsEmpty then
    begin
      if MessageDlg('Deseja Realmente Excluir o Cliente?', mtConfirmation, mbYesNo, 0) = mrYes then
      begin
        Cliente.Id := memConsultaClienteROWID.AsInteger;
        Cliente.Deletar();
        CarregarClientes();
      end;
    end
    else
      ShowMessage('Nenhum Cliente carregado para exclusão');
  finally
    FreeAndNil(Cliente);
  end;
end;

procedure TfrmConsultaCliente.btnFinalizarClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmConsultaCliente.btnImprimirClick(Sender: TObject);
var frmRelatorioCliente : TfrmRelatorioCliente;
begin
  frmRelatorioCliente := TfrmRelatorioCliente.Create(nil);
  frmRelatorioCliente.memRelatorioCliente.CopyDataSet(memConsultaCliente);

  frmRelatorioCliente.rlrRelatorio.Preview();
end;

procedure TfrmConsultaCliente.btnNovoClick(Sender: TObject);
var frmCadastroCliente : TfrmCadastroCliente;
begin
  try
    Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);

    frmCadastroCliente.ShowModal;
  finally
    FreeAndNil(frmCadastroCliente);
    CarregarClientes();
  end;
end;

procedure TfrmConsultaCliente.btnUsuariosClick(Sender: TObject);
var frmCadastroUsuario : TfrmCadastroUsuario;
begin
  try
    Application.CreateForm(TfrmCadastroUsuario, frmCadastroUsuario);

    frmCadastroUsuario.ShowModal;
  finally
    FreeAndNil(frmCadastroUsuario);
    CarregarClientes();
  end;

end;

procedure TfrmConsultaCliente.CarregarClientes;
var Clientes : TCliente;
begin
  Clientes := TCliente.Create(dm.fdConn);

  if Trim(edtConsulta.Text) <> '' then
    Clientes.NomeCliente := edtConsulta.Text;

  memConsultaCliente.Close;
  memConsultaCliente.Open;
  memConsultaCliente.CopyDataSet(Clientes.RetornaQryConsulta);
end;

procedure TfrmConsultaCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmConsultaCliente.FormCreate(Sender: TObject);
var frmLogin : TfrmLogin;
begin
  //Login := TfrmLogin.Create(Self);
  Application.CreateForm(TfrmLogin, frmLogin);
  frmLogin.ShowModal;

  if frmLogin.ModalResult = mrCancel then
    Application.Terminate;

  FreeAndNil(frmLogin);
end;

procedure TfrmConsultaCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfrmConsultaCliente.FormShow(Sender: TObject);
begin
  CarregarClientes();
end;

end.


