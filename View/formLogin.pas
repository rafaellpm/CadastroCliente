unit formLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  dxGDIPlusClasses, Vcl.Buttons;

type
  TfrmLogin = class(TForm)
    Image1: TImage;
    edtUsuario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtSenha: TEdit;
    btnAcessar: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAcessarClick(Sender: TObject);
    procedure edtUsuarioEnter(Sender: TObject);
    procedure edtSenhaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  uUsuario, dmConexao, formConsultaCliente;

{$R *.dfm}

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
var Usuario : TUsuario;
begin
  if Trim(edtUsuario.Text) = '' then
  begin
    ShowMessage('Usuário não informado');
    Abort;
  end;

  Usuario := TUsuario.Create(dm.fdConn);

  try
    Usuario.Usuario := edtUsuario.Text;
    Usuario.Senha   := edtSenha.Text;

    if Usuario.ValidarLogin() then
    begin
      self.Hide;
      frmConsultaCliente.ShowModal;
    end
    else
    begin
      ShowMessage('Usuário ou Senha Inválidos.');
      edtUsuario.SetFocus;
      edtUsuario.SelectAll;
    end;
    
  finally

  end;
end;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TfrmLogin.edtSenhaEnter(Sender: TObject);
begin
  edtSenha.SelectAll;
end;

procedure TfrmLogin.edtUsuarioEnter(Sender: TObject);
begin
  edtUsuario.SelectAll;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Perform(Wm_NextDlgCtl,0,0);
end;

end.
