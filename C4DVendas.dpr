program C4DVendas;

uses
  Vcl.Forms,
  View.Principal in 'Src\View\View.Principal.pas' {ViewPrincipal},
  Model.Conexao.DM in 'Src\Model\Conexao\Model.Conexao.DM.pas' {ModelConexaoDM: TDataModule},
  Model.Subgrupos.DM in 'Src\Model\Subgrupos\Model.Subgrupos.DM.pas' {ModelSubgruposDM: TDataModule},
  View.Herancas.Buscar in 'Src\View\Herancas\View.Herancas.Buscar.pas' {ViewHerancasBuscar},
  View.Subgrupos.Buscar in 'Src\View\Subgrupos\View.Subgrupos.Buscar.pas' {ViewSubgruposBuscar},
  View.Herancas.Cadastrar in 'Src\View\Herancas\View.Herancas.Cadastrar.pas' {ViewHerancasCadastrar},
  View.Subgrupos.Cadastrar in 'Src\View\Subgrupos\View.Subgrupos.Cadastrar.pas' {ViewSubgruposCadastrar},
  Model.Pessoas.DM in 'Src\Model\Pessoas\Model.Pessoas.DM.pas' {ModelPessoasDM: TDataModule},
  View.Pessoas.Buscar in 'Src\View\Pessoas\View.Pessoas.Buscar.pas' {ViewPessoasBuscar},
  Exceptions.FieldName in 'Src\Exceptions\Exceptions.FieldName.pas',
  RTTI.FieldName in 'Src\RTTI\RTTI.FieldName.pas',
  Utils in 'Src\Utils\Utils.pas',
  View.Pessoas.Cadastrar in 'Src\View\Pessoas\View.Pessoas.Cadastrar.pas' {ViewPessoasCadastrar},
  Model.Cidades.DM in 'Src\Model\Cidades\Model.Cidades.DM.pas' {ModelCidadesDM: TDataModule},
  View.Cidades.Buscar in 'Src\View\Cidades\View.Cidades.Buscar.pas' {ViewCidadesBuscar},
  View.Cidades.Cadastrar in 'Src\View\Cidades\View.Cidades.Cadastrar.pas' {ViewCidadesCadastrar},
  Model.Produtos.DM in 'Src\Model\Produtos\Model.Produtos.DM.pas' {ModelProdutosDM: TDataModule},
  View.Produtos.Buscar in 'Src\View\Produtos\View.Produtos.Buscar.pas' {ViewProdutosBuscar},
  View.Produtos.Cadastrar in 'Src\View\Produtos\View.Produtos.Cadastrar.pas' {ViewProdutosCadastrar},
  View.Vendas in 'Src\View\Vendas\View.Vendas.pas' {ViewVendas},
  Model.Vendas.DM in 'Src\Model\Vendas\Model.Vendas.DM.pas' {ModelVendasDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Delphi: Sistema de vendas do zero ao multicamadas';
  Application.CreateForm(TModelConexaoDM, ModelConexaoDM);
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
