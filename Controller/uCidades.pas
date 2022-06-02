unit uCidades;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  System.SysUtils;

type TCidades = class
  private
    vConexao : TFDConnection;
  protected
    FUF: string;
    FId: integer;
    FCidade: string;
    procedure SetCidade(const Value: string);
    procedure SetId(const Value: integer);
    procedure SetUF(const Value: string);
  published
    property Id     : integer read FId     write SetId;
    property Cidade : string  read FCidade write SetCidade;
    property UF     : string  read FUF     write SetUF;

    procedure Carregar;
    procedure PopularIdCidade;

    function RetornarCidadesPorUf: TFDQuery;
    function RetornarUfs: TFDQuery;



    constructor Create(AFdConn: TFDConnection);
end;

implementation

uses
  uFuncoes;

{ TCidades }

procedure TCidades.Carregar;
var QryCons: TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT ROWID, * FROM CIDADES');
    QryCons.SQL.Add('WHERE ROWID = :ROWID');
    QryCons.ParamByName('ROWID').AsInteger := Id;
    QryCons.Open();

    Cidade := QryCons.FieldByName('CIDADE').AsString;
    UF     := QryCons.FieldByName('UF').AsString;

    FreeAndNil(QryCons);

  except on E : exception do
    raise Exception.Create('Erro ao Consultar Cidades');
  end;
end;

constructor TCidades.Create(AFdConn: TFDConnection);
begin
  vConexao := AFdConn;
end;

procedure TCidades.PopularIdCidade;
var QryCons: TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT ROWID, * FROM CIDADES');
    QryCons.SQL.Add('WHERE CIDADE = :CIDADE AND UF = :UF');
    QryCons.ParamByName('CIDADE').AsString := Cidade;
    QryCons.ParamByName('UF').AsString     := UF;
    QryCons.Open();

    Id := QryCons.FieldByName('ROWID').AsInteger;

  except on E : exception do
    raise Exception.Create('Erro ao Consultar Cidades');
  end;
end;

function TCidades.RetornarCidadesPorUf: TFDQuery;
var QryCons: TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT ROWID, * FROM CIDADES');
    QryCons.SQL.Add('WHERE UF = :UF');
    QryCons.ParamByName('UF').AsString := UF;
    QryCons.Open();

    Result := QryCons;

  except on E : exception do
    raise Exception.Create('Erro ao Consultar Cidades');
  end;
end;

function TCidades.RetornarUfs: TFDQuery;
var QryCons: TFDQuery;
begin
  try
    QryCons := CriarQuery(vConexao);

    QryCons.SQL.Add('SELECT ROWID, * FROM CIDADES');
    QryCons.SQL.Add('GROUP BY UF');
    QryCons.Open();

    Result := QryCons;

  except on E : exception do
    raise Exception.Create('Erro ao Consultar Cidades');
  end;
end;

procedure TCidades.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCidades.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TCidades.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
