unit formCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Mask, uCliente,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait;

type
  TfrmCadastroCliente = class(TForm)
    Panel1: TPanel;
    btnNovo: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnFechar: TSpeedButton;
    btnCancelar: TSpeedButton;
    GroupBox1: TGroupBox;
    edtCodigo: TEdit;
    Label1: TLabel;
    edtNomeCliente: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtEndereco: TEdit;
    Label4: TLabel;
    edtCelular: TEdit;
    Label5: TLabel;
    edtEmail: TEdit;
    Label6: TLabel;
    edtCpfCnpj: TEdit;
    cbbUF: TComboBox;
    Label7: TLabel;
    cbbCidade: TComboBox;
    Label8: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure edtCelularExit(Sender: TObject);
    procedure edtCpfCnpjExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnNovoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEmailExit(Sender: TObject);
    procedure cbbUFExit(Sender: TObject);
  private
    { Private declarations }
    Cliente : TCliente;
    procedure LimparTela;
    procedure ValidarCampos;
    procedure CarregaCidades;
    procedure CarregaUFs;
  public
    { Public declarations }
    procedure CarregaCliente(ACliente: TCliente);
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  dmConexao, uFuncoes, uCidades;

{$R *.dfm}

procedure TfrmCadastroCliente.btnExcluirClick(Sender: TObject);
begin
  if Cliente.Id > 0 then
  begin
    if MessageDlg('Deseja Realmente Excluir o Cliente?', mtConfirmation, mbYesNo, 0) = mrYes then
      Cliente.Deletar();
  end
  else
    ShowMessage('Nenhum Cliente carregado para exclusão');
end;

procedure TfrmCadastroCliente.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroCliente.btnNovoClick(Sender: TObject);
begin
  ValidarCampos();
  try
    Cliente.NomeCliente   := edtNomeCliente.Text;
    Cliente.CpfCnpj       := edtCpfCnpj.Text;
    Cliente.Endereco      := edtEndereco.Text;
    Cliente.Celular       := edtCelular.Text;
    Cliente.Email         := edtEmail.Text;
    Cliente.Cidade.Cidade := cbbCidade.Text;
    Cliente.Cidade.UF     := cbbUF.Text;

    if StrToIntDef(edtCodigo.Text, 0) > 0 then
    begin
      Cliente.Id := StrToInt(edtCodigo.Text);
      Cliente.Atualizar();
      ShowMessage('Cliente Atualizado com Sucesso.');
      LimparTela();
    end
    else
    begin
      if not Cliente.CpfCnpjJaCadastrado then
      begin
        Cliente.Cadastrar();
        ShowMessage('Cliente Cadastro com Sucesso.');
        LimparTela();
      end
      else
        ShowMessage('Já existe um cadastro com o CPF/CNPJ informado');
    end;

  except on e: exception do
    ShowMessage(e.Message);
  end;
end;

procedure TfrmCadastroCliente.CarregaCliente(ACliente: TCliente);
begin
  Cliente := ACliente;
end;

procedure TfrmCadastroCliente.CarregaCidades;
var Cidade : TCidades;
    QryCons : TFDQuery;
begin
  try
    Cidade := TCidades.Create(dm.fdConn);

    Cidade.UF := cbbUF.Text;
    QryCons := Cidade.RetornarCidadesPorUf;

    cbbCidade.Clear;
    QryCons.First;
    while not QryCons.Eof do
    begin
      cbbCidade.Items.Add(QryCons.FieldByName('CIDADE').AsString);

      QryCons.Next;
    end;
  finally
    FreeAndNil(Cidade);
    FreeAndNil(QryCons);
  end;
end;

procedure TfrmCadastroCliente.CarregaUFs;
var Cidade : TCidades;
    QryCons : TFDQuery;
begin
  try
    Cidade := TCidades.Create(dm.fdConn);
    QryCons := Cidade.RetornarUfs;

    cbbUF.Clear;
    QryCons.First;
    while not QryCons.Eof do
    begin
      cbbUF.Items.Add(QryCons.FieldByName('UF').AsString);

      QryCons.Next;
    end;
    cbbUF.ItemIndex := -1;

  finally
    FreeAndNil(Cidade);
    FreeAndNil(QryCons);
  end;
end;

procedure TfrmCadastroCliente.cbbUFExit(Sender: TObject);
begin
  CarregaCidades();
end;

procedure TfrmCadastroCliente.edtCelularExit(Sender: TObject);
begin
  edtCelular.Text := FormatarTelefone(edtCelular.Text);
end;

procedure TfrmCadastroCliente.edtCpfCnpjExit(Sender: TObject);
begin
  if Trim(edtCpfCnpj.Text) = '' then
    exit;

  if (CpfValido(SomenteNumeros(edtCpfCnpj.Text))) or (CnpjValido(SomenteNumeros(edtCpfCnpj.Text))) then
    edtCpfCnpj.Text := FormatarCPFCNPJ(SomenteNumeros(edtCpfCnpj.Text))
  else
  begin
    ShowMessage('CPF/CNPJ digitado não é válido');
    edtCpfCnpj.SetFocus;
  end;
end;

procedure TfrmCadastroCliente.edtEmailExit(Sender: TObject);
begin
  if Trim(edtEmail.Text) <> '' then
  begin
    if not EmailValido(edtEmail.Text) then
    begin
      ShowMessage('Email digitado não é válido');
      edtEmail.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(Cliente) then
    FreeAndNil(Cliente);
end;

procedure TfrmCadastroCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  if not Assigned(Cliente) then
    Cliente := TCliente.Create(dm.fdConn);

  CarregaUFs;

  if Cliente.Id > 0 then
  begin
    edtCodigo.Text      := IntToStr(Cliente.Id);
    edtNomeCliente.Text := Cliente.NomeCliente;
    edtCpfCnpj.Text     := Cliente.CpfCnpj;
    edtEndereco.Text    := Cliente.Endereco;
    edtCelular.Text     := Cliente.Celular;
    edtEmail.Text       := Cliente.Email;

    cbbUF.Text := Cliente.Cidade.UF;

    CarregaCidades;
    cbbCidade.Text := Cliente.Cidade.Cidade;

    edtNomeCliente.SetFocus;
  end;
end;

procedure TfrmCadastroCliente.LimparTela;
begin
  edtCodigo.Text      := '';
  edtNomeCliente.Text := '';
  edtCpfCnpj.Text     := '';
  edtEndereco.Text    := '';
  edtCelular.Text     := '';
  edtEmail.Text       := '';
  CbbUF.ItemIndex     := -1;
  cbbCidade.Clear;

  Cliente.Clear();
end;

procedure TfrmCadastroCliente.ValidarCampos;
begin
  if edtNomeCliente.Text = '' then
  begin
    ShowMessage('Nome de Cliente não informado');
    Abort;
  end
  else
  if edtCpfCnpj.Text = '' then
  begin
    ShowMessage('CPF/CNPJ não informado');
    Abort;
  end
  else
  if edtEndereco.Text = '' then
  begin
    ShowMessage('Endereço não informado');
    Abort;
  end
  else
  if edtCelular.Text = '' then
  begin
    ShowMessage('Numero de Telefone não informado');
    Abort;
  end
  else
  if edtEmail.Text = '' then
  begin
    ShowMessage('Email não informado');
    Abort;
  end
  else
  if cbbUF.Text = '' then
  begin
    ShowMessage('UF não informada');
    Abort;
  end
  else
  if cbbCidade.Text = '' then
  begin
    ShowMessage('Cidade não informada');
    Abort;
  end;

end;

procedure TfrmCadastroCliente.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Todos os Dados Alterados serão perdidos, Deseja Continuar?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    LimparTela();
  end;
end;

end.
