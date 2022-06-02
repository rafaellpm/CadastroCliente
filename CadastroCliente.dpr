program CadastroCliente;

uses
  Vcl.Forms,
  formConsultaCliente in 'View\formConsultaCliente.pas' {frmConsultaCliente},
  dmConexao in 'DAO\dmConexao.pas' {dm: TDataModule},
  uCliente in 'Controller\uCliente.pas',
  uFuncoes in 'Controller\uFuncoes.pas',
  uUsuario in 'Controller\uUsuario.pas',
  formCadastroCliente in 'View\formCadastroCliente.pas' {frmCadastroCliente},
  formLogin in 'View\formLogin.pas' {frmLogin},
  formCadastroUsuario in 'View\formCadastroUsuario.pas' {frmCadastroUsuario},
  formConsultaUsuario in 'View\formConsultaUsuario.pas' {frmConsultaUsuario},
  formRelatorioCliente in 'View\formRelatorioCliente.pas' {frmRelatorioCliente},
  uCidades in 'Controller\uCidades.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmConsultaCliente, frmConsultaCliente);
  Application.CreateForm(TfrmCadastroUsuario, frmCadastroUsuario);
  Application.CreateForm(TfrmConsultaUsuario, frmConsultaUsuario);
  Application.CreateForm(TfrmRelatorioCliente, frmRelatorioCliente);
  Application.Run;
end.
