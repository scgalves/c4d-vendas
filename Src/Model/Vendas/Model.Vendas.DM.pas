unit Model.Vendas.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  Model.Conexao.DM,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TModelVendasDM = class(TDataModule)
    QVendasCadastrar: TFDQuery;
    QVendasItensCadastrar: TFDQuery;
    QVendasItensListar: TFDQuery;
    QVendasCadastrarID: TIntegerField;
    QVendasCadastrarID_PESSOA: TIntegerField;
    QVendasCadastrarDATA: TDateField;
    QVendasCadastrarHORA: TTimeField;
    QVendasCadastrarTOTAL_BRUTO: TFMTBCDField;
    QVendasCadastrarTOTAL_DESCONTOS: TFMTBCDField;
    QVendasCadastrarTOTAL_ACRESCIMOS: TFMTBCDField;
    QVendasCadastrarTOTAL_LIQUIDO: TFMTBCDField;
    QVendasItensCadastrarID: TIntegerField;
    QVendasItensCadastrarID_VENDA: TIntegerField;
    QVendasItensCadastrarID_PRODUTO: TIntegerField;
    QVendasItensCadastrarQUANTIDADE: TFMTBCDField;
    QVendasItensCadastrarVALOR_UNITARIO: TFMTBCDField;
    QVendasItensCadastrarTOTAL_BRUTO: TFMTBCDField;
    QVendasItensCadastrarDESCONTO: TFMTBCDField;
    QVendasItensCadastrarACRESCIMO: TFMTBCDField;
    QVendasItensCadastrarTOTAL_LIQUIDO: TFMTBCDField;
    QVendasItensListarID: TIntegerField;
    QVendasItensListarID_VENDA: TIntegerField;
    QVendasItensListarID_PRODUTO: TIntegerField;
    QVendasItensListarQUANTIDADE: TFMTBCDField;
    QVendasItensListarVALOR_UNITARIO: TFMTBCDField;
    QVendasItensListarTOTAL_BRUTO: TFMTBCDField;
    QVendasItensListarDESCONTO: TFMTBCDField;
    QVendasItensListarACRESCIMO: TFMTBCDField;
    QVendasItensListarTOTAL_LIQUIDO: TFMTBCDField;
    QVendasItensListarPRODUTONOME: TStringField;
    QVendasTotalizar: TFDQuery;
    QVendasTotalizarTOTALQUANTIDADE: TFMTBCDField;
    QVendasTotalizarTOTALBRUTO: TFMTBCDField;
    QVendasTotalizarTOTALDESCONTO: TFMTBCDField;
    QVendasTotalizarTOTALACRESCIMO: TFMTBCDField;
    QVendasTotalizarTOTALLIQUIDO: TFMTBCDField;
    QVendasItensListarIMAGEM: TStringField;
    procedure QVendasCadastrarAfterInsert(DataSet: TDataSet);
    procedure QVendasItensCadastrarAfterInsert(DataSet: TDataSet);
  private

  public
    procedure VendasGet(const AIdVenda: Integer = 0);
    procedure VendasItensGet(const AIdItem: Integer = 0);
    procedure VendasItensListar(const AIdVenda: Integer = 0; const AIdItemVendaFocar: Integer = 0);
    procedure VendaTotalizar(const AIdVenda: Integer);
  end;

var
  ModelVendasDM: TModelVendasDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TModelVendasDM.VendasGet(const AIdVenda: Integer = 0);
begin
   QVendasCadastrar.Close;
   QVendasCadastrar.ParamByName('IdVenda').AsInteger := AIdVenda;
   QVendasCadastrar.Open;
end;

procedure TModelVendasDM.VendasItensGet(const AIdItem: Integer = 0);
begin
  QVendasItensCadastrar.Close;
  QVendasItensCadastrar.ParamByName('IdItem').AsInteger := AIdItem;
  QVendasItensCadastrar.Open;
end;

procedure TModelVendasDM.VendasItensListar(const AIdVenda: Integer = 0; const AIdItemVendaFocar: Integer = 0);
begin
  QVendasItensListar.DisableControls;
  try
    QVendasItensListar.Close;
    QVendasItensListar.ParamByName('IdVenda').AsInteger := AIdVenda;
    QVendasItensListar.Open;

    if(AIdItemVendaFocar > 0)then
      QVendasItensListar.Locate('ID', AIdItemVendaFocar, [loCaseInsensitive]);
  finally
    QVendasItensListar.EnableControls;
  end;
end;

procedure TModelVendasDM.QVendasCadastrarAfterInsert(DataSet: TDataSet);
begin
  QVendasCadastrarID_PESSOA.AsInteger := 1;
  QVendasCadastrarDATA.AsDateTime := Date;
  QVendasCadastrarHORA.AsDateTime := Time;
  QVendasCadastrarTOTAL_BRUTO.AsFloat := 0;
  QVendasCadastrarTOTAL_DESCONTOS.AsFloat := 0;
  QVendasCadastrarTOTAL_ACRESCIMOS.AsFloat := 0;
  QVendasCadastrarTOTAL_LIQUIDO.AsFloat := 0;
end;

procedure TModelVendasDM.QVendasItensCadastrarAfterInsert(DataSet: TDataSet);
begin
  QVendasItensCadastrarQUANTIDADE.AsFloat := 1;
  QVendasItensCadastrarVALOR_UNITARIO.AsFloat := 0;
  QVendasItensCadastrarTOTAL_BRUTO.AsFloat := 0;
  QVendasItensCadastrarDESCONTO.AsFloat := 0;
  QVendasItensCadastrarACRESCIMO.AsFloat := 0;
  QVendasItensCadastrarTOTAL_LIQUIDO.AsFloat := 0;
end;

procedure TModelVendasDM.VendaTotalizar(const AIdVenda: Integer);
begin
   QVendasTotalizar.Close;
   QVendasTotalizar.ParamByName('IdVenda').AsInteger := AIdVenda;
   QVendasTotalizar.Open;
end;

end.
