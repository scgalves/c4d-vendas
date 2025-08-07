unit Model.Pessoas.DM;

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
  TModelPessoasDM = class(TDataModule)
    QPessoasCadastro: TFDQuery;
    QPessoasBusca: TFDQuery;
    QPessoasCadastroID: TIntegerField;
    QPessoasCadastroNOME: TStringField;
    QPessoasCadastroFANTASIA: TStringField;
    QPessoasCadastroCLIENTE: TStringField;
    QPessoasCadastroFORNECEDOR: TStringField;
    QPessoasCadastroCEP: TStringField;
    QPessoasCadastroID_CIDADE: TIntegerField;
    QPessoasCadastroENDERECO: TStringField;
    QPessoasCadastroNUMERO: TStringField;
    QPessoasCadastroBAIRRO: TStringField;
    QPessoasCadastroCOMPLEMENTO: TStringField;
    QPessoasCadastroTELEFONE: TStringField;
    QPessoasCadastroCELULAR: TStringField;
    QPessoasCadastroEMAIL: TStringField;
    QPessoasCadastroTIPO_JURIDICO: TIntegerField;
    QPessoasCadastroCPF: TStringField;
    QPessoasCadastroRG: TStringField;
    QPessoasCadastroCNPJ: TStringField;
    QPessoasCadastroIE: TStringField;
    QPessoasCadastroATIVO: TStringField;
    QPessoasCadastroNASCIMENTO: TDateField;
    QPessoasCadastroDH_CADASTRO: TSQLTimeStampField;
    QPessoasBuscaID: TIntegerField;
    QPessoasBuscaNOME: TStringField;
    QPessoasBuscaFANTASIA: TStringField;
    QPessoasBuscaCLIENTE: TStringField;
    QPessoasBuscaFORNECEDOR: TStringField;
    QPessoasBuscaID_CIDADE: TIntegerField;
    QPessoasBuscaUF: TStringField;
    QPessoasBuscaENDERECO: TStringField;
    QPessoasBuscaTELEFONE: TStringField;
    QPessoasBuscaCELULAR: TStringField;
    QPessoasBuscaCIDADENOME: TStringField;
    procedure QPessoasCadastroAfterInsert(DataSet: TDataSet);
    procedure QPessoasCadastroBeforePost(DataSet: TDataSet);
  private
    procedure ValidarDadosQueryCadastro;
  public
    procedure CadastrarGet(const AIdPessoa: Integer);
    procedure PessoasBuscar(const ACondicao: String);
  end;

var
  ModelPessoasDM: TModelPessoasDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Exceptions.FieldName;

procedure TModelPessoasDM.CadastrarGet(const AIdPessoa: Integer);
begin
  QPessoasCadastro.Close;
  QPessoasCadastro.SQL.Clear;
  QPessoasCadastro.SQL.Add('select * from pessoas');
  QPessoasCadastro.SQL.Add('where(id = :IdPessoa)');
  QPessoasCadastro.ParamByName('IdPessoa').AsInteger := AIdPessoa;
  QPessoasCadastro.Open;
end;

procedure TModelPessoasDM.PessoasBuscar(const ACondicao: String);
begin
  QPessoasBusca.Close;
  QPessoasBusca.SQL.Clear;
  QPessoasBusca.SQL.Add('select ');
  QPessoasBusca.SQL.Add('pessoas.ID, ');
  QPessoasBusca.SQL.Add('pessoas.NOME, ');
  QPessoasBusca.SQL.Add('pessoas.FANTASIA, ');
  QPessoasBusca.SQL.Add('pessoas.CLIENTE, ');
  QPessoasBusca.SQL.Add('pessoas.FORNECEDOR, ');
  QPessoasBusca.SQL.Add('pessoas.ID_CIDADE, ');
  QPessoasBusca.SQL.Add('cidades.nome as CidadeNome, ');
  QPessoasBusca.SQL.Add('cidades.uf, ');
  QPessoasBusca.SQL.Add('pessoas.endereco, ');
  QPessoasBusca.SQL.Add('pessoas.telefone, ');
  QPessoasBusca.SQL.Add('pessoas.celular ');
  QPessoasBusca.SQL.Add('from pessoas ');
  QPessoasBusca.SQL.Add('inner join cidades on(cidades.id = pessoas.id_cidade)');
  QPessoasBusca.SQL.Add(ACondicao);
  QPessoasBusca.Open;
end;

procedure TModelPessoasDM.QPessoasCadastroAfterInsert(DataSet: TDataSet);
begin
  QPessoasCadastroATIVO.AsString := 'S';
  QPessoasCadastroCLIENTE.AsString := 'S';
  QPessoasCadastroFORNECEDOR.AsString := 'S';
  QPessoasCadastroDH_CADASTRO.AsDateTime := Now;
  QPessoasCadastroTIPO_JURIDICO.AsInteger := 1;
end;

procedure TModelPessoasDM.QPessoasCadastroBeforePost(DataSet: TDataSet);
begin
  Self.ValidarDadosQueryCadastro;
end;

procedure TModelPessoasDM.ValidarDadosQueryCadastro;
begin
  if(QPessoasCadastroNOME.AsString.Trim.IsEmpty)then
    raise ExceptionsFieldName.Create('Preencha o campo nome', 'NOME');

  if(QPessoasCadastroFANTASIA.AsString.Trim.IsEmpty)then
    raise ExceptionsFieldName.Create('Preencha o campo fantasia', 'FANTASIA');

  if(QPessoasCadastroID_CIDADE.AsInteger <= 0)then
    raise ExceptionsFieldName.Create('Preencha o campo código cidade', 'ID_CIDADE');
end;

end.
