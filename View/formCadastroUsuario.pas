unit formCadastroUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uUsuario;

type
  TfrmCadastroUsuario = class(TForm)
    Panel1: TPanel;
    btnNovo: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnFechar: TSpeedButton;
    btnCancelar: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    edtCodigo: TEdit;
    edtNomeUsuario: TEdit;
    edtSenha: TEdit;
    btnPesquisar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Usuario : TUsuario;
    procedure CarregarUsuario(AId: Integer);
    procedure LimparTela;
  public
    { Public declarations }
  end;

var
  frmCadastroUsuario: TfrmCadastroUsuario;

implementation

uses
  dmConexao, formConsultaUsuario;

{$R *.dfm}

procedure TfrmCadastroUsuario.btnExcluirClick(Sender: TObject);
begin
  if Usuario.Id > 0 then
  begin
    if MessageDlg('Deseja Realmente Excluir o Usuário?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      Usuario.Deletar();
      LimparTela();
    end;
  end
  else
    ShowMessage('Nenhum Usuário carregado para exclusão');
end;

procedure TfrmCadastroUsuario.LimparTela;
begin
  edtNomeUsuario.Text := '';
  edtSenha.Text       := '';
  edtCodigo.Text      := '';

  Usuario.Clear();
end;

procedure TfrmCadastroUsuario.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroUsuario.btnNovoClick(Sender: TObject);
begin
  if edtNomeUsuario.Text       = '' then
  begin
    ShowMessage('Nome de Usuário não informado');
    Abort;
  end;

  Usuario.Usuario := edtNomeUsuario.Text;
  Usuario.Senha   := edtSenha.Text;

  if StrToIntDef(edtCodigo.Text,0) > 0 then
  begin
    Usuario.Id := StrToInt(edtCodigo.Text);
    Usuario.Atualizar;
    ShowMessage('Usuário Atualizado com Sucesso.');
    LimparTela();
  end
  else
  begin
    if not Usuario.NomeDeUsuarioUtilizado then
    begin
      Usuario.Cadastrar;
      ShowMessage('Usuário cadastro com Sucesso.');
      LimparTela();
    end
    else
      ShowMessage('Já existe um cadastro com o nome de usuário informado');
  end;
end;

procedure TfrmCadastroUsuario.btnPesquisarClick(Sender: TObject);
var frmConsultaUsuario : TfrmConsultaUsuario;
begin
  Application.CreateForm(TfrmConsultaUsuario, frmConsultaUsuario);

  frmConsultaUsuario.ShowModal;

  if frmConsultaUsuario.RetornoConsulta > 0 then
  begin
    CarregarUsuario(frmConsultaUsuario.RetornoConsulta);
  end;
end;

procedure TfrmCadastroUsuario.CarregarUsuario(AId: Integer);
begin
  Usuario.Id := AId;
  Usuario.Carregar();

  edtNomeUsuario.Text := Usuario.Usuario;
  edtSenha.Text       := Usuario.Senha;
  edtCodigo.Text      := IntToStr(Usuario.Id);
end;

procedure TfrmCadastroUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(Usuario) then
    FreeAndNil(Usuario);
end;

procedure TfrmCadastroUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfrmCadastroUsuario.FormShow(Sender: TObject);
begin
  if not Assigned(Usuario) then
    Usuario := TUsuario.Create(dm.fdConn);

end;

procedure TfrmCadastroUsuario.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Todos os Dados Alterados serão perdidos, Deseja Continuar?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    LimparTela();
  end;
end;

end.
