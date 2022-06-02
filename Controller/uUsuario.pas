unit uUsuario;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  System.SysUtils;


type TUsuario = class
  private
    vConexao : TFDConnection;
  protected
    FId: Integer;
    FSenha: string;
    FUsuario: string;
    procedure SetId(const Value: Integer);
    procedure SetSenha(const Value: string);
    procedure SetUsuario(const Value: string);

  published
    property Id      : Integer read FId      write SetId;
    property Usuario : string  read FUsuario write SetUsuario;
    property Senha   : string  read FSenha   write SetSenha;

    procedure Cadastrar;
    procedure Atualizar;
    procedure Carregar;
    procedure Deletar;

    procedure Clear;

    function ValidarLogin: Boolean;
    function RetornaQryConsulta: TFDQuery;
    function NomeDeUsuarioUtilizado: Boolean;

    constructor Create(AFdConn: TFDConnection);
end;

implementation

uses
  uFuncoes;

{ TUsuario }

procedure TUsuario.Atualizar;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('UPDATE USUARIOS SET');
    QryExec.SQL.Add('USUARIO = :USUARIO, SENHA = :SENHA');
    QryExec.SQL.Add('WHERE ROWID = :ROWID');
    QryExec.ParamByName('ROWID').AsInteger     := Id;
    QryExec.ParamByName('USUARIO').AsString := Usuario;
    QryExec.ParamByName('SENHA').AsString   := Senha;

    QryExec.ExecSQL;

  except on E: Exception do
    raise Exception.Create('Erro ao Atualizar Usuario.... ' + #13#10 + ' Erro : '+ e.Message);
  end;

  FreeAndNil(QryExec);
end;

procedure TUsuario.Cadastrar;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('INSERT INTO USUARIOS');
    QryExec.SQL.Add('(USUARIO, SENHA)');
    QryExec.SQL.Add('VALUES');
    QryExec.SQL.Add('(:USUARIO, :SENHA)');
    QryExec.ParamByName('USUARIO').AsString := Usuario;
    QryExec.ParamByName('SENHA').AsString   := Senha;

    QryExec.ExecSQL;

  except on E: Exception do
    raise Exception.Create('Erro ao Atualizar Usuario.... ' + #13#10 + ' Erro : '+ e.Message);
  end;

  FreeAndNil(QryExec);
end;

procedure TUsuario.Carregar;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT  ROWID, * FROM USUARIOS');
    QryCons.SQL.Add('WHERE ROWID = :ROWID');
    QryCons.ParamByName('ROWID').AsInteger := Id;

    QryCons.Open();

    Usuario := QryCons.FieldByName('USUARIO').AsString;
    Senha   := QryCons.FieldByName('SENHA').AsString;

  except on E: Exception do
    raise Exception.Create('Erro ao Carregar Usuario.... ' + #13#10 + ' Erro : '+ e.Message);
  end;

  FreeAndNil(QryCons);
end;

procedure TUsuario.Clear;
begin
  Usuario := '';
  Senha   := '';
  Id      := 0;
end;

constructor TUsuario.Create(AFdConn: TFDConnection);
begin
  vConexao := AFdConn;
end;

procedure TUsuario.Deletar;
var QryExec: TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('DELETE FROM USUARIOS');
    QryExec.SQL.Add('WHERE ROWID = :ROWID');
    QryExec.ParamByName('ROWID').AsInteger := Id;
    QryExec.ExecSQL();

    Clear();

    FreeAndNil(QryExec);

  except on E : exception do
    raise Exception.Create('Erro ao Consultar Usuários');
  end;
end;

function TUsuario.RetornaQryConsulta: TFDQuery;
var QryCons: TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT ROWID, * FROM USUARIOS');
    QryCons.SQL.Add('WHERE USUARIO LIKE :USUARIO');
    QryCons.ParamByName('USUARIO').AsString := '%' + Usuario + '%';
    QryCons.Open();

    Result := QryCons;

  except on E : exception do
    raise Exception.Create('Erro ao Consultar Usuário');
  end;
end;

procedure TUsuario.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TUsuario.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

procedure TUsuario.SetUsuario(const Value: string);
begin
  FUsuario := Value;
end;

function TUsuario.ValidarLogin: Boolean;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);
    Result := False;

    QryCons.SQL.Add('SELECT  ROWID, * FROM USUARIOS');
    QryCons.SQL.Add('WHERE USUARIO = :USUARIO');
    QryCons.ParamByName('USUARIO').AsString := Usuario;
    QryCons.Open();

    if not QryCons.IsEmpty then
      if QryCons.FieldByName('SENHA').AsString = Senha then
        Result := True;

    FreeAndNil(QryCons);

  except on E: Exception do
    raise Exception.Create('Erro ao Validar Login.... ' + #13#10 + 'Erro : '+ e.Message);
  end;

end;

function TUsuario.NomeDeUsuarioUtilizado: Boolean;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);
    Result := False;

    QryCons.SQL.Add('SELECT  ROWID, * FROM USUARIOS');
    QryCons.SQL.Add('WHERE USUARIO = :USUARIO');
    QryCons.ParamByName('USUARIO').AsString := Usuario;
    QryCons.Open();

    if not QryCons.IsEmpty then
      Result := True
  finally
    FreeAndNil(QryCons);
  end;
end;

end.
