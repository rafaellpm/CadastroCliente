unit dmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, System.ImageList,
  Vcl.ImgList, Vcl.Controls, System.IniFiles, Vcl.Dialogs, vcl.Forms;

type
  Tdm = class(TDataModule)
    fdConn: TFDConnection;
    ImageList1: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ConectarDB;
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm }

procedure Tdm.ConectarDB;
var CaminhoIni, DataBase : string;
    ArqIni  : TIniFile;
begin
  CaminhoIni := ExtractFilePath(Application.ExeName) + 'config.ini';
  ArqIni := TIniFile.Create(CaminhoIni);

  if not FileExists(CaminhoIni) then
    ArqIni.WriteString('CONFIGURACAO', 'Database', ExtractFilePath(Application.ExeName)+'db\banco.db');

  DataBase := ArqIni.ReadString('CONFIGURACAO', 'Database', '');

  with fdConn do
  begin
    Params.Values['Database'] := DataBase;
    try
      Connected := True;
    except
      ShowMessage('Erro Ao Conectar ao a Banco de Dados.' + #13#10 + 'O Programa Será finalizado');
      halt(0);
    end;
  end;

end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ConectarDB();
end;

end.
