unit uCliente;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  System.SysUtils, uCidades;

type TCliente = class
  private
    vConexao : TFDConnection;
    FIdCidade: Integer;
    procedure SetIdCidade(const Value: Integer);

  protected
    FEmail       : string;
    FNomeCliente : String;
    FCpfCnpj     : string;
    FId          : Integer;
    FEndereco    : string;
    FCelular     : string;
    procedure SetCelular(const Value: string);
    procedure SetCpfCnpj(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetId(const Value: Integer);
    procedure SetNomeCliente(const Value: String);

  published
    property Id          : Integer read FId          write SetId;
    property NomeCliente : String  read FNomeCliente write SetNomeCliente;
    property Endereco    : string  read FEndereco    write SetEndereco;
    property CpfCnpj     : string  read FCpfCnpj     write SetCpfCnpj;
    property Celular     : string  read FCelular     write SetCelular;
    property Email       : string  read FEmail       write SetEmail;
    property IdCidade    : Integer read FIdCidade    write SetIdCidade;

    var Cidade : TCidades;

    procedure Cadastrar;
    procedure Atualizar;
    procedure Carregar;
    procedure Deletar;
    procedure Clear;

    function RetornaQryConsulta : TFDQuery;
    function CpfCnpjJaCadastrado : Boolean;

    constructor Create(AFdConn: TFDConnection);
end;

implementation

uses
  uFuncoes;

{ TCliente }

procedure TCliente.Atualizar;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('UPDATE CLIENTES SET');
    QryExec.SQL.Add('NOME_CLIENTE = :NOME_CLIENTE, CPF_CNPJ = :CPF_CNPJ, ENDERECO = :ENDERECO,');
    QryExec.SQL.Add('CELULAR = :CELULAR, EMAIL = :EMAIL, ID_CIDADE = :ID_CIDADE');
    QryExec.SQL.Add('WHERE ROWID = :ROWID');
    QryExec.ParamByName('ROWID').AsInteger       := Id;
    QryExec.ParamByName('NOME_CLIENTE').AsString := NomeCliente;
    QryExec.ParamByName('CPF_CNPJ').AsString     := CpfCnpj;
    QryExec.ParamByName('ENDERECO').AsString     := Endereco;
    QryExec.ParamByName('CELULAR').AsString      := Celular;
    QryExec.ParamByName('EMAIL').AsString        := Email;


    Cidade.PopularIdCidade;

    QryExec.ParamByName('ID_CIDADE').AsInteger   := Cidade.Id;

    QryExec.ExecSQL;

  except on E: Exception do
    raise Exception.Create('Erro ao Atualizar Cliente.... ' + #13#10 + ' Erro : '+ e.Message);
  end;

  FreeAndNil(QryExec);
end;

procedure TCliente.Cadastrar;
var QryExec : TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('INSERT INTO CLIENTES');
    QryExec.SQL.Add('(NOME_CLIENTE, CPF_CNPJ, ENDERECO, CELULAR, EMAIL, ID_CIDADE)');
    QryExec.SQL.Add('VALUES ');
    QryExec.SQL.Add('(:NOME_CLIENTE, :CPF_CNPJ, :ENDERECO, :CELULAR, :EMAIL, ID_CIDADE)');
    QryExec.ParamByName('NOME_CLIENTE').AsString := NomeCliente;
    QryExec.ParamByName('CPF_CNPJ').AsString     := CpfCnpj;
    QryExec.ParamByName('ENDERECO').AsString     := Endereco;
    QryExec.ParamByName('CELULAR').AsString      := Celular;
    QryExec.ParamByName('EMAIL').AsString        := Email;

    Cidade.PopularIdCidade;

    QryExec.ParamByName('ID_CIDADE').AsInteger   := Cidade.Id;

    QryExec.ExecSQL;

  except on E: Exception do
    raise Exception.Create('Erro ao Cadastrar Cliente.... ' + #13#10 + ' Erro : '+ e.Message);
  end;

  FreeAndNil(QryExec);
end;

procedure TCliente.Carregar;
var QryCons: TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT ROWID, * FROM CLIENTES');
    QryCons.SQL.Add('WHERE ROWID = :ROWID');
    QryCons.ParamByName('ROWID').AsInteger := Id;
    QryCons.Open();

    NomeCliente := QryCons.FieldByName('NOME_CLIENTE').AsString;
    CpfCnpj     := QryCons.FieldByName('CPF_CNPJ').AsString;
    Endereco    := QryCons.FieldByName('ENDERECO').AsString;
    Celular     := QryCons.FieldByName('CELULAR').AsString;
    Email       := QryCons.FieldByName('EMAIL').AsString;
    IdCidade    := QryCons.FieldByName('ID_CIDADE').AsInteger;

    Cidade.Id := IdCidade;
    Cidade.Carregar;

  except on E: Exception do
    raise Exception.Create('Erro ao Consultar Cliente.... ' + #13#10 + ' Erro : '+ e.Message);
  end;
  FreeAndNil(QryCons);
end;

procedure TCliente.Clear;
begin
  Id := 0;
  NomeCliente := '';
  Endereco := '';
  CpfCnpj := '';
  Celular := '';
  Email := '';
end;

function TCliente.CpfCnpjJaCadastrado: Boolean;
var QryCons : TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);
    Result := False;

    QryCons.SQL.Add('SELECT  ROWID, * FROM CLIENTES');
    QryCons.SQL.Add('WHERE CPF_CNPJ = :CPF_CNPJ');
    QryCons.ParamByName('CPF_CNPJ').AsString := CpfCnpj;
    QryCons.Open();

    if not QryCons.IsEmpty then
      Result := True
  finally
    FreeAndNil(QryCons);
  end;
end;

constructor TCliente.Create(AFdConn: TFDConnection);
begin
  vConexao := AFdConn;
  Cidade   := TCidades.Create(vConexao);
end;

procedure TCliente.Deletar;
var QryExec: TFDQuery;
begin
  try
    QryExec := CriarQuery(vConexao);

    QryExec.SQL.Add('DELETE FROM CLIENTES');
    QryExec.SQL.Add('WHERE ROWID = :ROWID');
    QryExec.ParamByName('ROWID').AsInteger := Id;
    QryExec.ExecSQL();

    Clear();

    FreeAndNil(QryExec);
  except on E : exception do
    raise Exception.Create('Erro ao Consultar Clientes');
  end;
end;

function TCliente.RetornaQryConsulta: TFDQuery;
var QryCons: TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT C.ROWID, C.*, CI.CIDADE, CI.UF FROM CLIENTES AS C ');
    QryCons.SQL.Add('INNER JOIN CIDADES AS CI ON CI.ROWID = C.ID_CIDADE');
    QryCons.SQL.Add('WHERE C.NOME_CLIENTE LIKE :NOME_CLIENTE');
    QryCons.ParamByName('NOME_CLIENTE').AsString := '%' + NomeCliente + '%';
    QryCons.Open();

    Result := QryCons;

  except on E : exception do
    raise Exception.Create('Erro ao Consultar Clientes');
  end;
end;

procedure TCliente.SetCelular(const Value: string);
begin
  FCelular := Value;
end;

procedure TCliente.SetCpfCnpj(const Value: string);
begin
  FCpfCnpj := Value;
end;

procedure TCliente.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TCliente.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TCliente.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TCliente.SetIdCidade(const Value: Integer);
begin
  FIdCidade := Value;
end;

procedure TCliente.SetNomeCliente(const Value: String);
begin
  FNomeCliente := Value;
end;

end.
