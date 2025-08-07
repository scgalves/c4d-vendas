unit Model.Produtos.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Model.Conexao.DM;

type
  TModelProdutosDM = class(TDataModule)
    QProdutosCadastro: TFDQuery;
    QProdutosBusca: TFDQuery;
    QLook: TFDQuery;
    QProdutosCadastroID: TIntegerField;
    QProdutosCadastroID_SUBGRUPO: TIntegerField;
    QProdutosCadastroNOME: TStringField;
    QProdutosCadastroDESCRICAO: TStringField;
    QProdutosCadastroPRECO_CUSTO: TFMTBCDField;
    QProdutosCadastroPORCENTAGEM: TFMTBCDField;
    QProdutosCadastroPRECO_VENDA: TFMTBCDField;
    QProdutosCadastroUNIDADE: TStringField;
    QProdutosCadastroCODIGO_BARRAS: TStringField;
    QProdutosBuscaID: TIntegerField;
    QProdutosBuscaNOME: TStringField;
    QProdutosBuscaPRECO_CUSTO: TFMTBCDField;
    QProdutosBuscaPORCENTAGEM: TFMTBCDField;
    QProdutosBuscaPRECO_VENDA: TFMTBCDField;
    QProdutosBuscaUNIDADE: TStringField;
    QProdutosBuscaCODIGO_BARRAS: TStringField;
    QProdutosBuscaID_SUBGRUPO: TIntegerField;
    QProdutosBuscaSUBGRUPO_NOME: TStringField;
    QProdutosCadastroIMAGEM: TStringField;
    QLookID: TIntegerField;
    QLookNOME: TStringField;
    QLookPRECO_VENDA: TFMTBCDField;
    QLookUNIDADE: TStringField;
    procedure QProdutosCadastroAfterInsert(DataSet: TDataSet);
    procedure QProdutosCadastroBeforePost(DataSet: TDataSet);
  private

  public
    procedure ValidarDadosQueryCadastro;
    procedure ProdutosBuscar(const ACondicao: string);
    procedure CadastrarGet(const AIdProduto: Integer);
    function LookProdutos(const ACodBarras: string): Boolean;
  end;

var
  ModelProdutosDM: TModelProdutosDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Exceptions.FieldName;

procedure TModelProdutosDM.CadastrarGet(const AIdProduto: Integer);
begin
  QProdutosCadastro.Close;
  QProdutosCadastro.SQL.Clear;
  QProdutosCadastro.SQL.Add('select * from produtos');
  QProdutosCadastro.SQL.Add('where(id = :IdProduto)');
  QProdutosCadastro.ParamByName('IdProduto').AsInteger := AIdProduto;
  QProdutosCadastro.Open;
end;

procedure TModelProdutosDM.ProdutosBuscar(const ACondicao: string);
begin
  QProdutosBusca.Close;
  QProdutosBusca.SQL.Clear;
  QProdutosBusca.SQL.Add('select');
  QProdutosBusca.SQL.Add('produtos.ID,');
  QProdutosBusca.SQL.Add('produtos.NOME,');
  QProdutosBusca.SQL.Add('produtos.PRECO_CUSTO,');
  QProdutosBusca.SQL.Add('produtos.PORCENTAGEM,');
  QProdutosBusca.SQL.Add('produtos.PRECO_VENDA,');
  QProdutosBusca.SQL.Add('produtos.UNIDADE,');
  QProdutosBusca.SQL.Add('produtos.CODIGO_BARRAS,');
  QProdutosBusca.SQL.Add('produtos.id_subgrupo,');
  QProdutosBusca.SQL.Add('subgrupos.NOME as Subgrupo_Nome');
  QProdutosBusca.SQL.Add('from produtos');
  QProdutosBusca.SQL.Add('join subgrupos on (subgrupos.id = produtos.id_subgrupo)');
  QProdutosBusca.SQL.Add(ACondicao);
  QProdutosBusca.Open;
end;

function TModelProdutosDM.LookProdutos(const ACodBarras: string): Boolean;
begin
  QLook.Close;
  QLook.ParamByName('CodBarras').AsString := ACodBarras;
  QLook.Open;

  Result := not QLook.IsEmpty;
end;

procedure TModelProdutosDM.QProdutosCadastroAfterInsert(DataSet: TDataSet);
begin
  QProdutosCadastroPRECO_CUSTO.AsFloat := 0;
  QProdutosCadastroPORCENTAGEM.AsFloat := 0;
  QProdutosCadastroPRECO_VENDA.AsFloat := 0;
  QProdutosCadastroUNIDADE.AsString := 'UN';
end;

procedure TModelProdutosDM.QProdutosCadastroBeforePost(DataSet: TDataSet);
begin
  Self.ValidarDadosQueryCadastro;
end;

procedure TModelProdutosDM.ValidarDadosQueryCadastro;
begin
  if(QProdutosCadastroNOME.AsString.Trim.IsEmpty)then
    raise ExceptionsFieldName.Create('Preencha o campo nome', QProdutosCadastroNOME.FieldName);

  if(QProdutosCadastroID_SUBGRUPO.AsInteger <= 0)then
    raise ExceptionsFieldName.Create('Subgrupo não informado', QProdutosCadastroID_SUBGRUPO.FieldName);

  if(QProdutosCadastroPRECO_CUSTO.AsFloat < 0)then
    raise ExceptionsFieldName.Create('Preço de custo inválido', QProdutosCadastroPRECO_CUSTO.FieldName);

  if(QProdutosCadastroPORCENTAGEM.AsFloat < 0)then
    raise ExceptionsFieldName.Create('Porcentagem inválida', QProdutosCadastroPORCENTAGEM.FieldName);

  if(QProdutosCadastroPRECO_VENDA.AsFloat <= 0)then
    raise ExceptionsFieldName.Create('Preço de venda inválido', QProdutosCadastroPRECO_VENDA.FieldName);

  if(QProdutosCadastroPRECO_VENDA.AsFloat < QProdutosCadastroPRECO_CUSTO.AsFloat )then
    raise ExceptionsFieldName.Create('Preço de venda não pode ser menor que o preço de custo', QProdutosCadastroPRECO_VENDA.FieldName);

  if(QProdutosCadastroUNIDADE.AsString.Trim.IsEmpty)then
    raise ExceptionsFieldName.Create('Informe a unidade', QProdutosCadastroUNIDADE.FieldName);

  if(QProdutosCadastroCODIGO_BARRAS.AsString.Trim.IsEmpty)then
    raise ExceptionsFieldName.Create('Informe o código de barras', QProdutosCadastroCODIGO_BARRAS.FieldName);
end;

end.
