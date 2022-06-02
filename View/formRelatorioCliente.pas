unit formRelatorioCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmRelatorioCliente = class(TForm)
    rlrRelatorio: TRLReport;
    rlbCabecalho: TRLBand;
    rlbTitulo: TRLBand;
    rlbTituloColunas: TRLBand;
    rlbGrid: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel1: TRLLabel;
    lblCodigo: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    memRelatorioCliente: TFDMemTable;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    memRelatorioClienteROWID: TIntegerField;
    memRelatorioClienteNOME_CLIENTE: TStringField;
    memRelatorioClienteCPF_CNPJ: TStringField;
    memRelatorioClienteENDERECO: TStringField;
    memRelatorioClienteCELULAR: TStringField;
    memRelatorioClienteEMAIL: TStringField;
    dsRelatorioCliente: TDataSource;
    RLBand1: TRLBand;
    memRelatorioClienteCIDADE: TStringField;
    memRelatorioClienteUF: TStringField;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioCliente: TfrmRelatorioCliente;

implementation

{$R *.dfm}

end.
